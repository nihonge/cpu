`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/19 11:00:04
// Design Name: 
// Module Name: ALU
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


module ALU(
    input clk,
    input rst_n,
    input [3:0] ctrl,
    input [31:0] num1,//rs
    input [31:0] num2,//rt
    output [31:0]ans,
    output error,
    output [1:0]e_message,//错误信息 0:正确 1:add溢出 2:虚拟地址错误 3:没有该指令
    output done
    );
    reg[1:0] R_e_message;
    reg R_done;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            R_done<=1'b0;
            R_e_message<=2'b0;
        end
    end
    assign ans=(ctrl==4'b0001)?({num2[15:0],16'b0}):
                (ctrl==4'b0010)?({{(16){num2[15]}},num2[15:0]}+num1):
                (ctrl==4'b0100)?(num1+num2):
                (ctrl==4'b1000)?(num2<<num1[4:0]):0;
    assign e_message=R_e_message;
    assign done=R_done;
endmodule
