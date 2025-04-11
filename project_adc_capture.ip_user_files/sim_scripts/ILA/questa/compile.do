vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu -sv "+incdir+../../../../project_adc_capture.gen/sources_1/bd/ILA/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_adc_capture.gen/sources_1/bd/ILA/ipshared/122e/hdl/verilog" "+incdir+../../../../project_adc_capture.gen/sources_1/bd/ILA/ipshared/b205/hdl/verilog" "+incdir+../../../../project_adc_capture.gen/sources_1/bd/ILA/ipshared/fd26/hdl/verilog" \
"C:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"C:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../bd/ILA/ip/ILA_ila_0_0/sim/ILA_ila_0_0.vhd" \
"../../../bd/ILA/sim/ILA.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

