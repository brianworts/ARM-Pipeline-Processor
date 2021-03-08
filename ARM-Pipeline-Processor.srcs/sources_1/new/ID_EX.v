`timescale 1ns / 1ps

module ID_EX(
    input clk,

    input IDEXRegWriteIn,
    output reg IDEXRegWriteOut,
    
    input IDEXBranchIn,
    output reg IDEXBranchOut,
    
    input [1:0] IDEXALUOpIn,
    output reg [1:0] IDEXALUOpOut,
    
    input IDEXALUSrcIn,
    output reg IDEXALUSrcOut,
    
    input IDEXPCIn,
    output reg IDEXPCOut,
    
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
        IDEXRegWriteOut <= IDEXRegWriteIn;
        IDEXBranchOut <= IDEXBranchIn;
        IDEXALUOpOut <= IDEXALUOpIn;
        IDEXPCOut <= IDEXPCIn;
        IDEXReadData1Out <= IDEXReadData1In;
        IDEXReadData2Out <= IDEXReadData2In;
        IDEXSignExtendOutOut <= IDEXSignExtendOutIn;
        IDEXOpcodeOut <= IDEXOpcodeIn;
        IDEXWriteRegisterOut <= IDEXWriteRegisterIn;
    end
endmodule
