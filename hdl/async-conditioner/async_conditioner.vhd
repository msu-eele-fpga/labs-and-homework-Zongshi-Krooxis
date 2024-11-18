library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.assert_pkg.all;
--use work.print_pkg.all;
--use work.tb_pkg.all;


entity aysnc_conditioner is
    port (
	clk   : in  std_ulogic;
	rst   : in  std_ulogic;
	async : in  std_ulogic;
	sync  : out std_ulogic
    );
end entity aysnc_conditioner;


architecture aysnc_conditioner_arch of aysnc_conditioner is

    component synchronizer is
	port (
            clk   : in    std_ulogic;
            async : in    std_ulogic;
            sync  : out   std_ulogic
        );
    end component synchronizer;

    component debouncer is
    	generic (
	    clk_period    : time;
	    debounce_time : time
    	);
    	port (
	    clk       : in  std_ulogic;
	    rst       : in  std_ulogic;
	    input     : in  std_ulogic;
	    debounced : out std_ulogic
    	);
    end component debouncer;

    component one_pulse is
    	port (
	    clk   : in  std_ulogic;
	    rst   : in  std_ulogic;
	    input : in  std_ulogic;
	    pulse : out std_ulogic
    	);
    end component one_pulse;

    signal sync_cond      : std_ulogic := '0';
    signal debounced_cond : std_ulogic := '0';

    constant DEBOUNCE_TIME : time := 100 ns;
	 constant CLK_PERIOD : time := 20 ns;


    begin

	SYNCH : synchronizer port map (	
				clk   => clk,
				async => async,
				sync  => sync_cond);

	DEBOUNCE : debouncer generic map (
        			clk_period    => CLK_PERIOD,
        			debounce_time => DEBOUNCE_TIME)
      			     port map (
        			clk       => clk,
        			rst       => rst,
        			input     => sync_cond,
        			debounced => debounced_cond);

	PULSER : one_pulse port map (
				clk 	=> clk,
	    			rst 	=> rst,
	    			input 	=> debounced_cond,
	    			pulse 	=> sync);


end architecture;
