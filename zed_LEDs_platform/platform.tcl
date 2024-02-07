# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\19165\Downloads\zedboard_LEDs-master\zedboard_LEDs-master\zed_LEDs_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\19165\Downloads\zedboard_LEDs-master\zedboard_LEDs-master\zed_LEDs_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zed_LEDs_platform}\
-hw {C:\Users\19165\Downloads\zedboard_LEDs-master\zedboard_LEDs-master\design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {C:/Users/19165/Downloads/zedboard_LEDs-master/zedboard_LEDs-master}

platform write
platform generate -domains 
platform generate
