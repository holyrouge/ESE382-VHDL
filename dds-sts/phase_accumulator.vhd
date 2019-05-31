-----------------------------------------------------------------------
--
-- Title       : phase_accumulator
-- Design      : phase_accumulator
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : phase_accumulator is a design description for a counter
-- that increments or decrements at each positive edge of the clock based
-- on the input for the frequency register.
--
-- Generics: a, m
-- Inputs: load, clk, rst_bar, d
-- Outputs: sig_edge			 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity phase_accumulator is
	generic (
		a : positive := 14; -- width of the phase accumulator
		m : positive := 7 -- width of phase acc. output
		);
	port (
		rst_bar : in std_logic; -- active low asynchronous system reset
		clk : in std_logic;	-- system clock
		up : in std_logic; -- count direction control, 1 => up, 0 => down
		d : in std_logic_vector(a-1 downto 0); -- count delta
		max : out std_logic; -- count has reached max value
		min : out std_logic; -- count has reached min value
		q : out std_logic_vector(m-1 downto 0) -- phase acc. outpu
		);
end phase_accumulator;

architecture behavior of phase_accumulator is
begin
	behave : process (clk, rst_bar) is
		variable count : std_logic_vector(a-1 downto 0); -- holds the count
		variable max_value : std_logic_vector(a-1 downto 0) := (others => '1'); -- holds the max value
		-- integer value of first m bits of d input
		variable delta : integer := to_integer(unsigned(d));
		variable count_int : integer := 0; -- holds the next count as an integer
	begin
		delta := to_integer(unsigned(d)); -- turn d input into integer
		-- if reset, set count and outputs to 0
		if rst_bar = '0' then
			count := (others => '0');
			count_int := 0;
			max <= '0';
			min <= '0';
			-- otherwise, if rising clock edge
		elsif rising_edge(clk) then	
			
			-- if increment
			if up = '1' then
				count_int := count_int + delta;
				-- check if count is more than max, if so, set count to max
				-- otherwise do regular counting
				if count_int >= 2**a - 1 then
					count := (others => '1');
					count_int := 2**a - 1;
				else
					count := std_logic_vector(to_unsigned(count_int, count'length));
				end if;
				-- if decrement
			elsif up = '0' then
				count_int := count_int - delta;
				-- check if count is less than 0, if so, set count to 0
				-- otherwise do regular counting
				if count_int <= 0 then
					count := (others => '0');
					count_int := 0;
				else
					count := std_logic_vector(to_unsigned(count_int, count'length));
				end if;
			end if;
			
			-- set output values of max and min based on count
			if count = max_value then
				-- remove the first value after the restart of the counter
				-- to remove the amount of time that the sine wave is flat at the top
				count_int := count_int - 128;
				count := std_logic_vector(to_unsigned(count_int, count'length));
				max <= '1';
			elsif count = not max_value then
				-- remove the first value after the restart of the counter
				-- to remove the amount of time that the sine wave is flat at the bottom
				count_int := count_int + 128;
				count := std_logic_vector(to_unsigned(count_int, count'length));
				min <= '1';
			else 
				max <= '0';
				min <= '0';
			end if;			
		end if;
		q <= count(a-1 downto a-m); -- set output to current count
	end process behave;
end behavior;