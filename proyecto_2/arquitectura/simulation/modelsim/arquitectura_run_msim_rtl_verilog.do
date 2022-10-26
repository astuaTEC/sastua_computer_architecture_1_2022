transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {d:/quartus/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {d:/quartus/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {d:/quartus/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {d:/quartus/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {d:/quartus/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cyclonev_ver
vmap cyclonev_ver ./verilog_libs/cyclonev_ver
vlog -vlog01compat -work cyclonev_ver {d:/quartus/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {d:/quartus/quartus/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_ver {d:/quartus/quartus/eda/sim_lib/cyclonev_atoms.v}

vlib verilog_libs/cyclonev_hssi_ver
vmap cyclonev_hssi_ver ./verilog_libs/cyclonev_hssi_ver
vlog -vlog01compat -work cyclonev_hssi_ver {d:/quartus/quartus/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_hssi_ver {d:/quartus/quartus/eda/sim_lib/cyclonev_hssi_atoms.v}

vlib verilog_libs/cyclonev_pcie_hip_ver
vmap cyclonev_pcie_hip_ver ./verilog_libs/cyclonev_pcie_hip_ver
vlog -vlog01compat -work cyclonev_pcie_hip_ver {d:/quartus/quartus/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v}
vlog -vlog01compat -work cyclonev_pcie_hip_ver {d:/quartus/quartus/eda/sim_lib/cyclonev_pcie_hip_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/ALU.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/Mux_2_to_1.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/Mux_3_to_1.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/regfile.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/adder.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/conditional.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/control.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/controller.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/decode.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/fetch.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/flopenrc.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/execute.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/arqui.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/hazardUnit.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/memory.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/CPU.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/divisorFrecuencia.sv}
vlog -sv -work work +incdir+C:/Users/Admin/Desktop/Semestre\ 2\ 2022/Arqui\ 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura {C:/Users/Admin/Desktop/Semestre 2 2022/Arqui 1/Proyectos/Proyecto2/sastua_computer_architecture_1_2022/proyecto_2/arquitectura/loadedMem.sv}

