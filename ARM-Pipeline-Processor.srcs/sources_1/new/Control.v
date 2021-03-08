`timescale 1ns / 1ps

module Control(
    input Instruction,
        
    output RegWrite,
    output Branch,
    output [1:0] ALUOp,
    output ALUSrc
    );
endmodule
