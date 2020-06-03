library ieee;
use ieee.std_logic_1164.all;

entity router is
	port(
		wclock: in std_logic;
		rclock: in std_logic;
	--------------------------------
		rst: in std_logic;
	--------------------------------
		wr1: in std_logic;
		wr2: in std_logic;
		wr3: in std_logic;
		wr4: in std_logic;
	--------------------------------
		datai1: in std_logic_vector(7 downto 0);
		datai2: in std_logic_vector(7 downto 0);
		datai3: in std_logic_vector(7 downto 0);
		datai4: in std_logic_vector(7 downto 0);
	--------------------------------
		datao1: out std_logic_vector(7 downto 0);
		datao2: out std_logic_vector(7 downto 0);
		datao3: out std_logic_vector(7 downto 0);
		datao4: out std_logic_vector(7 downto 0)
	);
end router;

architecture Behavioral of router is

----------------------------------------------------------------
type state is(d1,d2,d3,d4); 
signal currentstate : state;
signal nextstate : state;

signal counter : integer := 1;
-----------------------------------------------------------------
	component module1 IS
		PORT( 
			Datat_in: IN std_logic_vector(7 downto 0);
			Clock, Clock_En,Reset : IN std_logic;
			Data_out: OUT std_logic_vector(7 downto 0)
		 );
	end component;
	----------------------------------------------------
	component module2 IS
		PORT( 
			d_in: IN std_logic_vector(7 downto 0);
			sel: IN std_logic_vector(1 downto 0);
			en: in std_logic ; 
			d_out1,d_out2,d_out3,d_out4: OUT std_logic_vector(7 downto 0)
		);
	END component ; 
	----------------------------------------------------
	component FIFO is
		port(
			D_in : in std_logic_vector(7 downto 0);
			D_out : out std_logic_vector(7 downto 0);
			reset,rdclk,wrclk,r_req,w_req : in std_logic;
			empty,full : out std_logic);
	end component;
		
	----------------------------------------------------		
component R_R is
	port(
		clk: in std_logic;
		din1: in std_logic_vector(7 downto 0);
		din2: in std_logic_vector(7 downto 0);
		din3: in std_logic_vector(7 downto 0);
		din4: in std_logic_vector(7 downto 0);
		dout: out std_logic_vector(7 downto 0)
	);
end component;

	signal D_n1,D_n2,D_n3,D_n4: std_logic_vector(7 downto 0);
	---------------------------------------------------------------------
	signal dtof_11,dtof_21,dtof_31,dtof_41: std_logic_vector(7 downto 0);
	signal dtof_12,dtof_22,dtof_32,dtof_42: std_logic_vector(7 downto 0);		
	signal dtof_13,dtof_23,dtof_33,dtof_43: std_logic_vector(7 downto 0);
	signal dtof_14,dtof_24,dtof_34,dtof_44: std_logic_vector(7 downto 0);
	---------------------------------------------------------------------
	signal Odtof_11,Odtof_21,Odtof_31,Odtof_41: std_logic_vector(7 downto 0);
	signal Odtof_12,Odtof_22,Odtof_32,Odtof_42: std_logic_vector(7 downto 0);		
	signal Odtof_13,Odtof_23,Odtof_33,Odtof_43: std_logic_vector(7 downto 0);
	signal Odtof_14,Odtof_24,Odtof_34,Odtof_44: std_logic_vector(7 downto 0);
	---------------------------------------------------------------------
	signal rq_11,rq_21,rq_31,rq_41: std_logic;
	signal rq_12,rq_22,rq_32,rq_42: std_logic;		
	signal rq_13,rq_23,rq_33,rq_43: std_logic;
	signal rq_14,rq_24,rq_34,rq_44: std_logic;
	---------------------------------------------------------------------
	signal wq_11,wq_21,wq_31,wq_41: std_logic;
	signal wq_12,wq_22,wq_32,wq_42: std_logic;		
	signal wq_13,wq_23,wq_33,wq_43: std_logic;
	signal wq_14,wq_24,wq_34,wq_44: std_logic;
	---------------------------------------------------------------------
	signal em_11,em_21,em_31,em_41: std_logic;
	signal em_12,em_22,em_32,em_42: std_logic;		
	signal em_13,em_23,em_33,em_43: std_logic;
	signal em_14,em_24,em_34,em_44: std_logic;
	---------------------------------------------------------------------
	signal fu_11,fu_21,fu_31,fu_41: std_logic;
	signal fu_12,fu_22,fu_32,fu_42: std_logic;		
	signal fu_13,fu_23,fu_33,fu_43: std_logic;
	signal fu_14,fu_24,fu_34,fu_44: std_logic;
	---------------------------------------------------------------------
	signal out1: std_logic_vector(7 downto 0);
	signal out2: std_logic_vector(7 downto 0);		
	signal out3: std_logic_vector(7 downto 0);
	signal out4: std_logic_vector(7 downto 0);
	---------------------------------------------------------------------
	signal t1: std_logic_vector(1 downto 0);
	signal t2: std_logic_vector(1 downto 0);
	signal t3: std_logic_vector(1 downto 0);
	signal t4: std_logic_vector(1 downto 0);
	---------------------------------------------------------------------
	
	begin
		IB_1: module1 port map(datai1,wclock,wr1,rst,D_n1);
		IB_2: module1 port map(datai2,wclock,wr2,rst,D_n2);
		IB_3: module1 port map(datai3,wclock,wr3,rst,D_n3);
		IB_4: module1 port map(datai4,wclock,wr4,rst,D_n4);	
		
		
		-------------------------------------------------------------------------------------------
		t1 <= D_n1(7 downto 6);
		t2 <= D_n2(7 downto 6);
		t3 <= D_n3(7 downto 6);
		t4 <= D_n4(7 downto 6);
		
		DMUX_1: module2 port map(D_n1,t1,wr1,dtof_11,dtof_21,dtof_31,dtof_41);
		DMUX_2: module2 port map(D_n2,t2,wr2,dtof_12,dtof_22,dtof_32,dtof_42);
		DMUX_3: module2 port map(D_n3,t3,wr3,dtof_13,dtof_23,dtof_33,dtof_43);
		DMUX_4: module2 port map(D_n4,t4,wr4,dtof_14,dtof_24,dtof_34,dtof_44);

