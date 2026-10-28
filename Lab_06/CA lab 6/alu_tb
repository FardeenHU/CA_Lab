`timescale 1ns / 1ps

module ALU_tb;
    reg [31:0] A;  
    reg [31:0] B;  
    reg [3:0] ALUControl;  
    wire [31:0] ALUResult;  
    wire Zero;

    // Instantiate ONLY the ALU for mathematical testing
    ALU uut (  
        .A(A), .B(B), .ALUControl(ALUControl), .ALUResult(ALUResult), .Zero(Zero)  
    );

    initial begin  
        A = 32'h00000010; B = 32'h00000005; ALUControl = 4'b0000; #10; // ADD
        A = 32'h00000010; B = 32'h00000010; ALUControl = 4'b0001; #10; // SUB (Zero=1)
        A = 32'h0000FFFF; B = 32'h00000F0F; ALUControl = 4'b0010; #10; // AND
        A = 32'h0000F0F0; B = 32'h00000F0F; ALUControl = 4'b0011; #10; // OR
        A = 32'hFFFFFFFF; B = 32'h0000FFFF; ALUControl = 4'b0100; #10; // XOR
        A = 32'h00000001; B = 32'h00000002; ALUControl = 4'b0101; #10; // SLL
        A = 32'h00000008; B = 32'h00000002; ALUControl = 4'b0110; #10; // SRL
        $finish;  
    end
endmodule