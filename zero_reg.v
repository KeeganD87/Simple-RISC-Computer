module zero_reg(
	output [31:0] out,
	input [31:0] in,
	input en, BAout, clr, clk
	);

	wire [31:0] Q;
	gen_reg register(Q, in, en, clr, clk);
	assign out = BAout ? 0 : Q;
endmodule
