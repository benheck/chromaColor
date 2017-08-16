# onboard 50mhz clock
create_clock -name clock_50 -period 20.000 [get_ports clock_50]
create_clock -name clock_dot -period 12.000 [get_ports dotClock]
derive_pll_clocks
derive_clock_uncertainty

# set_false_path -from reset_n -to *


set_clock_groups -asynchronous \
-group { \
	u1|altpll_component|auto_generated|pll1|clk[2] \
	} \
-group { \
	u1|altpll_component|auto_generated|pll1|clk[0] \
	} \
-group { clock_dot } 


