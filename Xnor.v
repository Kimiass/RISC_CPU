module Xnor(result ,AC , Memory);
	output [7 : 0] result ;
	input [7 : 0] AC ,Memory;
	
	assign result = ~(AC ^ Memory);
endmodule


module XnorTB;
	wire [7 : 0] result ;
	reg [7 : 0] AC ,Memory;

	Xnor sample(result ,AC , Memory);

	initial
		begin
			AC = 8'b 10010101 ; Memory = 8'b 10001010;
			#100
			AC = 8'b 01001001 ; Memory = 8'b 00011010;
			#100
			AC = 8'b 10101010 ; Memory = 8'b 10110101;
		end
endmodule
