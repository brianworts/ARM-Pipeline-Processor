`timescale 1ns / 1ps

module EX_MEM(
    input clk,

    input EXMEMRegWriteIn,        
    output reg EXMEMRegWriteOut,        
    input EXMEMBranchIn,
    output reg EXMEMBranchOut,
     
    input EXMEMPC2AddIn,
    output reg EXMEMPC2AddOut,
    
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
        EXMEMRegWriteOut <= EXMEMRegWriteIn;
        EXMEMBranchOut <= EXMEMBranchIn;
        EXMEMPC2AddOut <= EXMEMPC2AddIn;
        EXMEMALUZeroOut <= EXMEMALUZeroIn;
        EXMEMALUResultOut <= EXMEMALUResultIn;
        EXMEMReadData2Out <= EXMEMReadData2In;
        EXMEMWriteRegisterOut <= EXMEMWriteRegisterIn;
    end
endmodule
