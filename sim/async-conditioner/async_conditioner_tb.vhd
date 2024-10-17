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
    
    constant DEBOUNCE_TIME : time := 100 ns;

    begin

	DUT : aysnc_conditioner port map(clk   => clk_tb,
					 rst   => rst_tb,
					 async => async_tb,
					 sync  => sync_tb);

	clk_tb <= not clk_tb after CLK_PERIOD / 2;

	STIM : process
	    begin
		wait_for_clock_edges(clk_tb, 2);
		rst_tb <= '1'; wait for CLK_PERIOD;
		rst_tb <= '0'; wait for CLK_PERIOD;

		async_tb <= '1'; wait for 4*CLK_PERIOD;
		async_tb <= '0'; wait for 4*CLK_PERIOD;

		async_tb <= '1'; wait for CLK_PERIOD;
		async_tb <= '0'; wait for CLK_PERIOD;

		async_tb <= '1'; wait for CLK_PERIOD;
		async_tb <= '0'; wait for CLK_PERIOD;

		async_tb <= '1'; wait for 2*CLK_PERIOD;
		async_tb <= '0'; wait for CLK_PERIOD;

		async_tb <= '1'; wait for CLK_PERIOD;
		async_tb <= '0'; wait for CLK_PERIOD;

		async_tb <= '1'; wait for CLK_PERIOD;
		async_tb <= '0'; wait for CLK_PERIOD;

		rst_tb <= '1'; wait;
		

	end process;

	EXPECTED : process
	    begin
		wait_for_clock_edges(clk_tb, 2);

		wait for 6*CLK_PERIOD;

		sync_expected <= '1'; wait for CLK_PERIOD;
		sync_expected <= '0'; wait for DEBOUNCE_TIME;
		wait for 4*CLK_PERIOD;

		sync_expected <= '1'; wait for CLK_PERIOD;
		sync_expected <= '0'; wait;
	end process;

	check_output : process is

	    variable failed : boolean := false;

	    begin
		wait_for_clock_edges(clk_tb, 2);
		for i in 0 to 24 loop

		    assert sync_expected = sync_tb
		    report "Error for clock cycle " & to_string(i) & ":" & LF & "sync = " & to_string(sync_tb) 
					& " sync_expected  = " & to_string(sync_expected)
		    severity warning;

		    if sync_expected /= sync_tb then
			failed := true;
		    end if;

		    wait for CLK_PERIOD;

		end loop;

		if failed then
		    report "tests failed!"
		    severity failure;
		else
		    report "all tests passed!";
		end if;

		std.env.finish;

  end process check_output;


end architecture;