-------------------------------------------------------------------------------------------
		
		
process(wclock ,wr1,wr2,wr3,wr4) is begin
	if (wr1 = '1') then
		CASE t1 is
			when "00" =>
						if fu_11<='0' then 
							wq_11<='1';
						else 
							wq_11<='0';
						end if;
				wq_21<='0';
				wq_31<='0';
				wq_41<='0';
			when "01" =>
				wq_11<='0';
						if  fu_21<='0' then 
							wq_21<='1';
						else
							wq_21<='0';
						end if;
				wq_11<='0';
				wq_31<='0';
				wq_41<='0';
			when "10" =>
				wq_11<='0';
				wq_21<='0';
					if  fu_31<='0' then 
						wq_31<='1';
					else
						wq_31<='0';
					end if;
				wq_41<='0';
			when "11" =>
				wq_11<='0';
				wq_21<='0';
				wq_31<='0';
					if  fu_41<='0' then 
						wq_41<='1';
					else
						wq_41<='1';
					end if;
			when others =>
		END CASE;
		else 
			wq_11<='0';
			wq_21<='0';
			wq_31<='0';
			wq_41<='0';
	END if;
------------------------------------------------------------
	if (wr2 = '1') then
		CASE t2 is
			when "00" =>
						if fu_12<='0' then 
							wq_12<='1';
						else 
							wq_12<='0';
						end if;
				wq_22<='0';
				wq_32<='0';
				wq_42<='0';
			when "01" =>
				wq_12<='0';
						if  fu_22<='0' then 
							wq_22<='1';
						else
							wq_22<='0';
						end if;
				wq_12<='0';
				wq_32<='0';
				wq_42<='0';
			when "10" =>
				wq_12<='0';
				wq_22<='0';
					if  fu_32<='0' then 
						wq_32<='1';
					else
						wq_32<='0';
					end if;
				wq_42<='0';
			when "11" =>
				wq_12<='0';
				wq_22<='0';
				wq_32<='0';
					if  fu_42<='0' then 
						wq_42<='1';
					else
						wq_42<='1';
					end if;
		when others =>		
		END CASE;
		else 
			wq_12<='0';
			wq_22<='0';
			wq_32<='0';
			wq_42<='0';
	END if;
