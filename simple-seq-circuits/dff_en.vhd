-----------------------------------------------------------------------
--
-- Title       : dff_en
-- Design      : dff_en
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/25/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : dff_en is the design description for a D flip flop
-- with an enable input.
--
-- Inputs: d, clk, en, rst_bar
-- Outputs: q
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity dff_en is
	port (
	d : in std_logic; -- data input
	clk : in std_logic; -- clock input
	en : in std_logic; -- enable input
	rst_bar : in std_logic; -- asynchronous reset
	q : out std_logic -- output
	);
end dff_en;


architecture behavioral of dff_en is
begin
	dff_en_behavior: process (clk, rst_bar)
	begin
		if rising_edge(clk) and en = '1' then 
			-- if there has been a change in clk and clk = 1 and en = 1,
			-- set input to output
			q <= d;
		end if;
		
		-- if rst_bar is asserted, clear the flip flop
		-- bc its the last statement, it will make the last 
		-- transaction, so if rst_bar is asserted, it will
		-- always have its output be the actual output
		if rst_bar = '0' then
			q <= '0';
		end if;
	end process dff_en_behavior;
end behavioral;