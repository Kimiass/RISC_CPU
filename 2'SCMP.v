module Complement(result, Memory);
	output [7 : 0] result ;
	input [7 : 0] Memory;
	
	assign result = ~(Memory) + 1;
endmodule


module ComplementTB;
	wire [7 : 0] result ;
	reg [7 : 0] Memory;

	Complement sample(result, Memory);

	initial
		begin
			Memory = 8'b 10001010;
			#100
			Memory = 8'b 00011010;
			#100
			Memory = 8'b 10110101;
		end
endmodule