------------------------------------------
if (wr3 = '1') then
		CASE t3 is
			when "00" =>
						if fu_13<='0' then 
							wq_13<='1';
						else 
							wq_13<='0';
						end if;
				wq_23<='0';
				wq_33<='0';
				wq_43<='0';
			when "01" =>
				wq_13<='0';
						if  fu_23<='0' then 
							wq_23<='1';
						else
							wq_23<='0';
						end if;
				wq_13<='0';
				wq_33<='0';
				wq_43<='0';
			when "10" =>
				wq_13<='0';
				wq_23<='0';
					if  fu_33<='0' then 
						wq_33<='1';
					else
						wq_33<='0';
					end if;
				wq_43<='0';
			when "11" =>
				wq_13<='0';
				wq_23<='0';
				wq_33<='0';
					if  fu_43<='0' then 
						wq_43<='1';
					else
						wq_43<='1';
					end if;
		when others =>		
		END CASE;
		else 
			wq_13<='0';
			wq_23<='0';
			wq_33<='0';
			wq_43<='0';
	END if;
-----------------------------------------------
if (wr4 = '1') then
		CASE t4 is
			when "00" =>
						if fu_14<='0' then 
								wq_14<='1';
						else 
								wq_14<='0';
						end if;
				wq_24<='0';
				wq_34<='0';
				wq_44<='0';
			when "01" =>
				wq_14<='0';
						if  fu_24<='0' then 
								wq_24<='1';
						else
								wq_24<='0';
						end if;
				wq_14<='0';
				wq_34<='0';
				wq_44<='0';
			when "10" =>
				wq_14<='0';
				wq_24<='0';
					if  fu_34<='0' then 
						wq_34<='1';
					else
						wq_34<='0';
					end if;
				wq_44<='0';
			when "11" =>
				wq_14<='0';
				wq_24<='0';
				wq_34<='0';
					if  fu_44<='0' then 
						wq_44<='1';
					else
						wq_44<='1';
					end if;
		when others =>		
		END CASE;
		else 
			wq_14<='0';
			wq_24<='0';
			wq_34<='0';
			wq_44<='0';
	END if;

	
end process;

-------------------------------------------------------------------------------------------------


rs1:process(rclock)
begin
if rising_edge(rclock) then
	if counter = 1 then
		currentstate <= d1;
		counter <= 0;
	else
	currentstate <= nextstate;
	
end if;
end if;
end process rs1;


rs: process(currentstate)
begin
case currentstate is

	when d1 =>
	if em_11 = '0' then 
		rq_11 <= '1';
	else
		rq_11 <= '0';
	end if ;
		rq_12 <= '0';
		rq_13 <= '0';
		rq_14 <= '0';
		 ------------
		if em_21= '0' then 
		rq_21 <= '1';
	else
		rq_21 <= '0';
	end if ;
		rq_22 <= '0';
		rq_23 <= '0';
		rq_24 <= '0';
		 ------------
		if em_31= '0' then 
		rq_31 <= '1';
	else
		rq_31 <= '0';
	end if ;
		rq_32 <= '0';
		rq_33 <= '0';
		rq_34 <= '0';	
		 ------------
		if em_41= '0' then 
		rq_41 <= '1';
	else
		rq_41 <= '0';
	end if ;
		rq_42 <= '0';
		rq_43 <= '0';
		rq_44 <= '0';
		
	nextstate <= d2;
----------------------------------------
	when d2 =>
		if em_12 = '0' then 
		rq_12 <= '1';
	else
		rq_12 <= '0';
	end if ;
		rq_11 <= '0';
		rq_13 <= '0';
		rq_14 <= '0';
		 ------------
		if em_22= '0' then 
		rq_22 <= '1';
	else
		rq_22 <= '0';
	end if ;
		rq_21 <= '0';
		rq_23 <= '0';
		rq_24 <= '0';
		 ------------
		if em_32= '0' then 
		rq_32 <= '1';
	else
		rq_32 <= '0';
	end if ;
		rq_31 <= '0';
		rq_33 <= '0';
		rq_34 <= '0';	
		 ------------
		if em_42= '0' then 
		rq_42 <= '1';
	else
		rq_42 <= '0';
	end if ;
		rq_41 <= '0';
		rq_43 <= '0';
		rq_44 <= '0';
	nextstate <= d3;
