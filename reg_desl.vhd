library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity reg_desl is
    Port ( clock, reset, en_reg, en_des		:in  STD_LOGIC;
           entrada 							:in  STD_LOGIC_VECTOR(7 downto 0);
           Q 								:out  STD_LOGIC );
end reg_desl;

architecture hardware_reg of reg_desl is
signal IQ: std_logic_vector(7 downto 0);
begin
	process (clock, reset, en_reg, en_des, entrada, IQ)
	begin
		if reset = '1' then
			IQ <= (others => '0');
		elsif clock'event and clock = '1' then
			if en_reg = '1' then 
				IQ <= entrada;
			elsif en_des = '1' then
				IQ <= '0' & IQ(7 downto 1);
			end if;
		end if;
		Q <= IQ(0);
	end process;
end hardware_reg;

