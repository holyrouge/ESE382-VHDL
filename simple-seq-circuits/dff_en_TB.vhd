library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity dff_en_tb is
end dff_en_tb;

architecture TB_ARCHITECTURE of dff_en_tb is
	-- Component declaration of the tested unit
	component dff_en
	port(
		d : in STD_LOGIC;
		clk : in STD_LOGIC;
		en : in STD_LOGIC;
		rst_bar : in STD_LOGIC;
		q : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal d : STD_LOGIC;
	signal clk : STD_LOGIC;
	signal en : STD_LOGIC;
	signal rst_bar : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dff_en
		port map (
			d => d,
			clk => clk,
			en => en,
			rst_bar => rst_bar,
			q => q
		);

	--Below VHDL code is an inserted .\compile\dff_en_waveform.vhs
	--User can modify it ....

STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>

	clk <= '0';
	d <= '0';
	en <= '0';
	rst_bar <= '0';
    wait for 20 ns; --0 fs
	rst_bar <= '1';
    wait for 5 ns; --20 ns
	clk <= '1';
    wait for 25 ns; --25 ns
	clk <= '0';
	d <= '1';
    wait for 25 ns; --50 ns
	clk <= '1';
    wait for 25 ns; --75 ns
	clk <= '0';
	d <= '0';
    wait for 20 ns; --100 ns
	en <= '1';
    wait for 5 ns; --120 ns
	clk <= '1';
    wait for 15 ns; --125 ns
	d <= '1';
    wait for 10 ns; --140 ns
	clk <= '0';
    wait for 25 ns; --150 ns
	clk <= '1';
    wait for 25 ns; --175 ns
	clk <= '0';
	d <= '0';
    wait for 25 ns; --200 ns
	clk <= '1';
    wait for 25 ns; --225 ns
	clk <= '0';
    wait for 25 ns; --250 ns
	clk <= '1';
    wait for 5 ns; --275 ns
	d <= '1';
    wait for 20 ns; --280 ns
	clk <= '0';
    wait for 25 ns; --300 ns
	clk <= '1';
    wait for 25 ns; --325 ns
	clk <= '0';
    wait for 10 ns; --350 ns
	en <= '0';
	rst_bar <= '0';
    wait for 10 ns; --360 ns
	rst_bar <= '1';
    wait for 5 ns; --370 ns
	clk <= '1';
    wait for 25 ns; --375 ns
	clk <= '0';
--	end of stimulus events
	wait;
end process; -- end of stimulus process
	



	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dff_en of dff_en_tb is
	for TB_ARCHITECTURE
		for UUT : dff_en
			use entity work.dff_en(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_dff_en;

