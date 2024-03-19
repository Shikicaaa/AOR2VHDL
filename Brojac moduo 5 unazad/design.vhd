library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moduo5_counter is
	Port( clk : in std_logic;
    		reset : in std_logic;
            count : out std_logic_vector (2 downto 0));
end moduo5_counter;

architecture Behavioralds of moduo5_counter is
begin
	process(clk, reset)
    	variable temp_count : unsigned (2 downto 0) := "101";
    begin
    	if reset = '1' then
        	temp_count := "101";
        elsif clk'event and clk = '1' then
        	if temp_count = "000" then
            	temp_count := "101";
       		else
            	temp_count := temp_count -1;
            end if;
        end if;
        count <= std_logic_vector(temp_count);
    end process;
end Behavioralds;