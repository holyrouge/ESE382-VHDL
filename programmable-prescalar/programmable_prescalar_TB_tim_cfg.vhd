configuration TIMING_FOR_programmable_prescalar of programmable_prescalar_tb is
	for testbench
		for UUT : programmable_prescalar
--
-- The user should replace : 
-- ENTITY_NAME with an	entity name from a backannotated VHDL file,
-- ARCH_NAME   with an architecture name from a backannotated VHDL file,
-- and uncomment the line below
--			use entity work.ENTITY_NAME (ARCH_NAME);
		end for;
	end for;
end TIMING_FOR_programmable_prescalar;

