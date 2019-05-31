-----------------------------------------------------------------------
--
-- Title       : adder_subtractor
-- Design      : adder_subtractor
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : adder_subtractor uses the pos_neg output of the 
-- address counter to determine which half of the sine wave cycle is 
-- current and to modify the 7-bit value from the sine lookup table
-- to produce an 8-bit value to be input to the DAC.
-- 
-- Generics: m
-- Inputs: pos_neg, sine_value
-- Outputs: dac_sine_value				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
	generic (
		m : positive := 7 -- width of phase acc. output
		);
	port (
		pos_neg : in std_logic; -- indicates pos. or neg. half of cycle
		sine_value : in std_logic_vector(m-1 downto 0); -- from sine table
		dac_value : out std_logic_vector(m downto 0) -- output to DAC
		);
end adder_subtractor;


architecture behavior of adder_subtractor is
begin
	behave:
		process (pos_neg, sine_value) is -- process that is sensitive to pos, sine_value
	begin
		if pos_neg = '1' then -- if pos is 1, the values go from 128 - 255 - 0
			dac_value <= "1" & sine_value; 
		else -- if pos is 0, the values go from 128 - -255 - 0
			-- when pos = 0, subtract the given sine value from 127 to get negative half of sine wave
			dac_value <= std_logic_vector(to_unsigned((127 - to_integer(unsigned(sine_value))), dac_value'length));
		end if;
	end process behave;
end behavior;