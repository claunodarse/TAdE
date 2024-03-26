library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Stopwatch is
    Port (
        clk : in STD_LOGIC; 
        reset : in STD_LOGIC; 
        INIT_PAUSE : in STD_LOGIC; -- Entrada para iniciar/pausar el cronómetro
        STOP : in STD_LOGIC; -- Entrada para detener el cronómetro
        hours : out STD_LOGIC_VECTOR (4 downto 0); -- Salida de horas
        minutes : out STD_LOGIC_VECTOR (5 downto 0); -- Salida de minutos
        seconds : out STD_LOGIC_VECTOR (5 downto 0) -- Salida de segundos
    );
end Stopwatch;

architecture Behavioral of Stopwatch is
    type State_Type is (INIT, RUNNING, PAUSED);
    signal state : State_Type := INIT;
    signal counter_seconds : integer range 0 to 59 := 0; -- Contador de segundos
    signal counter_minutes : integer range 0 to 59 := 0; -- Contador de minutos
    signal counter_hours : integer range 0 to 23 := 0; -- Contador de horas
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= INIT;
            counter_seconds <= 0;
            counter_minutes <= 0;
            counter_hours <= 0;
        elsif rising_edge(clk) then
            case state is
                when INIT =>
                    if INIT_PAUSE = '1' then
                        state <= RUNNING;
                    end if;
                when RUNNING =>
                    if INIT_PAUSE = '1' then
                        state <= PAUSED;
                    elsif STOP = '1' then
                        state <= INIT;
                        counter_seconds <= 0;
                        counter_minutes <= 0;
                        counter_hours <= 0;
                    else
                        counter_seconds <= counter_seconds + 1;
                        if counter_seconds = 59 then
                            counter_seconds <= 0;
                            counter_minutes <= counter_minutes + 1;
                            if counter_minutes = 59 then
                                counter_minutes <= 0;
                                counter_hours <= counter_hours + 1;
                            end if;
                        end if;
                    end if;
                when PAUSED =>
                    if INIT_PAUSE = '1' then
                        state <= RUNNING;
                    elsif STOP = '1' then
                        state <= INIT;
                        counter_seconds <= 0;
                        counter_minutes <= 0;
                        counter_hours <= 0;
                    end if;
            end case;
        end if;
    end process;

    hours <= conv_std_logic_vector(counter_hours, 5); -- Convertir el contador de horas a STD_LOGIC_VECTOR
    minutes <= conv_std_logic_vector(counter_minutes, 6); -- Convertir el contador de minutos a STD_LOGIC_VECTOR
    seconds <= conv_std_logic_vector(counter_seconds, 6); -- Convertir el contador de segundos a STD_LOGIC_VECTOR
end Behavioral;
