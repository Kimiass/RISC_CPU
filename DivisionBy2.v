module DivisionBy2(result , Cout , Memory);
	output [7 : 0] result ;
	output Cout;
	input [7 : 0] Memory;
	
	assign Cout = Memory[0];
	assign result = Memory >>> 1;
endmodule


module DivisionBy2TB;
	wire [7 : 0] result ;
	wire Cout ;
	reg [7 : 0] Memory;

	DivisionBy2 sample(result ,Cout , Memory);

	initial
		begin
			Memory = 8'b 10001010;
			#100
			Memory = 8'b 11000001;
			#100
			Memory = 8'b 00011010;
			
		end
endmodule
