module registerFile
	(
	 input logic [5:0] dataInput,
	 input logic [2:0] RA,
	 input logic [2:0] RB,
	 input logic [2:0] RD,
	 input logic [2:0] regDisplay,
	 input logic clock,
	 input logic reset,
	 input logic writeEnD,
	 output logic [5:0] A,
	 output logic [5:0] B,
	 output logic [5:0] D,
	 output logic [5:0] contents
	 );
	 
	 logic [5:0] zeroOut;
	 logic [5:0] oneOut;
	 logic [5:0] twoOut;
	 logic [5:0] threeOut;
	 logic [5:0] fourOut;
	 logic [5:0] fiveOut;
	 logic [5:0] sixOut;
	 logic [5:0] sevenOut;
	 
	 dflip #(6) regZero(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b000 && writeEnD), .q(zeroOut));
	 dflip #(6) regOne(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b001 && writeEnD), .q(oneOut));
	 dflip #(6) regTwo(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b010 && writeEnD), .q(twoOut));
	 dflip #(6) regThree(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b011 && writeEnD), .q(threeOut));
	 dflip #(6) regFour(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b100 && writeEnD), .q(fourOut));
	 dflip #(6) regFive(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b101 && writeEnD), .q(fiveOut));
	 dflip #(6) regSix(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b110 && writeEnD), .q(sixOut));
	 dflip #(6) regSeven(.d(dataInput), .clock(clock), .reset(reset), .en(RD==3'b111 && writeEnD), .q(sevenOut));
	 
	 always_comb begin
		unique case(RA)
			3'b000: A = zeroOut;
			3'b000: A = oneOut;
			3'b000: A = twoOut;
			3'b000: A = threeOut;
			3'b000: A = fourOut;
			3'b000: A = fiveOut;
			3'b000: A = sixOut;
			3'b000: A = sevenOut;
			default: A = 6'b000000;
		endcase
	 end
	 
	 always_comb begin
		unique case(RB)
			3'b000: B = zeroOut;
			3'b000: B = oneOut;
			3'b000: B = twoOut;
			3'b000: B = threeOut;
			3'b000: B = fourOut;
			3'b000: B = fiveOut;
			3'b000: B = sixOut;
			3'b000: B = sevenOut;
			default: B = 6'b000000;
		endcase
	 end
	 
	 always_comb begin
		unique case(RD)
			3'b000: D = zeroOut;
			3'b000: D = oneOut;
			3'b000: D = twoOut;
			3'b000: D = threeOut;
			3'b000: D = fourOut;
			3'b000: D = fiveOut;
			3'b000: D = sixOut;
			3'b000: D = sevenOut;
			default: D = 6'b000000;
		endcase
	 end
	 
	 always_comb begin
		unique case(regDisplay)
			3'b000: contents = zeroOut;
			3'b000: contents = oneOut;
			3'b000: contents = twoOut;
			3'b000: contents = threeOut;
			3'b000: contents = fourOut;
			3'b000: contents = fiveOut;
			3'b000: contents = sixOut;
			3'b000: contents = sevenOut;
			default: contents = 6'b000001;
		endcase
	 end
	
endmodule
