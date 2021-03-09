`timescale 1ns / 1ps

module PC(
    input clk,
    input reset,
    
    input [63:0] PCMuxOut,
    output reg [63:0] PC
    );
    
    always @(posedge clk)
    begin
        if (reset)
        begin
            PC <= 0;
        end
        else
        begin
            PC <= PCMuxOut;
        end
    end
    
endmodule
