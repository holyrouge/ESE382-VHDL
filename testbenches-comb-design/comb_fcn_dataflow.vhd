-----------------------------------------------------------------------
--
-- Title       : comb_fcn_dataflow
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
-- the dataflow style.
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


architecture dataflow of comb_fcn is
begin
	-- x as a CSOP
	x <= (not a and not b and not c) or (not a and b and not c) or (a and b and c);
	-- Y as a CPOS
	y <= (a or not b or c) and (not a or b or c) and (not a or not b or c);
end dataflow;