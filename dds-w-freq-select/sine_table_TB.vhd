-----------------------------------------------------------------------
--
-- Title       : sine_table_TB
-- Design      : sine_table_TB
-- Authors     : Prangon Ghose
-- Company     : Stony Brook University
-- Date		   : 04/17/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 09
--
-----------------------------------------------------------------------
--
-- Description : sine_table_TB is a design description for a testbench
-- for the sine lookup table that is used for the simple DDS system.
--
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------

-- testbench for laboratory 9 spring 19

library ieee;
use ieee.std_logic_1164.all;

entity sine_table_tb is
end sine_table_tb;

architecture tb_architecture of sine_table_tb is	
	-- stimulus signals
	signal clk : std_logic := '0';
	signal reset_bar : std_logic;
	-- observed signals
	signal pos_neg : std_logic;
	signal address : std_logic_vector(6 downto 0);
	signal sine_value : std_logic_vector(6 downto 0);
	
	constant period : time := 10 ns;
	
begin	
	-- quad_address_counter UUT
	UUT1 : entity quad_address_counter
	port map (
		clk => clk,
		reset_bar => reset_bar,
		pos_neg => pos_neg,
		address => address
		);
	-- sine_table UUT
	UUT2 : entity sine_table
	port map (
		address => address,
		sine_value => sine_value
		);
	
	reset_bar <= '0', '1' after 4 * period;	-- reset signal
	
	clock: process				-- system clock
	begin
		for i in 0 to 1032 loop
			wait for period;
			clk <= not clk;
		end loop;
		wait;
	end process;	
end tb_architecture;