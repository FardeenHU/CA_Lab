`timescale 1ns / 1ps

// ============================================================================
// 1. TOP-LEVEL MODULE (The Motherboard)
// ============================================================================
module top_alu_system (
    input wire clk,
    input wire pbin,
    input wire [15:0] physical_sw,
    output wire [15:0] physical_leds
);
    wire rst_clean;  
    wire [31:0] switch_data;  
    reg [31:0] led_write_data;

    debouncer rst_db (  
        .clk(clk), .pbin(pbin), .pbout(rst_clean)  
    ); 

    leds switch_reader (  
        .clk(clk), .rst(rst_clean), .btns(16'd0), .writeData(32'd0),  
        .writeEnable(1'b0), .readEnable(1'b1), .memAddress(30'd0),       
        .switches(physical_sw), .readData(switch_data)  
    );

    switches led_writer (  
        .clk(clk), .rst(rst_clean), .writeData(led_write_data),  
        .writeEnable(1'b1), .readEnable(1'b0), .memAddress(30'd0),  
        .readData(), .leds(physical_leds)      
    );

    // Fixed Operands for Lab 6
    wire [31:0] operand_a = 32'h10101010;  
    wire [31:0] operand_b = 32'h01010101;
    wire [31:0] alu_result;  
    wire alu_zero;

    ALU alu_inst (  
        .A(operand_a), .B(operand_b),  
        .ALUControl({1'b0, switch_data[2:0]}),  // Lower 3 switches control ALU  
        .ALUResult(alu_result), .Zero(alu_zero)  
    );

    always @(*) begin  
        led_write_data = {16'd0, alu_result[15:0]};  
    end
endmodule

// ============================================================================
// 2. ALU MODULE (The Calculator)
// ============================================================================
module ALU (
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [3:0]  ALUControl,
    output reg  [31:0] ALUResult,
    output wire        Zero
);
    localparam ALU_ADD = 4'b0000, ALU_SUB = 4'b0001, ALU_AND = 4'b0010, 
               ALU_OR  = 4'b0011, ALU_XOR = 4'b0100, ALU_SLL = 4'b0101, ALU_SRL = 4'b0110;

    always @(*) begin  
        case (ALUControl)  
            ALU_ADD: ALUResult = A + B;  
            ALU_SUB: ALUResult = A - B;  
            ALU_AND: ALUResult = A & B;  
            ALU_OR:  ALUResult = A | B;  
            ALU_XOR: ALUResult = A ^ B;  
            ALU_SLL: ALUResult = A << B[4:0];   
            ALU_SRL: ALUResult = A >> B[4:0];   
            default: ALUResult = 32'b0;  
        endcase  
    end
    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
endmodule

// ============================================================================
// 3. DEBOUNCER MODULE (Hardware Interface)
// ============================================================================
module debouncer (
    input wire clk, input wire pbin, output wire pbout
);
    reg [19:0] counter = 0;
    reg state = 0;
    always @(posedge clk) begin
        if (pbin !== state) begin
            counter <= counter + 1'b1;
            if (counter == 20'hFFFFF) begin
                state <= pbin;
                counter <= 0;
            end
        end else counter <= 0;
    end
    assign pbout = state;
endmodule

// ============================================================================
// 4. LEDS MODULE (Switch Reader Interface)
// ============================================================================
module leds (
    input wire clk, input wire rst, input wire [15:0] btns, input wire [31:0] writeData,
    input wire writeEnable, input wire readEnable, input wire [29:0] memAddress,
    input wire [15:0] switches, output reg [31:0] readData
);
    always @(posedge clk or posedge rst) begin
        if (rst) readData <= 32'd0;
        else if (readEnable) readData <= {16'd0, switches};
    end
endmodule

// ============================================================================
// 5. SWITCHES MODULE (LED Writer Interface)
// ============================================================================
module switches (
    input wire clk, input wire rst, input wire [31:0] writeData, input wire writeEnable,
    input wire readEnable, input wire [29:0] memAddress, output reg [31:0] readData,
    output reg [15:0] leds
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            leds <= 16'd0; readData <= 32'd0;
        end else if (writeEnable) leds <= writeData[15:0];
    end
endmodule