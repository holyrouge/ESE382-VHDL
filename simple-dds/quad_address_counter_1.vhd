-----------------------------------------------------------------------
--
-- Title       : quad_address_counter
-- Design      : quad_address_counter
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/17/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 09
--
-----------------------------------------------------------------------
--
-- Description : quad_address_counter is the design description for an
-- address counter that produces the appropriate count sequence to address
-- a sine table that contains valaues for only the first quadrant of a 
-- sine wave cycle.
--
-- Inputs: clk, reset_bar
-- Outputs: pos_neg, address				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity quad_address_counter is
	port(
		clk : in std_logic; -- system clock, 50% duty cycle assumbed
		reset_bar : in std_logic; -- active low asynchronous reset
		pos_neg : out std_logic; -- 1 for first half of cycle, 0 for second half
		address : out std_logic_vector(6 downto 0) -- address to sine table
		);
end quad_address_counter;		  


architecture behavior of quad_address_counter is
	signal count : std_logic_vector(6 downto 0); -- holds the count
	signal pos : std_logic; -- holds the pos/neg value
	signal up : integer range 1 to 4; -- holds the up or down value
begin
	behave:
		process (clk, reset_bar) is
	begin
		if reset_bar = '0' then	  -- if reset_bar is enabled, set count to 0, pos to 1
			count <= (others => '0');
			pos <= '1';
			up <= 1;
		else 
			if rising_edge(clk) then -- if rising clock edge
				-- if count is at max, change pos
				if (up = 1 or up = 3) and count = "1111110" then
					up <= up + 1;
					-- after 2 changes of up, changes pos to its opposite
					-- basically after half of sine, changes to opposite signed part
					count <= (others => '1'); -- set count to 0
				elsif (up = 2 or up = 4) and count = "0000001" then
					if up = 4 then -- when up
						up <= 1;
					else
						up <= up + 1;
					end if;
					count <= std_logic_vector(unsigned(count) - 1);
				elsif up = 2 or up = 4 then
					count <= std_logic_vector(unsigned(count) - 1);
				else
					count <= std_logic_vector(unsigned(count) + 1);
					-- otherwise, increment counts
				end if;
			end if;			
		end if;
	end process behave;
	-- set output values from local signals
	pos_neg <= pos;
	address <= count;
end behavior;