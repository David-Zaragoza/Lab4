module dflip
	#(parameter int size = 1)
	(
	  input logic [size-1:0] d,
	  input logic clock,
	  input logic reset,
	  input logic en,
	  output logic [size-1:0] q
	 );
	 
	 logic [511:0] rst_val;
	 assign rst_val = 512'd0;
	 
	 always_ff @(posedge clock) begin
		priority case (1'b1)
			(~reset): q[size-1:0] <= rst_val[size-1:0];
			(en):     q[size-1:0] <=       d[size-1:0];
			default:  q[size-1:0] <=       q[size-1:0];
		endcase
	 end
	 
endmodule 