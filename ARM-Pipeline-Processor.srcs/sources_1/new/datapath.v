`timescale 1ns / 1ps

//NOTES
    //Check if Muxes should be immediate or delayed one cycle
    
    //Async read, sync write
        //if write and read at same time, should read old value


module datapath(
    input clk,
    input reset,
    
    output reg [31:0] PC,
    input [31:0] instruction
    );
    
    wire Reg2Lock;
    wire [1:0] ALUOp;
    wire ALUSrc;
    wire Branch;
    wire MemRead;
    wire MemWrite;
    wire RegWrite;
    wire MemToReg;
    
    wire Zero;
    
    wire PCSrc;
    assign PCSrc = Branch & Zero;
    ////////////////////////////////
    //Program Counter
    wire PCMuxOut;
    
    wire PCAddOut;
    wire BranchAddOut;
    
    mux PCMux(
        .clk(clk), 
        .reset(reset),
        
        .inputA(PCAddOut),
        .inputB(BranchAddOut),
        .selector(PCSrc),
        .outputData(PCMuxOut)
    );
    
    always @(*)
    begin
        if (reset)
        begin
            PC = 0;
        end
        else
        begin
            PC = PCMuxOut;
        end
    end
    ////////////////////////////////
endmodule
