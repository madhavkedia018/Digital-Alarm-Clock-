# Digital Alarm Clock
The digital alarm clock symbolizes the evolution of timekeeping mechanisms, marking a tran-
sition from traditional mechanical clocks to sophisticated electronic devices. Its compact design,precise timekeeping capabilities, and customizable alarm functionalities have revolutionized the
way individuals manage their schedules and wake up each day.


By developing a digital alarm clock using Verilog and FPGA, this project demonstrates the
application of digital electronics principles to real-world problems. It serves as a platform to
explore and understand fundamental concepts in digital design

## Introduction
In the fast-paced and technology-driven world we live in, digital devices have become an integral part
of our daily lives. One such device that has stood the test of time and continues to be a staple
in households worldwide is the alarm clock. Alarm clocks play a crucial role in helping individuals
manage their time, ensuring they wake up promptly and stay organized throughout the day. The
traditional analog alarm clocks have evolved into digital counterparts, offering enhanced features and
functionalities.

## Objectives
1. Implement a real-time clock that displays hours, minutes, and seconds on a 7-segment display.
2. Design a user-friendly interface to set the time and alarm. This can include using buttons,
switches, or any other input devices available on the FPGA board.
3. Implement a snooze feature that allows the user to delay the alarm by a specified amount of
time.
4. Extend the design to allow the user to set and manage multiple alarms.
5. Evaluate user satisfaction and gather feedback for improvement.

## Methodology

### Simulating the digital alarm clock using Verilog HDL
The first step of our project is to
properly understand and write code in Verilog HDL. For this purpose, ”Verilog HDL: A Guide
to Digital Design and Synthesis, Second Edition” is a useful reference to understand the basic
concepts. The digital alarm clock is then implemented, accounting for features such as snooze
and multiple alarms.

### Reading the manual of the FPGA BOARD and understanding all connections
Inthe next phase of our project, we focus on understanding the FPGA Architecture. ”An Overview
of FPGAs and FPGA Programming: Initial Experiences at Daresbury Version 2.0” is the
reference book used for this purpose. Then we have to examine the ”DIGILENT: Nexys 4TM
FPGA Board Reference Manual” to figure out the connections to the particular FPGA board
that we are using.

### Implementing the alarm clock on hardware 
The final phase of the project involves
the hardware implementation of our Verilog code on an FPGA board. "Verilog-based FPGA
design" is a reference paper that helped us to understand and program our FPGA board
using Verilog HDL. This research paper provided details about the seven-segment display, the
temperature sensors, the PWM Audo Signal generator, and all the other basics about the FPGA
board.


