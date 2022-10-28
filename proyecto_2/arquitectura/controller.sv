

module controller #(parameter OPCODEWIDTH = 4)(output logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlag,takeBranchE,
					output logic [2:0] aluControlED,
					input logic [OPCODEWIDTH-1:0] opcodeD,
					input logic [OPCODEWIDTH-1:0] opcodeE,
					input logic NE2, ZE2, VE2, CE2 );

	
	control #(OPCODEWIDTH) controlunit(
		writeEnableDD,
		writeDataEnableMD,
		resultSelectorWBD,
		data2SelectorED,
		outFlag,
		aluControlED,
		opcodeD
	);
	
	// condunit
	
	conditional #(OPCODEWIDTH) condunit
	(takeBranchE,
	 opcodeE,
	NE2, ZE2, VE2, CE2
	);
	
endmodule 