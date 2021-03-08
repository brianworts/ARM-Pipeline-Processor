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
              
    output [31:0] DMAddress,
    output [63:0] DMWriteData,
    output [63:0] DMReadData
    );
    
    //wire Reg2Lock;
    //wire [1:0] ALUOp;
    //wire ALUSrc;
    //wire Branch;
    //wire MemRead;
    //wire MemWrite;
    //wire RegWrite;
    //wire MemToReg;
    
    //wire Zero;
    
    
    ////////////////////////////////
    //IF
    //wire PCSrc;
    //assign PCSrc = Branch & Zero;
    
    wire [63:0] PCMuxOut;
    
    wire [63:0] PCAddOut;
    wire [63:0] BranchAddOut;
    
    Mux u_PCMux( 
        .inputA(PCAddOut),
        .inputB(BranchAddOut),
        .selector(0), //DEBUG: PCSrc
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
    wire [7:0] ReadRegister2In; //debug num bits??
    Mux u_RegsMux(
        .inputA(IFIDIMOut), //DEBUG
        .inputB(IFIDIMOut), //DEBUG
        .selector(IFIDIMOut[28]), //DEBUG: PCSrc
        .outputData(ReadRegister2In)
    );
    
    wire [4:0] ReadRegister1In;
    wire [4:0] WriteRegister; 
    wire [63:0] WriteData; 
    wire [63:0] ReadData1; 
    wire [63:0] ReadData2; 
    wire [63:0] InsSignExtendOut;
    
    Registers u_Registers(
        .readRegister1(ReadRegister1In),
        .readRegister2(ReadRegister2In),
        .writeRegister(WriteRegister),
        .writeData(WriteData),
        
        .regWrite(0),
        
        .readData1(ReadData1),
        .readData2(ReadData2)
    );
    
    assign #1 InsSignExtendOut = { {32{IFIDIMOut[31] }}, IFIDIMOut[31:0] };
    
    wire RegWriteControlOut;
    wire BranchControlOut;
    wire [1:0] ALUOpControlOut;
    wire ALUSrcOut;
    
    Control u_Control(
        .Instruction(IFIDIMOut),
        
        .RegWrite(RegWriteControlOut),
        .Branch(BranchControlOut),
        .ALUOp(ALUOpControlOut),
        .ALUSrc(ALUSrcOut)
    );
    //////////////////////////////////
    //ID/EX
    wire IDEXRegWriteOut;
    wire IDEXBranchOut;
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

        .IDEXRegWriteIn(RegWriteControlOut),
        .IDEXRegWriteOut(IDEXRegWriteOut),
        
        .IDEXBranchIn(BranchControlOut),
        .IDEXBranchOut(IDEXBranchOut),
        
        .IDEXALUOpIn(ALUOpControlOut),
        .IDEXALUOpOut(IDEXALUOpOut),
        
        .IDEXALUSrcIn(ALUSrcOut),
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
    reg [63:0] IDEXSignExtendOutOutShifted;
    always @(*)
    begin
            IDEXSignExtendOutOutShifted = #1 (IDEXSignExtendOutOut << 2);
    end
    
    Add u_PCAdd2(
        .inputA(IDEXPCOut),
        .inputB(IDEXSignExtendOutOutShifted), //Shift Left 2
        
        .outputData(PC2AddOut)
    );
    
    wire [63:0] ALUMuxOut;
    Mux u_ALUMux(
        .inputA(IDEXReadData2Out),
        .inputB(IDEXSignExtendOutOut),
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
        //Control 
        .ALUControl(ALUControlOut),
        //Output Data 
        .ALUOutput(ALUResult),
        .Zero(ALUZeroOut)
    );
    //////////////////////////////////
    //EX/MEM
    wire EXMEMRegWriteOut;
    wire EXMEMBranchOut;
    wire [63:0] EXMEMPC2AddOut;
    wire EXMEMALUZeroOut;
    wire [63:0] EXMEMALUResultOut;
    wire [63:0] EXMEMReadData2Out;
    wire [4:0] EXMEMWriteRegisterOut;
    
    EX_MEM u_EX_MEM(
        .EXMEMRegWriteIn(IDEXRegWriteOut),        
        .EXMEMRegWriteOut(EXMEMRegWriteOut),        
        .EXMEMBranchIn(IDEXBranchOut),
        .EXMEMBranchOut(EXMEMBranchOut),
         
        .EXMEMPC2AddIn(PC2AddOut),
        .EXMEMPC2AddOut(EXMEMPC2AddOut),
        
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
    
    //////////////////////////////////
    //MEM/WB
    
    //////////////////////////////////
    //WB
    
    //////////////////////////////////
endmodule
