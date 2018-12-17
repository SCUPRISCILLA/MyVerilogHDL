transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/my_BCDcounter {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/my_BCDcounter/my_BCDcounter.v}

vlog -vlog01compat -work work +incdir+D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/my_BCDcounter/simulation/modelsim {D:/MyWorkSpace/CodeProject/FPGA/MyVerilogHDL/my_BCDcounter/simulation/modelsim/my_BCDcounter.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  my_BCDcounter_vlg_tst

add wave *
view structure
view signals
run -all
