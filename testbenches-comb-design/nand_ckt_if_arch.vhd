-----------------------------------------------------------------------
--
-- Title       : nand_ckt_if_arch
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
-- Description : nand_ckt is a design description that replicates
-- the equation f = (a and b) or c using if statements.
--
-- Inputs: a, b, c_bar
-- Outputs: f
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity nand_ckt is
	port (
	a, b, c_bar : in std_logic; -- inputs
	f : out std_logic -- outputs
	);
end nand_ckt;


architecture if_arch of nand_ckt is
begin
	p0: process (all) is
	begin
		if (c_bar = '0') then
			f <= '1';
		elsif ((a = '1') and (b = '1')) then
			f <= '1';
		else
			f <= '0';
		end if;
	end process p0;
end if_arch;


