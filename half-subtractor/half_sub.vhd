-------------------------------------------------------------------------------
--
-- Title       : half_sub
-- Design      : lab01
-- Author      : Prangon Ghose and Albert Thomas
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : F:\ESE382\Lab1\Lab01b\lab01b\lab01b\src\half_sub.vhd
-- Generated   : Wed Feb  6 09:28:30 2019
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
--{entity {half_sub} architecture {dataflow}}

library IEEE;
use IEEE.std_logic_1164.all;

entity half_sub is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 borrow : out STD_LOGIC;
		 diff : out STD_LOGIC
	     );
end half_sub;

--}} End of automatically maintained section

architecture dataflow of half_sub is
begin
	borrow <= not a and b;	-- a'b for borrow = 1
	diff <= a xor b;	-- a'b or ab' for diff = 1
end dataflow;
