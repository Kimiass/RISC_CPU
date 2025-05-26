module CPU (clk, reset);
    input clk, reset;

    wire [7:0] IR;
    wire read,write;
    wire loadIR, incIR, clearIR;
    wire loadDR, incDR, clearDR;
    wire loadPC, incPC, clearPC;
    wire loadAR, incAR, clearAR;
    wire loadAC, incAC, clearAC;
    wire [2:0] busSelectors , aluOpcode;

    DataPath MyDataPath(clk,loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR,busSelectors, read, write,busSelectors , aluOpcode ,IR);
    Controller MyController(clk, reset,IR, loadPC,loadAR,loadDR,loadAC,loadIR,incPC,incAR,incDR,incAC,incIR,clearPC,clearAR,clearDR,clearAC,clearIR,busSelectors, read, write,busSelectors , aluOpcode);

endmodule

