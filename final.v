// Final Project

module final
	(
		CLOCK_50,						//	On Board 50 MHz
		KEY,							//	Push Button[3:0]
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		LEDG,
		LEDR,
		SW,
		//FOR PS2 CONTROLLER
		PS2_CLK,
		PS2_DAT,
		//HEX DISPLAYS
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5,
		HEX6,
		HEX7
	);

	input			CLOCK_50;				//	50 MHz
	input	[2:0]	KEY;					//	Button[3:0]
	input [17:0]	SW;
		
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	
	output[2:0] LEDG;
	output[17:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the color, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] color;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Bidirectionals
	inout				PS2_CLK;
	inout				PS2_DAT;
	
	// Internal Wires
	wire		[7:0]	ps2_key_data;
	wire				ps2_key_pressed;

	// Internal Registers
	reg			[7:0]	last_data_received;

		PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset					(0),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
	);

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(1),
			.clock(CLOCK_50),
			.colour(color),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "background.mif";
			
	// Put your code here. Your code should produce signals x,y,color and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	wire startDraw, finishDraw, startUpdate, startEdit, startSim, startSave, timer;
	wire [1199:0] current_state;
	
	wire[5:0] x_cursor;
	wire[4:0] y_cursor;
		
	wire click, move, resetBoard, load_enable, save_enable;
	wire[2:0] load_config;
	wire[7:0] pressed_key;
	//assign LEDR[5:0] = x_cursor;
	//assign LEDR[10:6] = y_cursor;
	//assign LEDR[17] = startSim;
	//assign LEDR[16] = load_enable;
	assign LEDR[15:13] = load_config;
	
	wire [10:0] num_live;
	wire [6:0] num_gen;
	//assign LEDR[10:0] = num_live;
	//assign LEDR[17:11] = num_gen;
	assign LEDR[2:0] = speed;
	
	wire speedUp, speedDown;
	wire [2:0] speed;
	//handles all drawing
	draw_module d1(CLOCK_50, current_state, startDraw, ~startSim, x_cursor, y_cursor, x, y, writeEn, color, finishDraw);
	
	//handles logic of conway's game of life array
	datapath d2(CLOCK_50, resetBoard, startUpdate, startEdit, startSave, load_enable, load_config, num_gen, x_cursor, y_cursor, current_state);
	
	//counts the number of live cells 
	liveCounter l1(current_state, num_live);
	
	//Main FSM 
	fsm_top f1(CLOCK_50, resetn, timer, startSim, click, move, save_enable, finishDraw, startDraw, startUpdate, startEdit, startSave, LEDG);
	
	//timer to count from one generation to the next
	timer t1(CLOCK_50, resetn, speedUp, speedDown, speed, timer);
	
	//number displays
	BinarytoDecimal_11bit_4digit b1(num_live, HEX0, HEX1, HEX2, HEX3);
	BinarytoDecimal_7bit_2digit b2(num_gen, HEX4, HEX5);
	char3bit_7seg c1(speed, HEX6);
	char3bit_7seg c2(3'b000, HEX7);
	
	//converts ps2 input into input signals
	receiveInput r1(CLOCK_50, resetn, ps2_key_data, ps2_key_pressed, x_cursor, y_cursor,
						click, move, save_enable, load_enable, load_config, speedUp, speedDown, startSim, resetBoard);
endmodule

module fsm_top (clock, resetn, timer, startSim, click, move, save, doneDraw, startDraw, startUpdate, startEdit, startSave, LEDG);
	input clock, timer, resetn, startSim, click, move, save, doneDraw;
	output startUpdate, startDraw, startEdit, startSave;
	output[2:0] LEDG;
	reg[2:0] y, Y;
	parameter [2:0] Idle=3'b000, Wait=3'b001, Update = 3'b010, Draw = 3'b011, Edit = 3'b100, Refresh = 3'b101, Save = 3'b110;
	
	always @ (posedge clock, negedge resetn)
		if (!resetn)
			y <= Idle;
		else
			y <= Y;
	
	//Idle: default state, does nothing
	//Wait: waits a set amount time based on speed then draws
	//Draw: Calls the draw module to draw based on current settings
	//Edit: Change the editted cell, then draws
	//Refresh: Refreshes the screen by calling draw next. Used when user is moving cursor around
	//Save: Save the current value in
	
	always @(*)
		case(y)
			Idle:	
				if (startSim) 
					Y = Wait;
				else if (move)
					Y = Refresh;
				else if (click)
					Y = Edit;
				else if (save)
					Y = Save;
				else 
					Y = Idle;
			Wait:
				if (timer)
					Y = Update;
				else
					Y = Wait;
			Update:
				Y = Draw;
			Draw:
				if(doneDraw)
					Y = Idle;
				else
					Y = Draw;
			Edit:
				Y = Draw;
			Refresh:
				Y = Draw;
			Save:
				Y = Idle;
			default:
				Y = Idle;
		endcase		
	
	assign startUpdate = (y == Update);
	assign LEDG = y;
	assign startDraw = (Y==Draw);
	assign startEdit = (y==Edit);
	assign startSave = (y==Save);
		
endmodule	

module timer(clock, resetn, inc_speed, dec_speed, speed, timer);
	input clock, inc_speed, dec_speed, resetn;
	reg[28:0] counter = 0;
	output reg [2:0] speed;
	output reg timer;
	
	wire[28:0] limit;
	assign limit = 29'd50000000/speed; 
	
	always @(posedge clock, negedge resetn)
	begin
		if (!resetn)
		begin
			//set defaults
			counter <= 0;
			timer <= 0;
			speed <= 3'b001;
		end
		else if (inc_speed)
		begin
			//if speed is not 7, increase speed
			if (speed != 3'b111)
			begin
			speed <= speed + 3'b1;
			counter <= 0;
			end
		end
		else if (dec_speed)
		begin
			//if the speed is not 1, decrement speed
			if (speed != 3'b001)
			begin
				counter <= 0;
				speed <= speed - 3'b1;
			end
		end
		else if (counter == limit)	//send a signal for one clock cycle once limit amount of cycles has passed
		begin
			counter <=0;
			timer <= 1;
		end
		else
		begin
			timer <= 0;
			counter <= counter + 29'b1;
		end
	end
endmodule