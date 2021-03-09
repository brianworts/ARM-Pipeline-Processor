`timescale 1ns / 1ps

module ID_EX(
    input clk,

    input [1:0] IDEXWBIn,
    output reg [1:0] IDEXWBOut,
    
    input [2:0] IDEXMIn,
    output reg [2:0] IDEXMOut,
    
    input [2:0] IDEXEXIn,
    output reg [1:0] IDEXALUOpOut,
    output reg IDEXALUSrcOut,
    
    input [63:0] IDEXPCIn,
    output reg [63:0] IDEXPCOut,
    
    input [63:0] IDEXReadData1In,
    output reg [63:0] IDEXReadData1Out,
    
    input [63:0] IDEXReadData2In,
    output reg [63:0] IDEXReadData2Out,
    
    input [63:0] IDEXSignExtendOutIn,
    output reg [63:0] IDEXSignExtendOutOut,
    
    input [10:0] IDEXOpcodeIn,
    output reg [10:0] IDEXOpcodeOut,
    
    input [4:0]IDEXWriteRegisterIn,
    output reg [4:0] IDEXWriteRegisterOut
    );
    
    always @(posedge clk)
    begin
        IDEXWBOut <= IDEXWBIn;
        IDEXMOut <= IDEXMIn;
        IDEXALUOpOut <= IDEXEXIn[2:1];
        IDEXALUSrcOut <= IDEXEXIn[0];
        
        IDEXPCOut <= IDEXPCIn;
        IDEXReadData1Out <= IDEXReadData1In;
        IDEXReadData2Out <= IDEXReadData2In;
        IDEXSignExtendOutOut <= IDEXSignExtendOutIn;
        IDEXOpcodeOut <= IDEXOpcodeIn;
        IDEXWriteRegisterOut <= IDEXWriteRegisterIn;
    end
endmodule
