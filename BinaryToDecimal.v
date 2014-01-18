module BinarytoDecimal_11bit_4digit(binary_num, display1, display2, display3, display4);
	input [10:0] binary_num;
	output[6:0] display1, display2, display3, display4;
	wire[3:0] thousands, hundreds, tens, ones;
	
	BCD_11bit converter(thousands, hundreds, tens, ones, binary_num);
	
	char_7seg hexdisp0(ones, display1);
	char_7seg hexdisp1(tens, display2);
	char_7seg hexdisp2(hundreds, display3);
	char_7seg hexdisp3(thousands, display4);
endmodule

module BinarytoDecimal_7bit_2digit(binary_num, display1, display2);
	input [6:0] binary_num;
	output[6:0] display1, display2;
	wire[3:0] h,t,o;
	
	BCD_7bit converter(h, t, o, binary_num);
	char_7seg hexdisp2(t, display2);
	char_7seg hexdisp1(o, display1);
endmodule

module BCD_11bit(thousands, hundreds, tens, ones, binaryinput);

integer i;

input [10:0] binaryinput;
output reg [3:0] thousands;
output reg [3:0] hundreds;
output reg [3:0] tens;
output reg [3:0] ones;

always @ (binaryinput)
begin
	thousands = 4'd0;
	hundreds = 4'd0;
	tens = 4'd0;
	ones = 4'd0;

	for (i = 10; i >= 0; i = i-1)
	begin
	
		if (thousands >= 4'd5)
			thousands = thousands + 4'd3;
		if (hundreds >= 4'd5)
			hundreds = hundreds + 4'd3;
		if (tens >= 4'd5)
			tens = tens + 4'd3;
		if (ones >= 4'd5)
			ones = ones + 4'd3;
		
		thousands = thousands << 1;
		thousands[0] = hundreds[3];
		hundreds = hundreds << 1;
		hundreds[0] = tens[3];
		tens = tens << 1;
		tens[0] = ones [3];
		ones = ones << 1;	
		ones[0] = binaryinput[i];	
	end
end
endmodule

module BCD_7bit(hundreds, tens, ones, binaryinput);

integer i;

input [6:0] binaryinput;
output reg [3:0] hundreds;
output reg [3:0] tens;
output reg [3:0] ones;

always @ (binaryinput)
begin
	hundreds = 4'd0;
	tens = 4'd0;
	ones = 4'd0;

	for (i = 6; i >=0; i = i-1)
	begin
	
		if (hundreds >= 4'd5)
			hundreds = hundreds + 4'd3;
		if (tens >= 4'd5)
			tens = tens + 4'd3;
		if (ones >= 4'd5)
			ones = ones + 4'd3;
		
		hundreds = hundreds << 1;
		hundreds[0] = tens[3];
		tens = tens << 1;
		tens[0] = ones [3];
		ones = ones << 1;	
		ones[0] = binaryinput[i];	
	end
end
endmodule

module char_7seg (C, Display);
	input [3:0] C; // input code
	output reg [6:0] Display; // output 7-seg code
	
	always@(*)
	case(C)
		4'b0000: Display = 7'b1000000;
		4'b0001: Display = 7'b1111001;
		4'b0010: Display = 7'b0100100;
		4'b0011: Display = 7'b0110000;
		4'b0100: Display = 7'b0011001;
		4'b0101: Display = 7'b0010010;
		4'b0110: Display = 7'b0000010;
		4'b0111: Display = 7'b1111000;
		4'b1000: Display = 7'b0000000;
		4'b1001: Display = 7'b0010000;
		default: Display = 7'b1111111;
	endcase

endmodule	

module char3bit_7seg (C, Display);
	input [2:0] C;
	output reg [6:0] Display;
	
	always@(*)
	case(C)
		3'b000: Display = 7'b1000000;
		3'b001: Display = 7'b1111001;
		3'b010: Display = 7'b0100100;
		3'b011: Display = 7'b0110000;
		3'b100: Display = 7'b0011001;
		3'b101: Display = 7'b0010010;
		3'b110: Display = 7'b0000010;
		3'b111: Display = 7'b1111000;
		default: Display = 7'b1111111;
	endcase
endmodule

	