module hexDisplay
	#(parameter int size = 1)
	 (
	  input logic [size-1:0] switch,
	  output logic [6:0] display
	  );
	  
	  always_comb begin
		case(switch)
			3'h0:    display = 7'b1000000;
			3'h1:    display = 7'b1111001;
			3'h2:    display = 7'b0100100;
			3'h3:    display = 7'b0110000;
			3'h4:    display = 7'b0011001;
			3'h5:    display = 7'b0010010;
			3'h6:    display = 7'b0000010;
			3'h7:    display = 7'b1111000;
			default: display = 7'b1111111;
		endcase
	  end

endmodule
