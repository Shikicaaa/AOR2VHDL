-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity moduo8_counter_tb is
end moduo8_counter_tb;

architecture Behavioral of moduo8_counter_tb is
    constant clk_period : time := 10 ns;
    
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal count : std_logic_vector(2 downto 0);
    
begin
	UUT: entity work.moduo8_counter(Behavioralds) port map(
    	clk => clk,
        reset => reset,
        count => count);
        
    clock_rpocess: process
    begin
    	while now < 1000ns loop
        	clk <= not clk;
            wait for clk_period / 2;
        end loop;
        wait;
    end process;
    
    stimulus: process
    begin
    	reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        wait for 100ns;
        
        wait;
    end process;
end Behavioral;