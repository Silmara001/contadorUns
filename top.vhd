library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity top is
	port (	clock, btn_reset, btn_start				:in std_logic;
			entrada									:in std_logic_vector(7 downto 0);
			saida									:out std_logic_vector(6 downto 0); 
			rco	:out std_logic;
			dep : out std_logic_vector(1 downto 0));
end top;

architecture hardware_top of top is
	component unidadeControle is
		port ( 	clock, reset, start 				:in std_logic;
				en_reg, en_des 						:out std_logic;
				dep									:out  std_logic_vector(1 downto 0) );
	end component;
	
	component fluxoDados is
		port (	clock, reset, en_reg, en_des   	:in  std_logic;				
				entrada  								:in std_logic_vector(7 downto 0);
				saida       							:out std_logic_vector(6 downto 0);	
				rco     									:out std_logic );
	end component;
	
	signal en_reg, en_des 								:std_logic;
begin
	uc0: unidadeControle port map(clock, btn_reset, btn_start, en_reg, en_des, dep);
	fd: fluxoDados port map(clock, btn_reset, en_reg, en_des, entrada, saida, rco );
end hardware_top;