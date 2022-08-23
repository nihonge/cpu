`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/19 15:26:46
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control(
    input [5:0] opcode,
    input [5:0] func,
    output c1,
    output c2,
    output c3,
    output [3:0]cA,//ALU使能
    output [1:0]cB,//br使能
    output dmem_we,
    output reg_we
    );
    wire [3:0]inst_type;//0:Lui，1:Addi，2:Add，3:Lw，4:Sw，5:Beq，6:J,7:Sllv 8:reserved 15:执行完毕
    assign inst_type=(opcode==6'b001000)?1:
                    (opcode==6'b001111)?0:
                    (opcode==6'b000010)?6:
                    (opcode==6'b100011)?3:
                    (opcode==6'b101011)?4:
                    (opcode==6'b000100)?5:
                    (opcode==6'b000000)?(
                    (func==6'b100000)?2:
                    (func==6'b000100)?7:8):8;
    assign c1=(inst_type==0||inst_type==1||inst_type==3||inst_type==4)?1:0;
    assign c2=(inst_type==2||inst_type==7)?1:0;
    assign c3=(inst_type==3)?1:0;
    assign dmem_we=(inst_type==4)?1:0;
    assign reg_we=(inst_type==0||inst_type==1||inst_type==2||inst_type==3||inst_type==7)?1:0;
    assign cA=(inst_type==0)?4'b0001:
            (inst_type==1||inst_type==3||inst_type==4)?4'b0010:
            (inst_type==2)?4'b0100:
            (inst_type==7)?4'b1000:4'b0000;
    assign cB=(inst_type==5)?2'b01:
            (inst_type==6)?2'b10:2'b00;
endmodule
