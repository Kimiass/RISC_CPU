module Controller (clk, reset,IR, loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR,busSelectors, read, write,busSelectors , aluOpcode);
    input clk,reset;
    input[7:0] IR;

    output read,write;
    output loadIR, incIR, clearIR;
    output loadDR, incDR, clearDR;
    output loadPC, incPC, clearPC;
    output loadAR, incAR, clearAR;
    output loadAC, incAC, clearAC;
    output [2:0] busSelectors , aluOpcode;

    wire [7:0] T,D;
    wire[2:0] sc;
    wire clearSC;
    wire busIR, busDR, busPC, busAR, busAC, busMem;
    wire opADD, opASHL, opXNOR, opDIV2, opLOAD, opSTORE, opCOMP,opROUND;

    //Address mode
    wire I;

    assign I = IR[7];

	
    SC sCounter(sc,clearSC,clk,1'b1);
 
    Decoder3_8 ScDecoder(T , sc); //Create T

    Decoder3_8 InstructionDecoder(D,IR[6:4]);  //Create D

    

    //set sc clear

    assign clearSC = reset | (D[0]&T[6]) | (D[1]&T[7]) |  (D[2]&T[6]) | (D[3]&T[7]) |  (D[4]&T[6]) | (D[5]&T[5]);

    


    //which part of alu -> when it has to work                                                                   
    assign opADD = D[0]&T[5];
    assign opASHL = D[1]&T[5];
    assign opXNOR = D[2]&T[5];
    assign opDIV2 = D[3]&T[5];
    assign opLOAD = D[4]&T[5]; 
    assign opSTORE = D[5]&T[4];
    assign opCOMP = D[6]&T[5];

    Encoder8_3 encodeOpcode({opROUND,opCOMP,opSTORE,opLOAD,opDIV2,opXNOR,opASHL,opADD}, aluOpcode); // create alu opcode


    //IR pins :
    assign loadIR = T[1];
    assign incIR = 0;
    assign clearIR = 0;

    //DR pins :
    assign loadDR = (D[0]&T[4]) | (D[1]&T[4]) |  (D[2]&T[4]) | (D[3]&T[4]) |  (D[4]&T[4]) | (D[6]&T[4]);
    assign incDR = 0;
    assign clearDR = 0;

    //PC pins :
    assign loadPC = 0;
    assign incPC = T[1];
    assign clearPC = reset;

    //AR pins :
    assign loadAR = T[0] | T[2] | (I&T[3]);
    assign incAR = 0;
    assign clearAR = 0;

    //AC pins :
    assign loadAC = (D[0]&T[5]) | (D[1]&T[5]) |  (D[2]&T[5]) | (D[3]&T[5]) |  (D[4]&T[5]) | (D[6]&T[5]);
    assign incAC = 0;
    assign clearAC = 0;

    //read and write pins
    assign read = T[1] | (I&T[3]) | (D[0]&T[4]) | (D[1]&T[4]) |  (D[2]&T[4]) | (D[3]&T[4]) |  (D[4]&T[4]) | (D[6]&T[4]) ;
    assign write =  (D[1]&T[6]) | (D[3]&T[6]) | (D[5]&T[4]) | (D[6]&T[7]) ;


    //When Register will be in Bus
    assign busIR = T[2];
    assign busDR = 0;
    assign busPC = T[0];
    assign busAR = 0;
    assign busAC = D[5]&T[4];
  
    Encoder8_3 BusSelect({read,1'b0,busIR,busAC,busDR,busPC,busAR,1'b0}, busSelectors); //create bus selectors
    

    
    

endmodule

