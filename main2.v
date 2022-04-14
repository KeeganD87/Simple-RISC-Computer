module main2(
	// I/O instantiation
	input HIin, LOin, PCin, IRin, Yin, InPortout, Zlowin, Zhighin,
	input HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout,
	
	input [3:0] ALUselect,
		
	input Gra, Grb, Grc, Rin, Rout, BAout, conffout, conffin, wren, OPin, IPin
);	
	wire [31:0] bus, Cdata;
	wire clr;
	wire [31:0] instr;
	wire [31:0] YData;
	wire [31:0] ZLowData, ZHighData;
	wire carry;
	wire [15:0] ctrl_in, ctrl_out;
	wire [63:0] ZReg;


	
	// General Registers
	wire [31:0]	busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, 
					busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInPC, busInMAR,
					busInMDR, busInHI, busInLO, busInZHI, busInZLO, busInInPort;
					
	zero_reg r0(busInR0, bus, ctrl_in[0], BAout, clr, clk);
	gen_reg #(85) r1(busInR1, bus, ctrl_in[1], clr, clk);
	gen_reg #(-1) r2(busInR2, bus, ctrl_in[2], clr, clk);
	gen_reg #(0) r3(busInR3, bus, ctrl_in[3], clr, clk);
	gen_reg #(0) r4(busInR4, bus, ctrl_in[4], clr, clk);
	gen_reg #(0) r5(busInR5, bus, ctrl_in[5], clr, clk);
	gen_reg #(0) r6(busInR6, bus, ctrl_in[6], clr, clk);
	gen_reg #(0) r7(busInR7, bus, ctrl_in[7], clr, clk);
	gen_reg #(0) r8(busInR8, bus, ctrl_in[8], clr, clk);
	gen_reg #(0) r9(busInR9, bus, ctrl_in[9], clr, clk);
	gen_reg #(0) r10(busInR10, bus, ctrl_in[10], clr, clk);
	gen_reg #(0) r11(busInR11, bus, ctrl_in[11], clr, clk);
	gen_reg #(0) r12(busInR12, bus, ctrl_in[12], clr, clk);
	gen_reg #(0) r13(busInR13, bus, ctrl_in[13], clr, clk);
	gen_reg #(0) r14(busInR14, bus, ctrl_in[14], clr, clk);
	gen_reg #(0) r15(busInR15, bus, ctrl_in[15], clr, clk);
	
	assign R0out = ctrl_out[0];
	assign R1out = ctrl_out[1];
	assign R2out = ctrl_out[2];
	assign R3out = ctrl_out[3];
	assign R4out = ctrl_out[4];
	assign R5out = ctrl_out[5];
	assign R6out = ctrl_out[6];
	assign R7out = ctrl_out[7];
	assign R8out = ctrl_out[8];
	assign R9out = ctrl_out[9];
	assign R10out = ctrl_out[10];
	assign R11out = ctrl_out[11];
	assign R12out = ctrl_out[12];
	assign R13out = ctrl_out[13];
	assign R14out = ctrl_out[14];
	assign R15out = ctrl_out[15];
	
	// RAM instantiation
	wire [31:0] data;
	
	//ram ram_inst(.address (busInMAR [8:0]), .clock (clk), .data (busInMDR), .wren (wren), .q (data));
	
	// PC and IR
	gen_reg ir(instr, bus, IRin, clr, clk);
	pc_reg #(0) pc(busInPC, bus, PCin, IncPC, clr, clk);
	
	// MAR and MDR
	gen_reg mar(busInMAR, bus, MARin, clr, clk);
	mdr_reg mdr(busInMDR, data, bus, MDRin, MDRread, clr, clk);
	
	// Special Registers
	gen_reg #(32'b00000000000000000000000001000101) hi(busInHI, bus, HIin, clr, clk);
	gen_reg #(32'b00000000000000000000000001000101) lo(busInLO, bus, LOin, clr, clk);
	gen_reg y(YData, bus, Yin, clr, clk);
	gen_reg Zlow(busInZLO, ZLowData, Zlowin, clr, clk);
	gen_reg Zhigh(busInZHI, ZHighData, Zhighin, clr, clk);

	
	// C Sign Extend
	assign Cdata = (instr[18] == 1) ? {{13{1'b1}},instr[18:0]} : {13'b0, instr[18:0]};

	// I/O ports
	wire [31:0] OPdata;
	reg [31:0] IPdatain;
	
	gen_reg #(32'b00000000000000000000000001000101) IP(busInInPort, IPdatain, IPin, clr, clk);
	gen_reg OP(OPdata, bus, OPin, clr, clk);
	
	// ALU
	alu alu(ALUselect, YData, bus, ZLowData, ZHighData, carry);
	
	// CON_FF
	con_ff con_ff_inst(instr, bus, conffin, clk, conffout);
	
	
	// Select and Encode	
	sel_enc sel_enc_inst (
		instr,
		Rin, Rout, BAout, Gra, Grb, Grc,
		ctrl_in, ctrl_out
	);
	
	// Bus
	bus bus_inst(
	bus,
	
	busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, 
	busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInHI, busInLO,
	busInZHI, busInZLO, busInPC, busInMDR, busInInPort, Cdata,
	
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout
	);
	
endmodule
