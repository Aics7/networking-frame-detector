library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity dec_counter is
    port (clock, clr : in std_logic;
    	zero : out std_logic;
        Q: out std_logic_vector(3 downto 0));
end entity;

architecture dec of dec_counter is

    signal counter_int: integer range 0 to 10;

    begin
        COUNTER : process (clock, clr)
            begin
            	zero <= '0';
                if (clr = '1') then
                    counter_int <= 0;

                elsif rising_edge(clock) then              

                    if (counter_int = 9) then
                      counter_int <= 0;
                      zero <= '1';
                    else
                      counter_int <= counter_int + 1;
                      zero <= '0';
                    end if;
           
                end if;
        end process;
    Q <= std_logic_vector(to_unsigned(counter_int, 4));
end dec;
