`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2024 15:27:26
// Design Name: 
// Module Name: pwm_ppm
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


module pwm_ppm(
    input clk,               // Clock input
    input rst,               // Reset input
    input [3:0] duty_cycle,  // 4-bit Duty cycle input
    output reg pwm_out,      // PWM output
    output reg ppm_out,      // PPM output
    output reg [3:0] counter // 4-bit counter for debugging
);

    reg ppm_clk;             // Internal signal for PPM clock
    reg pwm_ff;              // Flip-flop to store PWM state

    // Comparator to check if counter < duty_cycle
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 4'd0;
            pwm_out <= 1'b0;
            ppm_clk <= 1'b0;
            ppm_out <= 1'b0;
        end else begin
            // Counter logic
            if (counter == 4'd15)  // Maximum value for 4-bit counter
                counter <= 4'd0;
            else
                counter <= counter + 1;

            // PWM logic: Generate PWM based on duty cycle
            pwm_out <= (counter < duty_cycle);

            // Generate PPM clock: Toggle when counter reaches zero
            ppm_clk <= (counter == 4'd0) ? ~ppm_clk : ppm_clk;

            // Generate PPM Output based on PPM clock and counter position
            ppm_out <= (ppm_clk && (counter == duty_cycle)) ? pwm_ff : 1'b0;
        end
    end

endmodule
