module pc_reg #(parameter VAL = 0
)(
	output reg [31:0] Q,
	input [31:0] D,
	input wr, inc, clr, clk
);
	initial Q = VAL;
	
	always @(posedge clk) 
	begin
		if(clr)
			Q = 0;
		else if(wr)
			Q = D;
	end
endmodule
