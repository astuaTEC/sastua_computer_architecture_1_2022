
`timescale 1 ns / 1 ns
module CPU_tb();

	parameter WIDTH = 36;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	logic clk, reset, startIO; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	

	always begin
		clk = 1; # 10; clk = 0; # 10;
	end
	
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH)
			cpu (clk, reset, startIO, outFlag, out);
			
			
	initial begin
		reset = 1;
		startIO = 0;
		#25
		
		startIO = 1; // se enciende el switch
		reset = 0;

		
	end
		
	

endmodule 