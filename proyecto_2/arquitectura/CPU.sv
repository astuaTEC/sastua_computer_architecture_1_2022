
module CPU #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4, 
				parameter INSTRUCTIONWIDTH = 24)
				(input logic clock, reset, startIO, 
				output logic outFlag, endFlag, clk_1Hz,
				output logic [7:0] out);
	//logic clk_1Hz;
	logic [WIDTH-1:0] outaux;
	logic flag = 0;
	
	divisorFrecuencia	divisorFrecuencia(clock, clk_1Hz); //la señal de 50Mhz se pasa a 1Hz

	arqui #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) 
			arqui(clk_1Hz, reset, startIO, outFlag, outaux);
			
	assign out = outaux[7:0];
	
	initial begin 
		
		outFlag = 0;
		
	end
	
	always_ff @(posedge clk_1Hz) begin
		if(outaux === 500) begin
			flag <= 1;
			endFlag <= 1;
		end
		else if(flag === 0) endFlag <= 0;
	end
	
endmodule 