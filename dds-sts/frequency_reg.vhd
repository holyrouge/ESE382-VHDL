-----------------------------------------------------------------------
--
-- Title       : frequency_reg
-- Design      : frequency_reg
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : frequency_reg is the design description for the frequency
-- register that holds the value that is added to the phase accumulator
-- on each clock pulse.
-- 
-- Generics: a
-- Inputs: load, clk, rst_bar, d
-- Outputs: sig_edge			 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity frequency_reg is
	generic (a : positive := 14); -- size of register
	port (
		rst_bar : in std_logic; -- active low asynchronous system reset
		clk : in std_logic;	-- system clock
		load : in std_logic; -- enable register to load data
		d : in std_logic_vector(a-1 downto 0); -- data input
		q : out std_logic_vector(a-1 downto 0) -- data output
		);
end frequency_reg;

architecture behavior of frequency_reg is
begin
	behave : process (clk, rst_bar) is -- process
		variable freq_reg : std_logic_vector(a-1 downto 0); -- store input data
	begin
		-- asynchronous reset
		if rst_bar = '0' then
			freq_reg := (others => '0');
		elsif rising_edge(clk) then
			-- at rising clock edge, if load is 1, update freq_reg
			if load = '1' then
				freq_reg := d;
			end if;
		end if;
		q <= freq_reg;
	end process behave;
end behavior;