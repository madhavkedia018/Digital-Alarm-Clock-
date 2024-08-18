`timescale 1ns / 1ps
module clkgen_200khz(
    input clk_100MHz,
    output clk_200kHz
    );
    
    reg [7:0] counter = 8'h00;
    reg clk_reg = 1'b1;
    
    always @(posedge clk_100MHz) begin
        if(counter == 249) begin
            counter <= 8'h00;
            clk_reg <= ~clk_reg;
        end
        else
            counter <= counter + 1;
    end
    
    assign clk_200kHz = clk_reg;
    
endmodule
