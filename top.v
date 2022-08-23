`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/21 11:58:43
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst_n
    );
    wire jmp;
    wire[31:0]offset;
    wire branch;
    wire [31:0]target;
    wire [31:0]pc_value;
    wire [31:0]inst;
    pc pc(
        .clk(clk),
        .rst_n(rst_n),
        .jmp(jmp),
        .branch(branch),
        .offset(offset),
        .target(target),
        
        .pc_value(pc_value)
    );
////////////////////////////////////////////////////////////////////////
    iMem imem(
        .clk(clk),
        .rst_n(rst_n),
        .addr(pc_value),
        .data(inst)
    );
////////////////////////////////////////////////////////////////////////
    wire c1,c2,c3,dmem_we,reg_we;
    wire [3:0]cA;
    wire [1:0]cB;
    control ctrl(
        .opcode(inst[31:26]),
        .func(inst[5:0]),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .cA(cA),
        .cB(cB),
        .dmem_we(dmem_we),
        .reg_we(reg_we)
    );    
////////////////////////////////////////////////////////////////////////
    wire[4:0]wb_addr;
    wire[31:0]wb_data;
    wire [31:0]rs_data,rt_data;
    wire[31:0]ans;
    wire[31:0] r_data;
    regheap regheap(
        .clk(clk),
        .rst_n(rst_n),
        .reg_we(reg_we),
        .rs_addr(inst[25:21]),
        .rt_addr(inst[20:16]),
        .wb_addr(wb_addr),
        .wb_data(wb_data),
        .rs_data(rs_data),
        .rt_data(rt_data)
    );
////////////////////////////////////////////////////////////////////////
    wire error;
    wire [1:0]e_message;
    wire done;
    wire [31:0]num2; 
    ALU alu(
        .clk(clk),
        .rst_n(rst_n),
        .ctrl(cA),
        .num1(rs_data),
        .num2(num2),
        .ans(ans),
        .error(error),
        .e_message(e_message),
        .done(done)
    );
////////////////////////////////////////////////////////////////////////
    dMem dmem(
        .clk(clk),
        .rst_n(rst_n),
        .we(dmem_we),
        .addr(ans),
        .w_data(rt_data),
        .r_data(r_data)
    );
////////////////////////////////////////////////////////////////////////
    br_unit br_unit(
        .clk(clk),
        .rst_n(rst_n),
        .cB(cB),
        .pc_high(inst[31:28]),
        .i_offset(inst[15:0]),
        .i_target(inst[25:0]),
        .rsdata(rs_data),
        .rtdata(rt_data),
        .jmp(jmp),
        .branch(branch),
        .offset(offset),
        .target(target)
    );
    assign num2=c1?inst[15:0]:rt_data;
    assign wb_addr=c2?inst[15:11]:inst[20:16];
    assign wb_data=c3?r_data:ans; 
////////////////////////////////////////////////////////////////////////
endmodule
