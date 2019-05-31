-----------------------------------------------------------------------
--
-- Title       : binary_counter_3
-- Design      : binary_counter
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/10/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 08
--
-----------------------------------------------------------------------
--
-- Description : binary_counter is a binary up counter with an enable.
-- This architecture utilizes an integer variable to store the count.
--
-- Generic: n
-- Inputs: clk, cnten, rst_bar
-- Outputs: q				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity binary_counter is
	generic (n : integer := 4); -- generic for counter width
	port (
		clk : in std_logic; -- system clock
		cnten : in std_logic; -- enable counter count
		rst_bar : in std_logic; -- synchronous reset (active low)
		q : out std_logic_vector(n-1 downto 0) -- output
		);
end binary_counter;


architecture integer_variable of binary_counter is
begin
	bin_count: process (clk) is
		constant count_limit : integer := 2**n - 1;
		variable count : integer range 0 to count_limit; -- integer variable to store data
	begin
		if rst_bar = '0' then -- reset if rst_bar = 0
			count := 0;
		elsif cnten = '1' and rising_edge(clk) then
			-- reset count if at limit
			if count = count_limit then
				count := 0;
			else -- increment count if rising edge and count is enabled
				count := count + 1;
			end if;
		end if;
		q <= std_logic_vector(to_unsigned(count, n)); -- typecast to std_logic_vector
	end process bin_count;
end integer_variable;