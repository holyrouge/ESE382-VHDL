-----------------------------------------------------------------------
--
-- Title       : edge_det
-- Design      : edge_det
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 05/01/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 11
--
-----------------------------------------------------------------------
--
-- Description : edge_det is the design description for a positive and
-- a negative edge detection for the signal input.
--
-- Inputs: rst_bar, clk, sig, pos
-- Outputs: sig_edge			 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_det is
	port (
		rst_bar : in std_logic; -- asynchronous system reset
		clk : in std_logic;	-- system clock
		sig : in std_logic; -- input signal
		pos : in std_logic; -- '1' for positive edge, '0' for negative edge
		sig_edge : out std_logic -- high for one sys clock after edge
		);
end edge_det;

architecture moore_fsm of edge_det is
	-- enumerate state type with 3 states
	type state is (state_a, state_b, state_c);
	signal present_state, next_state : state; -- hold present and next states
begin
	-- state register
	state_reg : process (clk, rst_bar)
	begin
		-- asynchronous reset
		if rst_bar = '0' then
			present_state <= state_a;
			-- at the next clock edge, go to the next state
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process state_reg;
	
	-- determine output based on current state
	outputs : process (present_state)
	begin
		case present_state is
			-- pulse of '1' when in state_c, otherwise '0'
			when state_c => sig_edge <= '1';
			when others => sig_edge <= '0';
		end case;
	end process outputs;
	
	-- determine next state based on current state and
	-- inputs
	nxt_state : process (present_state, sig)
	begin
		case present_state is
			when state_a =>
				-- positive-edge detect
				-- move to state_b if '0'
				if pos = '1' and sig = '0' then
					next_state <= state_b;
					-- negative-edge detect
					-- move to state_b if '1'
				elsif pos = '0' and sig = '1' then
					next_state <= state_b;
				else
					next_state <= state_a;
				end if;
			
			when state_b =>
				-- positive-edge detect
				-- if transition from '0' to '1', then move to state_c
				if pos = '1' and sig = '1' then
					next_state <= state_c;
					-- negative-edge detect
					-- if transition from '1' to '0', then move to state_c
				elsif pos = '0' and sig = '0' then
					next_state <= state_c;
				else
					next_state <= state_b;
				end if;
			
			when others =>
				-- positive-edge detect
				-- if transition from '1' to '0', move back to state_b
				if pos = '1' and sig = '0' then
					next_state <= state_b;
					-- if transition from '0' to '1', move back to state_b
				elsif pos = '0' and sig = '1' then
					next_state <= state_b;
					-- otherwise, go back to state_a
				else
					next_state <= state_a;
				end if;
			
		end case;
	end process nxt_state;
end moore_fsm;