`timescale 1ns / 1ps
module tlc(
    input clk, reset, x,           
    output reg [1:0] hwy, cntry    
    );
    
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, 
              s3 = 3'b011, s4 = 3'b100, s5 = 3'b101;
    
    parameter red = 2'b00, yellow = 2'b01, green = 2'b10;
    
    reg [2:0] state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= s0;
        else
            state <= next_state;
    end
    
    always @(state or x) begin
        case (state)
            s0: next_state = (x) ? s1 : s0;
            s1: next_state = s2;
            s2: next_state = s3;
            s3: next_state = (x) ? s3 : s4;
            s4: next_state = s5;
            s5: next_state = s0;
            default: next_state = s0;
        endcase
    end
    
    always @(state) begin
        case (state)
            s0: begin 
                hwy = green; 
                cntry = red; 
            end
            s1: begin 
                hwy = yellow; 
                cntry = red; 
            end
            s2: begin 
                hwy = red; 
                cntry = red; 
            end
            s3: begin 
                hwy = red; 
                cntry = green; 
            end
            s4: begin 
                hwy = red; 
                cntry = yellow; 
            end
            s5: begin 
                hwy = red; 
                cntry = red; 
            end
        endcase
    end
endmodule
