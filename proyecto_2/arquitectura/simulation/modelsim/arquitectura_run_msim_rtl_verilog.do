transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/memory.sv}
vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/memory_tb.sv}
vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/loadedMem.sv}

vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/decode_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  decode_tb

add wave *
view structure
view signals
run -all
