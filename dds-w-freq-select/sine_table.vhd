-----------------------------------------------------------------------
--
-- Title       : sine_table
-- Design      : sine_table
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/17/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 10
--
-----------------------------------------------------------------------
--
-- Description : sine_table is a design description that turns the 
-- address values from quad_address_counter into sine values based on
-- a lookup table.
--
-- Generics: m
-- Inputs: address
-- Outputs: sine_value			 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sine_table is
	generic (
		m : positive := 7 -- width of phase acc. output
		);
	port (
		address : in std_logic_vector(m-1 downto 0); -- table address
		sine_value : out std_logic_vector(m-1 downto 0) -- table entry values
		);
end sine_table;

architecture behavior of sine_table is
	type table is array (0 to 127) of integer range 0 to 127;
	constant sine_tbl : table :=  -- lookup of table of integers representing sine wave
	(0, 2, 3, 5, 6, 8, 9, 11, 12, 14, 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32, 34, 35, 37, 
	38, 40, 41, 43, 44, 46, 47, 49, 50, 51, 53, 54, 56, 57, 58, 60, 61, 63, 64, 65, 67, 68, 69, 
	71, 72, 73, 74, 76, 77, 78, 79, 81, 82, 83, 84, 85, 86, 88, 89, 90, 91, 92, 93, 94, 95, 96, 
	97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 106, 107, 108, 109, 110, 111, 111, 112, 113, 
	113, 114, 115, 115, 116, 117, 117, 118, 118, 119, 120, 120, 121, 121, 122, 122, 122, 123, 123,
	124, 124, 124, 125, 125, 125, 125, 126, 126, 126, 126, 126, 127, 127, 127, 127, 127, 127, 127);
	
begin
	behave:
		process (address) is
		-- variable to hold address as integer
		variable table_index : integer range 0 to 127;
	begin	
		-- turn address into an integer
		table_index := to_integer(unsigned(address));
		-- get sine value from sine lookup table
		sine_value <= std_logic_vector(to_unsigned(sine_tbl(table_index), sine_value'length));
	end process behave;
end behavior;