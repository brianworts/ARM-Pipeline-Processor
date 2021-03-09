`timescale 1ns / 1ps

module ALUControl(
        input [10:0] OpcodeIn,
        input [1:0] ALUOp,
        
        output reg [3:0] ALUControlOut
    );
    
    
    always @(*)
    begin
        if (ALUOp == 2'b00)
        begin
            ALUControlOut = 4'b0010;
        end
        else if (ALUOp == 2'b01)
        begin
            ALUControlOut = 4'b0111;
        end
        else if (ALUOp == 2'b10)
        begin
            case(OpcodeIn)
                //case 0000: inputA AND(&) inputB
                11'b10001010000: begin
                    ALUControlOut = 4'b0000;
                end  
                  
                //case 0001: inputA OR(|) inputB
                11'b10101010000: begin
                    ALUControlOut = 4'b0001;
                end 
                
                //case 0010: inputA add(+) inputB
                11'b10001011000: begin
                    ALUControlOut = 4'b0010;
                end  
                
                //case 0110: inputA subtract(-) inputB
                11'b11001011000: begin
                    ALUControlOut = 4'b0110;
                end 
            endcase
        end
    end
endmodule
