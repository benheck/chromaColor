//altlvds_tx CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" COMMON_RX_TX_PLL="OFF" CORECLOCK_DIVIDE_BY=2 DATA_RATE="506.0 Mbps" DESERIALIZATION_FACTOR=7 DEVICE_FAMILY="Cyclone IV E" DIFFERENTIAL_DRIVE=0 ENABLE_CLK_LATENCY="OFF" IMPLEMENT_IN_LES="ON" INCLOCK_BOOST=0 INCLOCK_DATA_ALIGNMENT="EDGE_ALIGNED" INCLOCK_PERIOD=13833 INCLOCK_PHASE_SHIFT=0 MULTI_CLOCK="OFF" NUMBER_OF_CHANNELS=4 OUTCLOCK_ALIGNMENT="EDGE_ALIGNED" OUTCLOCK_DIVIDE_BY=1 OUTCLOCK_DUTY_CYCLE=50 OUTCLOCK_MULTIPLY_BY=1 OUTCLOCK_PHASE_SHIFT=0 OUTCLOCK_RESOURCE="AUTO" OUTPUT_DATA_RATE=506 PLL_COMPENSATION_MODE="AUTO" PLL_SELF_RESET_ON_LOSS_LOCK="ON" PREEMPHASIS_SETTING=0 REGISTERED_INPUT="OFF" USE_EXTERNAL_PLL="OFF" USE_NO_PHASE_SHIFT="ON" VOD_SETTING=0 tx_in tx_inclock tx_locked tx_out CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48
//VERSION_BEGIN 13.1 cbx_altaccumulate 2014:03:12:18:15:27:SJ cbx_altclkbuf 2014:03:12:18:15:27:SJ cbx_altddio_in 2014:03:12:18:15:27:SJ cbx_altddio_out 2014:03:12:18:15:27:SJ cbx_altiobuf_bidir 2014:03:12:18:15:29:SJ cbx_altiobuf_in 2014:03:12:18:15:29:SJ cbx_altiobuf_out 2014:03:12:18:15:29:SJ cbx_altlvds_tx 2014:03:12:18:15:29:SJ cbx_altpll 2014:03:12:18:15:29:SJ cbx_altsyncram 2014:03:12:18:15:29:SJ cbx_arriav 2014:03:12:18:15:29:SJ cbx_cyclone 2014:03:12:18:15:29:SJ cbx_cycloneii 2014:03:12:18:15:29:SJ cbx_lpm_add_sub 2014:03:12:18:15:29:SJ cbx_lpm_compare 2014:03:12:18:15:29:SJ cbx_lpm_counter 2014:03:12:18:15:29:SJ cbx_lpm_decode 2014:03:12:18:15:29:SJ cbx_lpm_mux 2014:03:12:18:15:30:SJ cbx_lpm_shiftreg 2014:03:12:18:15:30:SJ cbx_maxii 2014:03:12:18:15:30:SJ cbx_mgl 2014:03:12:18:25:18:SJ cbx_stratix 2014:03:12:18:15:31:SJ cbx_stratixii 2014:03:12:18:15:31:SJ cbx_stratixiii 2014:03:12:18:15:32:SJ cbx_stratixv 2014:03:12:18:15:32:SJ cbx_util_mgl 2014:03:12:18:15:30:SJ  VERSION_END
//CBXI_INSTANCE_NAME="LCD_DMD_driver_mf_lvds_mf_lvds_inst_altlvds_tx_ALTLVDS_TX_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2014 Altera Corporation
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, Altera MegaCore Function License 
//  Agreement, or other applicable license agreement, including, 
//  without limitation, that your use is for the sole purpose of 
//  programming logic devices manufactured by Altera and sold by 
//  Altera or its authorized distributors.  Please refer to the 
//  applicable agreement for further details.




//altddio_out CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" WIDTH=4 datain_h datain_l dataout outclock
//VERSION_BEGIN 13.1 cbx_altddio_out 2014:03:12:18:15:27:SJ cbx_cycloneii 2014:03:12:18:15:29:SJ cbx_maxii 2014:03:12:18:15:30:SJ cbx_mgl 2014:03:12:18:25:18:SJ cbx_stratix 2014:03:12:18:15:31:SJ cbx_stratixii 2014:03:12:18:15:31:SJ cbx_stratixiii 2014:03:12:18:15:32:SJ cbx_stratixv 2014:03:12:18:15:32:SJ cbx_util_mgl 2014:03:12:18:15:30:SJ  VERSION_END

