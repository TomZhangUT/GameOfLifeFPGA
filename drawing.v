module draw_module(clock, current_state, startDraw, cursor_enable, x_cursor, y_cursor, x_vga, y_vga, writeEn, color, finishDraw);
	input clock, startDraw, cursor_enable;
	input [1199:0] current_state;
	input [5:0] x_cursor;
	input [4:0] y_cursor; 
	
	wire cell_drawn, update_coord, reset_coord, load_coord, cursor_drawn;
	wire [7:0] x;
	wire [7:0] y;
	wire [7:0] x_vga_cell;
	wire [6:0] y_vga_cell;
	wire [2:0] color_cell;
	wire startCell;

	wire [7:0] x_vga_cursor;
	wire [6:0] y_vga_cursor;
	wire [2:0] color_cursor;
	wire startCursor;
	wire writeEn_cursor;
	
	output [7:0] x_vga;
	output [6:0] y_vga;
	output writeEn, finishDraw;
	output [2:0] color;
	
	//fsm that controls drawing
	fsm_draw f1(clock, startDraw, cell_drawn, cursor_drawn, cursor_enable, x, y, update_coord, reset_coord, load_coord, startCell, startCursor, finishDraw);
	
	//updates the x and y coordinates
	update_coord u1(clock,reset_coord,update_coord, x, y);
	
	//draws a square when startCell is high 
	draw_square d1(clock, load_coord, startCell, x, y, x_vga_cell, y_vga_cell, cell_drawn);
	
	//determines cell colour from current state
	cell_color c1(clock, update_coord, reset_coord, current_state, color_cell);
	
	//keeps track of cursor and draws it when appropriate
	cursor c2(clock, startCursor, x_cursor, y_cursor, x_vga_cursor, y_vga_cursor, color_cursor, writeEn_cursor, cursor_drawn);
	
	//mux between cursor output and cell output
	cursor_or_cell c3(startCursor, x_vga_cell, y_vga_cell, x_vga_cursor, y_vga_cursor, color_cell, color_cursor, x_vga, y_vga, color);
	
	assign writeEn = (startCell||writeEn_cursor);
endmodule

