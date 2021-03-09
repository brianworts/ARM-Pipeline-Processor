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
    input EXMEMALUResultIn,
    output reg EXMEMALUResultOut,
    
    input EXMEMReadData2In,
    output reg EXMEMReadData2Out,
    input EXMEMWriteRegisterIn,
    output reg EXMEMWriteRegisterOut
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
