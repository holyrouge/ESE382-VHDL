-----------------------------------------------------------------------
--
-- Title       : mux_6to1
-- Design      : mux_6to1
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/10/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 08
--
-----------------------------------------------------------------------
--
-- Description : mux_6to1 is a 6 input to 1 output multiplexer.
--
-- Inputs: ch[5:0], cs[2:0]
-- Outputs: mux_out				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_6to1 is
	port (
		ch : in std_logic_vector(5 downto 0); -- data input channels
		cs : in std_logic_vector(2 downto 0); -- output of mux
		mux_out : out std_logic -- output of mux
		);
end mux_6to1;

architecture behavior of mux_6to1 is
begin
	mux : process (ch, cs) is
		variable sel : integer;	-- variable to store cs as integer
	begin
		sel := to_integer(unsigned(cs)); -- turn cs into integer
		-- output selected channel if sel < 6, otherwise, 0
		if sel < 6 then
			mux_out <= ch(sel);
		else
			mux_out <= '0';
		end if;
	end process mux;
end behavior;