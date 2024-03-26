library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_256x32 is
generic( n: integer := 32;
			m: integer := 8
		);
    Port (
        clk : in STD_LOGIC; 
        rst : in STD_LOGIC; 
        din : in STD_LOGIC_VECTOR (n-1 downto 0); 
        wr : in STD_LOGIC; 
        rd : in STD_LOGIC; 
        addr : in STD_LOGIC_VECTOR (m-1 downto 0); 
        dout : out STD_LOGIC_VECTOR (n-1 downto 0) 
    );
end RAM_256x32;

architecture Behavioral of RAM_256x32 is
    type memory is array (0 to  2**m-1) of STD_LOGIC_VECTOR (n-1 downto 0);
    -- Declaración de la memoria RAM como una señal de tipo 'memory'
    signal ram : memory;
begin
    -- Proceso que se activa en el flanco ascendente de la señal de reloj o en el reset
    process (clk, rst)
    begin
        -- Si la señal de reset es alta, limpiar la memoria
        if rst = '1' then
            ram <= (others => (others => '0'));
        elsif rising_edge(clk) then
            -- Si la señal de escritura es alta, escribir el valor de 'din' en la dirección especificada por 'addr'
            if wr = '1' then
                ram(conv_integer(addr)) <= din;
            end if;
            -- Si la señal de lectura es alta, leer el valor de la dirección especificada por 'addr' y asignarlo a 'dout'
            if rd = '1' then
                dout <= ram(conv_integer(addr));
            end if;
        end if;
    end process;
end Behavioral;
