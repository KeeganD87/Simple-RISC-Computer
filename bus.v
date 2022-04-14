
module bus(
	output [31:0] busOut,

	input [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15,
				  busInHI, busInLO, busInZHI, busInZLO, busInPC, busInMDR, busInInPort, busInC,
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	input HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout
);
	reg [31:0] internalOut;
	assign busOut = internalOut;
	
	always @(R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, 
				R13out, R14out, R15out, HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout, 
				busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, 
				busInR11, busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZHI, busInZLO, busInPC, busInMDR, 
				busInInPort, busInC)
	begin
				if(R0out == 1) internalOut = busInR0; 
				else if(R1out == 1) internalOut = busInR1;
				else if(R2out == 1) internalOut = busInR2;
				else if(R3out == 1) internalOut = busInR3;
				else if(R4out == 1) internalOut = busInR4;
				else if(R5out == 1) internalOut = busInR5;
				else if(R6out == 1) internalOut = busInR6;
				else if(R7out == 1) internalOut = busInR7;
				else if(R8out == 1) internalOut = busInR8;
				else if(R9out == 1) internalOut = busInR9;
				else if(R10out == 1) internalOut = busInR10;
				else if(R11out == 1) internalOut = busInR11;
				else if(R12out == 1) internalOut = busInR12;
				else if(R13out == 1) internalOut = busInR13;
				else if(R14out == 1) internalOut = busInR14;
				else if(R15out == 1) internalOut = busInR15;
				else if(HIout == 1) internalOut = busInHI;
				else if(LOout == 1) internalOut = busInLO;
				else if(ZHighout == 1) internalOut = busInZHI;
				else if(ZLowout == 1) internalOut = busInZLO;
				else if(PCout == 1) internalOut = busInPC;
				else if(MDRout == 1) internalOut = busInMDR;
				else if(InPortout == 1) internalOut = busInInPort;
				else if(Cout == 1) internalOut = busInC;
				else internalOut = 32'bx;
			end
endmodule
		
