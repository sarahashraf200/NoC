--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:48:10 05/19/2020
-- Design Name:   
-- Module Name:   C:/WINDOWS/system32/e1/FIFOCON_tb.vhd
-- Project Name:  e1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fifocon
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
 
ENTITY FIFOCON_tb IS
END FIFOCON_tb;
 
ARCHITECTURE behavior OF FIFOCON_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fifocon
    PORT(
         reset : IN  std_logic;
         rdclk : IN  std_logic;
         wrclk : IN  std_logic;
         r_req : IN  std_logic;
         w_req : IN  std_logic;
         write_valid : OUT  std_logic;
         read_valid : OUT  std_logic;
         empty : OUT  std_logic;
         full : OUT  std_logic;
         wr_ptr : OUT  std_logic_vector(3 downto 0);
         rd_ptr : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal rdclk : std_logic := '0';
   signal wrclk : std_logic := '0';
   signal r_req : std_logic := '0';
   signal w_req : std_logic := '0';

 	--Outputs
   signal write_valid : std_logic;
   signal read_valid : std_logic;
   signal empty : std_logic;
   signal full : std_logic;
   signal wr_ptr : std_logic_vector(3 downto 0);
   signal rd_ptr : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant rdclk_period : time := 10 ns;
   constant wrclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fifocon PORT MAP (
          reset => reset,
          rdclk => rdclk,
          wrclk => wrclk,
          r_req => r_req,
          w_req => w_req,
          write_valid => write_valid,
          read_valid => read_valid,
          empty => empty,
          full => full,
          wr_ptr => wr_ptr,
          rd_ptr => rd_ptr
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
      -- hold reset state for 50 ns.
      wait for 50 ns;	
		
		reset<='1';
      wait for 10 ns;	
		reset<='0';
      wait for 10 ns;	
		w_req <= '1';
		r_req <= '0';
		wait for 20 ns;	
 -- check empty flag & invalid read
		w_req <= '0';
		r_req <= '1';
		wait for 20 ns;	
--check full flag & invalid wright
		r_req <= '0';
		w_req <= '1';
		wait for 160 ns;	
		w_req<='0';
		wait for 10 ns;	
		r_req<='1';
		wait for 10 ns;	
		r_req<='0';




		      wait;
   end process;

END;
