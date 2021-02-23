`timescale 1ns / 1ps

module registers(
    input clk,
    input reset,
    //Control value
    input regWrite,
    //Reg locations (64)
    input [5:0] readRegister1,
    input [5:0] readRegister2,
    input [5:0] writeRegister,
    //Data (64)
    input [5:0] writeData,
    //Data (64)
    output [5:0] readData1,
    output [5:0] readData2    
    );

    reg [63:0] RM[0:31];
    
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
                RM[writeRegister] = writeData;
            end
        end
    end
    
endmodule
