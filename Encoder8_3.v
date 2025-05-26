module Encoder8_3 (in , out);

    input [7:0] in;

    output [2:0] out;

    assign out[0] = in[1] | in[3] | in[5] | in[7];
    assign out[1] = in[2] | in[3] | in[6] | in[7];
    assign out[2] = in[4] | in[5] | in[6] | in[7];
    
endmodule


module Encoder8_3TB;
	wire [2:0] out;
	reg [7:0] in;

	Encoder8_3 sample(in,out);

	initial
		begin
		// out = 000
        	in = 8'b00000001;
		#100;
		// out = 001
		in = 8'b00000010;
		#100;
		// out = 010
		in = 8'b00000100;
		#100;
		// out = 011
		in = 8'b00001000;
		#100;
		// out = 100
		in = 8'b00010000;
		#100;
		// out = 101
		in = 8'b00100000;
		#100;
		// out = 110
		in = 8'b01000000;
		#100;
		// out = 111
		in = 8'b10000000;
		end

endmodule