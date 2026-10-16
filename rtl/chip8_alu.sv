`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Guilherme Costa
// 
// Create Date: 07.10.2026 15:34:03
// Design Name: 
// Module Name: chip8_alu
// Project Name: CHIP8_FPGA_ZyboZ7
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

//The Opcode table used for ALU operations only goes from 8xy0 to 8xyE, meaning it
//can do 15 different operations (including 0). 
module chip8_alu(

input logic [7:0] Vx_in,    //Value of first register
input logic [7:0] Vy_in,    //Value of second register
input logic [3:0] ALU_op,   //Operation selector, from familiy 8yxN opcode
output logic [7:0] ALU_out, //main result is stored in this variable
output logic vf_out         //1-bit flag to signal carry or borrow or shifted bits 

 );
    
    always_comb begin
    
        ALU_out = 8'h00;
        vf_out = 1'b0;
    
    
        //all opcodes come from the family 8xyN, but it only receives the N character 
        //from the control unit for identification of operation.
        case (ALU_op)
        
                4'h0: begin //(Assign): LD Vx, Vy -> Stores the value of register Vy in register Vx.
                    ALU_out = Vy_in;
                end
                
                4'h1: begin //(OR): OR Vx, Vy -> Performs a bitwise OR on the values of Vx 
                //and Vy, then stores the result in Vx. A bitwise OR compares the corrseponding
                //bits from two values, and if either bit is 1, then the same bit in the result
                //is also 1. Otherwise, it is 0.
                
                    ALU_out = Vx_in | Vy_in;
                
                end
        
                4'h2: begin //(AND): AND Vx, Vy -> Performs a bitwise AND on the values of Vx
                //and Vy, then stores the result in Vx. A bitwise AND compares the corrseponding
                //bits from two values, and if both bits are 1, then the same bit in the result
                //is also 1. Otherwise, it is 0.
                
                    ALU_out = Vx_in & Vy_in;
                
                end
                
                4'h3: begin //(XOR): XOR Vx, Vy -> Performs a bitwise exclusive OR on the values
                //of Vx and Vy, then stores the result in Vx. An exclusive OR compares the
                //corresponding bits from two values, and if the bits are not both the same, then
                //the corresponding bit in the result is set to 1. Otherwise, it is 0.
                
                    ALU_out = Vx_in ^ Vy_in;
                end
                
                4'h4: begin //(ADD): ADD Vx, Vy ;  Vx = Vx + Vy, Set VF = Carry
                //The values of Vx and Vy are added together. If the result is greater
                //than 8 bits (i.e., > 255,) VF is set to 1, otherwise 0. Only the lowest
                //8 bits of the result are kept, and stored in Vx.
                
                    {vf_out, ALU_out} = Vx_in + Vy_in;

                 end
                 
                 4'h5: begin //(SUB): SUB Vx, Vy; Vx = Vx - Vy, set VF = NOT borrow
                 //If Vx > Vy, then VF is set to 1, otherwise 0. Then Vy is subtracted
                 //from Vx, and the results stored in Vx.

                    ALU_out = Vx_in - Vy_in;    //ex: 3-5 = -2 == 256-2 = 254.
                    vf_out = (Vx_in >= Vy_in);  //if Vx >= Vy, vf_out = 1; else vf_out=0;
                   
                 end
                 
                 4'h6: begin //(SHR): SHR Vx; Operation SHIFT RIGHT
                 //If the least-significant bit of Vx is 1, then VF is set to 1,
                 //otherwise 0. Then Vx is divided by 2.
                 
                     vf_out = Vx_in[0];
                     ALU_out = Vx_in >> 1;

                 end
                 
                 4'h7: begin //(SUBN): SUBN Vx, Vy; Vx = Vy - Vx, set VF = NOT borrow
                 //If Vy > Vx, then VF is set to 1, otherwise 0. Then Vx is subtracted
                 //from Vy, and the results stored in Vx.

                    ALU_out = Vy_in - Vx_in;    //ex: 3-5 = -2 == 256-2 = 254.
                    vf_out = (Vy_in >= Vx_in);  //if Vy >= Vx, vf_out = 1; else vf_out=0;

                 end
                 
                 
                 4'hE: begin //(SHL): SHL Vx; Operation SHIFT LEFT
                 //If the most-significant bit of Vx is 1, then VF is set to 1,
                 //otherwise 0. Then Vx is divided by 2.
                 
                     vf_out = Vx_in[7];
                     ALU_out = Vx_in << 1;
    
                 end
                
                
                default: begin
                ALU_out = 8'h00;
                vf_out  = 1'b0;
                end
            
        endcase
    
    
    end
endmodule
