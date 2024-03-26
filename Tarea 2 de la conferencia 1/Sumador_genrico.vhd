library ieee ;

    use ieee.std_logic_1164.all ;

    use ieee.numeric_std.all ;



    entity GenSum is

        generic( n: integer := 4);

        port (

        cin : in std_logic;

        a,b : in std_logic_vector(n-1 downto 0) ;

        sum : out std_logic_vector(n-1 downto 0) ;

        cout : out std_logic

        );

       end GenSum;



       architecture arch of GenSum is

        signal carry : std_logic_vector(n downto 0) ;

       begin

        carry (0) <= cin;

        cout <= carry (n);

        sumGenerate : for i in 0 to n-1 generate

        sum(i) <= a(i) xor b(i) xor carry (i);

        carry (i+1) <= (a(i) and b(i)) or (a(i) and carry (i)) or (b(i) and carry (i));

        end generate;

        end arch;