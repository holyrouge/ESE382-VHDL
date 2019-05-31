-----------------------------------------------------------------------
--
-- Title       : nand_ckt_structural
-- Design      : nand_ckt
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : nand_ckt is a design description that uses
-- two two-input NAND gates with the structural style.
--
-- Inputs: a, b, c_bar
-- Outputs: f
-----------------------------------------------------------------------

-- Two Input NAND Gate
library ieee;
use ieee.std_logic_1164.all;


entity nand_2 is -- NAND component entity declaration
	port (
	in1, in2 : in std_logic; -- inputs
	out1 : out std_logic -- outputs
	);
end nand_2;


architecture dataflow of nand_2 is -- NAND component architecture
begin
	out1 <= in1 nand in2;
end dataflow;


-- Top Level Design Description
library ieee;
use ieee.std_logic_1164.all;


entity nand_ckt is -- top level entity
	port (
	a, b, c_bar : in std_logic; -- inputs
	f : out std_logic -- outputs
	);
end nand_ckt;


architecture structural of nand_ckt is -- top level architecture
signal s1 : std_logic;
begin
	-- instances of nand_2 declaration
	u1 : entity nand_2 port map (in1 => a, in2 => b, out1 => s1);
	u2 : entity nand_2 port map (in1 => s1, in2 => c_bar, out1 => f);
end structural;


