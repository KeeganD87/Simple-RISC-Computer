module con_ff(
	input [31:0] instr,
	input signed [31:0] bus,
	input CONin, clk,
	output out
);
	wire [3:0] con_en;
	decoder dec(con_en, instr[20:19]);
	
	wire eval, eq, neq, gte, lt;
	
	assign eq  = ((bus == 0) & con_en[0]) ? 1'b1 : 1'b0;
	assign neq = ((bus != 0) & con_en[1]) ? 1'b1 : 1'b0;
	assign gte = ((bus >= 0) & con_en[2]) ? 1'b1 : 1'b0;
	assign lt  = ((bus <= 0) & con_en[3]) ? 1'b1 : 1'b0;
	
	assign eval = eq | neq | gte | lt;
	
	gen_reg ff(out, eval, CONin, 1'b0, clk);
	
endmodule
