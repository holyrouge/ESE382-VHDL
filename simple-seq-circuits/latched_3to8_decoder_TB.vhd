-----------------------------------------------------------------------
--
-- Title       : latched_3to8_decoder_tb
-- Design      : latched_3to8_decoder_tb
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/27/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : latched_3to8_decoder_tb is a generated testbench for
-- latched_3to8_decoder from a stimulator-based waveform.
--
-- Inputs: None 
-- Outputs: None
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity latched_3to8_decoder_tb is
end latched_3to8_decoder_tb;

architecture TB_ARCHITECTURE of latched_3to8_decoder_tb is
	-- Component declaration of the tested unit
	component latched_3to8_decoder
	port(
		a : in STD_LOGIC_VECTOR(2 downto 0);
		e1_bar : in STD_LOGIC;
		e2 : in STD_LOGIC;
		le_bar : in STD_LOGIC;
		y : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC_VECTOR(2 downto 0);
	signal e1_bar : STD_LOGIC;
	signal e2 : STD_LOGIC;
	signal le_bar : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal y : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : latched_3to8_decoder
		port map (
			a => a,
			e1_bar => e1_bar,
			e2 => e2,
			le_bar => le_bar,
			y => y
		);

	--Below VHDL code is an inserted .\compile\latched_3to8_decoder_wave.vhs
	--User can modify it ....

STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>

	a <= "000";
	e2 <= '1';
	e1_bar <= '0';
	le_bar <= '0';
    wait for 20 ns; --0 fs
	a <= "001";
    wait for 20 ns; --20 ns
	a <= "010";
    wait for 10 ns; --40 ns
	le_bar <= '1';
    wait for 10 ns; --50 ns
	a <= "011";
    wait for 20 ns; --60 ns
	a <= "100";
	e2 <= '0';
    wait for 20 ns; --80 ns
	a <= "101";
	le_bar <= '0';
    wait for 20 ns; --100 ns
	a <= "110";
	e1_bar <= '1';
    wait for 20 ns; --120 ns
	a <= "111";
    wait for 10 ns; --140 ns
	e1_bar <= '0';
    wait for 10 ns; --150 ns
	a <= "000";
    wait for 10 ns; --160 ns
	e2 <= '1';
    wait for 10 ns; --170 ns
	a <= "001";
    wait for 20 ns; --180 ns
	a <= "010";
	e1_bar <= '1';
    wait for 10 ns; --200 ns
	e2 <= '0';
    wait for 10 ns; --210 ns
	a <= "011";
    wait for 15 ns; --220 ns
	e1_bar <= '0';
    wait for 5 ns; --235 ns
	a <= "100";
	e2 <= '1';
	le_bar <= '1';
    wait for 20 ns; --240 ns
	a <= "101";
	le_bar <= '0';
    wait for 20 ns; --260 ns
	a <= "110";
    wait for 20 ns; --280 ns
	a <= "111";
    wait for 20 ns; --300 ns
	a <= "000";
    wait for 20 ns; --320 ns
	a <= "001";
    wait for 20 ns; --340 ns
	a <= "010";
    wait for 20 ns; --360 ns
	a <= "011";
    wait for 20 ns; --380 ns
	a <= "100";
--	end of stimulus events
	wait;
end process; -- end of stimulus process

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_latched_3to8_decoder of latched_3to8_decoder_tb is
	for TB_ARCHITECTURE
		for UUT : latched_3to8_decoder
			use entity work.latched_3to8_decoder(netlist);
		end for;
	end for;
end TESTBENCH_FOR_latched_3to8_decoder;

