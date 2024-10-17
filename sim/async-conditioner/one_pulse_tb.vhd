library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity one_pulse_tb is
end entity;

architecture one_pulse_tb_arch of one_pulse_tb is

    signal	clk_tb,
		rst_tb,
		input_tb,
		pulse_tb : std_ulogic := '0';

    signal	pulse_expected : std_ulogic := '0';

    component one_pulse is
    	port (
	    clk   : in std_ulogic;
	    rst   : in std_ulogic;
	    input : in std_ulogic;
	    pulse : out std_ulogic
    	);
    end component one_pulse;



    begin

    	DUT : one_pulse port map( clk 	=> clk_tb,
	    			    rst 	=> rst_tb,
	    			    input 	=> input_tb,
	    			    pulse 	=> pulse_tb);

	clk_tb <= not clk_tb after CLK_PERIOD / 2;

	STIM : process
	    begin
		wait_for_clock_edges(clk_tb, 1);
		rst_tb <= '1'; wait for CLK_PERIOD; 	-- in to Reset
		rst_tb <= '0'; wait for CLK_PERIOD; 	-- out of Reset
--		input_tb <= '1';
		input_tb <= '1';  wait for 2*CLK_PERIOD;-- input high 2 cycles
		input_tb <= '0'; wait for 2*CLK_PERIOD;	-- input low for 2 cycles
		input_tb <= '1';  wait for CLK_PERIOD;	-- input high 1 cycles
		input_tb <= '0'; wait for CLK_PERIOD;	-- input low for 1 cycles
		input_tb <= '1'; wait for CLK_PERIOD;	-- set input high for 1 cycle
		rst_tb <= '1'; wait for CLK_PERIOD;	-- set reset high for 1 cycle
		rst_tb <= '0'; wait for CLK_PERIOD;	
		input_tb <= '0'; wait for CLK_PERIOD;	-- set input low
		wait;					-- End Test
	end process;

	EXPECTED : process
	    begin
		wait_for_clock_edges(clk_tb, 1);
		pulse_expected <= '0'; wait for 3*CLK_PERIOD;
		pulse_expected <= '1'; wait for CLK_PERIOD;

--		pulse_expected <= '0';

		pulse_expected <= '0'; wait for 3*CLK_PERIOD;
		pulse_expected <= '1'; wait for CLK_PERIOD;
		pulse_expected <= '0'; wait for CLK_PERIOD;
		pulse_expected <= '1'; wait for CLK_PERIOD;
		pulse_expected <= '0'; wait for CLK_PERIOD;
		pulse_expected <= '1'; wait for CLK_PERIOD;
		pulse_expected <= '0'; wait for CLK_PERIOD;
		wait;
	end process;



	check_output : process is

	    variable failed : boolean := false;

	    begin
		wait_for_clock_edges(clk_tb, 1);
		for i in 0 to 12 loop

		    assert pulse_expected = pulse_tb
		    report "Error for clock cycle " & to_string(i) & ":" & LF & "sync = " & to_string(pulse_tb) 
					& " sync_expected  = " & to_string(pulse_expected)
		    severity warning;

		    if pulse_expected /= pulse_tb then
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
