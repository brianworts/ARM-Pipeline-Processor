`timescale 1ns / 1ps

module ShiftLeftTwo(
    input clk,
    input reset,

    input [63:0] SLInput,
    output reg [63:0] SLOutput
    );
    always @(posedge clk)
    begin
        SLOutput = SLOutput << 2;
    end


endmodule
