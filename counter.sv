module counter
	#(parameter int m = 50000000, 
	  parameter int b = $clog2(m)
	  )
	 (
	  input logic clock,
	  input logic reset,
	  input logic inc,
	  input logic dec,
	  output logic [b-1:0] count
	  );
	  
	  logic [b-1:0] followingState;
	  
	  always_comb begin
		unique case(1'b1)
			(inc && !dec): followingState = (count==m-1) ? 0 : count+1'b1;
			(dec && !inc): followingState = (count==0) ? m-1 : count-1'b1;
			default: followingState = count;
		endcase
	  end
	  
	  dflip #(b) flopper(.d(followingState), .clock(clock), .reset(reset), .en(1'b1), .q(count));
	  
endmodule
