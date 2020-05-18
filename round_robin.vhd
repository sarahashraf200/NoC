

library ieee;
use ieee.std_logic_1164.all;

entity R_R is
--generic(n: integer);


port(
clk: in std_logic;
din1: in std_logic_vector(7 downto 0);
din2: in std_logic_vector(7 downto 0);
din3: in std_logic_vector(7 downto 0);
din4: in std_logic_vector(7 downto 0);
dout: out std_logic_vector(7 downto 0)
);



end R_R;

architecture behavioural of R_R is


type state is(d1,d2,d3,d4); 
signal currentstate : state;
signal nextstate : state;
signal DO: std_logic_vector(7 downto 0); -- DO is data out

signal counter : integer := 1;
--signal quant : integer :=2;
--variable t : 

begin
cs:process(clk)
begin
if rising_edge(clk) then
	if counter = 1 then
		currentstate <= d1;
		counter <= 0;
	else
	currentstate <= nextstate;
	dout<= DO;
end if;
end if;
end process cs;


rs: process(currentstate,din1,din2,din3,din4)
begin
case currentstate is

	when d1 =>
	DO <= din1 After 10 ns;
	nextstate <= d2;
	
	when d2 =>
	DO <= din2 After 10 ns;
	nextstate <= d3;

	when d3 =>
	DO <= din3 After 10 ns;
	nextstate <= d4;

	when d4 =>
	DO <= din4 After 10 ns;
	nextstate <= d1;

end case;
end process rs;

end behavioural;