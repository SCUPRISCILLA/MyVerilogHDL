transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/counter_ip {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/counter_ip/counter.v}

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/counter_ip/simulation/modelsim {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/counter_ip/simulation/modelsim/counter.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  counter_vlg_tst

add wave *
view structure
view signals
run -all
