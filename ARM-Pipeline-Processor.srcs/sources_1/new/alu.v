`timescale 1ns / 1ps

module ALU(
    //Input Data
    input [63:0] inputA, 
    input [63:0] inputB,
    //Control 
    input [3:0] ALUControl,
    //Output Data 
    output reg [63:0] ALUOutput, 
    output reg Zero 
    );
    
    always@(*) begin    //aluc
        //switch statement
        case(ALUControl)
            //case 0000: inputA AND(&) inputB
            4'b0000: begin
                ALUOutput = #1 inputA & inputB;
            end  
              
            //case 0001: inputA OR(|) inputB
            4'b0001: begin
                ALUOutput = #1 inputA | inputB;
            end 
            
            //case 0010: inputA add(+) inputB
            4'b0010: begin
                ALUOutput = #1 inputA + inputB;
            end 
            
            //case 0110: inputA subtract(-) inputB
            4'b0110: begin
                ALUOutput = #1 inputA - inputB;
            end 
            
            //case 0111: Pass inputB, result = inputB
            4'b0111: begin
                ALUOutput = #1 inputB; //For CBZ
            end 

        endcase
    end
    
    always@(*) begin //posedge CKLK
        if(ALUOutput == 0)
            Zero = #1 1;
        else
            Zero = #1 0;
    end
endmodule
