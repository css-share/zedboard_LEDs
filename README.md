# zedboard_LEDs
simple zedboard application that controls the LEDs connected to PL section

Zedboard rev.D hardware used:
  * LEDs 0-7 connected to PL
  * Pushbuttons (Right,Left,Up,Down,Center) connected to the PL
  * UART on the PS

Windows Software tools: Vivado 2018.2, Xilinx SDK 2018.2

The Zedboard_LEDs project uses the LEDs connected to the zynq PL as a visual indicator of board activity.
It uses the five directional pushbuttons on the zedboard, also connected to the PL, to change the LED activity.
When a button is pressed an interrupt on the PL side is generated and the ISR is called to interpret the
button press and take appropriate action.

There is another project called zedboardLEDs_control that contains a python script which establishes a 
connection to the zedboard via UARTPS_0 and has buttons that will mimick the zedboard pushbuttons and 
control LED activity similarly
