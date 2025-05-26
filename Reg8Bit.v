module Reg8Bit (clk, load, inc, clear, regInput, regOutput);
	output [7 : 0] regOutput;
	reg [7 : 0] regOutput;	
    	input clk, load, inc, clear;
    	input [7 : 0] regInput;

	always @(posedge clk) 
		begin
        	if (load == 1) regOutput <= regInput; 
        	else if (inc == 1) regOutput <= regOutput + 1;
        	else if (clear == 1) regOutput <= 8'b00000000;
    		end
endmodule

module Reg8BitTB;
	wire [7 : 0] regOutput;
	reg clk, load, inc, clear;
    	reg [7 : 0] regInput;

	Reg8Bit sample(clk, load, inc, clear, regInput, regOutput);
	initial 
		begin
        	clk = 0;
        	forever 
		#10 clk = ~clk;
    		end

    	initial 
		begin
		load = 1;
        	regInput = 8'b01011001;
        	#100;
        	load = 0;
		inc = 1;
       		#100;
        	inc = 0;
		clear = 1;
		#100;
		clear = 0;
		end
endmodule
