`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/19 10:35:18
// Design Name: 
// Module Name: regs
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

//寄存器堆，32个32位寄存器
module regheap(
    input clk,
    input rst_n,
    input reg_we,//写使能
    input [4:0]rs_addr,//rs寄存器地址
    input [4:0]rt_addr,
    input [4:0]wb_addr,//写回地址
    input [31:0]wb_data,
    output [31:0]rs_data,//寄存器数据
    output [31:0]rt_data
    );
    reg[31:0] regs[31:0];//32个32位
    integer i;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            for(i=0;i<32;i=i+1)regs[i]<=32'b0;
        end
        else if(reg_we)regs[wb_addr]<=wb_data;
    end
    assign rs_data=regs[rs_addr];
    assign rt_data=regs[rt_addr];
endmodule
