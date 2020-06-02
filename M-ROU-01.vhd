LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY module1 IS
PORT( 
Datat_in: IN std_logic_vector(7 downto 0);
Clock, Clock_En,Reset : IN std_logic;
Data_out: OUT std_logic_vector(7 downto 0)
 );
END ENTITY module1; 
ARCHITECTURE behav  OF module1 IS
BEGIN
proc1: PROCESS(Clock,Reset)
BEGIN

	IF Reset = '1' THEN
		Data_out <= "00000000" ;
	ELSIF rising_edge(Clock) THEN
		IF Clock_En = '1' THEN
		Data_out <= Datat_in;
		END IF;
	END IF;



END PROCESS proc1;

END ARCHITECTURE behav;