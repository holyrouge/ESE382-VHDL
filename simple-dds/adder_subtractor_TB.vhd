-----------------------------------------------------------------------
--
-- Title       : adder_subtractor_TB
-- Design      : adder_subtractor_TB
-- Authors     : Prangon Ghose and Albert Thomas
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : adder_subtractor is a design description for a testbench
-- for the adder_subtractor design in the context of the entire system.
--
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------

-- Testbench for Task 6 of Laboratory 10, Spring 2019


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor_tb is
	-- Generic declarations of the tested unit
		generic(
		a : positive := 14;
		m : positive := 7 );
end adder_subtractor_tb;

architecture tb_architecture of adder_subtractor_tb is

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0';
	signal rst_bar : std_logic;
	signal freq_val : std_logic_vector(a-1 downto 0);
	signal load_freq : std_logic;
	
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dac_sine_value : std_logic_vector(m downto 0); -- output of the adder_subtractor
	signal sig_edge : std_logic; -- output of edge_det
	signal pos : std_logic; -- input to edge_det
	signal up : std_logic; -- increment/decrement, and 
	-- output of phase_accumulator_fsm, input of phase_accumulator
	signal max : std_logic; -- max count, output of phase_accumulator, input of phase_accumulator_fsm
	signal min : std_logic; -- min count, output of phase_accumulator, input of phase_accumulator_fsm
	signal pos_neg : std_logic; -- pos/neg half of sine, and
	-- output of phase_accumulator_fs, input of address_subtractor
	signal q_1 : std_logic_vector(a-1 downto 0); -- output of frequency_reg, input of phase_accumulator
	signal q_2 : std_logic_vector(m-1 downto 0); -- output of phase_accumulator, input of sine_table
	signal sine_value : std_logic_vector(m-1 downto 0); -- output of sine_table
	
	constant period : time := 1 us;

begin
	pos <= '1'; -- set pos to high
	-- edge detector FSM
	UUT1: entity edge_det port map (clk => clk, rst_bar => rst_bar, sig => load_freq, pos => pos,
	sig_edge => sig_edge);
	-- frequency register
	UUT2: entity frequency_reg port map (clk => clk, rst_bar => rst_bar, load => sig_edge, d => freq_val,
		q => q_1);
	-- phase accumulator
	UUT3: entity phase_accumulator port map (clk => clk, rst_bar => rst_bar, up => up, d => q_1,
		max => max, min => min, q => q_2);
	-- phase accumulator FSM
	UUT4: entity phase_accumulator_fsm port map (clk => clk, rst_bar => rst_bar, max => max, min => min,
		up => up, pos => pos_neg);
	-- sine table
	UUT5: entity sine_table port map (address => q_2, sine_value => sine_value);
	-- adder subtractor
	UUT6: entity adder_subtractor port map (pos_neg => pos_neg, sine_value => sine_value,
		dac_sine_value => dac_sine_value);

	freq_val <= "00000011111111";
	
	load_freq <= '0', '1' after 7 * period, '0' after 10 * period;
		
	rst_bar <= '0', '1' after 4 * period;	-- reset signal
	
	clock: process				-- system clock
	begin
		for i in 0 to 1032 * (2 ** 7) loop
			wait for period;
			clk <= not clk;
		end loop;
		std.env.finish;
	end process;
end tb_architecture;