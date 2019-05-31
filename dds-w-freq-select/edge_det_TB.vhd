-----------------------------------------------------------------------
--
-- Title       : edge_det_TB
-- Design      : edge_det_tb
-- Authors     : Prangon Ghose and Albert Thomas
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : edge_det_tb is a design description for the testbench 
-- of the positive and negative edge detector.
--
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_det_tb is
end edge_det_tb;

architecture tb_architecture of edge_det_tb is
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0'; -- system clock
	signal rst_bar : std_logic; -- reset
	signal sig : std_logic := '0'; -- input signal
	signal pos : std_logic; -- '1' for positive edge detection, '0' for negative edge detection
	signal sig_edge : std_logic; -- output signal
	
	constant period : time := 1 us;
	
begin
	-- Unit Under Test port map
	UUT : entity edge_det
	port map (
		rst_bar => rst_bar,
		clk => clk,
		sig => sig,
		pos => pos,
		sig_edge => sig_edge
		);
	
	rst_bar <= '0', '1' after 4 * period;	-- reset signal
	pos <= '1', '0' after 100 * period; -- pos/neg edge detection select
	
	clock: process				-- system clock
	begin
		for i in 0 to 200 loop
			wait for period;
			clk <= not clk;
		end loop;
		std.env.finish;
	end process;
	
	input: process				-- input signal
	begin
		for i in 0 to 1032 loop
			wait for period * 10; -- input signal changes every 10 clocks
			sig <= not sig;
		end loop;
		std.env.finish;
	end process;
end tb_architecture;



