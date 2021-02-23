`timescale 1ns / 1ps

module testbench();
    
    reg clk;
    
    initial
    //Generate Clock
    begin
        clk = 0;
        while(1)
        begin
            #5 clk = ~clk;
        end
    end
    
    reg reset; //Active Low
    initial
    //Initize reset
    begin
        reset = 1;
        #10 reset = 0;
    end
    
    reg [31:0] IM[0:11];

    initial begin
    //Initialize IM
        $readmemh("D:/CELab2/ARM-Pipeline-Processor/IM.dat", IM);
    end
    
    wire [31:0] IMOut;
    wire [31:0] PC;
    assign IMOut = {IM[PC],IM[PC+1],IM[PC+2],IM[PC+3]};
    
    always @(posedge clk)
    //FRAME
    begin
        if (reset)
        begin
            
        end
        else
        begin
            
        end
    end
    
    datapath u_datapath (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .instruction(IMOut)
    );
    
endmodule
