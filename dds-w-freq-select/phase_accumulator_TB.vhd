-----------------------------------------------------------------------
--
-- Title       : phase_accumulator_TB
-- Design      : phase_accumulator_tb
-- Authors     : Prangon Ghose and Albert Thomas
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : phase_accumulator_tb is a design description for the testbench 
-- of the counter for the DDS system.
-- 
-- Generics: a, m
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity phase_accumulator_tb is
	-- Generic declarations of the tested unit
	generic (
		a : positive := 14; -- width of the phase accumulator
		m : positive := 7 -- width of phase acc. output
		);
end phase_accumulator_tb;

architecture tb_architecture of phase_accumulator_tb is
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0'; -- system clock
	signal rst_bar : std_logic; -- reset
	signal up : std_logic; -- count direction control, 1 => up, 0 => down
	signal d : std_logic_vector(a-1 downto 0) := (others => '0'); -- count delta
	signal max : std_logic; -- count has reached max value
	signal min : std_logic; -- count has reached min value
	signal q : std_logic_vector(m-1 downto 0); -- phase acc. output
	
	
	constant period : time := 1 us;
	
begin
	-- Unit Under Test port map
	UUT : entity phase_accumulator
	port map (
		rst_bar => rst_bar,
		clk => clk,
		up => up,
		d => d,
		max => max,
		min => min,
		q => q
		);
	
	rst_bar <= '0', '1' after 4 * period, '0' after 40 * period, '1' after 48 * period;	-- reset signal
	
	
	
	clock: process				-- system clock
	begin
		for i in 0 to 1032 loop
			wait for period;
			clk <= not clk;
		end loop;
		std.env.finish;
	end process;
	
	input: process				-- input signal
	begin
		d <= (others => '0'); -- set frequency of increment/decrement to 0
		up <= '1';
		wait for 5 * period;
		-- test increment to max to check if max is pulsed
		d <= std_logic_vector(to_unsigned(384, d'length));
		wait for 150 * period;
		-- test decrement to min if min is pulsed
		up <= '0';
		d <= std_logic_vector(to_unsigned(768, d'length));
		wait for 50 * period;
		-- start change frequency to see effect
		up <= '1';
		for i in 2 to 8 loop
			d <= std_logic_vector(to_unsigned(to_integer(unsigned(d)) + 127, d'length));
			wait for 4 * period;  
		end loop;
		std.env.finish;
	end process;
end tb_architecture;