//synthesis_resources = IO 4 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"ANALYZE_METASTABILITY=OFF;ADV_NETLIST_OPT_ALLOWED=DEFAULT"} *)
module  mf_lvds_ddio_out
	( 
	datain_h,
	datain_l,
	dataout,
	outclock) /* synthesis synthesis_clearbox=1 */;
	input   [3:0]  datain_h;
	input   [3:0]  datain_l;
	output   [3:0]  dataout;
	input   outclock;

	wire  [3:0]   wire_ddio_outa_datainhi;
	wire  [3:0]   wire_ddio_outa_datainlo;
	wire  [3:0]   wire_ddio_outa_dataout;

	cycloneive_ddio_out   ddio_outa_0
	( 
	.clkhi(outclock),
	.clklo(outclock),
	.datainhi(wire_ddio_outa_datainhi[0:0]),
	.datainlo(wire_ddio_outa_datainlo[0:0]),
	.dataout(wire_ddio_outa_dataout[0:0]),
	.muxsel(outclock)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clk(1'b0),
	.ena(1'b1),
	.sreset(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1),
	.dffhi(),
	.dfflo()
	// synopsys translate_on
	);
	defparam
		ddio_outa_0.async_mode = "none",
		ddio_outa_0.power_up = "low",
		ddio_outa_0.sync_mode = "none",
		ddio_outa_0.use_new_clocking_model = "true",
		ddio_outa_0.lpm_type = "cycloneive_ddio_out";
	cycloneive_ddio_out   ddio_outa_1
	( 
	.clkhi(outclock),
	.clklo(outclock),
	.datainhi(wire_ddio_outa_datainhi[1:1]),
	.datainlo(wire_ddio_outa_datainlo[1:1]),
	.dataout(wire_ddio_outa_dataout[1:1]),
	.muxsel(outclock)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clk(1'b0),
	.ena(1'b1),
	.sreset(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1),
	.dffhi(),
	.dfflo()
	// synopsys translate_on
	);
	defparam
		ddio_outa_1.async_mode = "none",
		ddio_outa_1.power_up = "low",
		ddio_outa_1.sync_mode = "none",
		ddio_outa_1.use_new_clocking_model = "true",
		ddio_outa_1.lpm_type = "cycloneive_ddio_out";
	cycloneive_ddio_out   ddio_outa_2
	( 
	.clkhi(outclock),
	.clklo(outclock),
	.datainhi(wire_ddio_outa_datainhi[2:2]),
	.datainlo(wire_ddio_outa_datainlo[2:2]),
	.dataout(wire_ddio_outa_dataout[2:2]),
	.muxsel(outclock)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clk(1'b0),
	.ena(1'b1),
	.sreset(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1),
	.dffhi(),
	.dfflo()
	// synopsys translate_on
	);
	defparam
		ddio_outa_2.async_mode = "none",
		ddio_outa_2.power_up = "low",
		ddio_outa_2.sync_mode = "none",
		ddio_outa_2.use_new_clocking_model = "true",
		ddio_outa_2.lpm_type = "cycloneive_ddio_out";
	cycloneive_ddio_out   ddio_outa_3
	( 
	.clkhi(outclock),
	.clklo(outclock),
	.datainhi(wire_ddio_outa_datainhi[3:3]),
	.datainlo(wire_ddio_outa_datainlo[3:3]),
	.dataout(wire_ddio_outa_dataout[3:3]),
	.muxsel(outclock)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clk(1'b0),
	.ena(1'b1),
	.sreset(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1),
	.dffhi(),
	.dfflo()
	// synopsys translate_on
	);
	defparam
		ddio_outa_3.async_mode = "none",
		ddio_outa_3.power_up = "low",
		ddio_outa_3.sync_mode = "none",
		ddio_outa_3.use_new_clocking_model = "true",
		ddio_outa_3.lpm_type = "cycloneive_ddio_out";
	assign
		wire_ddio_outa_datainhi = datain_h,
		wire_ddio_outa_datainlo = datain_l;
	assign
		dataout = wire_ddio_outa_dataout;
endmodule //mf_lvds_ddio_out


//lpm_compare CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" LPM_WIDTH=3 aeb dataa datab
//VERSION_BEGIN 13.1 cbx_cycloneii 2014:03:12:18:15:29:SJ cbx_lpm_add_sub 2014:03:12:18:15:29:SJ cbx_lpm_compare 2014:03:12:18:15:29:SJ cbx_mgl 2014:03:12:18:25:18:SJ cbx_stratix 2014:03:12:18:15:31:SJ cbx_stratixii 2014:03:12:18:15:31:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mf_lvds_cmpr
	( 
	aeb,
	dataa,
	datab) /* synthesis synthesis_clearbox=1 */;
	output   aeb;
	input   [2:0]  dataa;
	input   [2:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [2:0]  dataa;
	tri0   [2:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]  aeb_result_wire;
	wire  [0:0]  aneb_result_wire;
	wire  [7:0]  data_wire;
	wire  eq_wire;

	assign
		aeb = eq_wire,
		aeb_result_wire = (~ aneb_result_wire),
		aneb_result_wire = (data_wire[0] | data_wire[1]),
		data_wire = {datab[2], dataa[2], datab[1], dataa[1], datab[0], dataa[0], (data_wire[6] ^ data_wire[7]), ((data_wire[2] ^ data_wire[3]) | (data_wire[4] ^ data_wire[5]))},
		eq_wire = aeb_result_wire;
endmodule //mf_lvds_cmpr


//lpm_counter CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" lpm_modulus=7 lpm_width=3 clock q updown
//VERSION_BEGIN 13.1 cbx_cycloneii 2014:03:12:18:15:29:SJ cbx_lpm_add_sub 2014:03:12:18:15:29:SJ cbx_lpm_compare 2014:03:12:18:15:29:SJ cbx_lpm_counter 2014:03:12:18:15:29:SJ cbx_lpm_decode 2014:03:12:18:15:29:SJ cbx_mgl 2014:03:12:18:25:18:SJ cbx_stratix 2014:03:12:18:15:31:SJ cbx_stratixii 2014:03:12:18:15:31:SJ  VERSION_END


//lpm_compare CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone IV E" LPM_WIDTH=3 ONE_INPUT_IS_CONSTANT="YES" aeb dataa datab
//VERSION_BEGIN 13.1 cbx_cycloneii 2014:03:12:18:15:29:SJ cbx_lpm_add_sub 2014:03:12:18:15:29:SJ cbx_lpm_compare 2014:03:12:18:15:29:SJ cbx_mgl 2014:03:12:18:25:18:SJ cbx_stratix 2014:03:12:18:15:31:SJ cbx_stratixii 2014:03:12:18:15:31:SJ  VERSION_END

//synthesis_resources = 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mf_lvds_cmpr1
	( 
	aeb,
	dataa,
	datab) /* synthesis synthesis_clearbox=1 */;
	output   aeb;
	input   [2:0]  dataa;
	input   [2:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [2:0]  dataa;
	tri0   [2:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]  aeb_result_wire;
	wire  [0:0]  aneb_result_wire;
	wire  [7:0]  data_wire;
	wire  eq_wire;

	assign
		aeb = eq_wire,
		aeb_result_wire = (~ aneb_result_wire),
		aneb_result_wire = (data_wire[0] | data_wire[1]),
		data_wire = {datab[2], dataa[2], datab[1], dataa[1], datab[0], dataa[0], (data_wire[6] ^ data_wire[7]), ((data_wire[2] ^ data_wire[3]) | (data_wire[4] ^ data_wire[5]))},
		eq_wire = aeb_result_wire;
endmodule //mf_lvds_cmpr1

//synthesis_resources = lut 3 reg 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mf_lvds_cntr
	( 
	clock,
	q,
	updown) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	output   [2:0]  q;
	input   updown;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   updown;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]   wire_counter_comb_bita_0combout;
	wire  [0:0]   wire_counter_comb_bita_1combout;
	wire  [0:0]   wire_counter_comb_bita_2combout;
	wire  [0:0]   wire_counter_comb_bita_0cout;
	wire  [0:0]   wire_counter_comb_bita_1cout;
	wire  [0:0]   wire_counter_comb_bita_2cout;
	wire	[2:0]	wire_counter_reg_bit_d;
	wire	[2:0]	wire_counter_reg_bit_asdata;
	reg	[2:0]	counter_reg_bit;
	wire	[2:0]	wire_counter_reg_bit_ena;
	wire	[2:0]	wire_counter_reg_bit_sload;
	wire  wire_cmpr20_aeb;
	wire  aclr_actual;
	wire clk_en;
	wire cnt_en;
	wire  compare_result;
	wire  cout_actual;
	wire [2:0]  data;
	wire  external_cin;
	wire  [2:0]  modulus_bus;
	wire  modulus_trigger;
	wire  [2:0]  s_val;
	wire  [2:0]  safe_q;
	wire sclr;
	wire sload;
	wire sset;
	wire  time_to_clear;
	wire  updown_dir;

	cycloneive_lcell_comb   counter_comb_bita_0
	( 
	.cin(external_cin),
	.combout(wire_counter_comb_bita_0combout[0:0]),
	.cout(wire_counter_comb_bita_0cout[0:0]),
	.dataa(counter_reg_bit[0]),
	.datab(updown_dir),
	.datad(1'b1),
	.datac(1'b0)
	);
	defparam
		counter_comb_bita_0.lut_mask = 16'h5A90,
		counter_comb_bita_0.sum_lutc_input = "cin",
		counter_comb_bita_0.lpm_type = "cycloneive_lcell_comb";
	cycloneive_lcell_comb   counter_comb_bita_1
	( 
	.cin(wire_counter_comb_bita_0cout[0:0]),
	.combout(wire_counter_comb_bita_1combout[0:0]),
	.cout(wire_counter_comb_bita_1cout[0:0]),
	.dataa(counter_reg_bit[1]),
	.datab(updown_dir),
	.datad(1'b1),
	.datac(1'b0)
	);
	defparam
		counter_comb_bita_1.lut_mask = 16'h5A90,
		counter_comb_bita_1.sum_lutc_input = "cin",
		counter_comb_bita_1.lpm_type = "cycloneive_lcell_comb";
	cycloneive_lcell_comb   counter_comb_bita_2
	( 
	.cin(wire_counter_comb_bita_1cout[0:0]),
	.combout(wire_counter_comb_bita_2combout[0:0]),
	.cout(wire_counter_comb_bita_2cout[0:0]),
	.dataa(counter_reg_bit[2]),
	.datab(updown_dir),
	.datad(1'b1),
	.datac(1'b0)
	);
	defparam
		counter_comb_bita_2.lut_mask = 16'h5A90,
		counter_comb_bita_2.sum_lutc_input = "cin",
		counter_comb_bita_2.lpm_type = "cycloneive_lcell_comb";
	// synopsys translate_off
	initial
		counter_reg_bit[0:0] = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr_actual)
		if (aclr_actual == 1'b1) counter_reg_bit[0:0] <= 1'b0;
		else if  (wire_counter_reg_bit_ena[0:0] == 1'b1) 
			if (wire_counter_reg_bit_sload[0:0] == 1'b1) counter_reg_bit[0:0] <= wire_counter_reg_bit_asdata[0:0];
			else  counter_reg_bit[0:0] <= wire_counter_reg_bit_d[0:0];
	// synopsys translate_off
	initial
		counter_reg_bit[1:1] = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr_actual)
		if (aclr_actual == 1'b1) counter_reg_bit[1:1] <= 1'b0;
		else if  (wire_counter_reg_bit_ena[1:1] == 1'b1) 
			if (wire_counter_reg_bit_sload[1:1] == 1'b1) counter_reg_bit[1:1] <= wire_counter_reg_bit_asdata[1:1];
			else  counter_reg_bit[1:1] <= wire_counter_reg_bit_d[1:1];
	// synopsys translate_off
	initial
		counter_reg_bit[2:2] = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr_actual)
		if (aclr_actual == 1'b1) counter_reg_bit[2:2] <= 1'b0;
		else if  (wire_counter_reg_bit_ena[2:2] == 1'b1) 
			if (wire_counter_reg_bit_sload[2:2] == 1'b1) counter_reg_bit[2:2] <= wire_counter_reg_bit_asdata[2:2];
			else  counter_reg_bit[2:2] <= wire_counter_reg_bit_d[2:2];
	assign
		wire_counter_reg_bit_asdata = ({3{(~ sclr)}} & (({3{sset}} & s_val) | ({3{(~ sset)}} & (({3{sload}} & data) | (({3{(~ sload)}} & modulus_bus) & {3{(~ updown_dir)}}))))),
		wire_counter_reg_bit_d = {wire_counter_comb_bita_2combout[0:0], wire_counter_comb_bita_1combout[0:0], wire_counter_comb_bita_0combout[0:0]};
	assign
		wire_counter_reg_bit_ena = {3{(clk_en & (((sclr | sset) | sload) | cnt_en))}},
		wire_counter_reg_bit_sload = {3{(((sclr | sset) | sload) | modulus_trigger)}};
	mf_lvds_cmpr1   cmpr20
	( 
	.aeb(wire_cmpr20_aeb),
	.dataa(safe_q),
	.datab(modulus_bus));
	assign
		aclr_actual = 1'b0,
		clk_en = 1'b1,
		cnt_en = 1'b1,
		compare_result = wire_cmpr20_aeb,
		cout_actual = (wire_counter_comb_bita_2cout[0:0] | (time_to_clear & updown_dir)),
		data = {3{1'b0}},
		external_cin = 1'b1,
		modulus_bus = 3'b110,
		modulus_trigger = cout_actual,
		q = safe_q,
		s_val = {3{1'b1}},
		safe_q = counter_reg_bit,
		sclr = 1'b0,
		sload = 1'b0,
		sset = 1'b0,
		time_to_clear = compare_result,
		updown_dir = updown;
endmodule //mf_lvds_cntr


//lpm_shiftreg CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" LPM_DIRECTION="RIGHT" LPM_WIDTH=7 clock data load shiftin shiftout
//VERSION_BEGIN 13.1 cbx_lpm_shiftreg 2014:03:12:18:15:30:SJ cbx_mgl 2014:03:12:18:25:18:SJ  VERSION_END

//synthesis_resources = reg 7 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mf_lvds_shift_reg
	( 
	clock,
	data,
	load,
	shiftin,
	shiftout) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   [6:0]  data;
	input   load;
	input   shiftin;
	output   shiftout;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [6:0]  data;
	tri0   load;
	tri1   shiftin;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[6:0]	shift_reg;
	wire  [6:0]  shift_node;

	// synopsys translate_off
	initial
		shift_reg = 0;
	// synopsys translate_on
	always @ ( posedge clock)
		
			if (load == 1'b1) shift_reg <= data;
			else  shift_reg <= shift_node;
	assign
		shift_node = {shiftin, shift_reg[6:1]},
		shiftout = shift_reg[0];
endmodule //mf_lvds_shift_reg

//synthesis_resources = cycloneive_pll 1 IO 4 lut 3 reg 163 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"{-to lvds_tx_pll} AUTO_MERGE_PLLS=OFF"} *)
module  mf_lvds_lvds_tx
	( 
	tx_in,
	tx_inclock,
	tx_locked,
	tx_out) /* synthesis synthesis_clearbox=1 */;
	input   [27:0]  tx_in;
	input   tx_inclock;
	output   tx_locked;
	output   [3:0]  tx_out;

	wire  [3:0]   wire_ddio_out_dataout;
	reg	dffe11;
	reg	[2:0]	dffe3a;
	reg	[2:0]	dffe4a;
	reg	[2:0]	dffe5a;
	reg	[2:0]	dffe6a;
	reg	[2:0]	dffe7a;
	reg	[2:0]	dffe8a;
	reg	[27:0]	h_sync_a;
	reg	[27:0]	h_sync_b;
	reg	[27:0]	l_sync_a;
	reg	sync_dffe1a;
	wire  wire_cmpr10_aeb;
	wire  wire_cmpr9_aeb;
	wire  [2:0]   wire_cntr2_q;
	wire  wire_shift_reg12_shiftout;
	wire  wire_shift_reg13_shiftout;
	wire  wire_shift_reg14_shiftout;
	wire  wire_shift_reg15_shiftout;
	wire  wire_shift_reg16_shiftout;
	wire  wire_shift_reg17_shiftout;
	wire  wire_shift_reg18_shiftout;
	wire  wire_shift_reg19_shiftout;
	wire  [4:0]   wire_lvds_tx_pll_clk;
	wire  wire_lvds_tx_pll_fbout;
	wire  wire_lvds_tx_pll_locked;
	wire  fast_clock;
	wire  [3:0]  h_input;
	wire  [3:0]  l_input;
	wire  load_signal;
	wire  slow_clock;
	wire  [55:0]  tx_align_wire;
	wire  [55:0]  tx_in_wire;

	mf_lvds_ddio_out   ddio_out
	( 
	.datain_h(l_input),
	.datain_l(h_input),
	.dataout(wire_ddio_out_dataout),
	.outclock(fast_clock));
	// synopsys translate_off
	initial
		dffe11 = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		  dffe11 <= ((wire_cmpr9_aeb & sync_dffe1a) | (wire_cmpr10_aeb & (~ sync_dffe1a)));
	// synopsys translate_off
	initial
		dffe3a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b1)   dffe3a <= wire_cntr2_q;
	// synopsys translate_off
	initial
		dffe4a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b0)   dffe4a <= wire_cntr2_q;
	// synopsys translate_off
	initial
		dffe5a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b1)   dffe5a <= dffe3a;
	// synopsys translate_off
	initial
		dffe6a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b0)   dffe6a <= dffe4a;
	// synopsys translate_off
	initial
		dffe7a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b0)   dffe7a <= dffe5a;
	// synopsys translate_off
	initial
		dffe8a = 0;
	// synopsys translate_on
	always @ ( posedge fast_clock)
		if (sync_dffe1a == 1'b1)   dffe8a <= dffe6a;
	// synopsys translate_off
	initial
		h_sync_a = 0;
	// synopsys translate_on
	always @ ( posedge slow_clock)
		  h_sync_a <= tx_in;
	// synopsys translate_off
	initial
		h_sync_b = 0;
	// synopsys translate_on
	always @ ( negedge slow_clock)
		  h_sync_b <= h_sync_a;
	// synopsys translate_off
	initial
		l_sync_a = 0;
	// synopsys translate_on
	always @ ( negedge slow_clock)
		  l_sync_a <= tx_in;
	// synopsys translate_off
	initial
		sync_dffe1a = 0;
	// synopsys translate_on
	always @ ( posedge slow_clock)
		  sync_dffe1a <= (~ sync_dffe1a);
	mf_lvds_cmpr   cmpr10
	( 
	.aeb(wire_cmpr10_aeb),
	.dataa(dffe4a),
	.datab(dffe8a));
	mf_lvds_cmpr   cmpr9
	( 
	.aeb(wire_cmpr9_aeb),
	.dataa(dffe3a),
	.datab(dffe7a));
	mf_lvds_cntr   cntr2
	( 
	.clock(fast_clock),
	.q(wire_cntr2_q),
	.updown(sync_dffe1a));
	mf_lvds_shift_reg   shift_reg12
	( 
	.clock(fast_clock),
	.data({tx_in_wire[1], tx_in_wire[3], tx_in_wire[5], tx_in_wire[7], tx_in_wire[9], tx_in_wire[11], tx_in_wire[13]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg12_shiftout));
	mf_lvds_shift_reg   shift_reg13
	( 
	.clock(fast_clock),
	.data({tx_in_wire[0], tx_in_wire[2], tx_in_wire[4], tx_in_wire[6], tx_in_wire[8], tx_in_wire[10], tx_in_wire[12]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg13_shiftout));
	mf_lvds_shift_reg   shift_reg14
	( 
	.clock(fast_clock),
	.data({tx_in_wire[15], tx_in_wire[17], tx_in_wire[19], tx_in_wire[21], tx_in_wire[23], tx_in_wire[25], tx_in_wire[27]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg14_shiftout));
	mf_lvds_shift_reg   shift_reg15
	( 
	.clock(fast_clock),
	.data({tx_in_wire[14], tx_in_wire[16], tx_in_wire[18], tx_in_wire[20], tx_in_wire[22], tx_in_wire[24], tx_in_wire[26]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg15_shiftout));
	mf_lvds_shift_reg   shift_reg16
	( 
	.clock(fast_clock),
	.data({tx_in_wire[29], tx_in_wire[31], tx_in_wire[33], tx_in_wire[35], tx_in_wire[37], tx_in_wire[39], tx_in_wire[41]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg16_shiftout));
	mf_lvds_shift_reg   shift_reg17
	( 
	.clock(fast_clock),
	.data({tx_in_wire[28], tx_in_wire[30], tx_in_wire[32], tx_in_wire[34], tx_in_wire[36], tx_in_wire[38], tx_in_wire[40]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg17_shiftout));
	mf_lvds_shift_reg   shift_reg18
	( 
	.clock(fast_clock),
	.data({tx_in_wire[43], tx_in_wire[45], tx_in_wire[47], tx_in_wire[49], tx_in_wire[51], tx_in_wire[53], tx_in_wire[55]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg18_shiftout));
	mf_lvds_shift_reg   shift_reg19
	( 
	.clock(fast_clock),
	.data({tx_in_wire[42], tx_in_wire[44], tx_in_wire[46], tx_in_wire[48], tx_in_wire[50], tx_in_wire[52], tx_in_wire[54]}),
	.load(load_signal),
	.shiftin(1'b0),
	.shiftout(wire_shift_reg19_shiftout));
	cycloneive_pll   lvds_tx_pll
	( 
	.activeclock(),
	.clk(wire_lvds_tx_pll_clk),
	.clkbad(),
	.fbin(wire_lvds_tx_pll_fbout),
	.fbout(wire_lvds_tx_pll_fbout),
	.inclk({1'b0, tx_inclock}),
	.locked(wire_lvds_tx_pll_locked),
	.phasedone(),
	.scandataout(),
	.scandone(),
	.vcooverrange(),
	.vcounderrange()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clkswitch(1'b0),
	.configupdate(1'b0),
	.pfdena(1'b1),
	.phasecounterselect({3{1'b0}}),
	.phasestep(1'b0),
	.phaseupdown(1'b0),
	.scanclk(1'b0),
	.scanclkena(1'b1),
	.scandata(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		lvds_tx_pll.clk0_divide_by = 2,
		lvds_tx_pll.clk0_multiply_by = 7,
		lvds_tx_pll.clk0_phase_shift = "-988",
		lvds_tx_pll.clk1_divide_by = 14,
		lvds_tx_pll.clk1_multiply_by = 7,
		lvds_tx_pll.clk1_phase_shift = "-988",
		lvds_tx_pll.inclk0_input_frequency = 13833,
		lvds_tx_pll.operation_mode = "normal",
		lvds_tx_pll.self_reset_on_loss_lock = "on",
		lvds_tx_pll.lpm_type = "cycloneive_pll";
	assign
		fast_clock = wire_lvds_tx_pll_clk[0],
		h_input = {wire_shift_reg19_shiftout, wire_shift_reg17_shiftout, wire_shift_reg15_shiftout, wire_shift_reg13_shiftout},
		l_input = {wire_shift_reg18_shiftout, wire_shift_reg16_shiftout, wire_shift_reg14_shiftout, wire_shift_reg12_shiftout},
		load_signal = dffe11,
		slow_clock = wire_lvds_tx_pll_clk[1],
		tx_align_wire = {h_sync_b[27:21], l_sync_a[27:21], h_sync_b[20:14], l_sync_a[20:14], h_sync_b[13:7], l_sync_a[13:7], h_sync_b[6:0], l_sync_a[6:0]},
		tx_in_wire = tx_align_wire,
		tx_locked = wire_lvds_tx_pll_locked,
		tx_out = wire_ddio_out_dataout;
endmodule //mf_lvds_lvds_tx
//VALID FILE
