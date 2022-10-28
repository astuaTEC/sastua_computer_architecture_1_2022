
`timescale 1 ns / 1 ns
module CPU_tb();

	parameter WIDTH = 36;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	logic clock, reset, startIO, clk; 
	logic outFlag, endFlag, testFlag;
	logic [7:0] out;
	always begin
		clock = 1; # 10; clock = 0; # 10;
	end
	
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH)
			cpu (clock, reset, startIO, outFlag, endFlag, clk, testFlag, out);
				
	initial begin
		reset = 1;
		startIO = 0;
		#10;
		reset = 0;
		startIO = 1; // se enciende el switch
		#10;
		
	end
		
	

endmodule 