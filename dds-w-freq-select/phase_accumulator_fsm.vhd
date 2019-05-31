-----------------------------------------------------------------------
--
-- Title       : phase_accumulator_fsm
-- Design      : phase_accumulator_fsm
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/24/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : phase_accumulator_fsm is a design description for a FSM
-- that controls the direction of count of the phase accumulator based on
-- the values of the status signals max and min from the phase accumulator
--
-- Inputs: clk, rst_bar, max, min
-- Outputs: up, pos			 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity phase_accumulator_fsm is
	port (
		rst_bar : in std_logic; -- active low asynchronous system reset
		clk : in std_logic;	-- system clock
		max : in std_logic; -- max count
		min : in std_logic; -- min count
		up : out std_logic; -- count direction
		pos : out std_logic -- positive half of sine cycle
		);
end phase_accumulator_fsm;

architecture behavior of phase_accumulator_fsm is
	-- enumerate state type with 4 states
	type state is (state_a, state_b, state_c, state_d);
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
		variable state_output : std_logic_vector(1 downto 0); -- holds the output of states
	begin
		case present_state is
			when state_a =>	
			-- when in state a, up is 1, pos is 1
			state_output := "11";
			when state_b =>
			-- when in state b, up is 0, pos is 1
			state_output := "01";
			when state_c =>
			-- when in state c, up is 1, pos is 0
			state_output := "10";
			when state_d =>
			-- when in state d, up is 0, pos is 0
			state_output := "00";
			when others =>
			-- if others, do nothing
			null;
		end case;
		-- assign state_output to up and pos
		up <= state_output(1);
		pos <= state_output(0);
	end process outputs;
	
	-- determine next state based on current state and
	-- inputs
	nxt_state : process (present_state, max, min)
	begin
		case present_state is
			when state_a =>
				-- in state a, move to state b if max = 1
				if max = '1' then
					next_state <= state_b;
				else 
					next_state <= state_a;
			end if;
			when state_b =>
				-- in state b, move to state c if min = 1
				if min = '1' then
					next_state <= state_c;
				else 
					next_state <= state_b;
			end if;
			when state_c =>
				-- in state c, move to state d, if max = 1
				if max = '1' then
					next_state <= state_d;
				else 
					next_state <= state_c;
			end if;
			when state_d =>
				-- in state d, move to state a, if min = 1
				if min = '1' then
					next_state <= state_a;
				else 
					next_state <= state_d;
			end if;
			when others =>
			-- if others, move to state a
			next_state <= state_a;			
		end case;
	end process nxt_state;
end behavior;