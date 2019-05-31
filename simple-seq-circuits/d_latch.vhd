-----------------------------------------------------------------------
--
-- Title       : d_latch
-- Design      : d_latch
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/25/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : d_latch is the design description for an 
-- active low enabled D latch.
--
-- Inputs: d, le_bar
-- Outputs: ql
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
	port (
	d : in std_logic; -- data input
	le_bar : in std_logic; -- latch enable input (active low)
	ql : out std_logic -- output
	);
end d_latch;


architecture behavioral of d_latch is
begin
	latch_behavior: process (le_bar, d) -- process sensitivity list
	begin
		if le_bar = '0' then -- if le_bar is low, then set input to output
			ql <= d;
		end if;
	end process latch_behavior;		
end behavioral;