`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/19 16:56:28
// Design Name: 
// Module Name: iMem
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


module iMem(
    input clk,
    input rst_n,
    input [31:0]addr,
    output [31:0]data
    );
    reg[7:0] imem[255:0];
    initial begin
        $readmemh("D:/Computing/VIVADO/CPU/instruction.txt",imem);
    end
    wire [7:0]W_addr=addr[7:0];
    assign data={imem[W_addr],imem[W_addr+1],imem[W_addr+2],imem[W_addr+3]};
endmodule
