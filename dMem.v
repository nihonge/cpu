`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/19 19:22:35
// Design Name: 
// Module Name: dMem
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


module dMem(
    input clk,
    input rst_n,
    input we,
    input [31:0]addr,
    input [31:0]w_data,
    output [31:0]r_data//读出的数据
    );
    reg[7:0] dmem[255:0];
    initial begin
        $readmemb("D:/Computing/VIVADO/CPU/data.txt",dmem);
    end
    wire [7:0]W_addr=addr[7:0];
    assign r_data={dmem[W_addr+3],dmem[W_addr+2],dmem[W_addr+1],dmem[W_addr]};
    
    always@(posedge clk)begin
        if(we)begin
            dmem[W_addr+3]<=w_data[31:24];
            dmem[W_addr+2]<=w_data[23:16];
            dmem[W_addr+1]<=w_data[15:8];
            dmem[W_addr]<=w_data[7:0];
        end
    end
endmodule
