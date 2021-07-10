-- Testbench for 01111110 detector
library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component detector is
port(
  clock: in std_logic;
  reset: in std_logic;
  x: in std_logic;
  y: out std_logic);
end component;

signal clock_in, reset_in, x_in, y_out: std_logic;
signal input : std_logic_vector(150 downto 0) := "0111111000101011111101111110111111001111110011010101010111111000101010100001111110101111101111110010101010111111100011111101011111110101111110011111101";

begin

  -- Connect DUT
  DUT: detector port map(clock=> clock_in, reset=> reset_in, x=> x_in, y=>y_out);

  process
  
  begin
  reset_in <= '0';
  --using a for loop to loop seven times
  loop_test: for k in 0 to 151 loop
  	--setting reset to zero just to be safe
    
    clock_in <= '0';
    x_in <= input(k);
    wait for 1 ns;
    clock_in <= '1';
    wait for 1 ns;
    assert(y_out='0') report "Frame marker detected" severity error;
    --assert is used here to verify the output

    end loop loop_test;
    
    
    -- Clear inputs
    x_in <= '0';
    clock_in <= '0';
    reset_in <= '0';
    

    assert false report "Test done." severity note;
    wait;
  end process;
end tb;
