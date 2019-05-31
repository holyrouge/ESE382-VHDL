-----------------------------------------------------------------------
--
-- Title       : decoder_3to8_TB
-- Design      : decoder_3to8_tb
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 03/25/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 07
--
-----------------------------------------------------------------------
--
-- Description : decoder_3to8_tb is an exhaustive self-checking
-- testbench for the decoder_3to8 design entity.
--
-- Inputs: None
-- Outputs: None
-----------------------------------------------------------------------

library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

entity decoder_3to8_tb is
end decoder_3to8_tb;

architecture testbench of decoder_3to8_tb is
	signal a : STD_LOGIC_VECTOR(2 downto 0); -- data input
	signal en : STD_LOGIC; -- enable
	signal y : STD_LOGIC_VECTOR(7 downto 0); -- output
	
	constant period : time := 20 ns; -- constant for delays and waveform
	
begin
	
	-- Unit Under Test port map
	UUT : entity decoder_3to8
	port map (
		a => a,
		en => en,
		y => y
		);
	
	decoder_tb: process
	begin
		
		a <= "000";
		en <= '1';
		wait for period; --0 ns
		-- assert statement checks verifies output and outputs report if error
		assert (y = "00000001")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000001'"
		severity error;
		
		a <= "001";
		wait for period; --20 ns
		assert (y = "00000010")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000010'"
		severity error;
		
		a <= "010";
		en <= '0';
		wait for period; --40 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "011";
		wait for period; --60 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "100";
		wait for period; --80 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "101";
		en <= '1';
		wait for period; --100 ns
		assert (y = "00100000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00100000'"
		severity error;
		
		a <= "110";
		wait for period; --120 ns
		assert (y = "01000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '01000000'"
		severity error;
		
		a <= "111";
		wait for period; --140 ns
		assert (y = "10000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '10000000'"
		severity error;
		
		a <= "000";
		en <= '0';
		wait for period; --160 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "001";
		wait for period; --180 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "010";
		wait for period; --200 ns
		assert (y = "00000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000000'"
		severity error;
		
		a <= "011";
		en <= '1';
		wait for period; --220 ns
		assert (y = "00001000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00001000'"
		severity error;
		
		a <= "100";
		wait for period; --240 ns
		assert (y = "00010000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00010000'"
		severity error;
		
		a <= "101";
		wait for period; --260 ns
		assert (y = "00100000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00100000'"
		severity error;
		
		a <= "110";
		wait for period; --280 ns
		assert (y = "01000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '01000000'"
		severity error;
		
		a <= "111";
		wait for period; --300 ns
		assert (y = "10000000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '10000000'"
		severity error;
		
		a <= "000";
		wait for period; --320 ns
		assert (y = "00000001")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000001'"
		severity error;
		
		a <= "001";
		wait for period; --340 ns
		assert (y = "00000010")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000010'"
		severity error;
		
		a <= "010";
		wait for period; --360 ns
		assert (y = "00000100")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00000100'"
		severity error;
		
		a <= "011";
		wait for period; --380 ns
		assert (y = "00001000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00001000'"
		severity error;
		
		a <= "100";
		wait for period; -- 400 ns
		assert (y = "00010000")
		report "ERROR: a = " & to_string(a) & ", en = " & std_logic'image(en)
		& ", actual output = " & to_string(y) & ", expected output = '00010000'"
		severity error;
		wait;
	end process decoder_tb;
end testbench;