-----------------------------------------------------------------------
--
-- Title       : d_flip_flop
-- Design      : d_flip_flop
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/25/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : d_flip_flop is the design description for
-- a D flip flop.
--
-- Inputs: d, clk
-- Outputs: qff
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is
	port (
	d : in std_logic; -- data input
	clk : in std_logic; -- clk input
	qff : out std_logic -- output
	);
end d_flip_flop;


architecture behavioral of d_flip_flop is
begin
	flip_flop_behavior: process (clk) -- process sensitivity list
	begin
		if rising_edge(clk) then 
			-- if there is a rising edge on clk,
			-- set input to output
			qff <= d;
		end if;
	end process flip_flop_behavior;		
end behavioral;