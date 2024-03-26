LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testMemoria IS
END testMemoria;
 
ARCHITECTURE behavior OF testMemoria IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM_256x32
	 generic ( n: integer := 32;
				  m: integer := 8
				 );
	 PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(n-1 downto 0);
         wr : IN  std_logic;
         rd : IN  std_logic;
         addr : IN  std_logic_vector(m-1 downto 0);
         dout : OUT  std_logic_vector(n-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal din : std_logic_vector(31 downto 0) := (others => '0');
   signal wr : std_logic := '0';
   signal rd : std_logic := '0';
   signal addr : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM_256x32 PORT MAP (
          clk => clk,
          rst => rst,
          din => din,
          wr => wr,
          rd => rd,
          addr => addr,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	rst <= '1';
	wait for 100 ns;	
	rst <= '0';
	wait for clk_period*10;
	
	     addr <= "00000000"; -- direccion 0
        din <= x"00000001"; -- escribe 1 en la direccion 0
        wr <= '1';
        wait for clk_period;
        wr <= '0';
        wait for clk_period*10;
       
		 -- Read from memory
        rd <= '1';
        wait for clk_period;
        rd <= '0';
        wait for clk_period*10;
        -- Check if the read data is correct
        
		  assert dout = x"00000001" report "Read data is incorrect" severity error;
        wait;
    end process;
END;

      
     