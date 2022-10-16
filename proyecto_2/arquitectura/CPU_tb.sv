
`timescale 1 ns / 1 ns
module CPU_tb();

	parameter WIDTH = 36;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	logic clock, reset, startIO; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	

	/*always begin
		clock = 1; # 10; clock = 0; # 10;
	end*/
	
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH)
			cpu (clock, reset, startIO, outFlag, out);
				
	initial begin
	
		reset = 1;
		clock = 0;
		startIO = 0;
		
		#10;
		clock = 1;
		
		#10;
		clock = 0;
		reset = 0;
		startIO = 1; // se enciende el switch
		#10
		
		
		repeat(1000) begin
			clock = 1;
			#10
			if(outFlag) begin 
					$display ("Out:  %d",out);
			end
			clock = 0;
			#10;
		end
		
		$stop;

		
	end
		
	

endmodule 