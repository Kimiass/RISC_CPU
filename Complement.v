module Complement2(result, Memory);
	output [7 : 0] result ;
	input [7 : 0] Memory;
	
	assign result = ~(Memory) + 8'b00000001;
endmodule


module Complement2TB;
	wire [7 : 0] result ;
	reg [7 : 0] Memory;

	Complement2 sample(result, Memory);

	initial
		begin
			Memory = 8'b 10001010;
			#100
			Memory = 8'b 00011010;
			#100
			Memory = 8'b 10110101;
		end
endmodule
