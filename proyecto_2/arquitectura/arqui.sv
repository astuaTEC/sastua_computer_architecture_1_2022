module arqui #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, reset, startIO, 
	output logic outFlagIOE,
	output logic [WIDTH-1:0] out);
	
	logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, takeBranchE, outFlagIOD;
	
	logic [2:0] aluControlED;
	
	logic NE2, ZE2, VE2, CE2;
	
	logic [OPCODEWIDTH-1:0] opcodeD, opcodeE;
	
	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
	
	logic stallF, stallD, flushE, flushD;
	
	logic [WIDTH-1:0] NewPCF, PCF, PCPlus1F;
	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite, MemoryDataOutputM, MemoryDataOutputWB;
	
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
	
	logic writeEnableDE, writeDataEnableME, resultSelectorWBE, data2SelectorEE;
	
	logic [2:0] aluControlEE;
	
	logic [ADDRESSWIDTH-1:0] writeAddressD, regDestinationAddressD, regDestinationAddressE,reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE;
	
	logic [WIDTH-1:0] reg2FinalE;
	
	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
	
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	logic writeEnableDM, writeDataEnableMM, resultSelectorWBM,	outFlagIOM;
	
	logic NE1, ZE1, VE1, CE1;
	
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	
	logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB;
	
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
	
	logic writeEnableDWB, resultSelectorWBWB, data2SelectorEWB;
	
	logic [2:0] aluControlEWB;
	
	logic [WIDTH-1:0] aluOutputWB;
	
	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
	
	logic [WIDTH-1:0] outputWB;
	
	
	// Controller
	controller #(OPCODEWIDTH) Controller(writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED,
										outFlagIOD, takeBranchE, aluControlED, 
										opcodeD, opcodeE, NE2, ZE2, VE2, CE2);
		
		
	//**************************************************
	
	
	// Hazard Unit
	hazardUnit #(WIDTH, ADDRESSWIDTH) HazardUnit(
		writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE,
		regDestinationAddressM, regDestinationAddressWB, regDestinationAddressE,
		reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD,
		data1ForwardSelectorE, data2ForwardSelectorE,
		stallF, stallD, flushE, flushD);
		
	
	//**************************************************
	
	//Memory
	
	memory #(WIDTH, INSTRUCTIONWIDTH) Memory(clock, writeDataEnableMM, startIO, PCF, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
					
	
	//**************************************************
					
	// Fetch
	fetch #(WIDTH) Fetch(NewPCF, takeBranchE, clock, reset, !stallF, PCF, PCPlus1F);
	
	// Fetch - Decoding FlipFlop
	flopenrc  #(INSTRUCTIONWIDTH) FetchFlipFlop(clock, flushD, !stallD, InstructionF, InstructionD);
	
	
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
			
		
	//************************************************
	
	//Execute
	

	execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
	 aluControlEE,
	 data2SelectorEE,
	 data1ForwardSelectorE, data2ForwardSelectorE,
	 reg2FinalE, aluOutputE,
	 {NE1, ZE1, CE1, VE1}
	 );		
	


	 assign NewPCF = aluOutputE;
	 assign out = aluOutputE;

	 // Execution - Memory Flip-Flop
	 
	 
	 flopenrc  #(2*WIDTH+ADDRESSWIDTH+3) ExecuteFlipFlop(clock, reset, 1'b1,
	 {aluOutputE, reg2FinalE, regDestinationAddressE,
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM,
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM});
			
			
	//*****************************************************
	
	//Memory
	
	
	assign MemoryDataToWrite = reg2ContentM;
	assign MemoryDataAddress = aluOutputM;
	assign forwardM = aluOutputM;

	 // Memory - Write Back Flip-Flop

	flopenrc  #(2*WIDTH+ADDRESSWIDTH+2) MemoryFlipFlop(clock, reset, 1'b1,
	 {aluOutputM, MemoryDataOutputM, regDestinationAddressM,
		   writeEnableDM,
			resultSelectorWBM}, 
	 {aluOutputWB, MemoryDataOutputWB, regDestinationAddressWB,
			writeEnableDWB,
			resultSelectorWBWB});
			
	
	//*********************************************************
	
	//Write Back
	 
	 
	Mux_2_to_1  #(WIDTH) writeBack (aluOutputWB, MemoryDataOutputWB, resultSelectorWBWB, outputWB);
	assign writeAddressD = regDestinationAddressWB;
	assign dataToSaveD = outputWB;
	assign forwardWB = outputWB;
	 
	
	initial begin 
		resultSelectorWBE = 0;
	end
	 
	
endmodule 
