transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_15
vlib riviera/processing_system7_vip_v1_0_17
vlib riviera/xil_defaultlib
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/lib_cdc_v1_0_2
vlib riviera/interrupt_control_v3_1_5
vlib riviera/axi_gpio_v2_0_31
vlib riviera/generic_baseblocks_v2_1_1
vlib riviera/axi_register_slice_v2_1_29
vlib riviera/fifo_generator_v13_2_9
vlib riviera/axi_data_fifo_v2_1_28
vlib riviera/axi_crossbar_v2_1_30
vlib riviera/proc_sys_reset_v5_0_14
vlib riviera/dist_mem_gen_v8_0_14
vlib riviera/lib_pkg_v1_0_3
vlib riviera/lib_srl_fifo_v1_0_3
vlib riviera/lib_fifo_v1_0_18
vlib riviera/axi_quad_spi_v3_2_28
vlib riviera/xlconcat_v2_1_5
vlib riviera/axi_protocol_converter_v2_1_29

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_15 riviera/axi_vip_v1_1_15
vmap processing_system7_vip_v1_0_17 riviera/processing_system7_vip_v1_0_17
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap interrupt_control_v3_1_5 riviera/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_31 riviera/axi_gpio_v2_0_31
vmap generic_baseblocks_v2_1_1 riviera/generic_baseblocks_v2_1_1
vmap axi_register_slice_v2_1_29 riviera/axi_register_slice_v2_1_29
vmap fifo_generator_v13_2_9 riviera/fifo_generator_v13_2_9
vmap axi_data_fifo_v2_1_28 riviera/axi_data_fifo_v2_1_28
vmap axi_crossbar_v2_1_30 riviera/axi_crossbar_v2_1_30
vmap proc_sys_reset_v5_0_14 riviera/proc_sys_reset_v5_0_14
vmap dist_mem_gen_v8_0_14 riviera/dist_mem_gen_v8_0_14
vmap lib_pkg_v1_0_3 riviera/lib_pkg_v1_0_3
vmap lib_srl_fifo_v1_0_3 riviera/lib_srl_fifo_v1_0_3
vmap lib_fifo_v1_0_18 riviera/lib_fifo_v1_0_18
vmap axi_quad_spi_v3_2_28 riviera/axi_quad_spi_v3_2_28
vmap xlconcat_v2_1_5 riviera/xlconcat_v2_1_5
vmap axi_protocol_converter_v2_1_29 riviera/axi_protocol_converter_v2_1_29

vlog -work xilinx_vip  -incr "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2023.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"C:/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_15  -incr "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/5753/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_17  -incr "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_5 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_31 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6fbe/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_gpio_0_0/sim/design_1_axi_gpio_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_1  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/10ab/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_29  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ff9f/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_9  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ac72/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_9 -93  -incr \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ac72/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_9  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ac72/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_28  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/279e/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_30  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/fb47/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \

vcom -work proc_sys_reset_v5_0_14 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/408c/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_rst_ps7_0_100M_0/sim/design_1_rst_ps7_0_100M_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_gpio_1_0/sim/design_1_axi_gpio_1_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_gpio_2_0/sim/design_1_axi_gpio_2_0.vhd" \

vlog -work dist_mem_gen_v8_0_14  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/2ec6/simulation/dist_mem_gen_v8_0.v" \

vcom -work lib_pkg_v1_0_3 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/56d9/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_3 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/02c4/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_fifo_v1_0_18 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/1531/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work axi_quad_spi_v3_2_28 -93  -incr \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/98d8/hdl/axi_quad_spi_v3_2_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_quad_spi_0_0/sim/design_1_axi_quad_spi_0_0.vhd" \

vlog -work xlconcat_v2_1_5  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/147b/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../bd/design_1/ip/design_1_xlconcat_0_0/sim/design_1_xlconcat_0_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_gpio_3_0/sim/design_1_axi_gpio_3_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_gpio_4_0/sim/design_1_axi_gpio_4_0.vhd" \

vlog -work axi_protocol_converter_v2_1_29  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/a63f/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../zed_LEDs.srcs/sources_1/bd/design_1/ipshared/6b2b/hdl" "+incdir+../../../../zed_LEDs.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+C:/Xilinx/Vivado/2023.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_15 -l processing_system7_vip_v1_0_17 -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_31 -l generic_baseblocks_v2_1_1 -l axi_register_slice_v2_1_29 -l fifo_generator_v13_2_9 -l axi_data_fifo_v2_1_28 -l axi_crossbar_v2_1_30 -l proc_sys_reset_v5_0_14 -l dist_mem_gen_v8_0_14 -l lib_pkg_v1_0_3 -l lib_srl_fifo_v1_0_3 -l lib_fifo_v1_0_18 -l axi_quad_spi_v3_2_28 -l xlconcat_v2_1_5 -l axi_protocol_converter_v2_1_29 \
"../../../bd/design_1/ip/design_1_auto_pc_6/sim/design_1_auto_pc_6.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0_1/sim/design_1_auto_pc_0.v" \
"../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
"../../../bd/design_1/ip/design_1_auto_pc_2/sim/design_1_auto_pc_2.v" \
"../../../bd/design_1/ip/design_1_auto_pc_3/sim/design_1_auto_pc_3.v" \
"../../../bd/design_1/ip/design_1_auto_pc_4/sim/design_1_auto_pc_4.v" \
"../../../bd/design_1/ip/design_1_auto_pc_5/sim/design_1_auto_pc_5.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

