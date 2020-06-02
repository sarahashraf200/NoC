--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:00:49 05/23/2020
-- Design Name:   
-- Module Name:   H:/prog/eda/router_tb.vhd
-- Project Name:  eda
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: router
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY router_tb IS
END router_tb;
 
ARCHITECTURE behavior OF router_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT router
    PORT(
         wclock : IN  std_logic;
         rclock : IN  std_logic;
         rst : IN  std_logic;
         wr1 : IN  std_logic;
         wr2 : IN  std_logic;
         wr3 : IN  std_logic;
         wr4 : IN  std_logic;
         datai1 : IN  std_logic_vector(7 downto 0);
         datai2 : IN  std_logic_vector(7 downto 0);
         datai3 : IN  std_logic_vector(7 downto 0);
         datai4 : IN  std_logic_vector(7 downto 0);
         datao1 : OUT  std_logic_vector(7 downto 0);
         datao2 : OUT  std_logic_vector(7 downto 0);
         datao3 : OUT  std_logic_vector(7 downto 0);
         datao4 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal wclock : std_logic := '0';
   signal rclock : std_logic := '0';
   signal rst : std_logic := '0';
   signal wr1 : std_logic := '0';
   signal wr2 : std_logic := '0';
   signal wr3 : std_logic := '0';
   signal wr4 : std_logic := '0';
   signal datai1 : std_logic_vector(7 downto 0) := (others => '0');
   signal datai2 : std_logic_vector(7 downto 0) := (others => '0');
   signal datai3 : std_logic_vector(7 downto 0) := (others => '0');
   signal datai4 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal datao1 : std_logic_vector(7 downto 0);
   signal datao2 : std_logic_vector(7 downto 0);
   signal datao3 : std_logic_vector(7 downto 0);
   signal datao4 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant wclock_period : time := 10 ns;
   constant rclock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: router PORT MAP (
          wclock => wclock,
          rclock => rclock,
          rst => rst,
          wr1 => wr1,
          wr2 => wr2,
          wr3 => wr3,
          wr4 => wr4,
          datai1 => datai1,
          datai2 => datai2,
          datai3 => datai3,
          datai4 => datai4,
          datao1 => datao1,
          datao2 => datao2,
          datao3 => datao3,
          datao4 => datao4
        );

   -- Clock process definitions
   wclock_process :process
   begin
		wclock <= '1';
		wait for wclock_period/2;
		wclock <= '0';
		wait for wclock_period/2;
   end process;
 
   rclock_process :process
   begin
		rclock <= '0';
		wait for rclock_period/2;
		rclock <= '1';
		wait for rclock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst <= '1';
      wait for 30 ns;	
		rst<='0';
		wait for 40 ns;	

		datai1<="00000001";
		
		datai2<="00010010";

		datai3<="00100011";

		datai4<="00110100";
		wr1<='1';
		wr2<='1';
		wr3<='1';
		wr4<='1';
			
		wait for 10 ns;
		

		datai1<="01000001";
		datai2<="01010010";
		datai3<="01100011";
		datai4<="01110100";
		wait for 10 ns;
		datai1<="10000001";
		datai2<="10010010";
		datai3<="10100011";
		datai4<="10110100";
		wait for 10 ns;
		datai1<="11000001";
		datai2<="11010010";
		datai3<="11100011";
		datai4<="11110100";
		wait for 10 ns;
		wr1<='0';
		wr2<='0';
		wr3<='0';
		wr4<='0';
		wait for 30 ns;
		assert datao1 = "00000001" report "test case 1 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00010010" report "test case 21 failed" severity warning;
		assert datao2 = "01010010" report "test case 22 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00100011" report "test case 31 failed" severity warning;
		assert datao2 = "01100011" report "test case 32 failed" severity warning;
		assert datao3 = "10100011" report "test case 33 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00110100" report "test case 41 failed" severity warning;
		assert datao2 = "01110100" report "test case 42 failed" severity warning;
		assert datao3 = "10110100" report "test case 43 failed" severity warning;
		assert datao4 = "11110100" report "test case 44 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00000001" report "test case 51 failed" severity warning;
		assert datao2 = "01000001" report "test case 52 failed" severity warning;
		assert datao3 = "10000001" report "test case 53 failed" severity warning;
		assert datao4 = "11000001" report "test case 54 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00010010" report "test case 61 failed" severity warning;
		assert datao2 = "01010010" report "test case 62 failed" severity warning;
		assert datao3 = "10010010" report "test case 63 failed" severity warning;
		assert datao4 = "11010010" report "test case 64 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00100011" report "test case 71 failed" severity warning;
		assert datao2 = "01100011" report "test case 72 failed" severity warning;
		assert datao3 = "10100011" report "test case 73 failed" severity warning;
		assert datao4 = "11100011" report "test case 74 failed" severity warning;
		wait for 10 ns;
		assert datao1 = "00110100" report "test case 81 failed" severity warning;
		assert datao2 = "01110100" report "test case 82 failed" severity warning;
		assert datao3 = "10110100" report "test case 83 failed" severity warning;
		assert datao4 = "11110100" report "test case 84 failed" severity warning;

	
		
		
		

      wait;
   end process;

END;
