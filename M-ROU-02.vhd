LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY module2 IS
PORT( 
d_in: IN std_logic_vector(7 downto 0);
sel: IN std_logic_vector(1 downto 0);
en: IN std_logic ; 
d_out1,d_out2,d_out3,d_out4: OUT std_logic_vector(7 downto 0)
);
END ENTITY module2; 

ARCHITECTURE behav OF module2 IS
BEGIN
proc: PROCESS(d_in,sel,en)
BEGIN

IF en='1' then

	CASE sel is
	when "00" =>
	d_out1 <= d_in;
	d_out2 <= "00000000";
	d_out3 <= "00000000";
	d_out4 <= "00000000";
	when "01" =>
	d_out1 <= "00000000";
	d_out2 <= d_in;
	d_out3 <= "00000000";
	d_out4 <= "00000000";
	when "10" =>
	d_out1 <= "00000000";
	d_out2 <= "00000000";
	d_out3 <= d_in;
	d_out4 <= "00000000";
	when "11" =>
	d_out1 <= "00000000";
	d_out2 <= "00000000";
	d_out3 <= "00000000";
	d_out4 <= d_in;
	when others =>
	d_out1 <= "00000000";
	d_out2 <= "00000000";
	d_out3 <= "00000000";
	d_out4 <= "00000000";
	END CASE;

END IF;
	

END PROCESS proc;
END ARCHITECTURE behav;
