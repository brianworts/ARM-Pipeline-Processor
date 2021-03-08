`timescale 1ns / 1ps

module IF_ID(
    input clk,
    input reset,
    
    input [63:0] IFIDPCIn,
    output reg[63:0] IFIDPCOut,
    input [31:0] IFIDIMIn,
    output reg [31:0] IFIDIMOut
    );
    
    always @(posedge clk)
    begin
        if (reset)
        begin
        
        end
        else
        begin
            IFIDPCOut <= IFIDPCIn;
            IFIDIMOut <= IFIDIMIn;
        end
    end
    
endmodule
