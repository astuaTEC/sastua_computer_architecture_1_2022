
/*
	todo: definir bien los tamanos de las memorias
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

module loadedMem #(parameter WIDTH = 36)
  (input logic clk,
	input logic [3:0] we,
	input logic [WIDTH*3-1:0] a, wd,
	output logic [WIDTH*3-1:0] rd, 
	output logic  [7:0] chars [99:0]);
	
	// tamaños
	logic [24-1:0] RAM1 [1024-1:0]; // instrucciones
	logic [16-1:0] RAM2 [102-1:0]; // 16 bits
	logic [8-1:0] RAM3 [100-1:0]; // 8 bits

	initial begin
		$readmemb("mem1.txt", RAM1); //instrucciones
		$readmemb("mem2.txt", RAM2); //datos precargados
		$readmemb("mem3.txt", RAM3);//escribir el resultado del algoritmo
	end
	
	assign rd[WIDTH-1:0] = RAM1[a[WIDTH-1:0]]; //instrucciones
	assign rd[WIDTH*2-1:WIDTH] = RAM2[a[WIDTH*2-1:WIDTH]]; //
	assign rd[WIDTH*3-1:WIDTH*2] = RAM3[a[WIDTH*3-1:WIDTH*2]]; 
	//assign rd[WIDTH*4-1:WIDTH*3] = RAM4[a[WIDTH*4-1:WIDTH*3]]; 

	always_ff @(posedge clk) begin
		if (we[0]) RAM1[a[WIDTH-1:0]] <= wd[WIDTH-1:0];
		if (we[1]) RAM2[a[WIDTH*2-1:WIDTH]] <= wd[WIDTH*2-1:WIDTH];
		if (we[2]) begin
			RAM3[a[WIDTH*3-1:WIDTH*2]] <= wd[WIDTH*3-1:WIDTH*2];
			$writememb("mem3.txt", RAM3);
		end
	end
	assign chars = RAM3[99:0];
endmodule