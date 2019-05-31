-------------------------------------------------------------------------------
--
-- Title       : converter_bcd_2421_csop
-- Design      : converter_bcd_2421
-- Authors     : Prangon Ghose (111623211), Albert Thomas (111386879)
-- Company     : Stony Brook University
-- Date		   : 02/16/2019
-- Lab Section : 01
-- Bench Number: 05
-- Lab Number  : 03
--
-------------------------------------------------------------------------------
--
-- Description : converter_bcd_2421 is a BCD to 2421 converter that 
-- utilizes the CSOP implementation of the converter to create 
-- the circuit.
--
-- Inputs: d, c, b, a
-- Outputs: p, q, r, s
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {converter_bcd_2421} architecture {converter_bcd_2421}}

library IEEE;
use IEEE.std_logic_1164.all;

entity converter_bcd_2421 is
	 port(
		 d : in STD_LOGIC;
		 c : in STD_LOGIC;
		 b : in STD_LOGIC;
		 a : in STD_LOGIC;
		 p : out STD_LOGIC;
		 q : out STD_LOGIC;
		 r : out STD_LOGIC;
		 s : out STD_LOGIC
	     );
	attribute loc : string;
 	attribute loc of d : signal is "P3";
	attribute loc of c : signal is "P4";
    attribute loc of b : signal is "P5";
    attribute loc of a : signal is "P6";		
    attribute loc of p : signal is "P27";		
    attribute loc of q : signal is "P26";		
    attribute loc of r : signal is "P25";		
    attribute loc of s : signal is "P24";		 
end converter_bcd_2421;

--}} End of automatically maintained section

-- CSOP implementation of BCD to 2421 Converter
-- Sets the outputs to 0 when the given conditions
-- are true, 1 otherwise.
architecture csop of converter_bcd_2421 is
begin
	p <= ((not d)and c and (not b) and a) 
	or ((not d)and c and b and (not a))
	or ((not d)and c and b and a)
	or ((d and (not c) and (not b) and (not a))
	or (d and (not c) and (not b) and a));
	
	q <= ((not d)and c and (not b) and (not a)) 
	or ((not d)and c and b and (not a))
	or ((not d)and c and b and a)
	or ((d and (not c) and (not b) and (not a))
	or (d and (not c) and (not b) and a));
	
	r <= ((not d)and (not c) and b and (not a))
	or ((not d)and (not c) and b and a)
	or ((not d)and c and (not b) and a)
	or ((d and (not c) and (not b) and (not a))
	or (d and (not c) and (not b) and a));
	
	s <=((not d)and (not c) and (not b) and a)
	or ((not d)and (not c) and b and a)
	or ((not d)and c and (not b) and a) 
	or ((not d)and c and b and a)
	or (d and (not c) and (not b) and a);
end csop;