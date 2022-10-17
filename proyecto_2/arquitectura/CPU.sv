
module CPU #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4, 
				parameter INSTRUCTIONWIDTH = 24)
				(input logic clock, reset, startIO, 
				output logic outFlag, endFlag,
				output logic [WIDTH-1:0] out);
	
	arqui #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) 
			arqui(clock, reset, startIO, outFlag, out);
	
	always_ff @(posedge clock) begin
		if(out === 36'bx) endFlag <= 1;
		else endFlag <= 0;
	end
	
endmodule 