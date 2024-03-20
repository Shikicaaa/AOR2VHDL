-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_brojac is
	Port(
    	clk : in bit;
        q : out bit_vector(3 downto 0);
    );
end entity;

architecture bcd_arch of bcd_brojac is
begin
	process(clk)
    	variable q_int : bit_vector(3 downto 0);
        variable cq : bit;
    begin
    	if clk'event and clk = '1' then
        	cq := not cq;
            if cq = '1' then
            	case q_int is
                	when "0000" => q_int := "0001";
                	when "0001" => q_int := "0010";
                	when "0010" => q_int := "0011";
                	when "0011" => q_int := "0100";
                	when "0100" => q_int := "0101";
                	when "0101" => q_int := "0110";
                    when "0110" => q_int := "0111";
                    when "0111" => q_int := "1000";
                    when "1000" => q_int := "1001";
                    when others => q_int := "0000";
                end case;
            end if;
        end if;
    q <= q_int;
    end process;
end bcd_arch;