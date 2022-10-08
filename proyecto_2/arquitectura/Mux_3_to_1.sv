/*
Mux3: Book Digital Design and Computer Architecture. ARM Edition by Sarah Harris, David Harris
*/

module Mux_3_to_1 #(parameter WIDTH = 8)
						(input logic [WIDTH-1:0] d0, d1, d2,
						input logic [1:0] s,
						output logic [WIDTH-1:0] y);
						
	assign y = s[1] ? d2 : (s[0] ? d1 : d0);
	
endmodule 