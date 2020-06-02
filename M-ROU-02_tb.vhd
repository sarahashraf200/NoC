LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY module2_tb IS
END ENTITY module2_tb; 

ARCHITECTURE behav_tb  OF module2_tb IS
Component module2 is
port(
d_in: IN std_logic_vector(7 downto 0);
sel: IN std_logic_vector(1 downto 0);
en: IN std_logic ; 
d_out1,d_out2,d_out3,d_out4: OUT std_logic_vector(7 downto 0)

);
end component module2;

signal d_in: std_logic_vector(7 downto 0);
signal sel:  std_logic_vector(1 downto 0);
signal en:  std_logic ; 
signal d_out1,d_out2,d_out3,d_out4: std_logic_vector(7 downto 0);

Begin 


stim_proc: PROCESS is
BEGIN
WAIT FOR 5 ns;
d_in <= "10101010";
sel <=  "00";
en <= '1';

WAIT FOR 5 ns;
d_in <=  "11111111";
sel <=  "01";
en <=  '1';
WAIT FOR 20 ns;
d_in <=  "10101010";
sel <=  "00";
en <=  '0';

WAIT FOR 5 ns;
d_in <=  "10101010";
sel <=  "10";
en <=  '1';

WAIT FOR 5 ns;
d_in <=  "11110000";
sel <=  "11";
en <=  '1';
WAIT FOR 10 ns;

d_in <=  "10101010";
sel <=  "00";
en <= '0';

WAIT; --suspend process indifinetly
END PROCESS stim_proc;
utt : module2 PORT MAP (d_in, sel, en,d_out1,d_out2,d_out3,d_out4);
END ARCHITECTURE behav_tb;