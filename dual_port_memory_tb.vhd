--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:11:14 05/09/2020
-- Design Name:   
-- Module Name:   S:/dual_port_mem/dual_port_memory_tb.vhd
-- Project Name:  dual_port_mem
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dual_port_mem
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
 use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY dual_port_memory_tb IS
END dual_port_memory_tb;
 
ARCHITECTURE behavior OF dual_port_memory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dual_port_mem
    PORT(
         CLKA : IN  std_logic;
         WEA : IN  std_logic;
			 REA : IN  std_logic;
         ADDRA : IN  std_logic_vector(2 downto 0);
         d_in : IN  std_logic_vector(7 downto 0);
         CLKB : IN  std_logic;
         ADDRB : IN  std_logic_vector(2 downto 0);
         d_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal REA : std_logic := '0';
   signal CLKA : std_logic := '0';
   signal WEA : std_logic := '0';
   signal ADDRA : std_logic_vector(2 downto 0) := (others => '0');
   signal d_in : std_logic_vector(7 downto 0) := (others => '0');
   signal CLKB : std_logic := '0';
   signal ADDRB : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal d_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLKA_period : time := 10 ns;
   constant CLKB_period : time := 90 ns;
	
	--Test data
	type rom_type is array (0 to 7) of std_logic_vector( 7 downto 0);
	constant c_TEST_DATA : rom_type := (x"FF", x"F8", x"FC", x"3F", x"E7", x"17", x"CD", x"D8");
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dual_port_mem PORT MAP (
          CLKA => CLKA,
          WEA => WEA,
          ADDRA => ADDRA,
          d_in => d_in,
          CLKB => CLKB,
          ADDRB => ADDRB,
          d_out => d_out,
			 REA => REA
        );
		  
		  
 dual_memo : process
  begin

     WEA <= '1';
    write_loop : for i in 0 to 7 loop
      CLKA   <= '0';
      ADDRA  <= std_logic_vector(to_unsigned(i, 3));
      d_in   <= c_TEST_DATA(i);
      wait for CLKA_period / 2;
      CLKA   <= '1';
      wait for CLKA_period / 2;
    end loop;
    CLKA   <= '0';
    WEA <= '0';

    
    -- Read memory
    REA <= '1';
    read_loop : for i in 0 to 7 loop
      CLKB   <= '0';
      ADDRB  <= std_logic_vector(to_unsigned(i, 3));
      wait for CLKB_period / 2;
      CLKB <= '1';
      wait for CLKB_period / 2;
      assert (d_out = c_TEST_DATA(i))
		report "Incorrect value read back from memory" 
		severity ERROR;
    end loop;
	 CLKB   <= '0';
    REA <= '0';

    wait;
  end process dual_memo;

end architecture behavior;
