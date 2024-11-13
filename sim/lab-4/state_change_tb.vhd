library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity state_change_tb is
end entity;





architecture state_change_tb_arch of state_change_tb is

    component state_change is
    	generic(
	    clk_per	: in  time
    	);
    	port(
	    rst 	: in  std_ulogic;
	    clk 	: in  std_ulogic;
	    button	: in  std_ulogic;
	    sw		: in  std_ulogic_vector(3 downto 0);
	    sel		: out std_ulogic_vector(2 downto 0)
    	);
    end component;

    signal rst_tb, clk_tb, button_tb : std_ulogic := '0';
    signal sw_tb  : std_ulogic_vector(3 downto 0) := "0000";
    signal sel_tb : std_ulogic_vector(2 downto 0) := "000";
    constant clk_per_tb : time := 20 ns;

    begin

	DUT : state_change 
	    generic map(
	    	clk_per	=> clk_per_tb
    	    )
    	    port map(
	    	rst 	=> rst_tb,
	    	clk 	=> clk_tb,
	    	button	=> button_tb,
	    	sw	=> sw_tb,
	    	sel	=> sel_tb
	    );

	clk_tb <= not clk_tb after CLK_PERIOD / 2;

	STIM : process is
	    begin
		rst_tb <= '1';
		sw_tb <= "0000";
		wait_for_clock_edges(clk_tb, 2);
		rst_tb <= '0';
		wait_for_clock_edges(clk_tb, 1);
		button_tb <= '1';
		wait_for_clock_edges(clk_tb, 1);
		button_tb <= '0';
		sw_tb <= "0001";
		wait;
	end process;


  	check_output : process is

    	    variable failed : boolean := false;

  	    begin

    		for i in 0 to 100 loop

--        	    assert sync_expected = sync_tb
--        	    	report "Error for clock cycle " & to_string(i) & ":" & LF & "sync = " & to_string(sync_tb) & " sync_expected  = " & to_string(sync_expected)
--        	    severity warning;
--
--      	    if sync_expected /= sync_tb then
--        	        failed := true;
--      	    end if;

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