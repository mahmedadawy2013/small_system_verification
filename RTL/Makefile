compile:
	vlog -sv chip_top.sv \
	Regfile.sv \
	ALU.sv
sim:
	vsim -logfile sim.log -c -do "run -all" work.tb_rtl