module fsm_draw (clock, start, cell_drawn, cursor_drawn, cursor_enable,
						x_corner, y_corner, update_coord, reset_coord, load_coord, startCell, startCursor, finish);
	input clock, start, cell_drawn, cursor_enable, cursor_drawn;
	input[7:0] x_corner;
	input [6:0] y_corner;
	output update_coord, reset_coord, load_coord, startCell,startCursor, finish;
	reg[2:0] y, Y;
	parameter [2:0] Idle=3'b000, loadData = 3'b001, draw_SQ = 3'b010, update_coordinates=3'b011, draw_cursor=3'b100, done=3'b101;
	
	always @ (posedge clock)
		y <= Y;
	
	always @(*)
		case(y)
			Idle:
				if (start) 
					Y = loadData;
				else 
					Y = Idle;
			loadData:
				Y = draw_SQ;
			draw_SQ:
				if (cell_drawn)
					Y = update_coordinates;
				else
					Y= draw_SQ;
			update_coordinates:
				if((((x_corner == 8'd156) && (y_corner == 7'd116))||(y_corner > 7'd116)) && cursor_enable)
					Y = draw_cursor;
				else if(((x_corner == 8'd156) && (y_corner == 7'd116))||(y_corner > 7'd116))
					Y = done;
				else
					Y = loadData;
			draw_cursor:
				if (cursor_drawn)
					Y = done;
				else
					Y = draw_cursor;
			done:
				Y = Idle;
			default:
				Y = Idle;
		endcase		
	
	assign reset_coord=~(y==Idle); 
	assign update_coord = (y==update_coordinates);
	assign load_coord = (y==loadData);
	assign startCell = (y==draw_SQ);
	assign finish = (y==done);
	assign startCursor = (y==draw_cursor);
endmodule	

module update_coord(clock, reset, enable, x, y);
	input clock, reset, enable;
	output reg[7:0] x;
	output reg[6:0] y;
	
	always@(posedge clock)
	if (!reset)
	begin
		x <= 0;
		y <= 0;
	end
	else if ((enable) && (x == 8'd156))
	begin
		x <= 0;
		y <= y + 7'd4;
	end
	else if (enable)
	begin
		x <= x + 8'd4;
	end
endmodule

module cursor(clock, enable, x, y, x_vga, y_vga, color, writeEn, done);
	input clock, enable;
	input [5:0] x;
	input [4:0] y;
	output reg [7:0] x_vga;
	output reg [6:0] y_vga;
	output done;
	output reg writeEn;
	output [2:0] color;
	reg [3:0] counter;
	
	//updates counter to draw next pixel
	always@(posedge clock)
	if (!enable)
		counter <= 0;
	else if (enable)
		counter <= counter + 4'b1;
	
	//logic from drawing ring
	always@(*)
	case(counter)
		4'd1: 	begin x_vga=6'd4*x; 			y_vga=5'd4*y; 			writeEn = 1;end
		4'd2: 	begin x_vga=6'd4*x+6'd1; 	y_vga=5'd4*y; 			writeEn = 1;end
		4'd3: 	begin x_vga=6'd4*x+6'd2; 	y_vga=5'd4*y; 			writeEn = 1;end
		4'd4: 	begin x_vga=6'd4*x+6'd3; 	y_vga=5'd4*y; 			writeEn = 1;end
		4'd5: 	begin x_vga=6'd4*x; 			y_vga=5'd4*y+5'd1; 	writeEn = 1;end
		4'd6: 	begin x_vga=6'd4*x+6'd3;	y_vga=5'd4*y+5'd1; 	writeEn = 1;end
		4'd7: 	begin x_vga=6'd4*x; 			y_vga=5'd4*y+5'd2; 	writeEn = 1;end
		4'd8: 	begin x_vga=6'd4*x+6'd3; 	y_vga=5'd4*y+5'd2; 	writeEn = 1;end
		4'd9: 	begin x_vga=6'd4*x; 			y_vga=5'd4*y+5'd3; 	writeEn = 1;end
		4'd10: 	begin x_vga=6'd4*x+6'd1; 	y_vga=5'd4*y+5'd3; 	writeEn = 1;end
		4'd11: 	begin x_vga=6'd4*x+6'd2; 	y_vga=5'd4*y+5'd3; 	writeEn = 1;end
		4'd12: 	begin x_vga=6'd4*x+6'd3; 	y_vga=5'd4*y+5'd3; 	writeEn = 1;end
		default:	begin x_vga=6'd0; 			y_vga=5'd0;				writeEn = 0;end
	endcase
	
	assign color = 3'b011;
	assign done = (counter == 12); 
endmodule

module cursor_or_cell(startCursor, x_vga_cell, y_vga_cell, x_vga_cursor, y_vga_cursor, color_cell, color_cursor, x_vga, y_vga, color);
	input startCursor;
	input [7:0] x_vga_cell, x_vga_cursor;
	input [6:0] y_vga_cell, y_vga_cursor;
	input [2:0] color_cell, color_cursor;
	output reg [7:0] x_vga;
	output reg [6:0] y_vga;
	output reg [2:0] color;
	
	always@(*)
	if (startCursor)
	begin
		x_vga = x_vga_cursor;
		y_vga = y_vga_cursor;
		color = color_cursor;
	end
	else
	begin
		x_vga = x_vga_cell;
		y_vga = y_vga_cell;
		color = color_cell;
	end
endmodule

module cell_color(clock, enable, resetn, current_state, color); 
	input clock, enable;
	input resetn;
	output reg [2:0]color;
	input [1199:0] current_state;
	reg [10:0] counter;
	//reg [10:0] test_counter; //remove later, for testing purposes
	
	//updates counter to traverse bits
	always@(posedge clock)
	if (!resetn)
	begin
		counter <= 0;
	end
	else if (enable)
	begin
		counter <= counter + 11'd1;
	end
	
	//outputs appropriate colour
	always@(*)
	if (current_state[counter])
		color <= 3'b111;
	else
		color <= 3'b000;
endmodule

module draw_square(clock, load, enable, x_orig, y_orig, x_out, y_out, done_square);
	input load, clock, enable;
	input[7:0] x_orig;
	input[6:0] y_orig;
	output reg [7:0] x_out;
	output reg [6:0] y_out;
	
	reg [7:0] x;
	reg [6:0] y;
	reg [7:0] x_limit;
	reg [6:0] y_limit;
	
	output reg done_square;
	
	always@(posedge clock)
		if (load)
		begin
			//set the start coordinates
			x <= x_orig;
			y <= y_orig;
			x_out <= x_orig;
			y_out <= y_orig;
			done_square <= 0;
			
			if ((x_orig+8'd3) < 8'd159)
			x_limit <= x_orig+8'd3;
			else
			x_limit <= 8'd159;
			
			if ((y_orig+7'd3) < 7'd119)
			y_limit <= y_orig+7'd3;
			else
			y_limit <= 7'd119;
		end
		else if ((x_out == x_limit)&&(y_out == y_limit))
		begin
			//output done if at bottom right of square
			done_square <= 1;
		end
		else if ((x_out == x_limit) && (enable))
		begin
			//if at end of row, reset x position and increment y
			x_out <= x;
			y_out <= y_out + 7'd1;
		end
		else if (enable)
			//otherwise increment x
			x_out <= x_out + 8'd1;	
endmodule