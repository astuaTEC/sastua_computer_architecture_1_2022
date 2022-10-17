module fetch #(parameter WIDTH = 8)(input logic [WIDTH-1:0] NewPC,
	 input logic PCSelector, clock, reset, enable,
	 output logic [WIDTH-1:0] PC, PCPlus1
	 );
	 
	logic [WIDTH-1:0] TempPC;

	flopenrc #(WIDTH) pcreg(clock, reset, enable, TempPC ,PC);
	Mux_2_to_1 #(WIDTH) pcff(PCSelector, PCPlus1, NewPC, TempPC);
	adder #(WIDTH) pcadd(PC, 36'b1, PCPlus1); //Revisar el valor 36'b1


endmodule