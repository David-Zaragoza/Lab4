module alu
	(
	 input logic [5:0] A,
	 input logic [5:0] B,
	 input logic [2:0] RA,
	 input logic [2:0] RB,
	 input logic [2:0] RD,
	 input logic [2:0] OPCODE,
	 output logic [5:0] aluOut
	 );
	 
	 logic [5:0] muxOutput;
	 assign muxOutput = (A >= B) ? {3'b0, RD} : (6'b000001);
	 
	 always_comb begin
		case(OPCODE)
			3'b000: aluOut = 6'b000000;
			3'b001: aluOut = {RA, RB};
			3'b010: aluOut = A + B;
			3'b011: aluOut = A + RB;
			3'b100: aluOut = A*B;
			3'b101: aluOut = muxOutput;
			3'b110: aluOut = {RA, RB};
			3'b111: aluOut = 6'b000001;
			default: aluOut = 6'b000001;
		endcase
	 end
	 
endmodule
