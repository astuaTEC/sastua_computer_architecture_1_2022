
module control #(parameter OPCODEWIDTH = 4)
					(output logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlag,
					output logic [2:0] aluControlED,
					input logic [OPCODEWIDTH-1:0] opcodeD);
					
	always@(opcodeD) begin 
		
		case(opcodeD)
			4'b0000: begin // este no esta en la green sheet. Se pone todo en cero
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b000; // Suma
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0001: begin // Echar en memoria - Guardar
				writeEnableDD = 0;
			   data2SelectorED =  1'bx;;
				aluControlED = 3'b010; // Pasa A
				writeDataEnableMD = 1;
				resultSelectorWBD =  0;;
				outFlag = 0;
			end
			4'b0010: begin // Jalar inmediato - MOV - JAL
				writeEnableDD = 1;
				data2SelectorED = 1;
				aluControlED = 3'b011; // Pasa B
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0011: begin // Jalar - MOV
				writeEnableDD = 1;
				data2SelectorED =  1'bx;;
				aluControlED = 3'b010; // Pasa A
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0100: begin // Funcion especializada Out
				writeEnableDD = 0;
				data2SelectorED =  1'bx;;
				aluControlED = 3'b010; // Pasa A
				writeDataEnableMD = 0;
				resultSelectorWBD =  0;
				outFlag = 1;
			end
			4'b0101: begin // Suma
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000; // Suma
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0110: begin // resta - En nuesto caso MOD
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b001; //resta
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0111: begin // Apear de memoria - Carga
				writeEnableDD = 1;
				data2SelectorED = 1'bx;
				aluControlED = 3'b010; // Pasa A
				writeDataEnableMD = 0;
				resultSelectorWBD = 1;
				outFlag = 0;
			end
			4'b1000: begin // Or - En nuestro caso AND
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b101; // AND
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1001: begin // SHif left - En nuestro caso Shift rigth
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b111; // shift left
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1010: begin  // Comparar
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b001; // resta
				writeDataEnableMD = 0;
				resultSelectorWBD =  0;
				outFlag = 0;
			end
			4'b1011: begin // Salto inmediato en igualdad
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b011; // Pasa B
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1100: begin // Salto registro
				writeEnableDD = 0;
				data2SelectorED = 1'bx;
				aluControlED = 3'b010; // Pasa A
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;		
			end
			4'b1101: begin // Salto inmediato menor que - en nuestro caso mayor que
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b011; // Pasa B
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
//			4'b1110: begin 
//				writeEnableDD = 0;
//				data2SelectorED = 1;
//				aluControlED = 3'b111;
//				writeDataEnableMD = 0;
//				resultSelectorWBD = 0;
//				outFlag = 0;					
//			end
			4'b1111: begin // Salto inmediato
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b011; // Pasa B
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
			default begin // poner todo en cero por dafault
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b000; //Suma
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
		endcase
		
	
	end
	
	

endmodule 