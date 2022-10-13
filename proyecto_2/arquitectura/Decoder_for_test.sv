

module Decoder_for_test #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
				(input logic clock, reset, PCSelectorFD, obtainPCAsR1DD, writeEnableDD, writeDataEnableMD, writeEnableDWB,data2SelectorED,
				input logic [ADDRESSWIDTH-1:0] writeAddressD,
				input logic [2:0] aluControlED,
				input logic [INSTRUCTIONWIDTH-1:0] InstructionD,
				input logic [WIDTH-1:0] PCPlus1F,
				input logic [WIDTH-1:0] dataToSaveD,
				output logic [OPCODEWIDTH-1:0] opcodeD, opcodeE,
				output logic [ADDRESSWIDTH-1:0] regDestinationAddressD, reg1AddressD, reg2AddressD,
				output logic [WIDTH-1:0] inmmediateE,
				output logic [WIDTH-1:0] reg1ContentD, reg2ContentD,
				output logic [2:0] aluControlEE,
				output logic writeEnableDE, writeDataEnableME, resultSelectorWBE, data2SelectorEE);
	
	
	
	logic NE1, ZE1, VE1, CE1, NE2, ZE2, VE2, CE2, outFlagIOD, outFlagIOE;
	// *************************************************
	
	// Decoder
		
	decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) Decode
	( writeAddressD,
	  dataToSaveD, PCPlus1F,
	  InstructionD,
	  clock, reset, writeEnableDWB,
	  reg1ContentD, reg2ContentD, inmmediateD,
	  regDestinationAddressD, reg1AddressD, reg2AddressD,
	  opcodeD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 flopenrc  #(3*ADDRESSWIDTH+3*WIDTH+4+3+4+4+1) DecodeFlipFlop(clock, flushE, 1'b1,
	 {reg1ContentD, reg2ContentD, regDestinationAddressD, inmmediateD, reg1AddressD, reg2AddressD,
			writeEnableDD,
			writeDataEnableMD,
			resultSelectorWBD,
			data2SelectorED,
	      aluControlED,
			opcodeD,
			NE1, ZE1, VE1, CE1, outFlagIOD}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE, inmmediateE, reg1AddressE, reg2AddressE,
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE,
	      aluControlEE,
			opcodeE,
			NE2, ZE2, VE2, CE2, outFlagIOE});
			

endmodule 