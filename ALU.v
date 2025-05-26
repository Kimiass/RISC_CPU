module ALU(clk,AC ,DR ,selectors ,result, E);
	output[7:0] result;
	output E;
	input clk;
	input[7:0] AC, DR;
	input[2:0] selectors;
	wire[7:0] add, ashl, xNor, div, complement;
    	wire addCout, ashlCout, divCout, load;

    	Add ALUadd(add,addCout,AC,DR);
	Ashl ALUashl(ashl,ashlCout,DR);
	Xnor ALUxnor(xNor,AC,DR);
	DivisionBy2 ALUdiv(div,divCout,DR);
	Complement2 ALUcompelement(complement,DR);

    	assign result =
        	(selectors == 3'b000) ? add :
        	(selectors == 3'b001) ? ashl :
		(selectors == 3'b010) ? xNor :
        	(selectors == 3'b011) ? div :
		(selectors == 3'b100) ? DR :
		(selectors == 3'b101) ? AC :
       		(selectors == 3'b110) ? complement :
        	result;

   	assign E =
        	(selectors == 3'b000) ? addCout :
        	(selectors == 3'b001) ? ashlCout :
        	(selectors == 3'b011) ? divCout :
        	E;

endmodule

module ALUTB;
	wire [7:0] result;
    	wire E;
	reg clk;
    	reg [7:0] AC, DR;
    	reg [2:0] selectors;
	ALU sample(clk,AC ,DR ,selectors ,result, E);    
	initial 
		begin
        	clk = 0;
       		forever 
		#10 clk = ~clk;
    		end

	 initial 
		begin
		// 3'b000 -> Add
        	AC = 8'b00110001; DR = 8'b11000100; selectors = 3'b000;
		#100;
        	AC = 8'b11000001; DR = 8'b10100011; selectors = 3'b000;
		#100;
		// 3'b001 -> Ashl
		AC = 8'b00000000; DR = 8'b01000110; selectors = 3'b001;
		#100;
		AC = 8'b00000000; DR = 8'b10110001; selectors = 3'b001;
		#100;
		// 3'b010 -> Xnor
		AC = 8'b10110010; DR = 8'b10000110; selectors = 3'b010;
		#100;
		// 3'b011 -> DivisionBy2
		AC = 8'b00000000; DR = 8'b01000110; selectors = 3'b011;
		#100;
		AC = 8'b00000000; DR = 8'b10110001; selectors = 3'b011;
		#100;
		// 3'b100 -> Load
        	AC = 8'b00000000; DR = 8'b10011010; selectors = 3'b100;
		#100;
		// 3'b110 -> Complement2
        	AC = 8'b00000000; DR = 8'b10011010; selectors = 3'b110;
		#100;
		end
endmodule
