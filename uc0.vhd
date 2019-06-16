library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity unidadeControle is
	port ( 	clock, reset, start 			:in std_logic;
			en_reg, en_des 					:out std_logic;
			dep									:out  std_logic_vector(1 downto 0) );
end unidadeControle;

architecture hardware_uc of unidadeControle is
	type tipo_estado is (inicial, carrega, contaUns, mostra);
	signal estado   : tipo_estado; 
	signal deslocamentos: unsigned (3 downto 0);
begin
	process (estado, clock, reset, start, deslocamentos)
	begin
		if reset = '1' then
			estado <= inicial;
			deslocamentos <= (others => '0');
		else if (clock'event and clock = '1') then
			case estado is
				when inicial =>
					if start = '1' then
						estado <= carrega;
					else
						estado <= inicial;
					end if;
					
				when carrega =>
						estado <= contaUns;
					
				when contaUns =>
					if deslocamentos = 9 then
						estado <= mostra;
					else
						deslocamentos <= deslocamentos + 1;
						estado <= contaUns;
					end if;
					
				when mostra =>
					estado <= mostra;
			end case;
		end if;
		end if;
	end process;
   
	-- ================================================
	-- Logica de saida (combinatoria)
	-- ================================================
	with estado select en_reg <=
		'1' when carrega,
		'0' when others;
		
	with estado select en_des <=
		'1' when contaUns,
		'0' when others;
		
	with estado select dep <=
		"00" when inicial,
		"01" when carrega,
		"10" when contaUns,
		"11" when mostra,
		"11" when others;
end hardware_uc;