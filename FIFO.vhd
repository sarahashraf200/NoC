Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity FIFO is
   port( D_in : in std_logic_vector(7 downto 0);
         D_out : out std_logic_vector(7 downto 0);
         reset,rdclk,wrclk,r_req,w_req : in std_logic;
         empty,full : out std_logic);
end FIFO;

Architecture RTL of FIFO is

   component fifocon is
   port( reset, rdclk, wrclk, r_req, w_req : in std_logic;
         write_valid, read_valid, empty, full :out std_logic;
         wr_ptr, rd_ptr : out std_logic_vector(3 downto 0));
   end component;
   
   Component dual_port_mem is
     port(D_in : in std_logic_vector(7 downto 0);
         D_out : out std_logic_vector(7 downto 0);
         WEA, REA : in std_logic;
         ADDRA, ADDRB : in std_logic_vector(3 downto 0);
         CLKA, CLKB : std_logic);
   end component;
   
   SIGNAL wr_ptr,rd_ptr : std_logic_vector(3 downto 0);
   SIGNAL write_valid,read_valid,Nrdclk,Nwrclk : std_logic;
   
   begin
       Nrdclk <= not rdclk;
       Nwrclk <= not wrclk;
      F: fifocon port map(reset, Nrdclk, Nwrclk, r_req, w_req,
               write_valid, read_valid, empty, full, wr_ptr, rd_ptr);
      R: dual_port_mem port map(D_in, D_out, write_valid, read_valid,
               wr_ptr, rd_ptr, wrclk, rdclk);
   end RTL;