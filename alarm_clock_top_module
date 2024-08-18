`timescale 1ns / 1ps
module a_clock3 (
    input reset,            // Active high reset pulse
    input wire resett,          // active high reset for temperature sensor
    input clk,             // 100MHz input clock
    inout SDA,           
    input [1:0] H_in1,     // Most significant digit of current hour
    input [3:0] H_in0,     // Least significant digit of current hour
    input [3:0] M_in1,     // Most significant digit of current minute
    input [3:0] M_in0,     // Least significant digit of current minute
    input STOP_al,         // Stop alarm input
    input AL_ON,           // Alarm activation input
    input snooze,            // Snooze input
    input LD_alarm,          
    output [5:0]AL,       
    output [7:0]AN,         // Anodes (active low)
    output [6:0]seg,        // segment pins (active low)
    output AUD_PWM,
    output AUD_SD,
    output SCL,
    output [7:0]led        // shows binary temperature in celcius 
);

parameter MAX_ALARMS = 4;
parameter SNOOZE_DURATION = 30;
parameter ALARM_DURATION = 15; 
integer i;

// Internal signals
reg clk_1s; 
//reg clk_200khz;                                        // 1-s clock                                    
reg [77:0] tmp_1s;                                // Count for creating 1-s clock                     
reg [5:0] tmp_hour, tmp_minute, tmp_second;     // Counter for clock hour, minute, and second
reg [3:0] c_hour1;
reg [3:0] c_hour0;
reg [3:0] c_min1;
reg [3:0] c_min0;
reg [3:0] c_sec1;
reg [3:0] c_sec0;
reg snooze_active;                              // Flag to indicate if snooze is active
reg [10:0] snooze_counter;                      // Counter for snooze duration

// Alarm registers
reg [3:0] alarm_hour1[0:MAX_ALARMS-1];
reg [3:0] alarm_hour0[0:MAX_ALARMS-1];
reg [3:0] alarm_min1[0:MAX_ALARMS-1];
reg [3:0] alarm_min0[0:MAX_ALARMS-1];
reg [3:0] alarm_sec1[0:MAX_ALARMS-1];
reg [3:0] alarm_sec0[0:MAX_ALARMS-1];
reg [10:0] alarm_duration_counter;             // Countdown timer for each activated alarm
reg Alarm;


reg [3:0] ld_alarm_hour1;
reg [3:0] ld_alarm_hour0;
reg [3:0] ld_alarm_min1;
reg [3:0] ld_alarm_min0;
reg [3:0] ld_alarm_sec1;
reg [3:0] ld_alarm_sec0;


// common anode seven segment enabler 
 reg [4:0] digit_holder;
 wire [2:0] rr;
 
 
    wire sda_dir;                   // direction of SDA signal - to or from master
    wire w_200khz;                  // 200kHz SCL
    wire [7:0] w_data;              // 8 bits of temperature data




// Function to calculate modulus 10
function [3:0] mod_10;
    input [5:0] number;
    begin
        mod_10 = (number >= 50) ? 5 : ((number >= 40) ? 4 : ((number >= 30) ? 3 : ((number >= 20) ? 2 : ((number >= 10) ? 1 : 0))));
    end
endfunction

// Clock operation
always @(posedge clk_1s or posedge reset) begin
    if (reset) begin // Reset high => initialize clock and alarm
        // Reset clock to user-defined time
        tmp_hour <= H_in1 * 10 + H_in0;
        tmp_minute <= M_in1 * 10 + M_in0;
        tmp_second <= 0;
        // Initialize snooze flags and counter
        snooze_active <= 0;
        snooze_counter <= 0;
        // Initialize alarms
        for (i = 0; i < MAX_ALARMS; i = i + 1) begin
            alarm_hour1[i] <= 4'b0000;
            alarm_hour0[i] <= 4'b0000;
            alarm_min1[i] <= 4'b0000;
            alarm_min0[i] <= 4'b0000;

            Alarm <= 0;
            alarm_duration_counter <= 0; // Initialize alarm duration counters
        end
    end
    
     else begin
        // Clock increment
        tmp_second <= tmp_second + 1;
        if (tmp_second >= 59) begin
            tmp_minute <= tmp_minute + 1;
            tmp_second <= 0;
            if (tmp_minute >= 59) begin
                tmp_hour <= tmp_hour + 1;
                tmp_minute <= 0;
                if (tmp_hour >= 23) begin
                    tmp_hour <= 0;
                end
            end
        end
        

        if(!AL_ON) Alarm <= 0;
        else begin  
           alarm_hour1[0] = 1;  alarm_hour0[0] = 5; alarm_min1[0] = 2; alarm_min0[0] = 0;  alarm_sec1[0] = 0; 
           alarm_hour1[1] = 1;  alarm_hour0[1] = 5; alarm_min1[1] = 2; alarm_min0[1] = 1;  alarm_sec1[1] = 0; 
           alarm_hour1[2] = 1;  alarm_hour0[2] = 5; alarm_min1[2] = 2; alarm_min0[2] = 2;  alarm_sec1[2] = 0; 
           alarm_hour1[3] = 1;  alarm_hour0[3] = 5; alarm_min1[3] = 2; alarm_min0[3] = 3;  alarm_sec1[3] = 0; 
             
      if(LD_alarm)
       begin 
       ld_alarm_hour1 <= H_in1;   ld_alarm_hour0 <= H_in0;    ld_alarm_min1 <= M_in1;  ld_alarm_min0 <= M_in0; ld_alarm_sec1 <= 4'b0000; 
          end
          
          
            
        if(STOP_al) Alarm<=0;
        
        // Check for alarm activation
        for (i = 0; i < MAX_ALARMS; i = i + 1) begin
            if ({{alarm_hour1[i], alarm_hour0[i], alarm_min1[i], alarm_min0[i],alarm_sec1[i]} == {c_hour1, c_hour0, c_min1, c_min0,c_sec1}}
            || {{ld_alarm_hour1,ld_alarm_hour0,ld_alarm_min1,ld_alarm_min0,ld_alarm_sec1}=={c_hour1, c_hour0, c_min1, c_min0,c_sec1}})
              begin
                if (!snooze_active) begin
                    Alarm <= 1; // Activate alarm
                    alarm_duration_counter <= ALARM_DURATION; // Start alarm duration counter
                end
            end
        end
        
        // Check for alarm duration expiration
        
            if (alarm_duration_counter > 0)  alarm_duration_counter <= alarm_duration_counter - 1; // Decrement alarm duration counter
            
            else if (alarm_duration_counter == 0)   Alarm <= 0;  // Deactivate alarm after duration expires
               
               
        // Check for snooze
        if (snooze && !snooze_active) begin
            snooze_active <= 1;                // Activate snooze
            snooze_counter <= SNOOZE_DURATION; // Set snooze duration
                                               // Deactivate all alarms during snooze
            Alarm <= 0;                        // Deactivate all alarms during snooze
        end
        
        if (snooze_active && snooze_counter > 0) begin
            snooze_counter <= snooze_counter - 1;    // Decrement snooze counter
        end else if (snooze_active && snooze_counter == 0) begin
            snooze_active <= 0;                     // Deactivate snooze
            Alarm <= 1;
            alarm_duration_counter <= ALARM_DURATION;     end
        end 
    end
end

// Create 1-second clock
always @(posedge clk or posedge reset) begin
    if (reset) begin
        tmp_1s <= 0;
        clk_1s <= 0;
    end else begin
        tmp_1s <= tmp_1s + 1;
        if (tmp_1s <= 50000000) begin
            clk_1s <= 0;
        end else if (tmp_1s >= 100000000) begin
            clk_1s <= 1;
            tmp_1s <= 1;
        end else begin
            clk_1s <= 1;
        end
    end
end

// create 200KHz clock for I2C interface
 clkgen_200khz cgen(
        .clk_100MHz(clk),
        .clk_200kHz(w_200khz)
    ); 
   

// Output of the clock
always @(*) begin
    c_hour1 = mod_10(tmp_hour); 
    c_hour0 = tmp_hour - c_hour1 * 10; 
    c_min1 = mod_10(tmp_minute);  
    c_min0 = tmp_minute - c_min1 * 10;
    c_sec1 = mod_10(tmp_second);
    c_sec0 = tmp_second - c_sec1 * 10;
   // assign AL[0] = Alarm;
end

  always @(posedge clk)begin
        case(rr)
            3'b000: digit_holder <= c_hour1;
            3'b001: digit_holder <= c_hour0;
            3'b010: digit_holder <= 5'b10001;
            3'b011: digit_holder <= c_min1;
            3'b100: digit_holder <= c_min0;
            3'b101: digit_holder <= 5'b10001;
            3'b110: digit_holder <= c_sec1;
            3'b111: digit_holder <= c_sec0;
            default: digit_holder <= 5'b10000;
        endcase
    end


// Output of the clock

  disp_7_seg disp(.clk(clk), .digit_holder(digit_holder), .refresh_rate(rr), .AN(AN), .seg(seg));
  
  play_sound music(.clk(clk), .Alarm(Alarm), .AUD_PWM(AUD_PWM), .AUD_SD(AUD_SD));
  
  find_temp tempo( .clk_200kHz(w_200khz), .reset(resett), .temp_data(w_data), .SDA(SDA), .SDA_dir(sda_dir), .SCL(SCL) );
   
   
assign led = w_data;         // led's will show the temperature in degree celcius 
         
  // choose LED colour of your preference for the Alarm       
assign AL[0] = Alarm;        // red
assign AL[1] = 0;
assign AL[2] = Alarm;       // blue 
assign AL[3] = 0;
assign AL[4] = 0;
assign AL[5] = 0;

endmodule


