LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY module1_tb IS
END ENTITY module1_tb; 

ARCHITECTURE behav_tb  OF module1_tb IS
Component module1 is
port(
Datat_in: IN std_logic_vector(7 downto 0);
Clock, Clock_En,Reset : IN std_logic;
Data_out: OUT std_logic_vector(7 downto 0)
);
end component module1;

signal Datat_in :  std_logic_vector(7 downto 0);
signal Clock, Clock_En,Reset :  std_logic;
signal Data_out:  std_logic_vector(7 downto 0);

Begin 


clk: PROCESS is
BEGIN
clock <= '0' , '1' AFTER 10 ns;
WAIT FOR 20 ns;
END PROCESS clk;


stim_proc: PROCESS is
BEGIN
WAIT FOR 10 ns;
Datat_in <= "10101010";
Clock_En <= '1';
Reset <= '0';
WAIT FOR 20 ns;
Datat_in <= "11111111";
Clock_En <= '0';
Reset <= '0';
WAIT FOR 20 ns;
Datat_in <= "11111111";
Clock_En <= '0';
Reset <= '1';

WAIT FOR 20 ns;
Datat_in <= "11001100";
Clock_En <= '1';
Reset <= '0';
WAIT FOR 20 ns;
Datat_in <= "11111111";
Clock_En <= '0';
Reset <= '0';
WAIT FOR 10 ns;
Datat_in <= "11001100";
Clock_En <= '1';
Reset <= '0';

WAIT; --suspend process indifinetly
END PROCESS stim_proc;
utt : module1 PORT MAP (Datat_in,Clock, Clock_En,Reset, Data_out);
END ARCHITECTURE behav_tb;
