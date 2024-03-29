-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD3_counter_tb is
end entity BCD3_counter_tb;

architecture Behavioral of BCD3_counter_tb is
	constant clk_period : time := 10 ns;
    
    signal clk : std_logic := '0';
    signal wr : std_logic := '0';
    signal ce : std_logic := '0';
    signal din : std_logic_vector := "100110011001";
    
begin
	UUT: entity work.BCD3_counter(BCD3_arch) port map(
    clk => clk,
    wr => wr,
    ce => ce,
    din => din);
    
    clock_process: process
    begin
    	clk <= not clk after clk_period;
        wait for clk_period / 2;
    end process;
    
    stimulus: process
    begin
    	wr <= '0';
        ce <= '0';
        wait for 30 ns;
    	wr <= '0';
        ce <= '1';
        wait for 30 ns;
    	wr <= '1';
        ce <= '1';
        din <= "100110000111";
        wait for 30 ns;
        wr <= '0';
        ce <= '1';      
        wait for 10 ns;
        
        wait;
        
    end process;
end Behavioral;