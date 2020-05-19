--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:29:46 05/19/2020
-- Design Name:   
-- Module Name:   C:/WINDOWS/system32/e1/FIFO_tb.vhd
-- Project Name:  e1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FIFO
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
 
ENTITY FIFO_tb IS
END FIFO_tb;
 
ARCHITECTURE behavior OF FIFO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO
    PORT(
         D_in : IN  std_logic_vector(7 downto 0);
         D_out : OUT  std_logic_vector(7 downto 0);
         reset : IN  std_logic;
         rdclk : IN  std_logic;
         wrclk : IN  std_logic;
         r_req : IN  std_logic;
         w_req : IN  std_logic;
         empty : OUT  std_logic;
         full : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D_in : std_logic_vector(7 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal rdclk : std_logic := '0';
   signal wrclk : std_logic := '0';
   signal r_req : std_logic := '0';
   signal w_req : std_logic := '0';

 	--Outputs
   signal D_out : std_logic_vector(7 downto 0);
   signal empty : std_logic;
   signal full : std_logic;

   -- Clock period definitions
   constant rdclk_period : time := 10 ns;
   constant wrclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO PORT MAP (
          D_in => D_in,
          D_out => D_out,
          reset => reset,
          rdclk => rdclk,
          wrclk => wrclk,
          r_req => r_req,
          w_req => w_req,
          empty => empty,
          full => full
        );

   -- Clock process definitions
   rdclk_process :process
   begin
		rdclk <= '0';
		wait for rdclk_period/2;
		rdclk <= '1';
		wait for rdclk_period/2;
   end process;
 
   wrclk_process :process
   begin
		wrclk <= '0';
		wait for wrclk_period/2;
		wrclk <= '1';
		wait for wrclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
     
		reset<='1';
      wait for 10 ns;
		    reset<='0';
      wait for 10 ns;
		D_in<="10101010";
		w_req<='1';
      wait for 10 ns;
		D_in<="11111111";
		w_req<='1';
      wait for 10 ns;
		
		w_req<='0';
		r_req <= '1';
	   wait for 10 ns;
		r_req <= '1';
	
		wait for 10 ns;
		r_req <= '0';
		w_req<='1';
		wait for 160 ns;
		w_req<='0';
		r_req <= '1';


	  wait;
   end process;

END;
