library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fluxoDados is
	port(clock, reset, en_reg, en_des   	:in  std_logic;				
		  entrada  							:in std_logic_vector(7 downto 0);
		  saida       						:out std_logic_vector(6 downto 0);	
		  rco     							:out std_logic );
end fluxoDados;

architecture hardware_fd of fluxoDados is
	component reg_desl is
		port  (	clock, reset, en_reg, en_des 	:in  STD_LOGIC;
				entrada 						:in  STD_LOGIC_VECTOR(7 downto 0);
				Q 								:out  STD_LOGIC );
	end component;
	
	component cont is
		 port ( clock, reset, Q   				:in  std_logic;							
				resultado       				:out std_logic_vector(3 downto 0);	
				rco     						:out std_logic );
	end component;
	
	component hex7seg is
		 port (	hex      							: in  std_logic_vector(3 downto 0);
				display  							: out std_logic_vector(6 downto 0) );
	end component;
	
	signal Q : std_logic;
	signal resultado : std_logic_vector(3 downto 0);
	
begin
	reg_des: reg_desl port map(clock, reset, en_reg, en_des, entrada, Q);
	cnt: cont port map(clock, reset, Q, resultado, rco);
	hex: hex7seg port map(resultado, saida);
end hardware_fd;