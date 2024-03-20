-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_tb is
end entity;

architecture bcd_tb_arch of bcd_tb is
	constant clk_period : time := 10 ns;
    signal clk : bit := '0';
    
    begin
    	UUT: entity work.bcd_brojac(bcd_arch) port map(
        clk => clk
        );
        
        clock_process: process
        begin
        	clk <= not clk after clk_period;
            wait for clk_period / 2;
        end process;
        
end architecture bcd_tb_arch;