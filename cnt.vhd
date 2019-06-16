library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity cont is
	port (  clock, reset, Q   				:in  std_logic;							
			resultado       				:out std_logic_vector(3 downto 0);	
			rco     						:out std_logic);
end cont;

architecture hardware_cont of cont is
signal IQ: unsigned (3 downto 0);
begin
	process (clock, reset, IQ, Q)
	begin
		if reset = '1' then
			IQ <= (others => '0');
		elsif clock'event and clock = '1' then
			if Q = '1' then 
				IQ <= IQ + 1;
			end if;
		end if;
		resultado <= std_logic_vector(IQ);     
	end process;
	rco <= '1' when (IQ = 15) else '0';
end hardware_cont;