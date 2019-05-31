-------------------------------------------------------------------------------
--
-- Title       : half_adder
-- Design      : lab02
-- Author      : Albert Thomas and Prangon Ghose
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\ESE 382\lab01\lab01\src\half_adder.vhd
-- Generated   : Mon Feb 11 12:32:23 2019
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : A half adder using dataflow architecture.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {half_adder} architecture {dataflow}}

library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry_out : out STD_LOGIC
	     );
end half_adder;

--}} End of automatically maintained section

architecture dataflow of half_adder is
begin

	sum <= (not a and b) or(a and not b);
	carry_out <= a and b;

end dataflow;
