`timescale 1ns / 1ps

//NOTES
    //Need to go back and change register locations to 5 bits
    
    //Async read, sync write
        //if write and read at same time, should read old value

module Datapath(
    input clk,
    input reset,
    //PC
    output [63:0] PC,
    //IM
    input [31:0] IFIMOut,
    //DM
    output DMMemWrite,
    output DMMemRead,
              
    output [63:0] DMAddress,
    output [63:0] DMWriteData,
    input [63:0] DMReadData
    );

    ////////////////////////////////
    //IF
    wire PCSrc;

    wire [63:0] PCMuxOut;
    
    wire [63:0] PCAddOut;
    wire [63:0] EXMEMPCAdd2Out;
    
    Mux u_PCMux( 
        .inputA(PCAddOut),
        .inputB(EXMEMPCAdd2Out),
        .selector(PCSrc), 
        .outputData(PCMuxOut)
    );
    
    Add u_PCAdd(
        .inputA(PC),
        .inputB(64'd4), //Always add 4
        .outputData(PCAddOut)
    );
    
    PC u_PC(
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .PCMuxOut(PCMuxOut)
    );
    //////////////////////////////////
    //IF/ID
    wire [63:0] IFIDPCOut;
    wire [31:0] IFIDIMOut;
    
    IF_ID u_IF_ID(
        .clk(clk),
        .reset(reset),
        
        .IFIDPCIn(PC),
        .IFIDPCOut(IFIDPCOut),
        .IFIDIMIn(IFIMOut),
        .IFIDIMOut(IFIDIMOut)
    );
    //////////////////////////////////
    //ID
    wire [4:0] ReadRegister2In;
    wire [4:0] Reg2MuxAIn;
    wire [4:0] Reg2MuxBIn;
    wire Reg2Loc;
    assign Reg2Loc = IFIDIMOut[28];
    assign Reg2MuxAIn = IFIDIMOut[20:16];
    assign Reg2MuxBIn = IFIDIMOut[4:0];
    Mux u_RegsMux(
        .inputA(Reg2MuxAIn),
        .inputB(Reg2MuxBIn),
        .selector(Reg2Loc), 
        .outputData(ReadRegister2In)
    );
    
    wire [4:0] ReadRegister1In;
    wire [4:0] WriteRegister; 
    wire [63:0] RegWriteData; 
    wire [63:0] ReadData1; 
    wire [63:0] ReadData2; 
    wire [63:0] InsSignExtendOut;
    
    wire MEMWBRegWriteOut;

    
    Registers u_Registers(
        .readRegister1(IFIDIMOut[9:5]),
        .readRegister2(ReadRegister2In),
        .writeRegister(WriteRegister),
        .writeData(RegWriteData),
        
        .regWrite(MEMWBRegWriteOut),
        
        .readData1(ReadData1),
        .readData2(ReadData2)
    );
    
    assign #1 InsSignExtendOut = { {32{IFIDIMOut[31] }}, IFIDIMOut[31:0] };
    
    wire [1:0] WBControlOut;
    wire [2:0] MControlOut;
    wire [2:0] EXControlOut;
   
    
    Control u_Control(
        .Instruction(IFIDIMOut),
        
        .WB(WBControlOut),
        .M(MControlOut),
        .EX(EXControlOut)
    );
    //////////////////////////////////
    //ID/EX
    wire [1:0] IDEXWBControlOut;
    wire [2:0] IDEXMOut;
    wire [1:0] IDEXALUOpOut;
    wire IDEXALUSrcOut;
    wire [63:0] IDEXPCOut;
    wire [63:0] IDEXReadData1Out;
    wire [63:0] IDEXReadData2Out;
    wire [63:0] IDEXSignExtendOutOut;
    wire [10:0] IDEXOpcodeOut;
    wire [4:0] IDEXWriteRegisterOut;
    
    ID_EX u_ID_EX(
        .clk(clk),

        .IDEXWBIn(WBControlOut),
        .IDEXWBOut(IDEXWBControlOut),
        
        .IDEXMIn(MControlOut),
        .IDEXMOut(IDEXMOut),
        
        .IDEXEXIn(EXControlOut),
        .IDEXALUOpOut(IDEXALUOpOut),
        .IDEXALUSrcOut(IDEXALUSrcOut),

        .IDEXPCIn(IFIDPCOut),
        .IDEXPCOut(IDEXPCOut),
        
        .IDEXReadData1In(ReadData1),
        .IDEXReadData1Out(IDEXReadData1Out),
        
        .IDEXReadData2In(ReadData2),
        .IDEXReadData2Out(IDEXReadData2Out),
        
        .IDEXSignExtendOutIn(InsSignExtendOut),
        .IDEXSignExtendOutOut(IDEXSignExtendOutOut),
        
        .IDEXOpcodeIn(IFIDIMOut[31:21]),
        .IDEXOpcodeOut(IDEXOpcodeOut),
        
        .IDEXWriteRegisterIn(IFIDIMOut[4:0]),
        .IDEXWriteRegisterOut(IDEXWriteRegisterOut)
    );
    
    //////////////////////////////////
    //EX
    wire [63:0] PC2AddOut;
    reg [20:0] IDEXSignExtendOutOutShifted;
    always @(*)
    begin
            IDEXSignExtendOutOutShifted = #1 (IDEXSignExtendOutOut[23:5] << 2);
    end
    
    BranchAdd u_BranchAdd(
        .inputA(IDEXPCOut),
        .inputB(IDEXSignExtendOutOutShifted), //Shift Left 2
        
        .outputData(PC2AddOut)
    );
    
    wire [63:0] ALUMuxOut;
    Mux u_ALUMux(
        .inputA(IDEXReadData2Out),
        .inputB(IDEXSignExtendOutOut),//DEBUG BITS???????????????????????????
        .selector(IDEXALUSrcOut),
        .outputData(ALUMuxOut)
    );
    
    wire [63:0] ALUResult;
    wire ALUZeroOut;
    wire [3:0] ALUControlOut;
    
    ALUControl u_ALUControl(
        .OpcodeIn(IDEXOpcodeOut),
        .ALUOp(IDEXALUOpOut),
        
        .ALUControlOut(ALUControlOut)
    );
    
    ALU u_ALU(
        //Input Data
        .inputA(IDEXReadData1Out), 
        .inputB(ALUMuxOut),
        //ALUOp
        .ALUOp(IDEXALUOpOut),
        //Control 
        .ALUControl(ALUControlOut),
        //Output Data 
        .ALUOutput(ALUResult),
        .Zero(ALUZeroOut)
    );
    //////////////////////////////////
    //EX/MEM
    wire [1:0] EXMEMWBOut;
    wire EXMEMBranchOut;
    wire EXMEMMemWriteOut;
    wire EXMEMMemReadOut;
    
    wire EXMEMALUZeroOut;
    wire [63:0] EXMEMALUResultOut;
    wire [63:0] EXMEMReadData2Out;
    wire [4:0] EXMEMWriteRegisterOut;
     
    EX_MEM u_EX_MEM(
        .clk(clk),
    
        .EXMEMWBIn(IDEXWBControlOut),        
        .EXMEMWBOut(EXMEMWBOut),   
             
        .EXMEMMIn(IDEXMOut),
        .EXMEMBranchOut(EXMEMBranchOut),
        .EXMEMMemWriteOut(EXMEMMemWriteOut),
        .EXMEMMemReadOut(EXMEMMemReadOut),
         
        .EXMEMPC2AddIn(PC2AddOut),
        .EXMEMPC2AddOut(EXMEMPCAdd2Out),
        
        .EXMEMALUZeroIn(ALUZeroOut),
        .EXMEMALUZeroOut(EXMEMALUZeroOut),
        .EXMEMALUResultIn(ALUResult),
        .EXMEMALUResultOut(EXMEMALUResultOut),
        
        .EXMEMReadData2In(IDEXReadData2Out),
        .EXMEMReadData2Out(EXMEMReadData2Out),
        .EXMEMWriteRegisterIn(IDEXWriteRegisterOut),
        .EXMEMWriteRegisterOut(EXMEMWriteRegisterOut)
    );
    //////////////////////////////////
    //MEM
    assign PCSrc = EXMEMBranchOut & EXMEMALUZeroOut;
    assign DMAddress = EXMEMALUResultOut;
    assign DMWriteData = EXMEMReadData2Out;
    assign DMMemWrite = EXMEMMemWriteOut; 
    assign DMMemRead = EXMEMMemReadOut; 
    //////////////////////////////////
    //MEM/WB
    wire MemToRegOut;
    wire [63:0] MEMWBDMReadDataOut;
    wire [63:0] MEMWBALUResultOut;
    wire [4:0] MEMWBWriteRegisterOut;

    
    MEM_WB u_MEM_WB(
        .clk(clk),
    
        .MEMWBWBIn(EXMEMWBOut),
        .MEMWBRegWriteOut(MEMWBRegWriteOut),
        .MEMWBMemToRegOut(MemToRegOut),
        
        .MEMWBDMReadDataIn(DMReadData),
        .MEMWBDMReadDataOut(MEMWBDMReadDataOut),
        
        .MEMWBALUResultIn(EXMEMALUResultOut),
        .MEMWBALUResultOut(MEMWBALUResultOut),
        
        .MEMWBWriteRegisterIn(EXMEMWriteRegisterOut),
        .MEMWBWriteRegisterOut(MEMWBWriteRegisterOut)
    );
    //////////////////////////////////
    //WB
    Mux u_WBMux( 
        .inputA(MEMWBALUResultOut),
        .inputB(MEMWBDMReadDataOut),
        .selector(MemToRegOut),
        .outputData(RegWriteData)
    );
    assign WriteRegister = MEMWBWriteRegisterOut;
        
    //////////////////////////////////
endmodule
