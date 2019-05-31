-------------------------------------------------------------------------------
--
-- Title       : converter_bcd_2421_TB
-- Design      : converter_bcd_2421_tb
-- Authors     : Ken Short
-- Company     : Stony Brook University
-- Date		   : 02/17/2019
-- Lab Number  : 03
--
-------------------------------------------------------------------------------
--
-- Description : converter_bcd_2421_tb is a non-self-checking
-- testbench that stimulates the inputs of converter_bcd_2421
-- to test the behavior of the design entity.
--
-- Inputs	: None
-- Outputs  : None
-------------------------------------------------------------------------------

-- Non-self-checking testbench for Laboratory 3 Spring 2019
-- Ken Short 021719
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	-- required to use to_unsigned function

entity converter_bcd_2421_tb is
end converter_bcd_2421_tb;

architecture tb_architecture of converter_bcd_2421_tb is
	
-- Stimulus signals - 
-- signals mapped to the input and inout ports of tested entity
	signal d : std_logic;
	signal c : std_logic;
	signal b : std_logic;
	signal a : std_logic;
	
	-- Observed signals - signals mapped to the 
	-- output ports of tested entity
	signal p : std_logic;
	signal q : std_logic;
	signal r : std_logic;
	signal s : std_logic;
	
	constant period : time := 20ns;
	
begin
	
	-- Unit Under Test port map
	UUT : entity converter_bcd_2421
	port map (
	d => d,
	c => c,
	b => b,
	a => a,
	p => p,
	q => q,
	r => r,
	s => s
	);
	
	
	stim: process		-- apply all binary input combinations
	begin
		for i in 0 to 15 loop
			(d, c, b, a) <= (to_unsigned(i,4));
			wait for period;
		end loop;
		wait;
	end process;
	
end tb_architecture;