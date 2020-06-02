----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:56:36 05/09/2020 
-- Design Name: 
-- Module Name:    dual_port_memory - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity dual_port_mem is
  generic(
    DATA_WIDTH  : natural := 8;  -- each word is 8 bits
    ADDR_WIDTH  : natural := 4   -- the address of each port is 3 bits
  );
  port (
    -- Port A
    CLKA      : in  std_logic;
    WEA       : in  std_logic;  -- short for write enable active and it's only for port A as this port is write only
    ADDRA     : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    d_in      : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    -- Port B
    CLKB ,REA     : in  std_logic;
    ADDRB     : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    d_out     : out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end entity;

architecture behavior of dual_port_mem is

  type t_mem_type is array ((2**ADDR_WIDTH)-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
  
  
  -- total number of bits that's filled in the memory is the multiplication of the length of memory times width of memory
  -- since 2^address = the depth of the memory block
  
  
  signal r_memory : t_mem_type := (others=>(others=>'0')); 
  
  
  -- intiallizing the array which has a depth of ((2**ADDR_WIDTH)-1 downto 0) 
  -- and length of the number of data bits in each index, as we said memory bits = length * width
  -- here what the expression others=>(others=>'0')) means: For _most_ Xilinx FPGA famlies, the bitstream initializes all memories
--by default.  If you don't specify a value to initialize the RAMs, then
--it will be all zeroes in the bitstream.  This also helps to reduce
--bitstream size when using compression.  Explicitly choosing all zeroes,
--when you really don't care about the initial value has the effect
--of making simulation match the hardware.
--If instead you wanted to make sure you don't read uninitialized memory


 
begin


  -- when write enable is high it will synchronus clock 
  --and data will be written at a specific address at the rising edge of the clk but when write enable is low
  -- it will only read out the data from the address

  port_a : process(CLKA)
  begin
    if rising_edge(CLKA) then    
	 if (WEA = '1') then 
      r_memory(to_integer(unsigned(ADDRA))) <= d_in;
    end if;
	 end if;
  end process;

  port_b : process(CLKB)
  begin
    if rising_edge(CLKB) then
	 if REA = '1' then
      d_out <= r_memory(to_integer(unsigned(ADDRB)));
		end if;
    end if;
  end process;

end architecture;

