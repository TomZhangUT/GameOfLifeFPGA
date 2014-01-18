module datapath(clock, resetn, enable_update, enable_edit, enable_save, enable_load, load_config, num_gen, x, y, current_state);
	input clock, resetn, enable_update, enable_edit;
	input enable_load, enable_save;		
	reg [1199:0] next_state;
	reg [1199:0] saved_state;
	output reg [1199:0] current_state;
	output reg [6:0] num_gen;
	integer neighbours, row, col;
	
	input [5:0] x;
	input [4:0] y;
	input [2:0] load_config;
	
	always@(posedge clock, negedge resetn)
	if (!resetn)
	begin
		current_state <= 1200'h0;
		num_gen <= 0;
	end
	else if (enable_load)	//user indicates wants to load pattern on
	begin
		if (load_config == 3'b000)		//slider gun
		begin
		// starting square
			current_state[360] <= 1;
			current_state[361] <= 1;
			current_state[400] <= 1;
			current_state[401] <= 1;
			
		// 1st middle section	
			current_state[253] <= 1;
			current_state[292] <= 1;
			current_state[294] <= 1;
			current_state[331] <= 1;
			current_state[335] <= 1;
			current_state[336] <= 1;
			current_state[371] <= 1;
			current_state[375] <= 1;
			current_state[376] <= 1;
			current_state[411] <= 1;
			current_state[415] <= 1;
			current_state[416] <= 1;
			current_state[452] <= 1;
			current_state[454] <= 1;
			current_state[493] <= 1;
			
		//	2nd middle section
			current_state[185] <= 1;
			current_state[222] <= 1;
			current_state[223] <= 1;
			current_state[224] <= 1;
			current_state[225] <= 1;
			current_state[261] <= 1;
			current_state[262] <= 1;
			current_state[263] <= 1;
			current_state[264] <= 1;
			current_state[301] <= 1;
			current_state[304] <= 1;
			current_state[341] <= 1;
			current_state[342] <= 1;
			current_state[343] <= 1;
			current_state[344] <= 1;
			current_state[382] <= 1;
			current_state[383] <= 1;
			current_state[384] <= 1;
			current_state[385] <= 1;
			current_state[425] <= 1;
			
		// bar	
			current_state[230] <= 1;
			current_state[270] <= 1;
		
		// last square
			current_state[314] <= 1;
			current_state[315] <= 1;
			current_state[354] <= 1;
			current_state[355] <= 1;
			
		end
		else if (load_config == 3'b001)		//R-pentomino
		begin
			current_state[623] <= 1;
			current_state[624] <= 1;
			current_state[662] <= 1;
			current_state[663] <= 1;
			current_state[703] <= 1;
		end
		else if (load_config == 3'b010)		//pulsar
		begin
			current_state[376] <= 1;
			current_state[377] <= 1;
			current_state[378] <= 1;
			
			current_state[382] <= 1;
			current_state[383] <= 1;
			current_state[384] <= 1;
			
			current_state[454] <= 1;
			current_state[494] <= 1;
			current_state[534] <= 1;
			
			current_state[459] <= 1;
			current_state[499] <= 1;
			current_state[539] <= 1;
			
			current_state[461] <= 1;
			current_state[501] <= 1;
			current_state[541] <= 1;

			current_state[466] <= 1;
			current_state[506] <= 1;
			current_state[546] <= 1;
			
			current_state[576] <= 1;
			current_state[577] <= 1;
			current_state[578] <= 1;
			
			current_state[582] <= 1;
			current_state[583] <= 1;
			current_state[584] <= 1;
			
			current_state[656] <= 1;
			current_state[657] <= 1;
			current_state[658] <= 1;
			
			current_state[662] <= 1;
			current_state[663] <= 1;
			current_state[664] <= 1;
			
			current_state[694] <= 1;
			current_state[734] <= 1;
			current_state[774] <= 1;
			
			current_state[699] <= 1;
			current_state[739] <= 1;
			current_state[779] <= 1;
			
			current_state[701] <= 1;
			current_state[741] <= 1;
			current_state[781] <= 1;
			
			current_state[706] <= 1;
			current_state[746] <= 1;
			current_state[786] <= 1;
			
			current_state[856] <= 1;
			current_state[857] <= 1;
			current_state[858] <= 1;
			
			current_state[862] <= 1;
			current_state[863] <= 1;
			current_state[864] <= 1;
		end
		else if (load_config == 3'b011)		//wick
		begin
			// top squares
			current_state[404] <= 1;
			current_state[405] <= 1;
			current_state[444] <= 1;
			current_state[445] <= 1;
			current_state[408] <= 1;
			current_state[409] <= 1;
			current_state[448] <= 1;
			current_state[449] <= 1;
			current_state[412] <= 1;
			current_state[413] <= 1;
			current_state[452] <= 1;
			current_state[453] <= 1;
			current_state[416] <= 1;
			current_state[417] <= 1;
			current_state[456] <= 1;
			current_state[457] <= 1;
			current_state[420] <= 1;
			current_state[421] <= 1;
			current_state[460] <= 1;
			current_state[461] <= 1;
			current_state[424] <= 1;
			current_state[425] <= 1;
			current_state[464] <= 1;
			current_state[465] <= 1;
			current_state[428] <= 1;
			current_state[429] <= 1;
			current_state[468] <= 1;
			current_state[469] <= 1;
			current_state[432] <= 1;
			current_state[433] <= 1;
			current_state[472] <= 1;
			current_state[473] <= 1;
			
			// first row
			current_state[522] <= 1;
			current_state[523] <= 1;
			current_state[524] <= 1;
			current_state[525] <= 1;
			current_state[526] <= 1;
			current_state[527] <= 1;
			current_state[528] <= 1;
			current_state[529] <= 1;
			current_state[530] <= 1;
			current_state[531] <= 1;
			current_state[532] <= 1;
			current_state[533] <= 1;
			current_state[534] <= 1;
			current_state[535] <= 1;
			current_state[536] <= 1;
			current_state[537] <= 1;
			current_state[538] <= 1;
			current_state[539] <= 1;
			current_state[540] <= 1;
			current_state[541] <= 1;
			current_state[542] <= 1;
			current_state[543] <= 1;
			current_state[544] <= 1;
			current_state[545] <= 1;
			current_state[546] <= 1;
			current_state[547] <= 1;
			current_state[548] <= 1;
			current_state[549] <= 1;
			current_state[550] <= 1;
			current_state[551] <= 1;
			current_state[552] <= 1;
			current_state[553] <= 1;
			current_state[554] <= 1;
			current_state[555] <= 1;
			
			// three protruding cells on left and right side
			current_state[561] <= 1;
			current_state[600] <= 1;
			current_state[641] <= 1;
			current_state[596] <= 1;
			current_state[637] <= 1;
			current_state[676] <= 1;
			
			// two moving cells in middle 
			current_state[568] <= 1;
			current_state[647] <= 1;
			
			// middle row
			current_state[602] <= 1;
			current_state[603] <= 1;
			current_state[604] <= 1;
			current_state[605] <= 1;
			current_state[606] <= 1;
			current_state[611] <= 1;
			current_state[612] <= 1;
			current_state[613] <= 1;
			current_state[614] <= 1;
			current_state[615] <= 1;
			current_state[616] <= 1;
			current_state[617] <= 1;
			current_state[618] <= 1;
			current_state[619] <= 1;
			current_state[620] <= 1;
			current_state[621] <= 1;
			current_state[622] <= 1;
			current_state[623] <= 1;
			current_state[624] <= 1;
			current_state[625] <= 1;
			current_state[626] <= 1;
			current_state[627] <= 1;
			current_state[628] <= 1;
			current_state[629] <= 1;
			current_state[630] <= 1;
			current_state[631] <= 1;
			current_state[632] <= 1;
			current_state[633] <= 1;
			current_state[634] <= 1;
			current_state[635] <= 1;

			// bottom row
			current_state[682] <= 1;
			current_state[683] <= 1;
			current_state[684] <= 1;
			current_state[685] <= 1;
			current_state[686] <= 1;
			current_state[687] <= 1;
			current_state[688] <= 1;
			current_state[689] <= 1;
			current_state[690] <= 1;
			current_state[691] <= 1;
			current_state[692] <= 1;
			current_state[693] <= 1;
			current_state[694] <= 1;
			current_state[695] <= 1;
			current_state[696] <= 1;
			current_state[697] <= 1;
			current_state[698] <= 1;
			current_state[699] <= 1;
			current_state[700] <= 1;
			current_state[701] <= 1;
			current_state[702] <= 1;
			current_state[703] <= 1;
			current_state[704] <= 1;
			current_state[705] <= 1;
			current_state[706] <= 1;
			current_state[707] <= 1;
			current_state[708] <= 1;
			current_state[709] <= 1;
			current_state[710] <= 1;
			current_state[711] <= 1;
			current_state[712] <= 1;
			current_state[713] <= 1;
			current_state[714] <= 1;
			current_state[715] <= 1;
			
			// last square
			current_state[764] <= 1;
			current_state[765] <= 1;
			current_state[804] <= 1;
			current_state[805] <= 1;
			current_state[768] <= 1;
			current_state[769] <= 1;
			current_state[808] <= 1;
			current_state[809] <= 1;
			current_state[772] <= 1;
			current_state[773] <= 1;
			current_state[812] <= 1;
			current_state[813] <= 1;
			current_state[776] <= 1;
			current_state[777] <= 1;
			current_state[816] <= 1;
			current_state[817] <= 1;
			current_state[780] <= 1;
			current_state[781] <= 1;
			current_state[820] <= 1;
			current_state[821] <= 1;
			current_state[784] <= 1;
			current_state[785] <= 1;
			current_state[824] <= 1;
			current_state[825] <= 1;
			current_state[788] <= 1;
			current_state[789] <= 1;
			current_state[828] <= 1;
			current_state[829] <= 1;
			current_state[792] <= 1;
			current_state[793] <= 1;
			current_state[832] <= 1;
			current_state[833] <= 1;
		end
		else if (load_config == 3'b111)		//load preconfigured settings
		begin
			current_state <= saved_state;
		end
	end
	else if (enable_update)	//update to next generation
	begin
		current_state <= next_state;
		
		//update generation counter
		if (num_gen == 7'd99)
		begin
			num_gen <= 7'b0;
		end
		else
		begin
			num_gen <= num_gen + 7'b1;
		end
	end
	else if (enable_edit)	//if user edits a value
	begin
		current_state[40*y+x] <= ~current_state[40*y+x];	//toggle the value
	end
	else if (enable_save)	//if user saves a configuration
	begin
		saved_state <= current_state;	//save to register
	end
	
	//next state logic
	always@(*)
	begin
		//middle of the grid
		for (row = 1; row < 29; row = row+1)
		begin
			for (col =1; col<39; col = col + 1)
			begin
				neighbours = 	current_state[40*(row-1)+col-1] + 	current_state[40*(row-1)+col] +	current_state[40*(row-1)+col+1]	+
									current_state[40*row+col-1] 													+ 	current_state[40*row+col+1]  		+
									current_state[40*(row+1)+col-1] + 	current_state[40*(row+1)+col] + 	current_state[40*(row+1)+col+1]	;
				if (neighbours == 3)
					next_state[40*row+col] = 1;
				else if ((neighbours == 2) && (current_state[40*row+col]))
					next_state[40*row+col] = 1;
				else
					next_state[40*row+col] = 0;
			end
		end
		
		//top row excluding corners
		for (col = 1; col < 39; col = col+1)
		begin
			neighbours = 	current_state[col-1] 										+ 	current_state[col+1]  	+
								current_state[col+39] + 	current_state[col+40] 	+ 	current_state[col+41]	;
			if (neighbours == 3)
				next_state[col] = 1;
			else if ((neighbours == 2) && (current_state[col]))
				next_state[col] = 1;
			else
				next_state[col] = 0;
		end
		
		//bottom row excluding corners
		for (col = 1; col < 39; col = col+1)
		begin
			neighbours = 	current_state[col+1159] 										+ 	current_state[col+1161]  	+
								current_state[col+1119] + 	current_state[col+1120] 	+ 	current_state[col+1121]		;
			if (neighbours == 3)
				next_state[col+1160] = 1;
			else if ((neighbours == 2) && (current_state[col+1160]))
				next_state[col+1160] = 1;
			else
				next_state[col+1160] = 0;
		end
		
		//left col excluding corners
		for (row = 1; row<29; row = row + 1)
		begin
			neighbours = 		current_state[40*(row-1)]		 	+	current_state[40*(row-1) +1]	+
																				+ 	current_state[40*row+1]  		+
									current_state[40*(row+1)] 			+ 	current_state[40*(row+1) +1]	;
			if (neighbours == 3)
				next_state[40*row] = 1;
			else if ((neighbours == 2) && (current_state[40*row]))
				next_state[40*row] = 1;
			else
				next_state[40*row] = 0;
		end
		
		//right col excluding corners
		for (row = 1; row<29; row = row + 1)
		begin
			neighbours = 		current_state[40*(row-1)+39]		 	+	current_state[40*(row-1)+38]	+
																					+ 	current_state[40*row+38]  		+
									current_state[40*(row+1)+39] 			+ 	current_state[40*(row+1)+38]	;
			if (neighbours == 3)
				next_state[40*row+39] = 1;
			else if ((neighbours == 2) && (current_state[40*row+39]))
				next_state[40*row+39] = 1;
			else
				next_state[40*row+39] = 0;
		end
		
		//corners
		neighbours = current_state[1] + current_state[40] + current_state[41]; //top left
		
		if (neighbours == 3)
				next_state[0] = 1;
			else if ((neighbours == 2) && (current_state[0]))
				next_state[0] = 1;
			else
				next_state[0] = 0;

		neighbours = current_state[38] + current_state[78] + current_state[79];	//top right
		if (neighbours == 3)
				next_state[39] = 1;
			else if ((neighbours == 2) && (current_state[39]))
				next_state[39] = 1;
			else
				next_state[39] = 0;
		
		neighbours = current_state[1120] + current_state[1121] + current_state[1161];	//bottom left
		if (neighbours == 3)
				next_state[1160] = 1;
			else if ((neighbours == 2) && (current_state[1160]))
				next_state[1160] = 1;
			else
				next_state[1160] = 0;
				
		neighbours = current_state[1198] + current_state[1158] + current_state[1159];	//bottom right
		if (neighbours == 3)
				next_state[1199] = 1;
			else if ((neighbours == 2) && (current_state[1160]))
				next_state[1199] = 1;
			else
				next_state[1199] = 0;
		
	end
endmodule

module liveCounter(current_state, num_live);
	input [1199:0] current_state;
	output [10:0] num_live;
		
	//massive addition of all bits in the current state
	assign num_live = current_state[0] + 
		current_state[1] + current_state[2] + current_state[3] + current_state[4] + current_state[5] + current_state[6] + current_state[7] + current_state[8] + current_state[9] + current_state[10] + 
		current_state[11] + current_state[12] + current_state[13] + current_state[14] + current_state[15] + current_state[16] + current_state[17] + current_state[18] + current_state[19] + current_state[20] + 
		current_state[21] + current_state[22] + current_state[23] + current_state[24] + current_state[25] + current_state[26] + current_state[27] + current_state[28] + current_state[29] + current_state[30] + 
		current_state[31] + current_state[32] + current_state[33] + current_state[34] + current_state[35] + current_state[36] + current_state[37] + current_state[38] + current_state[39] + current_state[40] + 
		current_state[41] + current_state[42] + current_state[43] + current_state[44] + current_state[45] + current_state[46] + current_state[47] + current_state[48] + current_state[49] + current_state[50] + 
		current_state[51] + current_state[52] + current_state[53] + current_state[54] + current_state[55] + current_state[56] + current_state[57] + current_state[58] + current_state[59] + current_state[60] + 
		current_state[61] + current_state[62] + current_state[63] + current_state[64] + current_state[65] + current_state[66] + current_state[67] + current_state[68] + current_state[69] + current_state[70] + 
		current_state[71] + current_state[72] + current_state[73] + current_state[74] + current_state[75] + current_state[76] + current_state[77] + current_state[78] + current_state[79] + current_state[80] + 
		current_state[81] + current_state[82] + current_state[83] + current_state[84] + current_state[85] + current_state[86] + current_state[87] + current_state[88] + current_state[89] + current_state[90] + 
		current_state[91] + current_state[92] + current_state[93] + current_state[94] + current_state[95] + current_state[96] + current_state[97] + current_state[98] + current_state[99] + current_state[100] + 
		current_state[101] + current_state[102] + current_state[103] + current_state[104] + current_state[105] + current_state[106] + current_state[107] + current_state[108] + current_state[109] + current_state[110] + 
		current_state[111] + current_state[112] + current_state[113] + current_state[114] + current_state[115] + current_state[116] + current_state[117] + current_state[118] + current_state[119] + current_state[120] + 
		current_state[121] + current_state[122] + current_state[123] + current_state[124] + current_state[125] + current_state[126] + current_state[127] + current_state[128] + current_state[129] + current_state[130] + 
		current_state[131] + current_state[132] + current_state[133] + current_state[134] + current_state[135] + current_state[136] + current_state[137] + current_state[138] + current_state[139] + current_state[140] + 
		current_state[141] + current_state[142] + current_state[143] + current_state[144] + current_state[145] + current_state[146] + current_state[147] + current_state[148] + current_state[149] + current_state[150] + 
		current_state[151] + current_state[152] + current_state[153] + current_state[154] + current_state[155] + current_state[156] + current_state[157] + current_state[158] + current_state[159] + current_state[160] + 
		current_state[161] + current_state[162] + current_state[163] + current_state[164] + current_state[165] + current_state[166] + current_state[167] + current_state[168] + current_state[169] + current_state[170] + 
		current_state[171] + current_state[172] + current_state[173] + current_state[174] + current_state[175] + current_state[176] + current_state[177] + current_state[178] + current_state[179] + current_state[180] + 
		current_state[181] + current_state[182] + current_state[183] + current_state[184] + current_state[185] + current_state[186] + current_state[187] + current_state[188] + current_state[189] + current_state[190] + 
		current_state[191] + current_state[192] + current_state[193] + current_state[194] + current_state[195] + current_state[196] + current_state[197] + current_state[198] + current_state[199] + current_state[200] + 
		current_state[201] + current_state[202] + current_state[203] + current_state[204] + current_state[205] + current_state[206] + current_state[207] + current_state[208] + current_state[209] + current_state[210] + 
		current_state[211] + current_state[212] + current_state[213] + current_state[214] + current_state[215] + current_state[216] + current_state[217] + current_state[218] + current_state[219] + current_state[220] + 
		current_state[221] + current_state[222] + current_state[223] + current_state[224] + current_state[225] + current_state[226] + current_state[227] + current_state[228] + current_state[229] + current_state[230] + 
		current_state[231] + current_state[232] + current_state[233] + current_state[234] + current_state[235] + current_state[236] + current_state[237] + current_state[238] + current_state[239] + current_state[240] + 
		current_state[241] + current_state[242] + current_state[243] + current_state[244] + current_state[245] + current_state[246] + current_state[247] + current_state[248] + current_state[249] + current_state[250] + 
		current_state[251] + current_state[252] + current_state[253] + current_state[254] + current_state[255] + current_state[256] + current_state[257] + current_state[258] + current_state[259] + current_state[260] + 
		current_state[261] + current_state[262] + current_state[263] + current_state[264] + current_state[265] + current_state[266] + current_state[267] + current_state[268] + current_state[269] + current_state[270] + 
		current_state[271] + current_state[272] + current_state[273] + current_state[274] + current_state[275] + current_state[276] + current_state[277] + current_state[278] + current_state[279] + current_state[280] + 
		current_state[281] + current_state[282] + current_state[283] + current_state[284] + current_state[285] + current_state[286] + current_state[287] + current_state[288] + current_state[289] + current_state[290] + 
		current_state[291] + current_state[292] + current_state[293] + current_state[294] + current_state[295] + current_state[296] + current_state[297] + current_state[298] + current_state[299] + current_state[300] + 
		current_state[301] + current_state[302] + current_state[303] + current_state[304] + current_state[305] + current_state[306] + current_state[307] + current_state[308] + current_state[309] + current_state[310] + 
		current_state[311] + current_state[312] + current_state[313] + current_state[314] + current_state[315] + current_state[316] + current_state[317] + current_state[318] + current_state[319] + current_state[320] + 
		current_state[321] + current_state[322] + current_state[323] + current_state[324] + current_state[325] + current_state[326] + current_state[327] + current_state[328] + current_state[329] + current_state[330] + 
		current_state[331] + current_state[332] + current_state[333] + current_state[334] + current_state[335] + current_state[336] + current_state[337] + current_state[338] + current_state[339] + current_state[340] + 
		current_state[341] + current_state[342] + current_state[343] + current_state[344] + current_state[345] + current_state[346] + current_state[347] + current_state[348] + current_state[349] + current_state[350] + 
		current_state[351] + current_state[352] + current_state[353] + current_state[354] + current_state[355] + current_state[356] + current_state[357] + current_state[358] + current_state[359] + current_state[360] + 
		current_state[361] + current_state[362] + current_state[363] + current_state[364] + current_state[365] + current_state[366] + current_state[367] + current_state[368] + current_state[369] + current_state[370] + 
		current_state[371] + current_state[372] + current_state[373] + current_state[374] + current_state[375] + current_state[376] + current_state[377] + current_state[378] + current_state[379] + current_state[380] + 
		current_state[381] + current_state[382] + current_state[383] + current_state[384] + current_state[385] + current_state[386] + current_state[387] + current_state[388] + current_state[389] + current_state[390] + 
		current_state[391] + current_state[392] + current_state[393] + current_state[394] + current_state[395] + current_state[396] + current_state[397] + current_state[398] + current_state[399] + current_state[400] + 
		current_state[401] + current_state[402] + current_state[403] + current_state[404] + current_state[405] + current_state[406] + current_state[407] + current_state[408] + current_state[409] + current_state[410] + 
		current_state[411] + current_state[412] + current_state[413] + current_state[414] + current_state[415] + current_state[416] + current_state[417] + current_state[418] + current_state[419] + current_state[420] + 
		current_state[421] + current_state[422] + current_state[423] + current_state[424] + current_state[425] + current_state[426] + current_state[427] + current_state[428] + current_state[429] + current_state[430] + 
		current_state[431] + current_state[432] + current_state[433] + current_state[434] + current_state[435] + current_state[436] + current_state[437] + current_state[438] + current_state[439] + current_state[440] + 
		current_state[441] + current_state[442] + current_state[443] + current_state[444] + current_state[445] + current_state[446] + current_state[447] + current_state[448] + current_state[449] + current_state[450] + 
		current_state[451] + current_state[452] + current_state[453] + current_state[454] + current_state[455] + current_state[456] + current_state[457] + current_state[458] + current_state[459] + current_state[460] + 
		current_state[461] + current_state[462] + current_state[463] + current_state[464] + current_state[465] + current_state[466] + current_state[467] + current_state[468] + current_state[469] + current_state[470] + 
		current_state[471] + current_state[472] + current_state[473] + current_state[474] + current_state[475] + current_state[476] + current_state[477] + current_state[478] + current_state[479] + current_state[480] + 
		current_state[481] + current_state[482] + current_state[483] + current_state[484] + current_state[485] + current_state[486] + current_state[487] + current_state[488] + current_state[489] + current_state[490] + 
		current_state[491] + current_state[492] + current_state[493] + current_state[494] + current_state[495] + current_state[496] + current_state[497] + current_state[498] + current_state[499] + current_state[500] + 
		current_state[501] + current_state[502] + current_state[503] + current_state[504] + current_state[505] + current_state[506] + current_state[507] + current_state[508] + current_state[509] + current_state[510] + 
		current_state[511] + current_state[512] + current_state[513] + current_state[514] + current_state[515] + current_state[516] + current_state[517] + current_state[518] + current_state[519] + current_state[520] + 
		current_state[521] + current_state[522] + current_state[523] + current_state[524] + current_state[525] + current_state[526] + current_state[527] + current_state[528] + current_state[529] + current_state[530] + 
		current_state[531] + current_state[532] + current_state[533] + current_state[534] + current_state[535] + current_state[536] + current_state[537] + current_state[538] + current_state[539] + current_state[540] + 
		current_state[541] + current_state[542] + current_state[543] + current_state[544] + current_state[545] + current_state[546] + current_state[547] + current_state[548] + current_state[549] + current_state[550] + 
		current_state[551] + current_state[552] + current_state[553] + current_state[554] + current_state[555] + current_state[556] + current_state[557] + current_state[558] + current_state[559] + current_state[560] + 
		current_state[561] + current_state[562] + current_state[563] + current_state[564] + current_state[565] + current_state[566] + current_state[567] + current_state[568] + current_state[569] + current_state[570] + 
		current_state[571] + current_state[572] + current_state[573] + current_state[574] + current_state[575] + current_state[576] + current_state[577] + current_state[578] + current_state[579] + current_state[580] + 
		current_state[581] + current_state[582] + current_state[583] + current_state[584] + current_state[585] + current_state[586] + current_state[587] + current_state[588] + current_state[589] + current_state[590] + 
		current_state[591] + current_state[592] + current_state[593] + current_state[594] + current_state[595] + current_state[596] + current_state[597] + current_state[598] + current_state[599] + current_state[600] + 
		current_state[601] + current_state[602] + current_state[603] + current_state[604] + current_state[605] + current_state[606] + current_state[607] + current_state[608] + current_state[609] + current_state[610] + 
		current_state[611] + current_state[612] + current_state[613] + current_state[614] + current_state[615] + current_state[616] + current_state[617] + current_state[618] + current_state[619] + current_state[620] + 
		current_state[621] + current_state[622] + current_state[623] + current_state[624] + current_state[625] + current_state[626] + current_state[627] + current_state[628] + current_state[629] + current_state[630] + 
		current_state[631] + current_state[632] + current_state[633] + current_state[634] + current_state[635] + current_state[636] + current_state[637] + current_state[638] + current_state[639] + current_state[640] + 
		current_state[641] + current_state[642] + current_state[643] + current_state[644] + current_state[645] + current_state[646] + current_state[647] + current_state[648] + current_state[649] + current_state[650] + 
		current_state[651] + current_state[652] + current_state[653] + current_state[654] + current_state[655] + current_state[656] + current_state[657] + current_state[658] + current_state[659] + current_state[660] + 
		current_state[661] + current_state[662] + current_state[663] + current_state[664] + current_state[665] + current_state[666] + current_state[667] + current_state[668] + current_state[669] + current_state[670] + 
		current_state[671] + current_state[672] + current_state[673] + current_state[674] + current_state[675] + current_state[676] + current_state[677] + current_state[678] + current_state[679] + current_state[680] + 
		current_state[681] + current_state[682] + current_state[683] + current_state[684] + current_state[685] + current_state[686] + current_state[687] + current_state[688] + current_state[689] + current_state[690] + 
		current_state[691] + current_state[692] + current_state[693] + current_state[694] + current_state[695] + current_state[696] + current_state[697] + current_state[698] + current_state[699] + current_state[700] + 
		current_state[701] + current_state[702] + current_state[703] + current_state[704] + current_state[705] + current_state[706] + current_state[707] + current_state[708] + current_state[709] + current_state[710] + 
		current_state[711] + current_state[712] + current_state[713] + current_state[714] + current_state[715] + current_state[716] + current_state[717] + current_state[718] + current_state[719] + current_state[720] + 
		current_state[721] + current_state[722] + current_state[723] + current_state[724] + current_state[725] + current_state[726] + current_state[727] + current_state[728] + current_state[729] + current_state[730] + 
		current_state[731] + current_state[732] + current_state[733] + current_state[734] + current_state[735] + current_state[736] + current_state[737] + current_state[738] + current_state[739] + current_state[740] + 
		current_state[741] + current_state[742] + current_state[743] + current_state[744] + current_state[745] + current_state[746] + current_state[747] + current_state[748] + current_state[749] + current_state[750] + 
		current_state[751] + current_state[752] + current_state[753] + current_state[754] + current_state[755] + current_state[756] + current_state[757] + current_state[758] + current_state[759] + current_state[760] + 
		current_state[761] + current_state[762] + current_state[763] + current_state[764] + current_state[765] + current_state[766] + current_state[767] + current_state[768] + current_state[769] + current_state[770] + 
		current_state[771] + current_state[772] + current_state[773] + current_state[774] + current_state[775] + current_state[776] + current_state[777] + current_state[778] + current_state[779] + current_state[780] + 
		current_state[781] + current_state[782] + current_state[783] + current_state[784] + current_state[785] + current_state[786] + current_state[787] + current_state[788] + current_state[789] + current_state[790] + 
		current_state[791] + current_state[792] + current_state[793] + current_state[794] + current_state[795] + current_state[796] + current_state[797] + current_state[798] + current_state[799] + current_state[800] + 
		current_state[801] + current_state[802] + current_state[803] + current_state[804] + current_state[805] + current_state[806] + current_state[807] + current_state[808] + current_state[809] + current_state[810] + 
		current_state[811] + current_state[812] + current_state[813] + current_state[814] + current_state[815] + current_state[816] + current_state[817] + current_state[818] + current_state[819] + current_state[820] + 
		current_state[821] + current_state[822] + current_state[823] + current_state[824] + current_state[825] + current_state[826] + current_state[827] + current_state[828] + current_state[829] + current_state[830] + 
		current_state[831] + current_state[832] + current_state[833] + current_state[834] + current_state[835] + current_state[836] + current_state[837] + current_state[838] + current_state[839] + current_state[840] + 
		current_state[841] + current_state[842] + current_state[843] + current_state[844] + current_state[845] + current_state[846] + current_state[847] + current_state[848] + current_state[849] + current_state[850] + 
		current_state[851] + current_state[852] + current_state[853] + current_state[854] + current_state[855] + current_state[856] + current_state[857] + current_state[858] + current_state[859] + current_state[860] + 
		current_state[861] + current_state[862] + current_state[863] + current_state[864] + current_state[865] + current_state[866] + current_state[867] + current_state[868] + current_state[869] + current_state[870] + 
		current_state[871] + current_state[872] + current_state[873] + current_state[874] + current_state[875] + current_state[876] + current_state[877] + current_state[878] + current_state[879] + current_state[880] + 
		current_state[881] + current_state[882] + current_state[883] + current_state[884] + current_state[885] + current_state[886] + current_state[887] + current_state[888] + current_state[889] + current_state[890] + 
		current_state[891] + current_state[892] + current_state[893] + current_state[894] + current_state[895] + current_state[896] + current_state[897] + current_state[898] + current_state[899] + current_state[900] + 
		current_state[901] + current_state[902] + current_state[903] + current_state[904] + current_state[905] + current_state[906] + current_state[907] + current_state[908] + current_state[909] + current_state[910] + 
		current_state[911] + current_state[912] + current_state[913] + current_state[914] + current_state[915] + current_state[916] + current_state[917] + current_state[918] + current_state[919] + current_state[920] + 
		current_state[921] + current_state[922] + current_state[923] + current_state[924] + current_state[925] + current_state[926] + current_state[927] + current_state[928] + current_state[929] + current_state[930] + 
		current_state[931] + current_state[932] + current_state[933] + current_state[934] + current_state[935] + current_state[936] + current_state[937] + current_state[938] + current_state[939] + current_state[940] + 
		current_state[941] + current_state[942] + current_state[943] + current_state[944] + current_state[945] + current_state[946] + current_state[947] + current_state[948] + current_state[949] + current_state[950] + 
		current_state[951] + current_state[952] + current_state[953] + current_state[954] + current_state[955] + current_state[956] + current_state[957] + current_state[958] + current_state[959] + current_state[960] + 
		current_state[961] + current_state[962] + current_state[963] + current_state[964] + current_state[965] + current_state[966] + current_state[967] + current_state[968] + current_state[969] + current_state[970] + 
		current_state[971] + current_state[972] + current_state[973] + current_state[974] + current_state[975] + current_state[976] + current_state[977] + current_state[978] + current_state[979] + current_state[980] + 
		current_state[981] + current_state[982] + current_state[983] + current_state[984] + current_state[985] + current_state[986] + current_state[987] + current_state[988] + current_state[989] + current_state[990] + 
		current_state[991] + current_state[992] + current_state[993] + current_state[994] + current_state[995] + current_state[996] + current_state[997] + current_state[998] + current_state[999] + current_state[1000] + 
		current_state[1001] + current_state[1002] + current_state[1003] + current_state[1004] + current_state[1005] + current_state[1006] + current_state[1007] + current_state[1008] + current_state[1009] + current_state[1010] + 
		current_state[1011] + current_state[1012] + current_state[1013] + current_state[1014] + current_state[1015] + current_state[1016] + current_state[1017] + current_state[1018] + current_state[1019] + current_state[1020] + 
		current_state[1021] + current_state[1022] + current_state[1023] + current_state[1024] + current_state[1025] + current_state[1026] + current_state[1027] + current_state[1028] + current_state[1029] + current_state[1030] + 
		current_state[1031] + current_state[1032] + current_state[1033] + current_state[1034] + current_state[1035] + current_state[1036] + current_state[1037] + current_state[1038] + current_state[1039] + current_state[1040] + 
		current_state[1041] + current_state[1042] + current_state[1043] + current_state[1044] + current_state[1045] + current_state[1046] + current_state[1047] + current_state[1048] + current_state[1049] + current_state[1050] + 
		current_state[1051] + current_state[1052] + current_state[1053] + current_state[1054] + current_state[1055] + current_state[1056] + current_state[1057] + current_state[1058] + current_state[1059] + current_state[1060] + 
		current_state[1061] + current_state[1062] + current_state[1063] + current_state[1064] + current_state[1065] + current_state[1066] + current_state[1067] + current_state[1068] + current_state[1069] + current_state[1070] + 
		current_state[1071] + current_state[1072] + current_state[1073] + current_state[1074] + current_state[1075] + current_state[1076] + current_state[1077] + current_state[1078] + current_state[1079] + current_state[1080] + 
		current_state[1081] + current_state[1082] + current_state[1083] + current_state[1084] + current_state[1085] + current_state[1086] + current_state[1087] + current_state[1088] + current_state[1089] + current_state[1090] + 
		current_state[1091] + current_state[1092] + current_state[1093] + current_state[1094] + current_state[1095] + current_state[1096] + current_state[1097] + current_state[1098] + current_state[1099] + current_state[1100] + 
		current_state[1101] + current_state[1102] + current_state[1103] + current_state[1104] + current_state[1105] + current_state[1106] + current_state[1107] + current_state[1108] + current_state[1109] + current_state[1110] + 
		current_state[1111] + current_state[1112] + current_state[1113] + current_state[1114] + current_state[1115] + current_state[1116] + current_state[1117] + current_state[1118] + current_state[1119] + current_state[1120] + 
		current_state[1121] + current_state[1122] + current_state[1123] + current_state[1124] + current_state[1125] + current_state[1126] + current_state[1127] + current_state[1128] + current_state[1129] + current_state[1130] + 
		current_state[1131] + current_state[1132] + current_state[1133] + current_state[1134] + current_state[1135] + current_state[1136] + current_state[1137] + current_state[1138] + current_state[1139] + current_state[1140] + 
		current_state[1141] + current_state[1142] + current_state[1143] + current_state[1144] + current_state[1145] + current_state[1146] + current_state[1147] + current_state[1148] + current_state[1149] + current_state[1150] + 
		current_state[1151] + current_state[1152] + current_state[1153] + current_state[1154] + current_state[1155] + current_state[1156] + current_state[1157] + current_state[1158] + current_state[1159] + current_state[1160] + 
		current_state[1161] + current_state[1162] + current_state[1163] + current_state[1164] + current_state[1165] + current_state[1166] + current_state[1167] + current_state[1168] + current_state[1169] + current_state[1170] + 
		current_state[1171] + current_state[1172] + current_state[1173] + current_state[1174] + current_state[1175] + current_state[1176] + current_state[1177] + current_state[1178] + current_state[1179] + current_state[1180] + 
		current_state[1181] + current_state[1182] + current_state[1183] + current_state[1184] + current_state[1185] + current_state[1186] + current_state[1187] + current_state[1188] + current_state[1189] + current_state[1190] + 
		current_state[1191] + current_state[1192] + current_state[1193] + current_state[1194] + current_state[1195] + current_state[1196] + current_state[1197] + current_state[1198] + current_state[1199]; 
endmodule