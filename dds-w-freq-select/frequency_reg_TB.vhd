-----------------------------------------------------------------------
--
-- Title       : frequency_reg_TB
-- Design      : frequency_reg_tb
-- Authors     : Prangon Ghose and Albert Thomas
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : frequency_reg_tb is a design description for the testbench 
-- of the frequency register that stores the input data for the DDS.
-- 
-- Generics: a
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity frequency_reg_tb is
	-- Generic declarations of the tested unit
	generic(
		a : positive := 14
		);
end frequency_reg_tb;

architecture tb_architecture of frequency_reg_tb is
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0'; -- system clock
	signal rst_bar : std_logic; -- reset
	signal load : std_logic; -- enable for the storing of data in the register
	signal d : std_logic_vector(a-1 downto 0) := (others => '0'); -- data input
	signal q : std_logic_vector(a-1 downto 0); -- data output
	
	
	constant period : time := 1 us;
	
begin
	-- Unit Under Test port map
	UUT : entity frequency_reg
	port map (
		rst_bar => rst_bar,
		clk => clk,
		load => load,
		d => d,
		q => q
		);
	
	rst_bar <= '0', '1' after 4 * period, '0' after 20 * period, '1' after 24 * period;	-- reset signal
	-- load signal
	load <= '0', '1' after 10 * period, '0' after 30 * period, '1' after 34 * period;
	
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
		for i in 0 to 1032 loop
			wait for period * 2; -- input signal increments after every 2 periods
			d <= std_logic_vector(to_unsigned(to_integer(unsigned(d)) + 1, d'length));
		end loop;
		std.env.finish;
	end process;
end tb_architecture;



