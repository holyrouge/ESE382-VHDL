-----------------------------------------------------------------------
--
-- Title       : dds_sts
-- Design      : dds_sts
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : dds_sts is the structural design description for
-- a DDS system with frequency that allows for triangular, square, and
-- sine wave.
--
-- Inputs: clk, rst_bar, freq_val, load_freq
-- Outputs: dac_sine_value, pos_sine				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dds_sts is
	generic (
		a : positive := 14; 
		m : positive := 7
		);
	port (
		clk : in std_logic; -- system clock
		rst_bar : in std_logic; -- asynchronous reset
		freq_val : in std_logic_vector(a-1 downto 0); -- selects frequency
		load_freq : in std_logic; -- pulse to load a new frequency selection
		ws1 : in std_logic; -- waveform select
		ws0 : in std_logic; -- waveform select
		dac_value : out std_logic_vector(7 downto 0); -- output to DAC
		pos_sine : out std_logic -- positive half of sine cycle
		);
	attribute loc : string;
	attribute loc of clk : signal is "J1";
	attribute loc of rst_bar : signal is "F1";
	attribute loc of freq_val : signal is 
                   "A13,F8,C12,E10,F9,E8,E7,D7,C5,E6,A10,D9,B6,B5";
	attribute loc of load_freq : signal is "C2";
	attribute loc of ws1 : signal is "C7";
	attribute loc of ws0 : signal is "D8";
	attribute loc of dac_value : signal is 
			 "C4,F7,B9,B7,A5,A4,A3,D6"; 
	attribute loc of pos_sine : signal is "B4";
end dds_sts;


architecture structural of dds_sts is
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
	signal add_sub_input : std_logic_vector(m-1 downto 0); -- input to the adder_subtractor
	signal ws : std_logic_vector(1 downto 0); -- waveform select
begin
	pos <= '1'; -- set pos to high
	ws(1) <= ws1;
	ws(0) <= ws0;
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
	
	-- set input for adder subtractor based on waveform select	
	with ws select add_sub_input <=
		sine_value when "01",
		q_2 when "10",
		(others => '1') when "11",
		(others => '0') when others;
		
	-- adder subtractor
	UUT6: entity adder_subtractor port map (pos_neg => pos_neg, sine_value => add_sub_input,
		dac_value => dac_value);
	
	pos_sine <= pos_neg; -- output pos half of sine wave
end structural;