---------------------------------------
	when d3 =>
		if em_13 = '0' then 
		rq_13 <= '1';
	else
		rq_13 <= '0';
	end if ;
		rq_12 <= '0';
		rq_11 <= '0';
		rq_14 <= '0';
		 ------------
		if em_23= '0' then 
		rq_23 <= '1';
	else
		rq_23 <= '0';
	end if ;
		rq_22 <= '0';
		rq_21 <= '0';
		rq_24 <= '0';
		 ------------
		if em_33= '0' then 
		rq_33 <= '1';
	else
		rq_33 <= '0';
	end if ;
		rq_32 <= '0';
		rq_31 <= '0';
		rq_34 <= '0';	
		 ------------
		if em_43= '0' then 
		rq_43 <= '1';
	else
		rq_43 <= '0';
	end if ;
		rq_42 <= '0';
		rq_41 <= '0';
		rq_44 <= '0';
			
	nextstate <= d4;

	when d4 =>
		if em_14 = '0' then 
		rq_14 <= '1';
	else
		rq_14 <= '0';
	end if ;
		rq_12 <= '0';
		rq_13 <= '0';
		rq_11 <= '0';
		 ------------
		if em_24= '0' then 
		rq_24 <= '1';
	else
		rq_24 <= '0';
	end if ;
		rq_22 <= '0';
		rq_23 <= '0';
		rq_21 <= '0';
		 ------------
		if em_34= '0' then 
		rq_34 <= '1';
	else
		rq_34 <= '0';
	end if ;
		rq_32 <= '0';
		rq_33 <= '0';
		rq_31 <= '0';	
		 ------------
		if em_44= '0' then 
		rq_44 <= '1';
	else
		rq_44 <= '0';
	end if ;
		rq_42 <= '0';
		rq_43 <= '0';
		rq_41 <= '0';
		
	nextstate <= d1;
	
	


end case;






end process rs;



-------------------------------------------------------------------------------------------------

		FIFO_11:FIFO port map(dtof_11,Odtof_11,rst,rclock,wclock,rq_11,wq_11,em_11,fu_11);
		FIFO_21:FIFO port map(dtof_21,Odtof_21,rst,rclock,wclock,rq_21,wq_21,em_21,fu_21);
		FIFO_31:FIFO port map(dtof_31,Odtof_31,rst,rclock,wclock,rq_31,wq_31,em_31,fu_31);
		FIFO_41:FIFO port map(dtof_41,Odtof_41,rst,rclock,wclock,rq_41,wq_41,em_41,fu_41);
	
		FIFO_12:FIFO port map(dtof_12,Odtof_12,rst,rclock,wclock,rq_12,wq_12,em_12,fu_12);
		FIFO_22:FIFO port map(dtof_22,Odtof_22,rst,rclock,wclock,rq_22,wq_22,em_22,fu_22);
		FIFO_32:FIFO port map(dtof_32,Odtof_32,rst,rclock,wclock,rq_32,wq_32,em_32,fu_32);
		FIFO_42:FIFO port map(dtof_42,Odtof_42,rst,rclock,wclock,rq_42,wq_42,em_42,fu_42);
		
		FIFO_13:FIFO port map(dtof_13,Odtof_13,rst,rclock,wclock,rq_13,wq_13,em_13,fu_13);
		FIFO_23:FIFO port map(dtof_23,Odtof_23,rst,rclock,wclock,rq_23,wq_23,em_23,fu_23);
		FIFO_33:FIFO port map(dtof_33,Odtof_33,rst,rclock,wclock,rq_33,wq_33,em_33,fu_33);
		FIFO_43:FIFO port map(dtof_43,Odtof_43,rst,rclock,wclock,rq_43,wq_43,em_43,fu_43);
		
		FIFO_14:FIFO port map(dtof_14,Odtof_14,rst,rclock,wclock,rq_14,wq_14,em_14,fu_14);
		FIFO_24:FIFO port map(dtof_24,Odtof_24,rst,rclock,wclock,rq_24,wq_24,em_24,fu_24);
		FIFO_34:FIFO port map(dtof_34,Odtof_34,rst,rclock,wclock,rq_34,wq_34,em_34,fu_34);
		FIFO_44:FIFO port map(dtof_44,Odtof_44,rst,rclock,wclock,rq_44,wq_44,em_44,fu_44);
		  
-------------------------------------------------------------------------------------------

		scheduler1:R_R port map(rclock,Odtof_11,Odtof_12,Odtof_13,Odtof_14,out1);
		scheduler2:R_R port map(rclock,Odtof_21,Odtof_22,Odtof_23,Odtof_24,out2);
		scheduler3:R_R port map(rclock,Odtof_31,Odtof_32,Odtof_33,Odtof_34,out3);
		scheduler4:R_R port map(rclock,Odtof_41,Odtof_42,Odtof_43,Odtof_44,out4);

-------------------------------------------------------------------------------------------
		datao1 <= out1 ;
		datao2 <= out2 ;
		datao3 <= out3 ;
		datao4 <= out4 ;

end Behavioral;