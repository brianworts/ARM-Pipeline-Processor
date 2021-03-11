`timescale 1ns / 1ps

module Registers(
    input clk,
    input reset,
    //Control value
    input regWrite,
    //Reg locations (64)
    input [4:0] readRegister1,
    input [4:0] readRegister2,
    input [4:0] writeRegister,
    //Data (64)
    input [63:0] writeData,
    //Data (64)
    output [63:0] readData1,
    output [63:0] readData2    
    );

    reg [63:0] RM[31:0];
    
    initial 
    begin
        $readmemh("D:/CELab2/ARM-Pipeline-Processor/RM.dat", RM);
    end
    
    assign readData1 = RM[readRegister1];
    assign readData2 = RM[readRegister2];
    
    always @(*)
    begin
    //Drive RM
    //Output
        //RM
        if (reset)
        begin
            $readmemh("D:/CELab2/ARM-Pipeline-Processor/RM.dat", RM);
        end
        else
        begin
            if (regWrite)
            begin
                #1 RM[writeRegister] = writeData;
            end
        end
    end
    
endmodule
