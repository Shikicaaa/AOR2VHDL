-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD3_counter is
Port( clk : in std_logic;
	  rst : in std_logic;
      Qout : out std_logic_vector (11 downto 0);
      Par0 : out std_logic_vector (3 downto 0);
      Par1 : out std_logic_vector (3 downto 0);
      Par2 : out std_logic_vector (3 downto 0));
end BCD3_counter;

architecture BCD3_arch of BCD3_counter is
	signal count : unsigned (11 downto 0) := (others => '0');
    
    begin
    	process(clk, rst)
        begin
        	if rst = '1' then
            	count <= "100110011001";
            elsif clk'event and clk = '1' then
            	if count(3 downto 0) /= "0000" then
                    count <= count - 1;
                elsif count(7 downto 4) /= "0000" then
                    count(3 downto 0) <= "1001"; 
                    count(7 downto 4) <= count(7 downto 4) - 1; 
                elsif count(11 downto 8) /= "0000" then
                    count(3 downto 0) <= "1001"; 
                    count(7 downto 4) <= "1001"; 
                    count(11 downto 8) <= count(11 downto 8) - 1; 
                else
                    count <= "100110011001"; 
                end if;
            end if;
            Qout <= std_logic_vector(count);
            Par0 <= std_logic_vector(count(3 downto 0));
            Par1 <= std_logic_vector(count(7 downto 4));
            Par2 <= std_logic_vector(count(11 downto 8));
        end process;
end BCD3_arch;