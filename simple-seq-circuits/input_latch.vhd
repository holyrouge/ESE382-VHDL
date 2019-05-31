-----------------------------------------------------------------------
--
-- Title       : input_latch
-- Design      : input_latch
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/25/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : input_latch is a behavioral design description for 
-- a latch with 3 data inputs and 3 data outputs.
--
-- Inputs: a[2:0], le_bar
-- Outputs: a_lat[2:0]
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity input_latch is
	port (
	a : in std_logic_vector(2 downto 0); -- data input
	le_bar : in std_logic; -- latch enable input (active low)
	a_lat : out std_logic_vector(2 downto 0) -- latch output
	);
end input_latch;


architecture behavioral of input_latch is
begin
	latch_behavior: process (a, le_bar) -- process sensitivity list
	begin
		if le_bar = '0' then -- if le_bar is low, then set input to output
			a_lat <= a;
		end if;
	end process latch_behavior;		
end behavioral;