module encoder(
input in0, in1, in2, in3, in4, in5, in6, in7, in8, in9,
		in10, in11, in12, in13, in14, in15, in16, in17, in18, in19,
		in20, in21, in22, in23,
output reg [4:0] out
);

always @ (in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or in8 or in9
			 or in10 or in11 or in12 or in13 or in14 or in15 or in16 or in17 or in18
			 or in19 or in20 or in21 or in22 or in23) begin
	if(in0) begin
		out = 0;
	end if(in1) begin
		out = 1;
	end if(in2) begin
		out = 2;
	end if(in3) begin
		out = 3;
	end if(in4) begin
		out = 4;
	end if(in5) begin
		out = 5;
	end if(in6) begin
		out = 6;
	end if(in7) begin
		out = 7;
	end if(in8) begin
		out = 8;
	end if(in9) begin
		out = 9;
	end if(in10) begin
		out = 10;
	end if(in11) begin
		out = 11;
	end if(in12) begin
		out = 12;
	end if(in13) begin
		out = 13;
	end if(in14) begin
		out = 14;
	end if(in15) begin
		out = 15;
	end if(in16) begin
		out = 16;
	end if(in17) begin
		out = 17;
	end if(in18) begin
		out = 18;
	end if(in19) begin
		out = 19;
	end if(in20) begin
		out = 20;
	end if(in21) begin
		out = 21;
	end if(in22) begin
		out = 22;
	end if(in23) begin
		out = 23;
	end
end

endmodule
