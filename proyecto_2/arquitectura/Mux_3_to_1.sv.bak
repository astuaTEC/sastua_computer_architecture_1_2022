/*
	Multiplexor with three inputs
	Inputs:
	- d0 
	- d1
	- s : selects the output from the input
	Outputs:
	- y: value selectes
*/

module Mux_3_to_1 #(parameter N = 8)
	(input logic [N-1:0] d0, d1, d2,
	input logic [1:0] s,
	output logic [N-1:0] y);
	
	
	always_comb begin
		case (s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = 0;
		endcase
	end
	
endmodule