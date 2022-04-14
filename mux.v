module mux(
	output [31:0] out,
	input [8*31:0] in,
	input [$clog2(8)-1:0] select
);
	
	genvar i;
	generate
	for (i=0; i<8; i=i+1) begin : gen_mux
		assign out = (select == i) ? in[(i+1)*31:i*32] : {32{1'bz}};
	end
	endgenerate
endmodule

module mux_2(
	output reg [31:0] out,
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23,
	input [4:0] sel
);

always @ (sel or in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or in8 or in9 or in10 or in11 or in12 or in13 or in14 or in15 or in16 or in17 or in18 or in19 or in20 or in21 or in22 or in23)
begin: mux_2
	case(sel)
		5'b00000 : out = in0;
		5'b00001 : out = in1;
		5'b00010 : out = in2;
		5'b00011 : out = in3;
		5'b00100 : out = in4;
		5'b00101 : out = in5;
		5'b00110 : out = in6;
		5'b00111 : out = in7;
		5'b01000 : out = in8;
		5'b01001 : out = in9;
		5'b01010 : out = in10;
		5'b01100 : out = in11;
		5'b01011 : out = in12;
		5'b01101 : out = in13;
		5'b01110 : out = in14;
		5'b01111 : out = in15;
		5'b10000 : out = in16;
		5'b10001 : out = in17;
		5'b10010 : out = in18;
		5'b10011 : out = in19;
		5'b10100 : out = in20;
		5'b10101 : out = in21;
		5'b10111 : out = in22;
		5'b11000 : out = in23;
	endcase
end
endmodule
