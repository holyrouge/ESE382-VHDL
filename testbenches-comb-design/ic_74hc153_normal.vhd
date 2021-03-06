-----------------------------------------------------------------------
--
-- Title       : ic_74hc153_normal
-- Design      : ic_74hc153
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/09/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 06
--
-----------------------------------------------------------------------
--
-- Description : ic_74hc153 is a design description that replicates
-- the behavior of the of 74HC153 integrated circuit.
--
-- Inputs: e_bar, i0, i1, i2, i3, s1, s0
-- Outputs: y
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity ic_74hc153 is
	port (
	i0, i1, i2, i3, s1, s0, e_bar : in std_logic; -- inputs
	y : out std_logic -- outputs
	);
end ic_74hc153;


architecture normal of ic_74hc153 is
begin
	y <= not e_bar and ((not s1 and not s0 and i0) or
	(not s1 and s0 and i1) or
	(s1 and not s0 and i2) or
	(s1 and s0 and i3));
end normal;


