`define PC_START 0
`timescale 1ns/10ps

module datapath_tb;
	reg HIin, LOin, PCin, IRin, Yin, InPortout, Zlowin, Zhighin;
	reg HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout;	
	reg [3:0] ALUselect;
	reg Gra, Grb, Grc, Rin, Rout, BAout, conffout, conffin, wren, OPin, IPin;
	parameter 	Default = 4'b0000, T0= 4'b0111, T1= 4'b1000, T2= 4'b1001, T3= 4'b1010, 
					T4= 4'b1011, T5= 4'b1100, T6= 4'b1101, T7= 4'b1110;
	reg 	[3:0] Present_state = Default;
	
	main2 DUT (.HIin(HIin), .LOin(LOin), .PCin(PCin), .IRin(IRin), .Yin(Yin), .InPortout(InPortout), .Zlowin(Zlowin), .Zhighin(Zhighin), .HIout(HIout), .LOout(LOout), .PCout(PCout),
				 .MDRout(MDRout), .MDRin(MDRin), .MARin(MARin), .MDRread(MDRread), .Cout(Cout), .clk(clk), .IncPC(IncPC), .ZLowout(ZLowout),
				 .ZHighout(ZHighout), .ALUselect(ALUselect), .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
				 .conffout(conffout), .conffin(conffin), .wren(wren), .OPin(OPin), .IPin(IPin));
initial
	begin
		clk = 0;
		forever #10 clk = ~ clk;
	end
	
	always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)	// #40 was added in week 5, this will cover later time delays
			Default 		: 		#40		Present_state = T0;
			T0 			: 		#40		Present_state = T1;
			T1 			: 		#40		Present_state = T2;
			T2 			: 		#40		Present_state = T3;
			T3 			: 		#40		Present_state = T4;
			T4 			: 		#40		Present_state = T5;
			T5				:		#40		Present_state = T6;
			T6				:		#40		Present_state = T7;
		endcase
	end
always @(Present_state)
	begin
		case(Present_state)
			Default: begin
				Gra <= 0; Grb <= 0; Grc <= 0; PCout <= 0; ZLowout <= 0; ZHighout <= 0; MDRout<= 0;
				Rin <= 0; Rout <= 0; BAout <= 0; //initialize the signals
				MARin <= 0; Zlowin <= 0; Zhighin <= 0; Cout <= 0; HIin <= 0; LOin <= 0; HIout <= 0; LOout <= 0;
				PCin <=0; MDRin <= 0; IRin  <= 0; Yin <= 0; OPin <= 0; conffin <= 0; conffout <= 0; wren <= 0;
				ALUselect <= 4'b0000; MDRread <= 0; ALUselect <= 4'b0001; InPortout <= 0; IPin <= 0;
		end
		
		T0: begin // LD
				PCout<= 1; MARin <= 1; ALUselect <= 4'b1011; Zlowin <= 1;
		end
		T1: begin
				MARin <= 0; PCout <= 0; ALUselect <= 4'b0000; Zlowin <= 0;
				ZLowout <= 1; PCin <= 1; MDRread <= 1; MDRin <= 1;
		end
		T2: begin
				ZLowout <= 0; PCin <= 0; MDRread <= 0; MDRin <= 0;
				MDRout <= 1; IRin <= 1; 
		end
		T3: begin
				MDRout <= 0; IRin <= 0; 
				Grb <= 1; BAout <= 1;  Yin <= 1; 
		end
		T4: begin
				Grb <= 0; BAout <= 0;  Yin <= 0; 
				Cout <= 1; Zlowin <= 1; 
				#20 ALUselect <= 4'b0001;
		end
		T5: begin
				Cout <= 0; Zlowin <= 0;
				ZLowout <= 1; MARin <= 1; 
		end
		T6: begin
				ZLowout <= 0; MARin <= 0; 
				MDRread <= 1; MDRin <= 1;
		end
		T7: begin
				MDRread <= 0; MDRin <= 0;
				MDRout <= 1; Gra <= 1; Rin <= 1;
		end

//		T0: begin //LDI
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; BAout <= 1; Yin <= 1; 
//		end
//		T4: begin
//				Grb <= 0; BAout <=0; Yin <= 0; 
//				Cout <= 1;  Zlowin <= 1;
//				#20
//				ALUselect <= 4'b0001; 
//		end
//		T5: begin
//				Cout <=0;  Zlowin<=0;
//				ZLowout <= 1; Gra <= 1; Rin <= 1; 
//		end

//		T0: begin // JR
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Gra <= 1; Rout <= 1; PCin <= 1; 
//		end
		
//		T0: begin //JAL
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; Rin <= 1; PCout <= 1;	
//		end
//		T4: begin
//				Grb <= 0; Rin <= 0; PCout <= 0;
//				Gra <= 1; Rout <= 1; PCin <= 1;
//		end	
		
