-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_brojac is
	Port(
    	clk : in std_logic;
        q : out std_logic_vector(7 downto 0);
    );
end entity;

architecture bcd_arch of bcd_brojac is
begin
    process(clk)
        variable jed : unsigned(3 downto 0) := (others => '0');
        variable des : unsigned(3 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then
            if jed = "1001" then
                jed := "0000";
                des := des + 1;
                if des = "1001" then
                    des := "0000";
                    jed := "0000";
                end if;
            else
                jed := jed + 1;
            end if;
        end if;
        q <= std_logic_vector(des & jed);
    end process;
end bcd_arch;