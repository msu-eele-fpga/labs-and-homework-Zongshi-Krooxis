library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pattern3 is
    port (
	rst     : in std_ulogic;
	clk     : in std_ulogic;
	pattern : out std_ulogic_vector(7 downto 0)
    );
end entity;

architecture pattern3_arch of pattern3 is
    begin
end architecture;