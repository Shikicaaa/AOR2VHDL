library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity brojac is
generic(n : integer := 4);
port(
	rst, clk : in std_logic;
	dout : out std_logic_vector(0 to n-1)
);
end brojac;

architecture a_brojac of brojac is
begin
	process(clk)
		variable broj : integer := 0;
	begin
	if clk'event then
		if rst = '1' or broj = 2**n - 1 then
			broj := 2**(n-1); -- 1000 za n = 4;
		elsif rst = '0' and broj /= 2**n - 1 then
			broj := to_integer(shift_right(unsigned(to_unsigned(broj,1));
		end if;
	end if;
	dout <= std_logic_vector(to_unsigned(broj,n));
	end process;
end architecture;

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity tb is
	generic( n : integer := 4);
end tb;

architecture a_tb of tb is
	signal clk, reset : std_logic;
	signal dout : std_logic_vector(0 to n-1);
begin
	dut: entity work.brojac(a_brojac)
		port map(reset, clk, dout);
	clock: process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process clock;
	stimulus: process
	begin 
		reset <= '1';
		wait for 350 ns;
		reset <= '0';
		wait for 1 us;
	end process stimulus;
end architecture;

