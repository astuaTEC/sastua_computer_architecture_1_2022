
/*
    0000 add A + B       Addition
    0001 sub A - B       Subtraction
	 0010 A 					 Out = a
	 0011 B 					 Out = b
    0100 mod A % B       Module
    0101 and  A &  B     Logical and
    0110 mul A * B     	 multiplication
    0111  Shift right A >> B Logical shift right
*/
// Referencia: https://github.com/liaukovv/single_cycle/blob/master/datapath/alu.v

module ALU #(parameter N = 16)(
    input logic [N-1:0] a, b,
    input logic [2:0] ctrl,
    output logic [N-1:0] res,
    output logic [3:0] flags // 3=negative, 2=zero, 1=carry, 0=overflow
);

	wire [N-1:0] ares, lres;
	wire [N-1:0] sumres, sb;
	wire cout;

	assign res = ctrl[2] ? lres : ares;

	//overflow
	assign o1 = ~(ctrl[0] ^ (a[N-1] ^ b[N-1]));
	assign o2 = (ares[N-1] ^ a[N-1]);
	assign o3 = ~ctrl[2];
	assign flags[0] = o1 & o2 & o3;

	//carry
	assign flags[1] = (~ctrl[2]) & cout;

	//zero
	assign flags[2] = ~(|res);

	//negative
	assign flags[3] = res[N-1];

	//arithmetic result
	assign sb = ctrl[0] ? ~b : b;
	assign {cout, sumres} = a + sb + ctrl[0];
	
	assign ares = (ctrl[1:0] == 2'b10) ? a	:
					  (ctrl[1:0] == 2'b11) ? b	:
					  sumres;

	//logical result
	assign lres = (ctrl[2:0] == 3'b100) ? a % b    :
					  (ctrl[2:0] == 3'b101) ? a & b    :
					  (ctrl[2:0] == 3'b110) ? a * b    :
					  (ctrl[2:0] == 3'b111) ? a >> 1   :
															0    ;

endmodule 