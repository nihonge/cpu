`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/21 12:11:30
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input rst_n,
    input jmp,
    input branch,
    input [31:0] offset,
    input [31:0] target,
    output [31:0]pc_value
    );
    reg [31:0]R_pc;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            R_pc<=32'b0;
        end
        else begin//beq、j指令处理代码
        if(branch==1)begin
            R_pc<={{(14){offset[15]}},offset[15:0],2'b00}+R_pc+4;//offset左移两位并进行符号扩展
        end
        else if(jmp==1)begin
            R_pc<={pc_value[31:28],target[25:0],2'b00}-32'h00400000;//减去指令存储基地址
        end
        else
        R_pc<=R_pc+4;//自动加4
        end      
    end
    assign pc_value=R_pc;
endmodule
