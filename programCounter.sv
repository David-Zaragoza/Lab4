module programCounter
	#(parameter int m = 64,
	  parameter int b = $clog2(m)
	  )
	 (
	  input logic [5:0] aluOutput,
	  input logic clock,
	  input logic reset, 
	  input logic inc,
	  input logic dec,
	  input logic jump,
	  input logic cjump,
	  input logic haltEnable,
	  output logic [b-1:0] count
	  );
	 
	 logic [b-1:0] followingState;
	 logic [25:0] countFive;
	 logic onceMore;
	 
	 counter #(50000000) contador(.clock(clock), .reset(reset), .inc(1'b1), .dec(1'b0), .count(countFive));
	 assign onceMore = (countFive=='0);
	 
	 always_comb begin
		unique case(1'b1)
			(onceMore && inc && !dec && !jump && !haltEnable) : followingState = (count==m-1) ? 0 : count+1'b1;
			(onceMore && dec && !inc) : followingState = (count==0) ? m-1 : count-1'b1;
			(inc && jump && !haltEnable && !cjump) : followingState = aluOutput;
			(inc && jump && cjump && !haltEnable) : followingState = count + aluOutput;
			default : followingState = count;
		endcase
	 end
	 
	 dflip #(b) flopper(.d(followingState), .clock(clock), .reset(reset), .en(1'b1), .q(count));

endmodule