## Block Diagram
![image](https://github.com/user-attachments/assets/079baca2-a969-4431-a1b7-740a807880d6)

## Working
**Initialization:** Upon reset, the clock is initialized to the user-defined time, alarm settings
are cleared, and internal counters are reset.


**Clock Operation:** The clock increments every second, updating the counters for hours, minutes,
and seconds accordingly. The hour counter resets at 24, mimicking a 24-hour clock format.


**Alarm Activation:** Alarm settings are compared with the current time, and if a match is found
and the alarm is not in snooze mode, it is activated. The alarm remains active for a predefined
duration (ALARM_DURATION).


**Multiple Alarms:** This feature allows users to have different alarms for various purposes, such
as waking up, reminders for meetings, or medication alerts. The module includes an array of
registers (alarm_hour1, alarm_hour0, alarm_min1, alarm_min0, alarm_sec1, alarm_sec0) to
store the settings for each alarm. These registers hold the hour, minute, and second values for
each alarm.


**Snooze Functionality:** Upon snooze activation, alarms are temporarily deactivated, and a snooze
timer is started (SNOOZE_DURATION). After the snooze duration elapses, alarms are reactivated.


**Output Assignment:** The calculated hour, minute, and second values are assigned to the output
ports for display.





 ## Simulations
1. In the initial simulation scenario we observe the precise functionality of our digital alarm clock
module as it accurately triggers four distinct alarms at their designated times within a 30-minute
duration. This simulation highlights the module’s reliability in effectively notifying users at specified
intervals, demonstrating its capability to manage multiple alarms seamlessly.

![image](https://github.com/user-attachments/assets/984c2e4f-4f35-44d8-a81b-6fd966c79bd4)


2. In the second simulation scenario, we explore the interaction between the user and our digital
alarm clock module as the snooze feature is engaged following the activation of the first alarm. This
simulation provides insight into the practical usage of our alarm clock design, showcasing how users can
interact with the system to temporarily delay alarms for a brief period. By examining the response of
the clock module to the user-initiated snooze action, we gain valuable insight into its ability to seam-
lessly accommodate user preferences while maintaining accurate timekeeping and alarm management.
The following waveform depicts the working of the snooze feature in our design module. After the user
presses the snooze button, the current alarm goes to active low and after some time, it becomes active
high again.

![image](https://github.com/user-attachments/assets/f6f6ba19-631c-4ebe-a17c-459deca3661c)


3. In the third simulation scenario, we explore the user interaction with our digital alarm clock
module as the stop alarm button is pressed during the activation of the second alarm. This simulation
provides a nuanced examination of the clock’s responsiveness to user commands, highlighting its ability
to accommodate immediate user actions to halt alarm activation. By observing the clock module’s
reaction to the stop alarm command amidst ongoing alarm activity, we gain valuable insights into its
ability to promptly cease alarm alerts while maintaining overall system integrity.

![image](https://github.com/user-attachments/assets/0bcf65c2-54d1-4e44-ba43-56ce78a06f86)


4. In the fourth simulation scenario, we explore a scenario where the user’s interaction with our
digital alarm clock module reflects frustration and a desire to halt alarm activation altogether. In this
simulation, as the third alarm begins buzzing, the user becomes irritated and opts to deactivate the
AL ON button, effectively disabling the current and subsequent alarms. This scenario sheds light on
the clock module’s response to user-initiated actions aimed at halting alarm alerts entirely, showcasing
its adaptability to user preferences even in scenarios of heightened frustration. Through this simulation,
we aim to examine the clock’s ability to accommodate user needs in diverse situations, underscoring
its versatility and user-centric design approach.

![image](https://github.com/user-attachments/assets/b33a7805-5f45-49a8-ad7d-20c612d6b69f)



## The FPGA board
The Nexys4 DDR board is a complete, ready-to-use digital circuit development platform based on the
latest Artix-7 Field Programmable Gate Array (FPGA) from Xilinx. With its(XC7A100T-1CSG324C)
high-capacity, generous external memories, collection of USB, and various other ports, the Nexys4 DDR
hosts designs that range from introductory combinational circuits to the most powerful embedded
processors which is an added advantage. The Nexys4 DDR board can be used for a wide range of
designs because of the several built-in peripherals like accelerometer, temperature sensor, MEMs digital
microphone, speaker amplifier, and I/O devices. The Artix-7 FPGA is optimized for high-performance
logic, and offers more capacity, high performance, and more logic resources than earlier designs.
The board uses an Artix-7 FPGA, which is part of Xilinx’s 7-series FPGA family known for its
low power consumption and cost-effectiveness. The specific FPGA on the Nexys DDR board is the
XC7A200T-1FBG676C, which features over 215K logic cells, 13.2 Mb of Block RAM, and 740 DSP
slices.
### Artix 7 FPGA board
![image](https://github.com/user-attachments/assets/9c602f19-96ba-453f-b367-9bbeefa24bde)
### ARTIX 7 Board Pin Description
![image](https://github.com/user-attachments/assets/d57e2de0-2bc2-41c7-a3ab-1fbd2b6f07ce)
### Pin Layout
![image](https://github.com/user-attachments/assets/b72712b7-164f-4a2c-aa6f-044fbd562845)


## Hardware Implementation

1. **Current Time:** The current time is set by using M_in0, M_in1, H_in0, and H_in1. Using the reset button(package
pin N17) we can set it to the required time. As shown in Fig.15 the current time is set at 00:01:22.


![image](https://github.com/user-attachments/assets/c08a6979-aa86-49d4-a1a1-57ba4d7d5aef)


2. **Alarm Time:** The alarm time is set by using the M_in0, M_in1, H_in0, and H_in1. The user can activate or
deactivate the alarm using the AL_ON signal(Package pin V10). As shown in Fig. 16 the alarm
time is set at 07:29:00. The LD_alarm Signal lights up a visual indicator (red LED) and the
AUD_PWM Signal controls the audio output for the alarm (e.g., a buzzer or speaker).


![image](https://github.com/user-attachments/assets/f9c6ca86-adc5-408e-8293-45e299143c44)


3. **Snooze:** The snooze feature is activated using the snooze button(package pin M18.) The current alarm
stops ringing when this button is pressed. After a certain duration of time called the Snooze
Duration, the alarm output becomes high again.


4. **Stop Alarm:** The STOP_al button which is mapped to package pin M17 is used to stop the current alarm and
make its output from high to low.


5. **Deactivating Alarm:** The AL_ON button which is mapped to package pin V10 is an input for activating the alarm
functionality. If this is turned off, all the subsequent alarms are deactivated.


## Future scope
- [ ] A calendar that displays the date in the DD-MM-YYYY format can also be integrated into the
clock. The date will be updated every 24 hours, and then depending upon the month, after
28/30/31 days, the month is also updated. There should also be a condition to check if the year
is a leap year or not.
- [ ] While our alarm clock design uses a basic slightly high-pitched sound output, the design can be
further modified to use various alarm ringtones which can be changed according to the user’s
preference.
- [ ] The alarm clock can be modified so that it can be connected to users’ mobile phones and other
devices as well.
- [ ] For the benefit of the users, the design can be further integrated to allow voice commands. The
user will be able to set alarms using these commands and control other features as well.
