module decode_tb#(parameter WIDTH = 	32, parameter REGNUM = 8, 
					parameter ADDRESSWIDTH = 3, parameter OPCODEWIDTH = 4,
					parameter INSTRUCTIONWIDTH = 24)();

	logic [ADDRESSWIDTH-1:0] writeA;
	logic [WIDTH-1:0] dataToSave, PC;
	logic [INSTRUCTIONWIDTH-1:0] instruction;
	logic clk, reset, writeE;
	logic [WIDTH-1:0] rd1D, rd2D, inmediate;
	logic [ADDRESSWIDTH-1:0] regDestinationAddress, r1A, r2A;
	logic [OPCODEWIDTH-1:0] opcode;
	
	
	decode testDecode (writeA, dataToSave, PC, instruction,
	 clk, reset, writeE, rd1D, rd2D, inmediate, 
	 regDestinationAddress, r1A, r2A,
	 opcode
	 );
	 
	 always begin
		clk = 0; #5; clk=~clk; #5;
	end
	
	initial begin	
		#5;
		
		PC = 16'd0; // 1 - 1 = 0
		
		// Ejemplo 1: SUM r0, r1, r2
		instruction = 24'b010100000001001000000000; writeE = 0;
		#20;
		
		
		// Execution -> R15 - R15 (1 - 1 = 0)
		
		dataToSave = 16'd1;
		#10;
		
		// Memory
		writeA = 0;
		#10;
		writeE = 1;
		#10;
		instruction = 24'b001100000000000000000000;
		#10

		// Ejemplo 2: MOD r5, r6, r7
		writeE = 0;
		instruction = 24'b011001010110011100000000; writeE = 0;
		#10;
		
	end
endmodule