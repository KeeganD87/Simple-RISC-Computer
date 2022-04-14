module sel_enc(
	input [31:0] instr,
	input Rin, Rout, BAout, Gra, Grb, Grc,
	output [15:0] ctrl_in, ctrl_out
	);
	
	wire [3:0] ra, rb, rc, decoder_in;
	assign ra = instr[26:23];
	assign rb = instr[22:19];
	assign rc = instr[18:15];
	
	assign decoder_in = Gra ? ra : 
							  Grb ? rb : 
							  Grc ? rc :
							  4'b0000;
	
	wire [15:0] decoder_out;
	decoder dec(decoder_out, decoder_in);
	
	wire Rout_en;
	assign Rout_en = BAout | Rout;
	assign ctrl_in = Rin ? decoder_out : 16'b0;
	assign ctrl_out = Rout_en ? decoder_out : 16'b0;
	
endmodule
