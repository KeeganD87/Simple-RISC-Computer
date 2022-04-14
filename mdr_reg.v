module mdr_reg(out, MdataIn, bus, en, rd, clr, clk);


output reg [31:0] out;
input [31:0] MdataIn, bus;
input en, rd, clr, clk;

wire [31:0] in;
always @(posedge clk or posedge clr)
		if(clr)
			out = 0; 
		else if(rd)
			out = bus;
		else
			out = MdataIn;
endmodule
