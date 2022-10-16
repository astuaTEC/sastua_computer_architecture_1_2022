

module execute#(parameter WIDTH = 8) 
					(input logic [WIDTH-1:0] data1, data2, data3, forwardM, forwardWB,
					 input logic [2:0] aluControl,
					 input logic data2Selector,
					 input logic [1:0] data1ForwardSelector, data2ForwardSelector,
					 output logic [WIDTH-1:0] data2AfterForward, aluOutput,
					 output logic [3:0] ALUFlagsE
					 );	
					
	logic [WIDTH-1:0] data1AfterForward;
	logic [WIDTH-1:0] data2Final;

	Mux_3_to_1  #(WIDTH) data1ForwardMUX(data1, forwardWB, forwardM, data1ForwardSelector, data1AfterForward);	
									
	Mux_3_to_1  #(WIDTH) data2ForwardMUX(data2, forwardWB, forwardM, data2ForwardSelector, data2AfterForward);	

	Mux_2_to_1  #(WIDTH) data2MUX(data2Selector, data2AfterForward, data3, data2Final); 

	ALU #(WIDTH) ALU( data1AfterForward, data2Final, aluControl, aluOutput, ALUFlagsE);

endmodule 