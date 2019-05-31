-----------------------------------------------------------------------
--
-- Title       : phase_accumulator_fsm_TB
-- Design      : phase_accumulator_fsm_tb
-- Authors     : Prangon Ghose and Albert Thomas
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : phase_accumulator_fsm_tb is a design description for the testbench 
-- of the phase_accumulator_FSM that controls the phase_accumulator counter.
--
-- Inputs: None
-- Outputs: None				 
-----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity phase_accumulator_fsm_tb is
end phase_accumulator_fsm_tb;

architecture tb_architecture of phase_accumulator_fsm_tb is
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : std_logic := '0'; -- system clock
	signal rst_bar : std_logic; -- reset
	signal max : std_logic; -- count has reached max value
	signal min : std_logic; -- count has reached min value
	signal up : std_logic; -- count direction control, 1 => up, 0 => down
	signal pos : std_logic; -- positive half of sine cycle
		
		
	constant period : time := 1 us;
	
begin
	-- Unit Under Test port map
	UUT : entity phase_accumulator_fsm
	port map (
		rst_bar => rst_bar,
		clk => clk,
		max => max,
		min => min,
		up => up,
		pos => pos
		);
	
	rst_bar <= '0', '1' after 4 * period, '0' after 40 * period, '1' after 44 * period;	-- reset signal
	-- max input (try out each combination of max)
	max <= '1', '0' after 10 * period, '1' after 20 * period, '0' after 30 * period, 
	'1' after 50 * period, '0' after 60 * period;
	-- min input (try out each combination of min)
	min <= '0', '1' after 10 * period, '0' after 20 * period, '1' after 30 * period, 
	'1' after 50 * period, '0' after 60 * period;  
	
	
	
	clock: process				-- system clock
	begin
		for i in 0 to 100 loop
			wait for period;
			clk <= not clk;
		end loop;
		std.env.finish;
	end process;
end tb_architecture;



