module CPU2 (clk, reset, read, write, address, memoryIn, memoryOut);
    input clk,reset;
    input [7:0] memoryOut;


    output [3:0] address;
    output [7:0] memoryIn;
    output read,write;


    wire [7:0] bus , alu;
    wire [7:0] DR,AC,IR;    
    wire [3:0] AR, PC; 
    wire E;
    wire loadIR, incIR, clrIR;
    wire loadDR, incDR, clrDR;
    wire loadPC, incPC, clrPC;
    wire loadAR, incAR, clrAR;
    wire loadAC, incAC, clrAC;
    wire [7:0] T,D;
    wire [2:0] busSEL , aluOpcode, sc;
    wire ResetSC;
    wire busIR, busDR, busPC, busAR, busAC, busMem;
    wire I;



    assign memoryIn = bus;
    assign address = AR;
    assign I = IR[7];

                                         
    
    Decoder3_8 decoder_instruction(D,IR[6:4]); //make D
    Decoder3_8 decoder_sc(T,sc); //make T


    assign ResetSC = reset | (D[0]&T[5]) | (D[1]&T[5]) |  (D[2]&T[5]) | (D[3]&T[5]) |  (D[4]&T[5]) | (D[5]&T[4]) | (D[6]&T[5]);

    SC SCounter(sc,ResetSC,clk,1'b1);
                                                         

    //AR pins :
    assign loadAR = T[0] | T[2] | (I&T[3]);
    assign incAR = 0;
    assign clrAR = 0;

    //PC pins :
    assign loadPC = 0;
    assign incPC = T[1];
    assign clrPC = reset;

    //DR pins :
    assign loadDR = (D[0]&T[4]) | (D[1]&T[4]) |  (D[2]&T[4]) | (D[3]&T[4]) |  (D[4]&T[4]) | (D[6]&T[4]);
    assign incDR = 0;
    assign clrDR = 0;

    //AC pins :
    assign loadAC = (D[0]&T[5]) | (D[1]&T[5]) |  (D[2]&T[5]) | (D[3]&T[5]) |  (D[4]&T[5]) | (D[6]&T[5]);
    assign incAC = 0;
    assign clrAC = 0;

    //IR pins :
    assign loadIR = T[1];
    assign incIR = 0;
    assign clrIR = 0;

    //read and write pins
    assign read = (D[0]&T[4]) | (D[1]&T[4]) |  (D[2]&T[4]) | (D[3]&T[4]) |  (D[4]&T[4]) | (D[6]&T[4]) | (I&T[3]) | T[1];
    assign write = (D[5]&T[4]);

    //Bus select
    assign busIR = T[2];
    assign busDR = 0;
    assign busPC = T[0];
    assign busAR = 0;
    assign busAC = D[5]&T[4];
    assign aluOpcode = IR[6:4];


    Encoder8_3 encoder_busSEL({read,1'b0,busIR,busAC,busDR,busPC,busAR,1'b0}, busSEL);
    
    
    BUS busRoad(bus,8'b0, {4'b0,AR},{4'b0,PC},DR,AC,IR,8'b0,memoryOut , busSEL);

    ALU aluUnit(clk,AC,DR,aluOpcode,alu, E);

    Reg4Bit PCreg(clk,loadPC,incPC,clrPC,bus[3:0],PC);
    Reg4Bit ARreg(clk,loadAR,incAR,clrAR,bus[3:0],AR);

    Reg8Bit DRreg(clk,loadDR,incDR,clrDR,bus[7:0],DR);
    Reg8Bit ACreg(clk,loadAC,incAC,clrAC,alu,AC);
    Reg8Bit IRreg(clk,loadIR,incIR,clrIR,bus[7:0],IR);
    

endmodule
