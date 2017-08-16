//
// LCD DMD driver
// 
// Intended for 1366x768 LCD panel
//

module LCD_DMD_driver(

input			clock_50,

input			dotClock,				// Rising edge pulse that data comes in on
input			dotData,				// Dots coming in from video processor
input			dotLatch,				// Active high pulse that loads frame onto display
input	[2:0]	dotReg,					// Select which register to write to
input		   dotEnable,				//Use this to detect what type of display this is
	
output			pairECLK,
output			pairE2,
output			pairE1,
output			pairE0,	
	
output			pairOCLK,
output			pairO2,
output			pairO1,
output			pairO0,
		
output			led0,
	
output			backlight_pwm
);

//
// LVDS output clock
//
	reg 	[6:0]	CLKdata = 7'b1100011;
	reg 	[6:0]	RX2data = 7'b0000000;
	reg 	[6:0]	RX1data = 7'b0000000;
	reg 	[6:0]	RX0data = 7'b0000000;

//
// Display generation counters
//
	reg 	[15:0]	currentPixel = 0;			//Which 4x4 pixel we are drawing
	reg 	[7:0]		pixelX = 0;					//Which sub-pixel of a fat pixel we are drawing
	reg 	[7:0]		pixelY = 0;					
	reg 	[15:0]	pixelYcount = 0;
	reg 	[15:0]	startingRaster = 0;			//Where the display should start reading raster memory from
	reg 	[15:0]	startingRaster_1;			//Since this signal crosses clock domains, it must be synchronized
	reg 	[15:0]	startingRaster_2;			
	reg 	[15:0]	startingRaster_3;			
	reg				newRasterAddress, newRasterAddress_1, newRasterAddress_2, 
					newRasterAddress_3, newRasterAddress_4, newRasterAddress_5;
	
	reg		[5:0]	r;
	reg		[5:0]	g;
	reg		[5:0]	b;

always @*
begin
	RX2data[6] <= gd_de; 
	RX2data[5] <= gd_vsync;
	RX2data[4] <= gd_hsync;	  
	RX2data[3:0] <= gd_de ? b[5:2] : 4'h0;
	  
	RX1data[6:5] <= gd_de ? b[1:0] : 2'h0;
	RX1data[4:0] <= gd_de ? g[5:1] : 5'h0;
	  
	RX0data[0] <= gd_de ? g[0] : 1'h0;
	RX0data[5:0] <= gd_de ? r[5:0] :6'h0;

end

// dot array parameters
parameter	[7:0]	dot_x = 128;
parameter	[7:0]	dot_y = 64;

parameter	[7:0]	dot_width = 10;
parameter	[7:0]	dot_height = 10;

parameter	[15:0]	dot_offset_l = 43;
parameter	[15:0]	dot_offset_r = 43;
parameter	[15:0]	dot_offset_u = 64;
parameter	[15:0]	dot_offset_d = 64;

// sync generation parameters

		reg	[15:0]	count_x;
		reg	[15:0]	count_y;

parameter	[15:0]	x_visible_width = 'd1366;
parameter	[15:0]	x_back_porch = 'd90;
parameter	[15:0]	x_front_porch = 'd70;

parameter	[15:0]	y_visible_height = 'd768;
parameter	[15:0]	y_back_porch = 'd4;
parameter	[15:0]	y_front_porch = 'd19;

// note: this display does not use hsync or vsync, only DE
//
		reg			gd_de /* synthesis noprune */;
		reg			gd_hsync = 0 /* synthesis noprune */;
		reg			gd_vsync = 0 /* synthesis noprune */;
		reg			gd_visible /* synthesis noprune */;

