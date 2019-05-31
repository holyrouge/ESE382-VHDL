-----------------------------------------------------------------------
--
-- Title       : dds_sts_TB
-- Design      : dds_sts_tb
-- Authors     : Prangon Ghose (ID: 111623211) and Albert Thomas (ID: 111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : dds_sts_tb is a design description for a testbench
-- for the direct digital synthesis system with square, triangle, and
-- sine wave output.
--
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------

-- Testbench for Task 6 of Laboratory 10, Spring 2019


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dds_sts_tb is
	-- Generic declarations of the tested unit
		generic(
		a : positive := 14;
		m : positive := 7 );
end dds_sts_tb;

architecture tb_architecture of dds_sts_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0';
	signal rst_bar : std_logic;
	signal freq_val_input : std_logic_vector(15 downto 0) := x"00FF";
	signal freq_val : std_logic_vector(a-1 downto 0);
	signal load_freq : std_logic;
	signal ws1 : std_logic;
	signal ws0 : std_logic;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dac_value : std_logic_vector(7 downto 0);
	signal pos_sine : std_logic;
	
	constant period : time := 1 us;

begin
	-- Unit Under Test port map
	UUT : entity dds_sts
		generic map (
			a => a,
			m => m
		)

		port map (
			clk => clk,
			rst_bar => rst_bar,
			freq_val => freq_val,
			load_freq => load_freq,
			ws1 => ws1,
			ws0 => ws0,
			dac_value => dac_value,
			pos_sine => pos_sine
		);

	freq_val <= freq_val_input(a-1 downto 0); -- input freq
	
	load_freq <= '0', '1' after 7 * period, '0' after 10 * period; -- load freq
		
	rst_bar <= '0', '1' after 4 * period;	-- reset signal
	
	ws1 <= '0', '1' after 1000 * period, '0' after 2000 * period, '1' after 4000 * period; -- waveform select
	ws0 <= '1', '0' after 1000 * period, '1' after 2000 * period, '0' after 3000 * period, '1' after 4000 * period; -- waveform select
	
	clock: process				-- system clock
	begin
		for i in 0 to 1032 * (2 ** 7) loop
			wait for period/2;
			clk <= not clk;
		end loop;
		std.env.finish;
	end process;
end tb_architecture;



