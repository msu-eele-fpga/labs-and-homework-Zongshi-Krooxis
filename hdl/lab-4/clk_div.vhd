-- Author : Aaron McLean
--
-- Architecture based on Ian's ClkGenerator
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
    port (
	rst		: in  std_ulogic;
	clk 		: in  std_ulogic;
	half_clk 	: out std_ulogic;
	quarter_clk	: out std_ulogic;
	double_clk	: out std_ulogic;
	eighth_clk	: out std_ulogic;
	four_times_clk	: out std_ulogic
    );
end entity;


architecture clk_div_arch of clk_div is

    constant baseClkRate : unsigned(27 downto 0) := "0010111110101111000010000000"; -- 50MHz

    -- constant baseClkRate : unsigned(7 downto 0) := "00101000"; -- test 80 Hz

    signal	cnt_half, 
		cnt_quarter, 
		cnt_eighth, 
		cnt_double, 
		cnt_four_times : integer := 0;

    constant HALF_MAX		: integer := (to_integer(baseClkRate) / 2);
    constant QUARTER_MAX	: integer := (to_integer(baseClkRate) / 4);
    constant EIGHTH_MAX		: integer := (to_integer(baseClkRate) / 8);
    constant DOUBLE_MAX		: integer := (to_integer(baseClkRate) * 2);
    constant FOUR_TIMES_MAX	: integer := (to_integer(baseClkRate) * 4);

    begin

	DIVIDER : process(clk)
	    begin
		if (rst = '1') then
			cnt_half 	<= 0;
			cnt_quarter 	<= 0;
			cnt_eighth 	<= 0;
			cnt_double 	<= 0;
			cnt_four_times 	<= 0;
			half_clk 	<= '0';
			quarter_clk 	<= '0';
			eighth_clk 	<= '0';
			double_clk 	<= '0';
			four_times_clk	<= '0';
		else
		    -- HALF COUNTER --
		    if (cnt_half > HALF_MAX) then
			cnt_half <= 0;
			half_clk <= not half_clk;
		    else
			cnt_half <= cnt_half + 1;
		    end if;

		    -- QUARTER COUNTER --
		    if (cnt_quarter > QUARTER_MAX) then
			cnt_quarter <= 0;
			quarter_clk <= not quarter_clk;
		    else
			cnt_quarter <= cnt_quarter + 1;
		    end if;

		    -- EIGHTH COUNTER --
		    if (cnt_eighth > EIGHTH_MAX) then
			cnt_eighth <= 0;
			eighth_clk <= not eighth_clk;
		    else
			cnt_eighth <= cnt_eighth + 1;
		    end if;

		    -- DOUBLE COUNTER --
		    if (cnt_double > DOUBLE_MAX) then
			cnt_double <= 0;
			double_clk <= not double_clk;
		    else
			cnt_double <= cnt_double + 1;
		    end if;

		    -- FOUR TIMES COUNTER --
		    if (cnt_four_times > FOUR_TIMES_MAX) then
			cnt_four_times <= 0;
			four_times_clk <= not four_times_clk;
		    else
			cnt_four_times <= cnt_four_times + 1;
		    end if;

		end if;
	end process;


end architecture;