module decode #(parameter WIDTH = 	32, parameter REGNUM = 8, 
					parameter ADDRESSWIDTH = 3, parameter OPCODEWIDTH = 4,
					parameter INSTRUCTIONWIDTH = 24)
	(input logic [ADDRESSWIDTH-1:0] writeA,
	 input logic [WIDTH-1:0] dataToSave, PC,
	 input logic [INSTRUCTIONWIDTH-1:0] instruction,
	 input logic clock, reset, writeE,
	 output logic [WIDTH-1:0] rd1D, rd2D, inmediate,
	 output logic [ADDRESSWIDTH-1:0] regDestinationAddress, r1A, r2A,
	 output logic [OPCODEWIDTH-1:0] opcode
	 );
		
	
	assign r1A = instruction[15:12];
	assign r2A = instruction[11:8];
	assign regDestinationAddress = instruction[19:16];
	assign inmediate[15:0] = instruction[15:0];
	assign inmediate[WIDTH-1:16] = 0;
	assign opcode = instruction[23:20];
		
	
	regfile #(WIDTH, REGNUM, ADDRESSWIDTH) registerFile (!clock, writeE, 
				r1A,r2A, writeA, dataToSave, PC, rd1D, rd2D );

endmodule