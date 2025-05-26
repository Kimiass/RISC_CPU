module DataPath(clk,loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR, read, write,busSelectors , aluOpcode ,IR);
    input clk,loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR,read,write;
    input [2:0] busSelectors , aluOpcode;    
    output[7:0] IR;

    wire [7:0] bus , alu , AC ,DR ,MemoryOut; 
    wire [3:0] AR, PC;
    wire E;
    
    BUS busPath(bus , 8'b0, {4'b0,AR},{4'b0,PC},DR,AC,IR,8'b0,MemoryOut, busSelectors);

    ALU aluUnit(clk,AC,DR,aluOpcode,alu, E);

    Reg4Bit regPC(clk,loadPC,incPC,clearPC,bus[3:0],PC);
    Reg4Bit regAR(clk,loadAR,incAR,clearAR,bus[3:0],AR);

    Reg8Bit regDR(clk,loadDR,incDR,clearDR,bus[7:0],DR);
    Reg8Bit regAC(clk,loadAC,incAC,clearAC,alu[7:0],AC);
    Reg8Bit regIR(clk,loadIR,incIR,clearIR,bus[7:0],IR);

    Memory MemoryUnit(clk,write,read,AR,bus,MemoryOut);
    

endmodule


module DataPathTB;
	reg clk,loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR,read,write;
	reg [2:0] busSelectors , aluOpcode;
	
	wire IR;

	DataPath sample(clk,loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR, read, write,busSelectors , aluOpcode,IR);


	initial 
		begin
        	clk = 1;
        	forever 
		#50 clk = ~clk;
    		end
	initial
		begin

		read = 1;
		busSelectors = 3'b111;
		#100
		
		loadDR = 1;
		read = 0;
		#100
		
		loadDR=0;
		aluOpcode = 3'b100;
		#100

		loadAC = 1;
		
		
		end
endmodule