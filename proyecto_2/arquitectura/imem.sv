
module imem(input logic [31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[399:0];
	
	initial
		$readmemh("memfile2.dat", RAM);
		
	assign rd = RAM[a[22:2]]; // word aligned
	
endmodule 