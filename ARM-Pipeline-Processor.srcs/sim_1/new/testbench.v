`timescale 1ns / 1ps

module testbench();
    //////////////////////////////////////////
    //CLK
    reg clk;
    
    //Generate Clock
    initial
    begin
        clk = 0;
        while(1)
        begin
            #5 clk = ~clk;
        end
    end
    /////////////////////////////////////////////
    //Reset
    reg reset; //Active Low
    initial
    //Initize reset
    begin
        reset = 1;
        #20 reset = 0;
    end
    ////////////////////////////////////////////
    
    
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
    
    wire [63:0] PC;
    
    //////////////////////////////////////////////
    //IM
    wire [31:0] IMOut;
    
    IM u_IM (
        .PC(PC),
        .IMOut(IMOut)
    );
    //////////////////////////////////////////////
    //DM
    wire DMMemWrite;
    wire DMMemRead;
    
    wire [63:0] DMAddress;
    wire [63:0] DMWriteData;
    wire [63:0] DMReadData;
    
    DM u_DM(
        .DMMemWrite(DMMemWrite),
        .DMMemRead(DMMemRead),

        .DMAddress(DMAddress),
        .DMWriteData(DMWriteData),
        .DMReadData(DMReadData) 
    );
    //////////////////////////////////////////////
    
    Datapath u_Datapath (
        .clk(clk),
        .reset(reset),
        
        //PC
        .PC(PC),
        
        //IM
        .IFIMOut(IMOut),
        
        //DM
        .DMMemWrite(DMMemWrite),
        .DMMemRead(DMMemRead),
        
        .DMAddress(DMAddress),
        .DMWriteData(DMWriteData),
        .DMReadData(DMReadData)
    );
    
endmodule
