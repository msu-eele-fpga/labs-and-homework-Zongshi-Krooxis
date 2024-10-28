library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_patterns is
    generic (
	system_clock_period : time := 20 ns
    );
    port (
	clk : in std_ulogic;
	rst : in std_ulogic;
	push_button : in std_ulogic;
	switches : in std_ulogic_vector(3 downto 0);
	hps_led_control : in boolean;
	base_period : in unsigned(7 downto 0);
	led_reg : in std_ulogic_vector(7 downto 0);
	led : out std_ulogic_vector(7 downto 0)
    );
end entity led_patterns;


architecture led_patterns_arch of led_patterns is

----------------------------------------------------------------
-- - - - - - - COMPONENT DECLARATION
----------------------------------------------------------------

    component aysnc_conditioner is
    	port (
	    clk   : in  std_ulogic;
	    rst   : in  std_ulogic;
	    async : in  std_ulogic;
	    sync  : out std_ulogic
    	);
    end component aysnc_conditioner;

    component mux is
	port (
	    rst		: in  std_ulogic;
	    in1 	: in  std_ulogic;
	    in2 	: in  std_ulogic;
	    in3 	: in  std_ulogic;
	    in4 	: in  std_ulogic;
	    in5 	: in  std_ulogic;
	    sel		: in  integer;
	    mux_out	: out std_ulogic;
	);
    end component;

    component pattern1 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic;
	);
    end component;

    component pattern2 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic;
	);
    end component;

    component pattern3 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic;
	);
    end component;

    component pattern4 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic;
	);
    end component;

    component pattern5 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic;
	);
    end component;

    component clk_div is
	port (
	    rst			: in  std_ulogic;
	    clk 		: in  std_ulogic;
	    half_clk 		: out std_ulogic;
	    quarter_clk		: out std_ulogic;
	    double_clk		: out std_ulogic;
	    eighth_clk		: out std_ulogic;
	    four_times_clk	: out std_ulogic;
	);
    end component;

    component state_change is
	port(
	    rst 	: in  std_ulogic;
	    clk 	: in  std_ulogic;
	    button	: in  std_ulogic;
	    sel		: out std_ulogic;
	);
    end component;

----------------------------------------------------------------
-- - - - - - - SIGNAL DECLARATION
----------------------------------------------------------------


    begin
end architecture;