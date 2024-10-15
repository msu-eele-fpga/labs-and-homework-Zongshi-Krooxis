library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity async_conditioner_tb is
end entity;

architecture async_conditioner_tb_arch of async_conditioner_tb is

    component aysnc_conditioner is
    	port (
	    clk   : in  std_ulogic;
	    rst   : in  std_ulogic;
	    async : in  std_ulogic;
	    sync  : out std_ulogic
    	);
    end component aysnc_conditioner;

    signal clk_tb,
	   rst_tb,
	   async_tb,
	   sync_tb,
	   sync_expected : std_ulogic := '0';

    begin

	DUT : aysnc_conditioner port map(clk   => clk_tb,
					 rst   => rst_tb,
					 async => async_tb,
					 sync  => sync_tb);

	clk_tb <= not clk_tb after CLK_PERIOD / 2; -- SYNC WITH A WAIT?

	STIM : process
	    begin
		wait_for_clock_edges(clk_tb, 2);
		
	end process;

	EXPECTED : process
	    begin
		wait_for_clock_edges(clk_tb, 2);
	end process;


end architecture;