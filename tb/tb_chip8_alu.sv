`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2026 17:35:46
// Design Name: 
// Module Name: tb_chip8_alu
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


module tb_chip8_alu();

    // 1. Create virtual cables to connect to ALU.
    logic [7:0] tb_Vx_in;
    logic [7:0] tb_Vy_in;
    logic [3:0] tb_ALU_op;
    logic [7:0] tb_ALU_out;
    logic       tb_vf_out;

    // 2. Connecting tb virtual cables to ALU virtual cables.
    chip8_alu uut (
        .Vx_in(tb_Vx_in),
        .Vy_in(tb_Vy_in),
        .ALU_op(tb_ALU_op),
        .ALU_out(tb_ALU_out),
        .vf_out(tb_vf_out)
    );

    // 3. Injecting electrical pulses over time
    initial begin
        // Defining initial values for V1 = 170 (10101010) and V2 = 85 (01010101).
        tb_Vx_in = 8'b10101010; 
        tb_Vy_in = 8'b01010101; 

        //Test 1:(ASSIGN)
        tb_ALU_op = 4'h0;
        #10; // Esperar 10 nanosegundos para o sinal propagar

        // Test 2:(OR)
        tb_ALU_op = 4'h1;
        #10;

        // Test 3:(AND)
        tb_ALU_op = 4'h2;
        #10;

        // Test 4:(XOR)
        tb_ALU_op = 4'h3;
        #10;

        // Stop simulator
        $finish;
    end

endmodule