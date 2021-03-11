`timescale 1ns / 1ps

module IM(
        input [63:0] PC,
        output [31:0] IMOut
    );
    
    reg [31:0] IM[31:0];

    initial 
    begin
    //Initialize IM
        $readmemh("D:/CELab2/ARM-Pipeline-Processor/IM.dat", IM);
    end
    
    assign #1 IMOut = IM[PC];
    
endmodule
