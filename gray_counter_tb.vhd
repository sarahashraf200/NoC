--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:19:28 05/10/2020
-- Design Name:   
-- Module Name:   S:/dual_port_mem/gray_counter_tb.vhd
-- Project Name:  dual_port_mem
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GrayCounter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Testbench IS
END Testbench;

ARCHITECTURE TBarch OF Testbench IS
  COMPONENT GrayCounter IS
    GENERIC (N: integer := 4);
    PORT (Clk, Rst, En: IN std_logic;
          output: OUT std_logic_vector (N-1 DOWNTO 0));
  END COMPONENT;

  SIGNAL Clk_s, Rst_s, En_s: std_logic;
  SIGNAL output_s: std_logic_vector(3 DOWNTO 0);

BEGIN
  CompToTest: GrayCounter GENERIC MAP (4)  PORT MAP (Clk_s, Rst_s, En_s, output_s);
   
  Clk_proc: PROCESS
  
  BEGIN
    Clk_s <= '1';
    WAIT FOR 10 ns;
    Clk_s <= '0';
    WAIT FOR 100 ns;
  END PROCESS clk_proc;
                      
  Vector_proc: PROCESS
  BEGIN
    Rst_s <= '1';
    WAIT UNTIL Clk_s='1' AND Clk_s'EVENT;
    WAIT FOR 50 NS;
    Rst_s <= '0';
    En_s <= '1';
    FOR index IN 0 To 3 LOOP
      WAIT UNTIL Clk_s='1' AND Clk_s'EVENT;
    END LOOP;
    WAIT FOR 50 NS;
    WAIT;
  END PROCESS Vector_proc;

END TBarch;