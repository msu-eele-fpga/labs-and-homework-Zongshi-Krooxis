library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity aysnc_conditioner is
    port (
	clk : in std_ulogic;
	rst : in std_ulogic;
	async : in std_ulogic;
	sync : out std_ulogic
    );
end entity aysnc_conditioner;

architecture aysnc_conditioner_arch of aysnc_conditioner is
    begin
end architecture;
