
`timescale 1 ns / 1 ns
module memory_tb();


	parameter WIDTH = 36;
	parameter INSTRUCTIONWIDTH = 24;
	logic clk, we, startIO;
	logic [WIDTH-1:0] a1, a2, wd;
	logic [INSTRUCTIONWIDTH-1:0] rd1;
	logic [WIDTH-1:0] rd2;
	
	/*
	
	Memory with segmentation
	Inputs:
	- clk: the clock
	- we: enables writing on data segment
	- a1: instruction segment address
	- a2: data segment address
	- wd: data to write on data segment
	Outputs:
	- rd1: instruction requested
	- rd2: data requested
	*/
	
	
	
	memory #(WIDTH, INSTRUCTIONWIDTH) mem (clk, we, startIO, a1, a2, wd, rd1, rd2);
		
	initial 
	begin
	
		clk = 0;
		startIO = 1;
		we = 1;
	   a1 = 0;
		a2 = 17;
		wd = 8'h25; //se escribe un 25h en la pos 17
	   		
		#10;
	   clk = 1;
		
		
		#10;
		clk = 0;
		
		we = 0; // lectura
		a1 = a1+1; // PC + 1
		a2 = 106; // verificamos la pos 106 en memoria (mem3)
	   
		#10;
	   clk = 1;
		
		#10;
		clk = 0;
		a1 = a1+1; //PC + 1
		
	   
		#10;
	   clk = 1;
		
		#10;
		clk = 0;
		
		a1 = a1+1; // PC + 1
		wd = 8'h12;
		we = 1; // escribir lo que tenga wd en a2
		
		#10;
	   clk = 1;
		
		#10;
		clk = 0;
		
		we = 0; // leer
		a2 = 17; // ver lo que tiene la pos 17
		a1 = a1+1; // PC + 1
	   
		#10;
	   clk = 1;
	end
	
endmodule 