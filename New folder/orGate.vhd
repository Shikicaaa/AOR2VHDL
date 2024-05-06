library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity orGate is
port(
	a, b : in std_logic;
	c : out std_logic
);
end orGate;

architecture a_orGate of orGate is
begin
	c<= a or b;
end architecture;