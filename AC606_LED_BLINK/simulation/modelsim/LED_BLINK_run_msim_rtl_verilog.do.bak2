transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/AC606_LED_BLINK {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/AC606_LED_BLINK/LED_BLINK.v}

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/AC606_LED_BLINK/simulation/modelsim {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/AC606_LED_BLINK/simulation/modelsim/LED_BLINK.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  LED_BLINK_vlg_tst

add wave *
view structure
view signals
run -all
