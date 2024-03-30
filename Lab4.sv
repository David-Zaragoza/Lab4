module Lab4
	(
	 input logic clock,
	 input logic KEY0,
	 input logic SW0,
	 input logic SW1,
	 input logic SW2,
	 input logic SW3,
	 input logic SW4,
	 input logic SW5,
	 input logic SW6,
	 input logic SW7,
	 output logic [6:0] HEX0,
	 output logic [6:0] HEX1,
	 output logic [6:0] HEX2,
	 output logic [6:0] HEX3,
	 output logic LED0,
	 output logic LED1,
	 output logic LED2,
	 output logic LED3,
	 output logic LED4,
	 output logic LED5,
	 output logic LED6,
	 output logic LED7
	 );
	 
	 logic [11:0] IR;
	 logic [5:0] pcOut, aluOut, dataD, display765, A, B;
	 logic [2:0] OPCODE, RA, RB, RD, interRD, switchInput, dispRegNum;
	 logic jumpEnable, cJumpEnable, interInc, haltEnable, writeEnD;

	 logic [2:0] dispHexZero, dispHexOne, dispHexTwo, dispHexThree; 

	 assign switchInput = {SW4, SW3, SW2};
	 assign dispRegNum = {SW7, SW6, SW5};

	 (* ram_init_file = "Lab4.mif" *) logic [11:0] memory[63:0];
	 assign IR = memory[pcOut];

	 assign OPCODE = IR[11:9];
	 assign RA = IR[8:6];
	 assign RB = IR[5:3];
	 assign RD = IR[2:0];

	 assign haltEnable = (OPCODE == 3'b000) ? (1'b1) : (1'b0);
	 assign jumpEnable = (OPCODE == 3'b101) || (OPCODE == 3'b110);
	 assign cJumpEnable = (OPCODE == 3'b101);
	 assign writeEnD = ( ((OPCODE == 3'b001) || (OPCODE == 3'b010) || (OPCODE == 3'b011) || (OPCODE == 3'b100)) && (interInc && oneSec) );

	 assign interRD = (switchInput == 3'b000) ? (dispRegNum) : (RD);
	 registerFile reggie(.clock(clock), .reset(SW0), .RA(RA), .RB(RB), .RD(RD), .writeEnD(writeEnD), .dataInput(aluOut), .A(A), .B(B), .D(D), .regDisplay(dispRegNum), .contents(display765));
	 
	 alu loggie(.OPCODE(OPCODE), .RA(RA), .RB(RB), .RD(RD), .A(A), .B(B), .aluOut(aluOut));

	 assign interInc = (SW1) ? (!KEY0) : (1'b1);
	 programCounter #(64) county(.clock(clock), .reset(reset), .jump(jumpEnable), .cjump(cJumpEnable), .aluOutput(aluOut), .inc(interInc && oneSec), .dec(1'b0), .count(pcOut), .haltEnable(haltEnable));
	 logic oneSec;
	 logic [25:0] countFifty;
	 counter #(50000000) newbie(.clock(clock), .reset(reset), .inc(1'b1), .dec(1'b0), .count(countFifty));
	 assign oneSec = (countFifty=='0);

	always_comb begin
		unique case (switchInput)
			3'b000 : begin
				dispHexZero = display765[2:0];
				dispHexOne = display765[5:3];
				dispHexTwo = 3'b0;
				dispHexThree = 3'b0;
			end
			3'b001 : begin
				dispHexZero = RD;
				dispHexOne = RB;
				dispHexTwo = RA;
				dispHexThree = OPCODE;
			end
			3'b010 : begin
				dispHexZero = pcOut[2:0];
				dispHexOne = pcOut[5:3];
				dispHexTwo = 3'b0;
				dispHexThree = 3'b0;
			end
			3'b011 : begin
				dispHexZero = OPCODE;
				dispHexOne =  3'b0;	
				dispHexTwo = 3'b0;
				dispHexThree =  3'b0;
			end
		3'b100 : begin
			dispHexZero = aluOut[2:0];
			dispHexOne =  aluOut[5:3];
			dispHexTwo = 3'b0;
			dispHexThree =  3'b0;
			end
		endcase
	end

	assign LED0 = (pcOut[0]);
	assign LED1 = (pcOut[1]);
	assign LED2 = (pcOut[2]);
	assign LED3 = (pcOut[3]);
	assign LED4 = (pcOut[4]);
	assign LED5 = (pcOut[5]);
	assign LED6 = 1'b0;
	assign LED7 = 1'b0;

	hexDisplay #(3) zeroHex(.switch(dispHexZero), .display(HEX0));
	hexDisplay #(3) oneHex(.switch(dispHexOne), .display(HEX1));
	hexDisplay #(3) twoHex(.switch(dispHexTwo), .display(HEX2));
	hexDisplay #(3) threeHex(.switch(dispHexThree), .display(HEX3));

endmodule

