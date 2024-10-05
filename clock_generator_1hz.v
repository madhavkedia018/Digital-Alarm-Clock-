`timescale 1ns / 1ps
module clkgen_1hz(
    input clk_100MHz,
    output clk_1Hz
    );
    
    reg [31:0] counter = 32'h00;
    reg clk_reg = 1'b1;
    
    always @(posedge clk_100MHz) begin
        if(counter == 49999999) begin
            counter <= 32'h00;
            clk_reg <= ~clk_reg;
        end
        else
            counter <= counter + 1;
    end
    
    assign clk_1Hz = clk_reg;
    
endmodule
