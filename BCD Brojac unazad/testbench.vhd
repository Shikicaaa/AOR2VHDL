-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD3_counter_tb is
end entity BCD3_counter_tb;

architecture Behavioral of BCD3_counter_tb is
	constant clk_period : time := 10 ns;
    
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal Qout : std_logic_vector(11 downto 0);
    
begin
	UUT: entity work.BCD3_counter(BCD3_arch) port map(
    clk => clk,
    rst => rst,
    Qout => Qout);
    
    clock_process: process
    begin
    	clk <= not clk after clk_period;
        wait for clk_period / 2;
    end process;
    
    stimulus: process
    begin
    	rst <= '1';
        wait for 10 ns;
        rst <= '0';
        
        wait for 10 ns;
        
        wait;
        
    end process;
end Behavioral;