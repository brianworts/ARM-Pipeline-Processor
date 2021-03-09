`timescale 1ns / 1ps


module MEM_WB(
    input clk,
    
    input [1:0] MEMWBWBIn,
    output reg MEMWBRegWriteOut,
    output reg MEMWBMemToRegOut,
    
    input [63:0] MEMWBDMReadDataIn,
    output reg [63:0] MEMWBDMReadDataOut,
    
    input [63:0] MEMWBALUResultIn,
    output reg [63:0] MEMWBALUResultOut,
    
    input [4:0] MEMWBWriteRegisterIn,
    output reg [4:0] MEMWBWriteRegisterOut
    );
    
    always @ (posedge clk)
    begin
        MEMWBRegWriteOut <= MEMWBWBIn[1];
        MEMWBMemToRegOut <= MEMWBWBIn[0];
        
        MEMWBDMReadDataOut <= MEMWBDMReadDataIn;
        MEMWBALUResultOut <= MEMWBALUResultIn;
        MEMWBWriteRegisterOut <= MEMWBWriteRegisterIn;
    end
    
endmodule
