library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is
PORT( J,K,CLOCK: in std_logic;
	Q, QB: out std_logic);
end JK_FF;

Architecture behavioral of JK_FF is
begin
PROCESS(CLOCK)
	variable TMP: std_logic:='0';
	begin
	if(CLOCK='1' and CLOCK'EVENT) then
		if(J='0' and K='0')then
			TMP:=TMP;
		elsif(J='1' and K='1')then
			TMP:= not TMP;
		elsif(J='0' and K='1')then
			TMP:='0';
		else
			TMP:='1';
		end if;
	end if;
	Q<=TMP;
	QB <=not TMP;
end PROCESS;
end behavioral;