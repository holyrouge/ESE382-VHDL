-----------------------------------------------------------------------
--
-- Title       : comb_fcn_tb
-- Design      : comb_fcn_tb
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : comb_fcn_tb is a self-checking exhausting testbench
-- for the comb_fcn design description.
--
-- Inputs	: None
-- Outputs	: None
-- Requirements	: VHDL 1076-2008 Compiler
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity comb_fcn_tb is
end comb_fcn_tb;


architecture testbench of comb_fcn_tb is

signal inputs : std_logic_vector(2 downto 0); -- vector for inputs
signal outputs : std_logic_vector(1 downto 0); -- vector for outputs

-- record stores the inputs and outputs corresponding to
-- each test case
type test_vector is record
	a, b, c, x, y : std_logic;
end record;

-- truth table for outputs. This is used to match the outputs from 
-- the UUT with the actual answer to verify the design description
type truth_table is array (natural range <>) of test_vector;
constant comb_fcn_table : truth_table := (
-- a, b, c, x, y
('0', '0', '0', '1', '1'),
('0', '0', '1', '0', '1'),
('0', '1', '0', '1', '0'),
('0', '1', '1', '0', '1'),
('1', '0', '0', '0', '0'),
('1', '0', '1', '0', '1'),
('1', '1', '0', '0', '0'),
('1', '1', '1', '1', '1')
); 

constant period : time := 20 ns; -- constant for delays and waveform

begin
	-- make instance of design description
	UUT : entity comb_fcn(dataflow) port map (a => inputs(2), b => inputs(1),
		c => inputs(0), x => outputs(1), y => outputs(0));
		
	tb : process -- process
	begin
		for i in comb_fcn_table'range loop -- loop to try out all of the combinations
			-- set inputs
			inputs(2) <= comb_fcn_table(i).a;
			inputs(1) <= comb_fcn_table(i).b;
			inputs(0) <= comb_fcn_table(i).c;
			
			wait for period; -- wait to suspend program and set values
			
			-- assert statement checks output values and verifies output 
			assert ((comb_fcn_table(i).x = outputs(1)) and (comb_fcn_table(i).y = outputs(0)))
			-- report statement outputs the input, expected output 
			-- and actual output of when the decoder fails
			report "input = " & to_string(inputs) & 
			"    expected output = " & std_logic'image(comb_fcn_table(i).x) & 
			std_logic'image(comb_fcn_table(i).y) & "    actual output = " &
			to_string(outputs) severity error; -- simulation is not stopped
		end loop;
		std.env.finish; -- finish the process
	end process tb; -- end process	
end testbench; -- end architecture