-----------------------------------------------------------------------
--
-- Title       : comb_fcn_case_arch
-- Design      : comb_fcn
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : comb_fcn is a decoder based on a truth table that takes
-- three values and outputs two values. The architecture uses
-- case statements.
--
-- Inputs: a, b, c
-- Outputs: x, y
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity comb_fcn is
	port (
	a, b, c : in std_logic; -- inputs
	x, y : out std_logic -- outputs
	);
end comb_fcn;


architecture case_arch of comb_fcn is
signal inputs : std_logic_vector(2 downto 0);
signal outputs : std_logic_vector(1 downto 0);
begin
	inputs <= (a, b, c);
	(x, y) <= outputs;
	
	cmb_fcn: process (inputs) is
	begin
		case (inputs) is
			when "100" | "110" => outputs <= "00";
			when "001" | "011" | "101" => outputs <= "01";
			when "010" => outputs <= "10";
			when others => outputs <= "11";
		end case;
	end process cmb_fcn;
end case_arch;