library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee.std_logic_unsigned.all;
entity Generador_de_senal is
  port (
    clk: in std_logic;
    rst: in std_logic;
    q: out std_logic

  ) ;
end Generador_de_senal ; 

architecture GeneradorArch of Generador_de_senal is
signal sq: std_logic:='0';  -- Valores logicos van entre ' '
signal counter: integer range 0 to 49999999:=0; -- Los valores enteros van sin nada
-- Las cadenas de bits ej 0001 van entre " "
begin
    process( rst,clk ) -- el process se activa cuando cambia la senal rst o clk
        begin
            if rst = '1' then   -- si reset esta activo entonces
                sq <= '0';      --la salida vale 0
                counter <= 0;   --el contador vale 0
            elsif clk = '1' and clk'event then --si el rst esta desactivado y hubo un flanco de subida d reloj entonces:
                if counter = 49999999 then  --si el contador esta lleno
                    sq <= not sq;   --invierte la senal de salida
                    counter <= 0;   --resetea el contador
                else                --si el contador no esta lleno
                    counter <= counter +1;  --aumenta el contador en 1
                end if;
            else
                sq <= sq;
            end if;
    end process ;
	 q <= sq;
end GeneradorArch ;