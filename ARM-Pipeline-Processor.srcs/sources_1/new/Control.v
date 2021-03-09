`timescale 1ns / 1ps

module Control(
    input [31:0] Instruction,
        
    output reg [1:0] WB,
    output reg [2:0] M,
    output reg [2:0] EX
    );
    
    
    
    always @(*)
    begin
        if ((Instruction[31:21] == 11'b10001011000) || (Instruction[31:21] == 11'b10001010000) || (Instruction[31:21] == 11'b10101010000) || (Instruction[31:21] == 11'b10001010000))
                                    //add                                   //sub                                   //or                            //and
        begin
            EX = 3'b100;
            M = 3'b000;
            WB = 2'b10;
        end
        if ((Instruction[31:21] == 11'b11111000010)) //LDUR
        begin
            EX = 3'b001;
            M = 3'b010;
            WB = 2'b11;
        end
        if ((Instruction[31:21] == 11'b11111000000)) //STUR
        begin
            EX = 3'b001;
            M = 3'b001;
            WB = 2'b00;
        end
        if ((Instruction[31:24] == 11'b10110100)) //CBZ
        begin
            EX = 3'b010;
            M = 3'b100;
            WB = 2'b00;
        end
    end
    
endmodule
