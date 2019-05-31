-----------------------------------------------------------------------
--
-- Title       : ic_74hc153_tb
-- Design      : ic_74hc153_tb
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : ic_74hc153_tb is a self-checking exhausting testbench
-- for the ic_74hc153 design description.
--
-- Inputs	: None
-- Outputs	: None
-- Requirements	: VHDL 1076-2008 Compiler
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ic_74hc153_tb is
end ic_74hc153_tb;


architecture testbench of ic_74hc153_tb is
	
	signal inputs : std_logic_vector(3 downto 0); -- vector for inputs
	signal e_bar  : std_logic; -- e_bar
	signal selected : std_logic_vector(1 downto 0); -- vector for selected
	signal output : std_logic; -- output
	
	constant period : time := 20 ns; -- constant for delays and waveform
	constant enable : std_logic := '1'; -- enable value to determine the architecture
	--  being used
	
begin
	-- make instance of design description
	UUT : entity ic_74hc153(normal) port map (e_bar => e_bar, s1 => selected(1),
		s0 => selected(0), i3 => inputs(3), i2 => inputs(2), i1 => inputs(1), 
		i0 => inputs(0), y => output);
	
	tb : process -- process
		variable exp_output : std_logic; -- variable to store expected output
		variable selectedVar : std_logic_vector(1 downto 0); -- variable to store selected
	begin
		-- output which architecture is being used
		if enable = '1' then
			report "Verifying 74HC153 IC with High Z";
		else
			report "Verifying 74HC153 IC without High Z";
		end if;
		
		-- Test with E_BAR = '0'
		for j in 0 to 3 loop -- loop to try out all combinations of select
			selectedVar := std_logic_vector(to_unsigned(j, 2));
			report "Verifying for E_BAR = '0', S1 = " & std_logic'image(selectedVar(1))
			& ", S0 = " & std_logic'image(selectedVar(0));
			for i in 0 to 15 loop -- loop to try out all combinations of inputs
				-- (i3, i2, i1, i0) 
				inputs <= std_logic_vector(to_unsigned(i, 4)); -- set inputs
				e_bar <= '0'; -- set e_bar
				selected <= selectedVar; -- set selected
				
				wait for period; -- wait to suspend program and set values
				
				-- finding expected output through an if statement
				-- if e_bar = '0' and the input at integer value of (s1, s0) = '1', output = '1'
				if (not e_bar and inputs(to_integer(unsigned(selectedVar)))) then
					exp_output := '1';
				else 
					exp_output := '0';
				end if;
				
				-- if enable, set high Z when e_bar is not asserted
				if ((e_bar = '1') and (enable = '1')) then
					exp_output := 'Z';
				else
					null;
				end if;
				
				-- assert statement checks output values and verifies output 
				assert (exp_output = output)
				-- report statement outputs the input, expected output 
				-- and actual output of when the decoder fails
				report "ERROR: e_bar = " & std_logic'image(e_bar) & ", s1 = " & to_string(selected(1))
				& ", s0 = " & to_string(selected(0)) & ", i3 = " & to_string(inputs(3)) & 
				", i2 = " & to_string(inputs(2)) & ", i1 = " & to_string(inputs(1)) 
				& ", i0 = " & to_string(inputs(0)) & ",    expected output = "
				& to_string(exp_output) & ",    actual output = " & to_string(output)
				severity error; -- simulation is not stopped
			end loop; -- end inner loop
		end loop; -- end outer loop
		
		-- Test with E_BAR = '1'
		for j in 0 to 3 loop -- loop to try out all combinations of select
			selectedVar := std_logic_vector(to_unsigned(j, 2));
			report "Verifying for E_BAR = '1', S1 = " & std_logic'image(selectedVar(1))
			& ", S0 = " & std_logic'image(selectedVar(0));
			for i in 0 to 15 loop -- loop to try out all combinations of inputs
				-- (i3, i2, i1, i0) 
				inputs <= std_logic_vector(to_unsigned(i, 4)); -- set inputs
				e_bar <= '1'; -- set e_bar
				selected <= selectedVar; -- set selected
				
				wait for period; -- wait to suspend program and set values
				
				-- finding expected output through an if statement
				-- if e_bar = '0' and the input at integer value of (s1, s0) = '1', output = '1'
				if (not e_bar and inputs(to_integer(unsigned(selectedVar)))) then
					exp_output := '1';
				else 
					exp_output := '0';
				end if;
				
				-- if enable, set high Z when e_bar is not asserted
				if ((e_bar = '1') and (enable = '1')) then
					exp_output := 'Z';
				else
					null;
				end if;
				
				-- assert statement checks output values and verifies output 
				assert (exp_output = output)
				-- report statement outputs the input, expected output 
				-- and actual output of when the decoder fails
				report "ERROR: e_bar = " & std_logic'image(e_bar) & ", s1 = " & to_string(selected(1))
				& ", s0 = " & to_string(selected(0)) & ", i3 = " & to_string(inputs(3)) & 
				", i2 = " & to_string(inputs(2)) & ", i1 = " & to_string(inputs(1)) 
				& ", i0 = " & to_string(inputs(0)) & ",    expected output = "
				& to_string(exp_output) & ",    actual output = " & to_string(output)
				severity error; -- simulation is not stopped
			end loop; -- end inner loop
		end loop; -- end outer loop
		
		std.env.finish; -- finish process
	end process tb; -- end process	
end testbench; -- end architecture