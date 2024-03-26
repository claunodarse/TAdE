library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity Multiplexor is
  port (
 A,B,C,D: in std_logic;
 En : in std_logic_vector (1 downto 0);
 Dout : out std_logic
  ) ;
end Multiplexor ; 

architecture arch of Multiplexor is
begin
process (A,B,C,D,En)
begin
    case En is
        when "00"=> Dout <= A;
        when "01"=> Dout <= B;
        when "10"=> Dout <=C;
        when "11"=> Dout <=D;
		  when others => Dout <= '0';-- no se puede olvidar este caso al utilizar la sentencia case
        end case;
		  end process;
       

end arch ;