`timescale 1ns / 1ps

module EX_MEM(
    input clk,

    input [1:0] EXMEMWBIn,        
    output reg [1:0] EXMEMWBOut,        
    input [2:0] EXMEMMIn,
    output reg EXMEMBranchOut,
    output reg EXMEMMemWriteOut,
    output reg EXMEMMemReadOut,
     
    input [63:0] EXMEMPC2AddIn,
    output reg [63:0] EXMEMPC2AddOut,
    
    input EXMEMALUZeroIn,
    output reg EXMEMALUZeroOut,
    input [63:0] EXMEMALUResultIn,
    output reg [63:0] EXMEMALUResultOut,
    
    input [63:0] EXMEMReadData2In,
    output reg [63:0] EXMEMReadData2Out,
    input [4:0] EXMEMWriteRegisterIn,
    output reg [4:0] EXMEMWriteRegisterOut
    );
    
    always @(posedge clk)
    begin
        EXMEMWBOut <= EXMEMWBIn;
        
        EXMEMBranchOut <= EXMEMMIn[2];
        EXMEMMemWriteOut <= EXMEMMIn[0];
        EXMEMMemReadOut <= EXMEMMIn[1];
        
        EXMEMPC2AddOut <= EXMEMPC2AddIn;
        EXMEMALUZeroOut <= EXMEMALUZeroIn;
        EXMEMALUResultOut <= EXMEMALUResultIn;
        EXMEMReadData2Out <= EXMEMReadData2In;
        EXMEMWriteRegisterOut <= EXMEMWriteRegisterIn;
    end
endmodule
