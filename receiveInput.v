module receiveInput(clock, resetn, ps2_key_data, ps2_key_pressed, x, y, change, move, save_enable, load_enable, load_config, speedUp, speedDown, startSim, resetBoard);
	//receiveInput(clock, resetn, ps2_key_data, ps2_key_pressed, x, y, change, move, startSim, resetBoard);
	input clock, resetn;
	input[7:0] ps2_key_data;
	input ps2_key_pressed;
	output reg change;
	output reg move;
	output reg startSim;
	output reg [5:0] x;
	output reg [4:0] y;	
	output reg resetBoard;
	output reg [2:0] load_config;
	output reg load_enable;
	output reg speedUp;
	output reg speedDown;
	output reg save_enable;
	
	reg[7:0] key_data1;
	reg[7:0] key_data2;
	
	always@(posedge clock)
	begin
		key_data2 <= key_data1;
		key_data1 <= ps2_key_data;
	end
	
	always @(posedge clock)
	begin
		if (!resetn)
		begin
			x <= 0;
			y <= 0;
			startSim <= 0;
			change <= 0;
			move <= 0;
			resetBoard <= 1;
			load_config <= 3'b000;
			load_enable <= 0;
			save_enable <= 0;
		end
		else
		begin
			if ((key_data2 == 8'hF0)&&(key_data1 == 8'h75) && (y != 5'd0)) //up arrow
			begin
				y <= y - 5'd1;
				startSim <= 0;
				move <= 1;
				change <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h72) && (y != 5'd29)) //down arrow
			begin
				y <= y + 5'd1;
				startSim <= 0;
				move <= 1;
				change <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0)&& (key_data1 == 8'h6B) && (x != 6'd0)) //left arrow
			begin
				x <= x - 6'd1;
				startSim <= 0;
				move <= 1;
				change <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0) && (key_data1 == 8'h74) && (x != 6'd39)) //right arrow
			begin
				x <= x + 6'd1;
				startSim <= 0;
				move <= 1;
				change <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0) && (key_data1 == 8'h29)) //space bar
			begin
				change <= 1;
				startSim <= 0;
				move <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h4D)) //p for pause
			begin
				startSim <= ~startSim;
				move <= 0;
				change <= 0;
				resetBoard <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h1B)) //s for save
			begin
				move <= 0;
				change <= 0;
				resetBoard <= 1;
				save_enable <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h2D)) //r for restart
			begin
				resetBoard <= 0;
				move <= 1;
				change <= 0;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h16)) //config 1
			begin
				load_config <= 3'b000;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h1E)) //config 2
			begin
				load_config <= 3'b001;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h26)) //config 3
			begin
				load_config <= 3'b010;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h25)) //config 4
			begin
				load_config <= 3'b011;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h2E)) //config 5
			begin
				load_config <= 3'b100;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h4B)) //load
			begin
				load_config <= 3'b111;
				load_enable <= 1;
				resetBoard <= 1;
				change <= 0;
				move <= 1;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h4E)) //minus
			begin
				speedUp <= 0;
				speedDown <= 1;
				load_enable <= 0;
				resetBoard <= 1;
				change <= 0;
				move <= 0;
			end
			else if ((key_data2 == 8'hF0)&&(key_data1 == 8'h55)) //plus
			begin
				speedUp <= 1;
				speedDown <= 0;
				load_enable <= 0;
				resetBoard <= 1;
				change <= 0;
				move <= 0;
			end
			else
			begin
				change <= 0;
				move <= 0; 
				speedUp <= 0;
				speedDown <= 0;
				load_enable <= 0;
				resetBoard <= 1;
				save_enable <= 0;
			end
		end
			
	end
endmodule