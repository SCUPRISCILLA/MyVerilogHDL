transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/UART_BYTE {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/UART_BYTE/UART_BYTE.v}

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/UART_BYTE/simulation/modelsim {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/UART_BYTE/simulation/modelsim/UART_BYTE.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  UART_BYTE_vlg_tst

add wave *
view structure
view signals
run -all
