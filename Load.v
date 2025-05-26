module Load(AC , Memory);
	output [7 : 0] AC ;
	input [7 : 0] Memory;
	
	assign AC = Memory;
endmodule


module LoadTB;
	wire [7 : 0] AC ;
	reg [7 : 0] Memory;

	Load sample(AC , Memory);

	initial
		begin
			Memory = 8'b 10001010;
			#100
			Memory = 8'b 00011010;
			#100
			Memory = 8'b 10110101;
		end
endmodule