//		T0: begin // OUTPORT
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <= 1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Gra <= 1; Rout <= 1; OPin <= 1;
//		end

//		T0: begin //INPORT
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <= 1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Gra <= 1; Rin <= 1; InPortout <= 1;
//		end

//		T0: begin // MFLO
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Gra <= 1; Rin <= 1; LOout <= 1;	
//		end

//		T0: begin // MFHI
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <= 1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Gra <=1 ; Rin <= 1; HIout <= 1;	
//		end

/*
		T0: begin // BR
				PCout <= 1; MARin <= 1; 
				ALUselect <= 4'b1011; Zlowin <= 1;
		end 
		T1: begin
				MARin <= 0; PCout <= 0;
				ALUselect <= 4'b0000; Zlowin <= 0;
				ZLowout <= 1; PCin <= 1;
				MDRread <= 1; MDRin <=1;
		end
		T2: begin
				ZLowout <= 0; MDRin <= 0;
				PCin <= 0; MDRread <= 0;
				MDRout <= 1; IRin <= 1;
		end
		T3: begin
				MDRout <= 0; IRin <= 0;
				Gra <= 1; Rout <= 1; conffin <= 1;
		end
		T4: begin
				Gra <= 0; Rout<=0; conffin <=0; 
				PCout <= 1; Yin <= 1; 
		end
		T5: begin
				PCout <= 0; Yin <= 0;
				Cout <= 1;  Zlowin <= 1; 
				#20
				ALUselect <= 4'b1111; 
		end
		T6: begin
				Cout <= 0;  Zlowin <= 0; 
				ZLowout <= 1;  //CON -> PCin : If CON FF =1. then PCin <- PC + 1 + C(signextended) 
				if(conffout == 1)
					PCin <= 1;
		end
*/

//		T0: begin // ANDI
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; Rout <= 1; Yin <= 1; 
//		end
//		T4: begin
//				Grb <= 0; Rout <= 0; Yin <= 0; 
//				Cout <= 1; Zlowin <= 1; 
//				#20
//				ALUselect <= 4'b0110; 
//		end
//		T5: begin
//				Cout <= 0; Zlowin <= 0;
//				ZLowout <= 1; Gra <= 1; Rin <= 1; 
//		end

//		T0: begin //ORI
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end	 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; Rout <= 1; Yin <= 1; 
//		end
//		T4: begin
//				Grb <= 0; Rout <= 0; Yin <= 0; 
//				Cout <= 1; Zlowin <= 1; 
//				#20
//				ALUselect <= 4'b0111; 
//		end
//		T5: begin
//				Cout <= 0; Zlowin  <= 0;
//				ZLowout <= 1; Gra <= 1; Rin <= 1; 
//		end

//		T0: begin // ADDI
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <= 1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; Rout <= 1; Yin <= 1;  
//		end
//		T4: begin
//				Grb <= 0; Rout <= 0; Yin <= 0; 
//				Cout <= 1; Zlowin <= 1;		
//				#20
//				ALUselect <= 4'b0001;
//		end
//		T5: begin
//				Cout <= 0; Zlowin <= 0;
//				ZLowout <= 1; Gra <= 1; Rin <= 1; 
//		end

//		T0: begin //ST
//				PCout <= 1; MARin <= 1; 
//				ALUselect <= 4'b1011; Zlowin <= 1;
//		end 
//		T1: begin
//				MARin <= 0; PCout <= 0;
//				ALUselect <= 4'b0000; Zlowin <= 0;
//				ZLowout <= 1; PCin <= 1;
//				MDRread <= 1; MDRin <=1;
//		end
//		T2: begin
//				ZLowout <= 0; MDRin <= 0;
//				PCin <= 0; MDRread <= 0;
//				MDRout <= 1; IRin <= 1;
//		end
//		T3: begin
//				MDRout <= 0; IRin <= 0;
//				Grb <= 1; BAout <= 1; Yin <= 1; 
//		end
//		T4: begin
//				Grb <= 0; BAout <= 0; Yin <= 0; 
//				Cout <= 1; Zlowin <= 1;
//				#20
//				ALUselect <= 4'b0001;  
//		end
//		T5: begin
//				Cout <= 0; Zlowin <= 0;
//				ZLowout <= 1; MARin <= 1; 
//		end
//		T6: begin
//				ZLowout <= 0; MARin <= 0;
//				Rout <= 1; Gra <= 1;
//				wren <= 1; MDRin <= 1; 
//		end
//		T7: begin
//				wren <= 0; MDRin <= 0;
//				Rout <= 0; Gra <= 0;
//				MDRout <= 1; Gra <= 1; Rin <= 1;
//		end
	endcase			
  end
endmodule 
