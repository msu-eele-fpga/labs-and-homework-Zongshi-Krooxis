library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pattern5 is
    port (
	rst     : in std_ulogic;
	clk     : in std_ulogic;
	pattern : out std_ulogic_vector(7 downto 0)
    );
end entity;

architecture pattern5_arch of pattern5 is
    begin
end architecture;