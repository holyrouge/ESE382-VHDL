-------------------------------------------------------------------------------
--
-- Title       : half_adder
-- Design      : lab02b
-- Author      : Albert Thomas and Prangon Chose
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
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {half_adder} architecture {dataflow}}

library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is
	port(a,b : in std_logic;
	sum, carry_out: out std_logic);

	attribute loc : string;
	attribute loc of a : signal is "P3";
	attribute loc of b : signal is "P4";
	attribute loc of sum : signal is "P27";
	attribute loc of carry_out : signal is "P26";
	
end entity half_adder;

--}} End of automatically maintained section

architecture dataflow of half_adder is
begin

	sum <= (not a and b) or(a and not b);
	carry_out <= a and b;

end dataflow;
