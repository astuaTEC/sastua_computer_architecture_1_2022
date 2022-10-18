
module CPU #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4, 
				parameter INSTRUCTIONWIDTH = 24)
				(input logic clock, reset, startIO, 
				output logic outFlag, endFlag,
				output logic [WIDTH-1:0] out);
	logic clk_1Hz;
	
	divisorFrecuencia	divisorFrecuencia(clock, clk_1Hz); //la señal de 50Mhz se pasa a 1Hz

	arqui #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) 
			arqui(clk_1Hz, reset, startIO, outFlag, out);
	
	always_ff @(posedge clock) begin
		if(outFlag === 1) endFlag <= 1;
		else endFlag <= 0;
	end
	
endmodule 