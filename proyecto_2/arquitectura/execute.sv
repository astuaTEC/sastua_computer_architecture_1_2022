module execute#(parameter WIDTH = 8) 
					(input logic [WIDTH-1:0] rd1E, rd2E, ExtImmE, ResultW, ALUOutM, 
					input logic [1:0] ForwardAE, ForwardBE,
					input logic [2:0] ALUControlE,
					input ALUSrcE,
					output[WIDTH-1:0] WriteDataE, ALUResultE,
					output [3:0] ALUFlagsE
					);
					
logic [WIDTH-1:0] SrcAE;

logic [WIDTH-1:0] SrcBE;

Mux_3_to_1 #(WIDTH) byp1mux(rd1E, ResultW, ALUOutM, ForwardAE, SrcAE); 
Mux_3_to_1 #(WIDTH) byp2mux(rd2E, ResultW, ALUOutM, ForwardBE, WriteDataE); 
Mux_2_to_1 #(WIDTH) srcbmux(WriteDataE, ExtImmE, ALUSrcE, SrcBE); 

ALU #(WIDTH) alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ALUFlagsE);

endmodule
