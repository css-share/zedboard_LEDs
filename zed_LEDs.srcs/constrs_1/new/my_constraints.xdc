set_property PACKAGE_PIN Y11 [get_ports spi_rtl_io0_io]
set_property PACKAGE_PIN Y10 [get_ports spi_rtl_io1_io]
set_property PACKAGE_PIN AA11 [get_ports spi_rtl_sck_io]
set_property PACKAGE_PIN AA9 [get_ports {spi_rtl_ss_io[0]}]

set_property PACKAGE_PIN F22 [get_ports {sws_8bits_tri_i[0]}]
set_property PACKAGE_PIN G22 [get_ports {sws_8bits_tri_i[1]}]
set_property PACKAGE_PIN H22 [get_ports {sws_8bits_tri_i[2]}]
set_property PACKAGE_PIN F21 [get_ports {sws_8bits_tri_i[3]}]
set_property PACKAGE_PIN H19 [get_ports {sws_8bits_tri_i[4]}]
set_property PACKAGE_PIN H18 [get_ports {sws_8bits_tri_i[5]}]
set_property PACKAGE_PIN H17 [get_ports {sws_8bits_tri_i[6]}]
set_property PACKAGE_PIN M15 [get_ports {sws_8bits_tri_i[7]}]
set_property PACKAGE_PIN T22 [get_ports {leds_8bits_tri_o[0]}]
set_property PACKAGE_PIN T21 [get_ports {leds_8bits_tri_o[1]}]
set_property PACKAGE_PIN U22 [get_ports {leds_8bits_tri_o[2]}]
set_property PACKAGE_PIN U21 [get_ports {leds_8bits_tri_o[3]}]
set_property PACKAGE_PIN V22 [get_ports {leds_8bits_tri_o[4]}]
set_property PACKAGE_PIN W22 [get_ports {leds_8bits_tri_o[5]}]
set_property PACKAGE_PIN U19 [get_ports {leds_8bits_tri_o[6]}]
set_property PACKAGE_PIN U14 [get_ports {leds_8bits_tri_o[7]}]
set_property PACKAGE_PIN P16 [get_ports {btns_5bits_tri_i[0]}]
set_property PACKAGE_PIN R16 [get_ports {btns_5bits_tri_i[1]}]
set_property PACKAGE_PIN N15 [get_ports {btns_5bits_tri_i[2]}]
set_property PACKAGE_PIN R18 [get_ports {btns_5bits_tri_i[3]}]
set_property PACKAGE_PIN T18 [get_ports {btns_5bits_tri_i[4]}]

set_property IOSTANDARD LVCMOS25 [get_ports {spi_rtl_*}]
set_property IOSTANDARD LVCMOS25 [get_ports {leds_8bits_tri_o[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {sws_8bits_tri_i[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {btns_5bits_tri_i[*]}]

set_property PULLDOWN true [get_ports {spi_rtl_*}]
#set_property PULLDOWN true [get_ports {leds_8bits_tri_o[*]}]
set_property PULLDOWN true [get_ports {sws_8bits_tri_i[*]}]

set_property PACKAGE_PIN B22 [get_ports int_out]
set_property IOSTANDARD LVCMOS25 [get_ports int_out]