`timescale 1ns / 1ps

module br_unit(
    input clk,
    input rst_n,
    input [1:0]cB,
    input [3:0]pc_high,
    input [15:0]i_offset,
    input [25:0]i_target,
    input [31:0]rsdata,
    input [31:0]rtdata,
    output jmp,
    output branch,
    output [31:0] offset,
    output [31:0] target
);
    assign jmp=(cB==2'b10)?1:0;
    assign branch=((cB==2'b01)&&(rsdata==rtdata))?1:0;
    assign offset=i_offset;
    assign target=i_target;
endmodule
