transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/memory.sv}
vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/memory_tb.sv}
vlog -sv -work work +incdir+C:/Users/samas/Desktop/TEC/IIS-2022/Arqui\ I/Repositorio\ GitHub/proyecto_2/arquitectura {C:/Users/samas/Desktop/TEC/IIS-2022/Arqui I/Repositorio GitHub/proyecto_2/arquitectura/loadedMem.sv}

