module SC(number,reset,clk,inc);
	output reg[2:0] number;
	input reset , clk , inc;

	always @(posedge clk)
		begin
			if (reset == 1)
				number <= 3'b000;
			else if(inc == 1)
				number <= number+3'b001;
			
		end
endmodule

module SCTB;
	wire[2:0] number;
	reg reset,clk,inc;

	SC sample(number,reset,clk,inc);
	initial 
		begin 
			clk=0;
			#100
			forever 
			#100
			clk=~clk;
		end
	initial 
		begin
			reset=1;
			inc=0;
			#20;
			reset=0;
			inc=1;
		end
endmodule