always @(posedge clk_pixel) begin
	
	// pixel generation
	if(count_y < settings_latch[0]) begin
		// lightbar
		r <= settings_latch[6][5:0];
		g <= settings_latch[6][5:0];
		b <= settings_latch[6][5:0];
	end else begin
		// by default, all areas will be black
		r <= 0;
		g <= 0;
		b <= 0;
		
		if(count_y >= settings_latch[1] & pixelYcount < settings_latch[5] && count_y < y_visible_height ) begin
			// active DMD area
			if(count_x >= dot_offset_l && count_x < x_visible_width - dot_offset_r ) begin
				// visible x-area
				r <= dataOut[7:5]         * shader[pixelY + (settings_latch[2] * dot_height)][pixelX];
				g <= dataOut[4:2]         * shader[pixelY + (settings_latch[2] * dot_height)][pixelX];
				b <= {dataOut[1:0], 1'b0} * shader[pixelY + (settings_latch[2] * dot_height)][pixelX];	
			
				pixelX <= pixelX + 1'b1;
				if(pixelX == dot_width-1) begin
					pixelX <= 0; 
				end
				if(pixelX == dot_width-3) begin
					// increment next BRAM pixel a couple cycles ahead
					currentPixel <= currentPixel + 1'b1;
				end
			end

			if(count_x == x_visible_width ) begin 
				// end of line, increment all Y registers
				currentPixel <= currentPixel - dot_x;
				pixelX <= 0;
				pixelY <= pixelY + 1'b1;
				if(pixelY == dot_height-1) begin
					pixelY <= 0;
					pixelYcount <= pixelYcount + 1'b1;
					// override previous assignment, don't decrement pointer
					currentPixel <= currentPixel;
				end
			end
		end
	end
	
	if(count_y == y_visible_height && count_x == 0) begin
		// end of visible frame
		// reset all counters in preperation for next frame
		pixelX <= 0;
		pixelY <= 0;
		pixelYcount <= 0;
		currentPixel <= startingRaster_3;
	end

	// sync generation
	count_x <= count_x + 1'b1;
	if(count_x == x_visible_width-1) begin
		gd_de <= 0;
		gd_hsync <= 1;
	end
	if(count_x == x_visible_width + x_front_porch-1) begin
		gd_hsync <= 0;
	end
	if(count_x == x_visible_width + x_front_porch + x_back_porch-1) begin
		// reset x counter
		count_x <= 0;
		gd_de <= 1'b1 & gd_visible;
		gd_hsync <= 1;
		
		count_y <= count_y + 1'b1;
		
		if(count_y == y_visible_height-1) begin
			gd_vsync <= 0;
			gd_visible <= 0;
			gd_de <= 0;
		end
		if(count_y == y_visible_height + y_front_porch-1) begin
			gd_vsync <= 1;
		end
		if(count_y == y_visible_height + y_front_porch + y_back_porch-1) begin
			// reset y counter
			count_y <= 0;
			gd_visible <= 1;
			gd_de <= 1;
			gd_vsync <= 1;
		end
	end
	
	// synchronize the new address
	{startingRaster_2, startingRaster_1} <= {startingRaster_1, startingRaster};
	newRasterAddress_5 <= newRasterAddress_4;
	{newRasterAddress_4, newRasterAddress_3} <= {newRasterAddress_3, newRasterAddress_2};
	{newRasterAddress_2, newRasterAddress_1} <= {newRasterAddress_1, newRasterAddress};
	
	// load the new address
	if(newRasterAddress_5) begin
		startingRaster_3 <= startingRaster_2;	
		// load new settings
		settings_latch <= settings;
	end
end


// 
// DMD receiver registers
//	
parameter	[15:0]	num_settings = 16;			// Number of settings words (stop writing after this is reached)
	reg 	[15:0]	settings [0:15];			//Stores 16 word-sized settings used to config the FPGA via external MCU
	reg 	[15:0]	settings_latch [0:15];
	
	// synchronizers for filtering any noise resulting from too-fast input comparators
	reg				dotClock_1, dotClock_2, dotClock_3 = {1'b0, 1'b0, 1'b0};
	reg				dotLatch_1, dotLatch_2, dotLatch_3 = {1'b0, 1'b0, 1'b0};
	reg		[2:0] 	dotReg_1, dotReg_2, dotReg_3 = {3'b0, 3'b0, 3'b0};
	reg				dotData_1, dotData_2, dotData_3;
	reg				dotEnable_1, dotEnable_2, dotEnable_3;
	
	reg 	[7:0]	debug_written_byte /* synthesis noprune */;
	
	reg				dmd_first_frame = 0;
	reg				dmd_first_byte = 0;
	reg		[2:0]	dmd_bit_count = 7;
	reg		[7:0]	dmd_data = 8'hFF;
	reg		[3:0]	dmd_setting_count = 15;
	reg				dmd_setting_word = 0;

	reg		[15:0]	dmd_init_counter = 0;
	reg				dmd_enable, dmd_enable_1, dmd_enable_2 = {1'b0, 1'b0, 1'b0};

initial dmd_first_frame = 0;
initial dmd_first_byte = 0;

initial begin
	dotClock_3 <= 0;
	dotClock_2 <= 0;
	dotClock_1 <= 0;
	dmd_enable <= 0;
end
	
	reg		[7:0]	dmd_init_count;
	
initial dmd_init_count = 0;

always @(posedge clk_latching) begin
	{dotClock_3, dotClock_2, dotClock_1} <= 
	{dotClock_2, dotClock_1, dotClock};
	{dotData_3, dotData_2, dotData_1} <= 
	{dotData_2, dotData_1, dotData};
	{dotLatch_3, dotLatch_2, dotLatch_1} <= 
	{dotLatch_2, dotLatch_1, dotLatch};
	{dotReg_3, dotReg_2, dotReg_1} <= 
	{dotReg_2, dotReg_1, dotReg};
	{dotEnable_3, dotEnable_2, dotEnable_1} <= 
	{dotEnable_2, dotEnable_1, dotEnable};

	// mini test-bench
	// for some reason this is necessary to bootstrap the receive logic
	// enough to display the initial ram contents
	dmd_init_count <= dmd_init_count + 1'b1;
	case(dmd_init_count)
	0: dotClock_1 <= 0;
	1: dotClock_1 <= 0;
	2: dotLatch_1 <= 1;
	default: begin
		dotClock_1 <= ~dotClock_1;
		dotLatch_1 <= dotLatch_1;
	end
	10: dotLatch_1 <= 0;
	16: dmd_init_count <= dmd_init_count;
	endcase
	
	//dmd_enable <= 1;
end

always @(posedge dotClock_3) begin
	newRasterAddress <= 0;												//Flag to set if the pointers change (on a frame edge)
	
	if (~dotLatch_3) begin									

		if (dmd_bit_count == 7) begin
			if (~dotReg_3[0]) begin
				writeAddress <=  writeAddress + 1'b1;
			end else begin
				if(~dmd_setting_word) begin
					dmd_setting_count <= dmd_setting_count + 1'b1;
				end
			end		
		end else begin
			writeAddress <=  writeAddress;		
		end
	
		dmd_data[dmd_bit_count] <= dotData_3;				//Build the incoming byte
	
	end else begin
		dmd_setting_count <= 15;							//Set to 15 so it will rollover on the next write cycle
		
		if (startingRaster) begin							//Not 0? (Must be 8192)
			startingRaster <= 0;								//Where the display should draw from
			writeAddress <= 8191;							//Where the next frame will be read into memory. We ONE BELOW the target since next cycle it will be advanced before anything happens			
		end else begin
			startingRaster <= 8192;							//Where the display should draw from
			writeAddress <= 16383;							//Where the next frame will be read into memory. We goto the last position of the 16 bit memory counter so it rolls forward to 0 on next cycle				
		end
		
		newRasterAddress <= 1;								//Flag that we've changed the pointers

	end

end

always @(negedge dotClock_3)
begin

	if (~dotLatch_3) begin											//Regular data, not the end of frame yet?	
	
		if (dmd_bit_count == 0)	begin								//Was that was the last bit?
		
			if (~dotReg_3[0]) begin									//If screen data...
				dataIn <= dmd_data;									//And send over the data
				writeEnable <= 1;										//Set write enable! 			
			end else begin												//Else if settings data...			
				if(~dmd_setting_word) begin
					settings[dmd_setting_count][15:8] <= dmd_data;
				end else begin
					settings[dmd_setting_count][7:0] <= dmd_data;
				end
				dmd_setting_word ^= 1;				
			end
			
			dmd_bit_count <= 7;										//Reset the bit pointer
			
		end else	begin                  
				dmd_bit_count <= dmd_bit_count - 1'b1;
				writeEnable <= 0;				
		end			
	end else begin
		dmd_bit_count <= 7;
		writeEnable <= 0;		
		dmd_setting_word <= 0;		
	end
		
end

//
// PWM backlight
//
	reg 	[7:0]	pwmBrightness = 200;	
	
always @(posedge pwm_clock_out) begin
	led0 <= 1;

	if (pwmBrightness > settings[3]) begin
		backlight_pwm <= 0;
	end else begin
		backlight_pwm <= 1;			
	end

	if (pwmBrightness == 250) begin
		pwmBrightness <= 0;
	end else begin
		pwmBrightness <= pwmBrightness + 8'h1;			
	end					
end


//
// LVDS driver
//
// Uses a 4-channel LVDS megafunction with 7 bits per channel.
// Megafunction instantiates its own serialization PLL.
//
wire	[27:0]	lvds_in = {CLKdata, RX2data, RX1data, RX0data};
wire	[3:0]	lvds_out;

mf_lvds	mf_lvds_inst (
	.tx_in ( lvds_in ),
	.tx_inclock ( clk_pixel ),
	.tx_out ( lvds_out )
);

// assign one of the LVDS channels to be the output (double channel is not used)
assign pairOCLK = lvds_out[3];
assign pairO2 = lvds_out[2];
assign pairO1 = lvds_out[1];
assign pairO0 = lvds_out[0];


//
// PLL
//
// Generated clocks:
// 1. Pixel clock for driving display (~72.3mhz)
// 2. PWM clock for backlight (~KHz)
// 3. Oversampling clock for DMD data receipt
//
wire clk_pixel;
wire pwm_clock_out;
wire clk_latching;
wire pll_locked;

mf_clocks u1 (
	.inclk0		( clock_50 ),
	.locked		( pll_locked ),
	.c0			( clk_pixel ),
	.c1			( pwm_clock_out ),
	.c2			( clk_latching )
);	

//
// BRAM framebuffer
//
// Contains two buffers.
// Two ports - DMD receiver writes, display driver reads.
//

reg		[7:0]	dataIn;
reg		[13:0] writeAddress = 8192;
reg				writeEnable = 0;
wire	[7:0]	dataOut;

mf_ram u2 (
	.rdclock	( clk_pixel ),
	.rdaddress	( currentPixel ),
	.q			( dataOut ),
	
	.wrclock	( dotClock_3 ),
	.wraddress	( writeAddress ),
	.wren		( writeEnable ),
	.data		( dataIn )
);	

// 
// Initial settings including pixel shapes and configuration.
//	
reg 	[3:0]	shader [0:39] [0:9];	//shader [0:44] [0:29];

initial
begin

	settings[0:15] = '{177, 326, 0, 225, 128, 32, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0};				//Single-high Rob Zombie - Dominos default. Resolutions scaled to 1366x768
	
	//settings[0:15] = '{25, 75, 0, 225, 128, 64, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0};					//Double-high Jetsons and newer
	
	//Index of Settings:
	//0 = endingWhite bar - Vertical line where we stop drawing the white bar
	//1 = start of DMD draw - Where we start drawing the DMD dots
	//2 = pixel shape - 0-3 shapes
	//3 = brightness (0-250) PWM value for backlight. Below 130-ish goes pitch black
	//4 = width in virtual pixels (just 128 for now)
	//5 = height in virtual pixels (32 or 64)
	//6 = brightness of white bar
	
	shader = 
	'{

	//Round Circle, Shaded Edges
	
	'{4'h0, 4'h0, 4'h3, 4'h5, 4'h5, 4'h5, 4'h3, 4'h0, 4'h0, 4'h0},
	'{4'h0, 4'h4, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h4, 4'h0, 4'h0},
	'{4'h3, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h3, 4'h0},
	
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	
	'{4'h3, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h3, 4'h0},
	'{4'h0, 4'h4, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h4, 4'h0, 4'h0},
	'{4'h0, 4'h0, 4'h3, 4'h5, 4'h5, 4'h5, 4'h3, 4'h0, 4'h0, 4'h0},
	
	'{4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0},

	//Shaded Tiles
	
	'{4'h0, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h0, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h5, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h9, 4'h5, 4'h0},
	'{4'h0, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h5, 4'h0, 4'h0},
	'{4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0},	

	//Fake Hi-Res
	
	'{4'h1, 4'h5, 4'h7, 4'h0, 4'h1, 4'h0, 4'h7, 4'h5, 4'h0, 4'h1},
	'{4'h5, 4'h7, 4'h9, 4'h7, 4'h2, 4'h7, 4'h9, 4'h7, 4'h5, 4'h2},
	'{4'h7, 4'h9, 4'h9, 4'h7, 4'h2, 4'h7, 4'h9, 4'h9, 4'h7, 4'h2},
	'{4'h0, 4'h7, 4'h7, 4'h0, 4'h1, 4'h0, 4'h7, 4'h7, 4'h0, 4'h1},
	'{4'h1, 4'h3, 4'h3, 4'h1, 4'h3, 4'h1, 4'h0, 4'h0, 4'h1, 4'h3},	
	'{4'h0, 4'h7, 4'h7, 4'h0, 4'h1, 4'h0, 4'h7, 4'h7, 4'h0, 4'h1},
	'{4'h7, 4'h9, 4'h9, 4'h7, 4'h2, 4'h7, 4'h9, 4'h9, 4'h7, 4'h0},
	'{4'h5, 4'h7, 4'h9, 4'h7, 4'h2, 4'h7, 4'h9, 4'h7, 4'h5, 4'h0},
	'{4'h0, 4'h5, 4'h7, 4'h0, 4'h1, 4'h0, 4'h7, 4'h5, 4'h0, 4'h1},
	'{4'h1, 4'h2, 4'h2, 4'h1, 4'h3, 4'h1, 4'h2, 4'h2, 4'h1, 4'h3},

	//Super-Shaded
	
	'{4'h0, 4'h0, 4'h3, 4'h5, 4'h5, 4'h5, 4'h3, 4'h0, 4'h0, 4'h0},
	'{4'h0, 4'h3, 4'h5, 4'h6, 4'h7, 4'h6, 4'h5, 4'h3, 4'h0, 4'h0},
	'{4'h3, 4'h5, 4'h6, 4'h7, 4'h8, 4'h7, 4'h6, 4'h5, 4'h3, 4'h0},
	
	'{4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'h8, 4'h7, 4'h6, 4'h5, 4'h0},	
	'{4'h5, 4'h6, 4'h7, 4'h9, 4'h9, 4'h9, 4'h7, 4'h6, 4'h5, 4'h0},
	'{4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'h8, 4'h7, 4'h6, 4'h5, 4'h0},
	
	'{4'h3, 4'h5, 4'h6, 4'h7, 4'h8, 4'h7, 4'h6, 4'h5, 4'h3, 4'h0},
	'{4'h0, 4'h3, 4'h5, 4'h6, 4'h7, 4'h6, 4'h5, 4'h3, 4'h0, 4'h0},
	'{4'h0, 4'h0, 4'h3, 4'h5, 4'h5, 4'h5, 4'h3, 4'h0, 4'h0, 4'h0},
	
	'{4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0, 4'h0}
	};

end	
	

endmodule
