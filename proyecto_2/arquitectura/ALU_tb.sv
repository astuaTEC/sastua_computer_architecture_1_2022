module ALU_tb();

	parameter WIDTH = 4;  
	logic [WIDTH-1:0] A;
	logic [WIDTH-1:0] B;
	logic [2:0] sel;
	logic [WIDTH-1:0] Out;
	logic [WIDTH-1:0] OutExpected;
	logic [3:0] flags, flagsExpected;
	logic C, Z, V, N, CExpected, ZExpected, VExpected, NExpected;
	
	ALU #(.N( WIDTH)) Test(
    .a(A),
    .b(B),
	 .ctrl(sel),
    .res(Out),
	 .flags(flags)
   );
	
	
	
	initial 
	begin
		
		
		$display ("=============SUMADOR=============");
		sel = 3'b000;
		
		
		A = 4'b0001;
		B = 4'b0001;
		OutExpected=4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1110;
		OutExpected = 4'b1101;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=1;
		
		#10
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0000;
		B = 4'b1110;
		OutExpected = 4'b1110;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1111;
		OutExpected = 4'b1110;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=1;
		
		#10
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		
		$display ("=============RESTADOR=============");
		sel = 3'b001;
		
		
		A = 4'b0001;
		B = 4'b0001;
		OutExpected=4'b0000;
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1110;
		OutExpected=4'b0001;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0000;
		B = 4'b1110;
		OutExpected=4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;

		#10;		
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[0])  
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1111;
		OutExpected=4'b0000;
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
	
		$display ("=============MODULO=============");
		
		sel = 3'b100;

		A = 4'b0000 ; 
		B = 4'b1100 ; 
		OutExpected = 4'b0000 ; 
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=1;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])    
			 $display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));


		A = 4'b0011 ; 
		B = 4'b0010 ; 
		OutExpected = 4'b0001 ;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])    
			 $display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

		A = 4'b0100 ; 
		B = 4'b1000 ; 
		OutExpected = 4'b0100 ;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
			 $display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

		A = 4'b0111 ; 
		B = 4'b0110 ; 
		OutExpected = 4'b0001 ;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
			 $display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

		A = 4'b1101 ; 
		B = 4'b1010 ; 
		OutExpected = 4'b0011;
		VExpected = 0; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])   
		$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
	
		
		$display ("=============AND=============");
		
		
		
		A = 4'b0011; 
		B = 4'b0000; 
		OutExpected = 4'b0000;
		sel = 3'b101;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=1;

		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));


		A = 4'b0110; 
		B = 4'b1001; 
		OutExpected = 4'b0000;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=1;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

	
		A = 4'b1100; 
		B = 4'b1110; 
		OutExpected = 4'b1100;
		VExpected = 0 ; 
		NExpected=1; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
				$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

		
		A = 4'b1111; 
		B = 4'b0001; 
		OutExpected = 4'b0001;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
				$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));

		
		
		
		$display ("=============SHIFT-R=============");
		
		A = 4'b0101; 
		OutExpected = 4'b0010;
		sel = 3'b111;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
				$display ($sformatf("exito para A = %b", A));
		else $error($sformatf("fallo para A = %b", A));
	
		A = 4'b1100; 
		OutExpected = 4'b0110;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
				$display ($sformatf("exito para A = %b", A));
		else $error($sformatf("fallo para A = %b", A));
		
		A = 4'b0100; 
		OutExpected = 4'b0010;
		VExpected = 0 ; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
				$display ($sformatf("exito para A = %b", A));
		else $error($sformatf("fallo para A = %b", A));
		
		A = 4'b0110; 
		OutExpected = 4'b0011;
		VExpected = 0; 
		NExpected=0; 
		CExpected=0;
		ZExpected=0;
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3])  
				$display ($sformatf("exito para A = %b", A));
		else $error($sformatf("fallo para A = %b", A));
		
		
		$display ("=============MULTIPLICADOR=============");
		
		sel = 3'b110;
		
		A = 4'b0011;
		B = 4'b0010;
		OutExpected = 4'b0110;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		A = 4'b0010;
		B = 4'b0001;
		OutExpected = 4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0010;
		B = 4'b0010;
		OutExpected = 4'b0100;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0010;
		B = 4'b1000;
		OutExpected = 4'b0000;
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == flags[1] && ZExpected == flags[2] && VExpected == flags[0] && NExpected == flags[3]) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
	end	
	
	
endmodule