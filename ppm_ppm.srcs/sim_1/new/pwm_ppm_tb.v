`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2024 15:29:59
// Design Name: 
// Module Name: pwm_ppm_tb
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


module pwm_ppm_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [3:0] duty_cycle;   // 4-bit Duty cycle input

    // Outputs
    wire pwm_out;
    wire ppm_out;
    wire [3:0] counter;

    // Instantiate the PWM and PPM module
    pwm_ppm uut (
        .clk(clk),
        .rst(rst),
        .duty_cycle(duty_cycle), // External 4-bit duty cycle input
        .pwm_out(pwm_out),
        .ppm_out(ppm_out),
        .counter(counter)
    );

    // Clock generation: 10ns period (100 MHz clock)
    always #5 clk = ~clk; // Toggle clock every 5 ns

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        duty_cycle = 4'd8; // Example duty cycle (50%)
        #20 rst = 0;       // Release reset after 20 ns

        // Modify duty cycle for testing
       // #100 duty_cycle = 4'd4;  // Change duty cycle to 25%
        //#100 duty_cycle = 4'd12; // Change duty cycle to 75%

        // Extend observation period (50,000 ns)
        #50000;

        $finish; // End the simulation
    end
endmodule
