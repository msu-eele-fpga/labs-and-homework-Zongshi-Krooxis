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
	    in1 	: in  std_ulogic_vector(7 downto 0);
	    in2 	: in  std_ulogic_vector(7 downto 0);
	    in3 	: in  std_ulogic_vector(7 downto 0);
	    in4 	: in  std_ulogic_vector(7 downto 0);
	    in5 	: in  std_ulogic_vector(7 downto 0);
	    sel		: in  std_ulogic_vector(2 downto 0);
	    mux_out	: out std_ulogic_vector(7 downto 0)
	);
    end component;

    component pattern1 is
	port (
	    rst     : in std_ulogic;
	    clk     : in std_ulogic;
	    pattern : out std_ulogic_vector(7 downto 0)
	);
    end component;

    component pattern2 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic_vector(7 downto 0)
	);
    end component;

    component pattern3 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic_vector(7 downto 0)
	);
    end component;

    component pattern4 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic_vector(7 downto 0)
	);
    end component;

    component pattern5 is
	port (
	    rst : in std_ulogic;
	    clk : in std_ulogic;
	    pattern : out std_ulogic_vector(7 downto 0)
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
	    four_times_clk	: out std_ulogic
	);
    end component;

    component state_change is
	port(
	    rst 	: in  std_ulogic;
	    clk 	: in  std_ulogic;
	    button	: in  std_ulogic;
	    sel		: out std_ulogic_vector(2 downto 0)
	);
    end component;

----------------------------------------------------------------
-- - - - - - - SIGNAL DECLARATION
----------------------------------------------------------------

    signal half_clk_top		: std_ulogic := '0';
    signal quarter_clk_top 	: std_ulogic := '0';
    signal double_clk_top 	: std_ulogic := '0';
    signal eighth_clk_top 	: std_ulogic := '0';
    signal four_times_clk_top 	: std_ulogic := '0';

    signal pattern1_top		: std_ulogic_vector(7 downto 0) := "00000000";
    signal pattern2_top		: std_ulogic_vector(7 downto 0) := "00000000";
    signal pattern3_top		: std_ulogic_vector(7 downto 0) := "00000000";
    signal pattern4_top		: std_ulogic_vector(7 downto 0) := "00000000";
    signal pattern5_top		: std_ulogic_vector(7 downto 0) := "00000000";

    signal sel_top : std_ulogic_vector(2 downto 0) := "000";

    signal sync_top : std_ulogic := '0';

    signal mux_out_top : std_ulogic_vector(7 downto 0) := "00000000";

    begin
----------------------------------------------------------------
-- - - - - - - COMPONENT INSTANTIATION
----------------------------------------------------------------
------- State Changer
    	STATE : state_change port map (
	    rst => rst,
	    clk => clk,
	    button => sync_top,
	    sel => sel_top);

------- Patterns
	PAT1 : pattern1 port map (
	    rst 	=> rst,
	    clk 	=> half_clk_top,
	    pattern => pattern1_top);

	PAT2 : pattern2 port map (
	    rst		=> rst,
	    clk		=> quarter_clk_top,
	    pattern	=> pattern2_top);

	PAT3 : pattern3 port map (
	    rst		=> rst,
	    clk		=> double_clk_top,
	    pattern	=> pattern3_top);

	PAT4 : pattern4 port map (
	    rst		=> rst,
	    clk		=> eighth_clk_top,
	    pattern	=> pattern4_top);

	PAT5 : pattern5 port map (
	    rst		=> rst,
	    clk		=> four_times_clk_top,
	    pattern	=> pattern5_top);

------- Clock Divider
    	DIVIDER : clk_div port map (
	    rst			=> rst,
	    clk 		=> clk,
	    half_clk 		=> half_clk_top,
	    quarter_clk		=> quarter_clk_top,
	    double_clk		=> double_clk_top,
	    eighth_clk		=> eighth_clk_top,
	    four_times_clk	=> four_times_clk_top);

------- Asynchronos Conditioner
    	ASYNC_COND : aysnc_conditioner port map (
	    clk	  => clk,
	    rst	  => rst,
	    async => push_button,
	    sync  => sync_top);

------- Pattern Multiplexor
    	MULTIPLEXOR : mux port map (
	    rst		=> rst,
	    in1 	=> pattern1_top,
	    in2 	=> pattern2_top,
	    in3 	=> pattern3_top,
	    in4 	=> pattern4_top,
	    in5 	=> pattern5_top,
	    sel		=> sel_top,
	    mux_out	=> mux_out_top);

----------------------------------------------------------------
-- - - - - - - COMPONENT INSTANTIATION
----------------------------------------------------------------


end architecture;