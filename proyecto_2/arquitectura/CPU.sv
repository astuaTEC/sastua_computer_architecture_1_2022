
module CPU #(parameter WIDTH = 36, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4, 
				parameter INSTRUCTIONWIDTH = 24)
				(input logic clock, reset, startIO, 
				output logic outFlag, endFlag, clk_1Hz, testFlag,
				output logic [7:0] out);
	//logic clk_1Hz;
	logic [WIDTH-1:0] outaux;
	logic flag = 0;
	logic  [7:0] chars [99:0];
	logic  [7:0] chars_indi;
	reg[4:0] con = 0;
	reg[8:0] pos = 0;
	
	
	divisorFrecuencia	divisorFrecuencia(clock, clk_1Hz); //la señal de 50Mhz se pasa a 1Hz

	arqui #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) 
			arqui(clock, reset, startIO, outFlag, outaux,chars);
			
	
	assign out = chars_indi;
	
	initial begin 
		
		outFlag = 0;
		
	end
	
	always_ff @(posedge clock) begin
		if(outaux === 500) begin
			flag <= 1;
			endFlag <= 1;
		end
		else if(flag === 0) endFlag <= 0;
	end
	
	always_ff @(posedge clock) begin
		if(endFlag == 1) begin
			if(con == 5) begin
				if(pos == 101) begin
					//NADA
				end
				else begin
					chars_indi <=chars[pos];
					pos=pos+1;
					testFlag=0;
					con=con +1;
				end
			end
			else if(con == 10) begin
				testFlag=1;
				con=0;
			end
			else con=con +1;
		end
		
	end
	
	
	
endmodule 