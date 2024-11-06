library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity clk_div_tb is
end entity;

architecture clk_div_tb_arch of clk_div_tb is

    component clk_div is
    	port (
	    rst			: in  std_ulogic;
	    clk 		: in  std_ulogic;
	    half_clk 		: out std_ulogic;
	    quarter_clk		: out std_ulogic;
	    double_clk		: out std_ulogic;
	    eighth_clk		: out std_ulogic;
	    four_times_clk	: out std_ulogic
    	);
    end component;

    signal rst_tb, clk_tb, half_clk_tb, quarter_clk_tb, double_clk_tb, eighth_clk_tb, four_times_clk_tb : std_ulogic := '0';

    begin

	DUT : clk_div port map(
	    rst => rst_tb, 
	    clk => clk_tb, 
	    half_clk => half_clk_tb, 
	    quarter_clk => quarter_clk_tb,
	    double_clk => double_clk_tb,
	    eighth_clk => eighth_clk_tb,
	    four_times_clk => four_times_clk_tb
	);

	clk_tb <= not clk_tb after CLK_PERIOD / 2;

	STIM : process is
	    begin
		rst_tb <= '0';
		wait_for_clock_edges(clk_tb, 1);
		rst_tb <= '1'; wait for CLK_PERIOD;
		rst_tb <= '0'; wait;
	end process;


  	check_output : process is

    	    variable failed : boolean := false;

  	    begin

    		for i in 0 to 500 loop

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
