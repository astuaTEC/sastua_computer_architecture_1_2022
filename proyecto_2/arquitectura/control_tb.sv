module control_tb
				#(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)();

	logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlag;
	logic [2:0] aluControlED;
	logic [OPCODEWIDTH-1:0] opcodeD;

	logic writeEnableDDExpected, writeDataEnableMDExpected, resultSelectorWBDExpected, data2SelectorEDExpected, outFlagExpected;
	logic [2:0] aluControlEDExpected;
	
	control controlTest(
					writeEnableDD, 
					writeDataEnableMD, 
					resultSelectorWBD,
					data2SelectorED,
					outFlag,
					aluControlED,
					opcodeD
					);
								
								
	initial begin	
		
		//Test bench para unidad de control
		
		// No instrucción
		opcodeD = 4'b0000;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b000;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito estado base 0000");
		else $display("Falló estado base 0000");

		// Echar (guardar) en memoria
		opcodeD = 4'b0001;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b010;
		writeDataEnableMDExpected = 1;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito echar en memoria 0001");
		else $display("Falló echar en memoria 0001");
		
		// Jalar (mover) inmediato
		opcodeD = 4'b0010;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b011;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito jalar inmediato 0010");
		else $display("Falló jalar inmediato 0010");
		
		// Jalar (Mover)
		opcodeD = 4'b0011;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b010;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito jalar 0011");
		else $display("Falló jalar 0011");
		
		// Función Especializada Out
		opcodeD = 4'b0100;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b010;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 1;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito out 0100");
		else $display("Falló out 0100");
		
		// Suma
		opcodeD = 4'b0101;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b000;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito suma 0101");
		else $display("Falló suma 0101");
		
		// Módulo (residuo)
		opcodeD = 4'b0110;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b001;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito módulo 0110");
		else $display("Falló módulo 0110");
		
		// Apear de memoria (Carga/Load)
		opcodeD = 4'b0111;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b010;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 1;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito apear en memoria 0111");
		else $display("Falló apear en memoria 0111");
		
		// AND lógico
		opcodeD = 4'b1000;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b101;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito and 1000");
		else $display("Falló and 1000");
		
		// Shift Right
		opcodeD = 4'b1001;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b111;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito shift right 1001");
		else $display("Falló shift right 1001");
		
		// Comparar
		opcodeD = 4'b1010;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b001;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito comparar 1010");
		else $display("Falló comparar 1010");
		
		// Brinco condicional (igualdad)
		opcodeD = 4'b1011;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b011;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito brinco condicional en igualdad 1011");
		else $display("Falló brinco condicional en igualdad 1011");
		
		// Brinco incondicional (para registro)
		opcodeD = 4'b1100;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b010;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito brinco incondicional 1100");
		else $display("Falló brinco incondicional 1100");
		
		// Brinco condicional en desigualdad (mayor que)
		opcodeD = 4'b1101;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b011;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito brinco condicional en desigualdad 1101");
		else $display("Falló brinco condicional en desigualdad 1101");
		
		// Multiplicacion
		opcodeD = 4'b1110;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito multiplicación 1110");
		else $display("Falló multiplicación 1110");
		
		// Brinco incondicional
		opcodeD = 4'b1111;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b011;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED === data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display("Éxito brinco incondicional 1111");
		else $display("Falló brinco incondicional 1111");
		
	end
																
endmodule