`timescale 1ns / 1ps
module tlc_tb( );
    reg clk;             
    reg reset;           
    reg x;                 
    wire [1:0] hwy;        
    wire [1:0] cntry;       
    
    tlc uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .hwy(hwy),
        .cntry(cntry)
    );
    
    always #10 clk = ~clk;
    
    task apply_reset;
        begin
            reset = 1;
            #40;      
            reset = 0; 
        end
    endtask
    
    initial begin
        clk = 0;
        reset = 0;
        x = 0;
        
        apply_reset;
    
        $display("Test case 1: No traffic on country road (x = 0)");
        x = 0;
        #300; 
    
        $display("Test case 2: Traffic detected on country road (x = 1)");
        x = 1;
        #300; 
    
        $display("Test case 3: Traffic stops on country road (x = 0)");
        x = 0;
        #300;
    
        $display("Simulation complete.");
        $stop;
    end
    
    initial begin
        $monitor("Time: %t | State: Highway=%b Country=%b | Sensor x=%b", 
                 $time, hwy, cntry, x);
    end
endmodule
