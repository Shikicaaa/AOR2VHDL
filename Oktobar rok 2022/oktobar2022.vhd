-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dff is
	port(
    	clk : in std_logic;
        d : in std_logic;
        q: out std_logic;
    );
end dff;

architecture dff_arch of dff is
begin
	q <= d when (clk'event and clk = '1') else q;
end architecture;


--------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity brojac is
	generic (n : integer := 5);
	port(
    	clk,r,dir : in std_logic;
        izlaz : out std_logic_vector (n-1 downto 0);
    );
end brojac;

architecture brojac_arch of brojac is
begin
	process(clk)
    	variable broj : integer range 0 to (2**n)-1;
    begin
    	if clk'event and clk = '1' then
        	if r = '1' then
            	if dir = '1' then
                	broj := 0;
                else
                	broj := (2**n)-1;
                end if;
            else
            	if dir = '1' then
                	if broj = (2**n-1) then broj := 0;
                    else broj := (broj + 1) mod (2**n - 1);
                    end if;
                else
                	if broj = 0 then broj := (2**n -1);
                    else broj := (broj -1)mod(2**n-1);
                    end if;
                end if;
			end if;
		end if;

		izlaz <= std_logic_vector(to_unsigned(broj, n));
	end process;
end architecture;

---------------------------------------kolo
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity kolo is
	generic (n : integer := 16);
    port(
    clk, r, dir : in std_logic;
    izlaz : out std_logic_vector(n-1 downto 0);
    );
end kolo;

architecture a_kolo of kolo is
signal medju : std_logic_vector(n-1 downto 0);
begin
	brojac: entity work.brojac(brojac_arch)
    	generic map(n)
        port map(
        clk => clk,
        r => r,
        dir => dir,
        izlaz => medju
        );
    povezi_gore: for i in 0 to n/4-1 generate
    begin
        flipflop_inst: entity work.dff(dff_arch)
            port map(
                clk => clk,
                d => medju(i),
                q => izlaz(i)
            );
    end generate povezi_gore;

    povezi_dole: for i in n/4 to n-1 generate
    begin
        izlaz(i) <= medju(i);
    end generate povezi_dole;
end architecture;


---testbench

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity tb is
  generic (n : integer := 16);
end tb ; 

architecture a_tb of tb is
    signal clk, rst, dir : std_logic;
    signal izlaz : std_logic_vector(n-1 downto 0);
begin

    dut: entity work.kolo(a_kolo)
        generic map (n)
        port map (clk, rst, dir, izlaz);

    clock_generator: process
    begin
        clk <= '0'; wait for 25 ns;
        clk <= '1'; wait for 25 ns;
    end process ;
    
    stimuli: process
    begin
        rst <= '0';
        dir <= '1';
        wait for 50 ns;
    end process ;

end architecture ;