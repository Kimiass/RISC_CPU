module BUS (out,in0,in1,in2,in3,in4,in5,in6,in7,selectors);
    output [7:0] out;
    input [7:0] in0,in1,in2,in3,in4,in5,in6,in7;
    input [2:0] selectors;
    wire [7:0] BusOut; 
    
    MUX8_1 BUSMUX(BusOut,in0,in1,in2,in3,in4,in5,in6,in7,selectors);
    assign out = BusOut;

endmodule


module BUSTB;
	wire [7:0] out;
	reg [7:0] in0,in1,in2,in3,in4,in5,in6,in7;
	reg [2:0] selectors;

	BUS sample(out,in0,in1,in2,in3,in4,in5,in6,in7,selectors);

	initial
		begin
		in0 = 8'b10101010;
		in1 = 8'b00001111;
		in2 = 8'b11110000;
		in3 = 8'b01010101;
		in4 = 8'b11100011;
		in5 = 8'b00110011;
		in6 = 8'b11001100;
		in7 = 8'b00011100;
		// select in0
        	selectors = 3'b000;
		#100;
		// select in1
		selectors = 3'b001;
		#100;
		// select in2
		selectors = 3'b010;
		#100;
		// select in3
		selectors = 3'b011;
		#100;
		// select in4
		selectors = 3'b100;
		#100;
		// select in5
		selectors = 3'b101;
		#100;
		// select in6
		selectors = 3'b110;
		#100;
		// select in7
		selectors = 3'b111;
		end

endmodule
