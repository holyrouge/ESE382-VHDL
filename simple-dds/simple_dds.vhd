-----------------------------------------------------------------------
--
-- Title       : simple_dds
-- Design      : simple_dds
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 04/17/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 09
--
-----------------------------------------------------------------------
--
-- Description : simple_dds is the structural design description for
-- a simple direct digital synthesis system that uses the quad_address_counter,
-- the sine_table, and the adder_subtractor to create a DDS system.
--
-- Inputs: clk, reset_bar
-- Outputs: dac_sine_value				 
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_dds is
	port (
		clk : in std_logic; -- system clock
		reset_bar : in std_logic; -- asynchronous reset
		dac_sine_value : out std_logic_vector(7 downto 0) -- to DAC
		);
	attribute loc : string;
	attribute loc of reset_bar : signal is "F1";
	attribute loc of clk : signal is "J1";
	attribute loc of dac_sine_value : signal is 
	"C4,F7,B9,B7,A5,A4,A3,D6";
end simple_dds;


architecture structural of simple_dds is
	signal pos_neg : std_logic; -- pos_neg output of address counter
	signal address : std_logic_vector(6 downto 0); -- address output of address counter
	signal sine_value : std_logic_vector(6 downto 0); -- output of sine_table
begin
	-- quad address counter
	UUT1: entity quad_address_counter port map (clk => clk, reset_bar => reset_bar,
		pos_neg => pos_neg, address => address);
	-- sine table
	UUT2: entity sine_table port map (address => address, sine_value => sine_value);
	-- adder subtractor
	UUT3: entity adder_subtractor port map (pos_neg => pos_neg, sine_value => sine_value,
		dac_sine_value => dac_sine_value);
end structural;