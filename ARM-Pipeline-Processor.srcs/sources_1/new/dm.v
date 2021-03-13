`timescale 1ns / 1ps

module DM(
        input DMMemWrite,
        input DMMemRead,

        input [63:0] DMAddress,
        input [63:0] DMWriteData,
        output [63:0] DMReadData 
    );
    
    reg [63:0] DM[31:0];

    initial begin
    //Initialize IM
        $readmemh("D:/CELab2/ARM-Pipeline-Processor/DM.dat", DM);
    end
    
    assign DMReadData = DM[DMAddress];
    
    always @(*)
    begin
        if (DMMemWrite)
        begin
            DM[DMAddress] = DMWriteData;
        end
    end
endmodule