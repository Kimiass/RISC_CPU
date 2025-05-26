module Decoder3_8 (out,in);
    output reg[7:0] out;
    input [2:0] in;
   
    always @(in) begin
        case(in)
            3'b000: out = 8'b00000001;
            3'b001: out = 8'b00000010;
            3'b010: out = 8'b00000100;
            3'b011: out = 8'b00001000;
            3'b100: out = 8'b00010000;
            3'b101: out = 8'b00100000;
            3'b110: out = 8'b01000000;
            3'b111: out = 8'b10000000;
            default: out = 8'bx;
        endcase
    end
endmodule


module Decoder3_8TB;
	wire [7:0] out;
	reg [2:0] in;

	Decoder3_8 sample(out , in);

	initial
		begin
		// out = 00000001
        	in = 3'b000;
		#100;
		// out = 00000010
		in = 3'b001;
		#100;
		// out = b00000100
		in = 3'b010;
		#100;
		// out = 00001000
		in = 3'b011;
		#100;
		// out = 00010000
		in = 3'b100;
		#100;
		// out = 00100000
		in = 3'b101;
		#100;
		// out = 01000000
		in = 3'b110;
		#100;
		// out = 10000000
		in = 3'b111;
		end

endmodule