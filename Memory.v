module Memory(clk,write_enable,read_enable,address,data_in,data_out);
    	input clk;
    	input write_enable;
	input read_enable;
    	input [3:0]address;
    	input [7:0]data_in;
    	output reg [7:0]data_out;
	reg [7:0]memory_block[0:15];



	always @(posedge clk) 
		begin
		memory_block[2] <= 8'b00101110;
        	if (write_enable == 1)
            	memory_block[address] <= data_in;
        	else if(read_enable == 1)
            	data_out <= memory_block[address];
		end
endmodule

module MemoryTB;
	reg clk;
	reg write_enable;
	reg read_enable;
	reg [3:0]address;
	reg [7:0]data_in;
	wire [7:0]data_out;

	Memory sample(clk,write_enable,read_enable,address,data_in,data_out);
	initial 
		begin
        	clk = 1;
        	forever 
		#50 clk = ~clk;
    		end
	initial
		begin
		write_enable = 1;
		read_enable = 0;
		address = 4'b0111;
		data_in = 8'b00010101;
		#100;
		write_enable = 0;
		read_enable = 1;
		address = 4'b0111;
		data_in = 8'b00000000;
		#100;
		write_enable = 1;
		read_enable = 0;
		address = 4'b0110;
		data_in = 8'b01100001;
		#100;
		write_enable = 0;
		read_enable = 1;
		address = 4'b0110;
		data_in = 8'b00000000;
		#100;
		end
endmodule