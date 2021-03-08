`timescale 1ns / 1ps

module SignExtend(
    input clk,
    input reset,
    
    input [31:0] SEInput,
    output reg [63:0] SEOutput
    );
    
    always @(posedge clk)
    begin
        SEOutput <= $signed(SEInput);
    end
    
endmodule
