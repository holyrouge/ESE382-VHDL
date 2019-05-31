-----------------------------------------------------------------------
--
-- Title       : nand_ckt_tb
-- Design      : nand_ckt_tb
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : nand_ckt_tb is a self-checking exhausting testbench
-- for the nand_ckt design description.
--
-- Inputs	: None
-- Outputs	: None
-- Requirements	: VHDL 1076-2008 Compiler
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity nand_ckt_tb is
end nand_ckt_tb;


architecture testbench of nand_ckt_tb is

signal inputs : std_logic_vector(2 downto 0); -- vector for inputs
signal output : std_logic; -- output

constant period : time := 20 ns; -- constant for delays and waveform

begin
	-- make instance of design description
	UUT : entity nand_ckt(structural) port map (a => inputs(2), b => inputs(1),
		c_bar => inputs(0), f => output);
		
	tb : process -- process
	variable exp_output : std_logic; -- variable to store expected output
	begin
		for i in 0 to 7 loop -- loop to try out all of the combinations
			inputs <= std_logic_vector(to_unsigned(i, 3)); -- set inputs
			
			wait for period; -- wait to suspend program and set values
			
			-- finding expected output through an if statement 
			if ((inputs = "001") or (inputs = "011") or (inputs = "101")) then
				exp_output := '0';
			else
				exp_output := '1';
			end if; -- end if
			
			-- assert statement checks output values and verifies output 
			assert (exp_output = output)
			-- report statement outputs the input, expected output 
			-- and actual output of when the decoder fails
			report "input = " & to_string(inputs) & "    expected output = "
			& to_string(exp_output) & "    actual output = " & to_string(output)
			severity error; -- simulation is not stopped
		end loop;
		std.env.finish; -- finish process
	end process tb; -- end process	
end testbench; -- end architecture