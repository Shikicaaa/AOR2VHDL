-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity brojac is
	generic (n : integer:= 4);
	port(
    	smer, ce, wr, clk : in std_logic;
        din : in integer range 0 to (2**n)-1;
        dout : out integer range 0 to (2**n)-1
    );
end brojac;

architecture brojac_arch of brojac is
begin
	process(clk)
    	variable broj : integer range 0 to 2**n := 0;
    	begin
        if clk'event and clk = '1' then --ako nije paralelni upis i ako je rastuca ivica.
        	if ce = '1' then
            	if smer = '0' then
                	if wr = '1' and broj = (2**n -1) then
                    	broj := din;
                    else
                    	broj := (broj - 1) mod (2**n);
                    end if;
				else
                	if wr = '1' and broj = (2**n -1) then
                    	broj := din;
                    else
                    	broj := (broj+1) mod (2**n);
                   	end if;
                end if;
			elsif wr = '1' then
				broj := din;
            end if;
        end if;
        dout <= broj;
        
    end process;
end architecture;

------------------------------------------------------------------

-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity brojac_tb is
	generic(n : integer := 4);
end brojac_tb;

architecture arch_brojac_tb of brojac_tb is
	signal smer, ce, wr, clk : std_logic;
    signal din, dout : integer;

begin
	dut:
    	entity work.brojac(brojac_arch)
        	generic map(n)
            port map(
            	smer => smer,
                ce => ce,
                wr => wr,
                clk => clk,
                din => din,
                dout => dout
            );
    generator: process
    begin
    	clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
	end process;
    
    stimulus: process
    begin
    	ce <= '0';
        din <= 15;
        wr <= '1';
        smer <= '1';
        wait for 10 ns;
        ce <= '1';
        din <= 13;
        wait for 300 ns;
        smer <= '0';
        wait for 700 ns;
	end process;
end architecture;