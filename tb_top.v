`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/22 21:25:20
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    reg clk,rst_n;
    initial begin
    clk=0;rst_n=0;
    #10 rst_n=1;
    end
    always #10 clk=~clk;
    top top(
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule
