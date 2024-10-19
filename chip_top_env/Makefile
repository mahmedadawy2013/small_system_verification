all: 	compile sim
# dont compile the trial.sv before compiling the design and the interface and the package 
# The order makes a difference 
# if u want to dont care about the the order of compilation check file trial_no_order.sv
compile:
		vlib work
		vlog -sv ../RTL/RegFile.sv ../RTL/ALU.sv ../RTL/chip_top.sv ../RTL/top_mux.sv  ../RTL/uart/UART_TX.sv \
		top_intf.sv ../register_memory_environment/reg_intf.sv ../ALU/alu_intf.sv ../register_memory_2_environment/reg2_intf.sv ../uart_environment/uart_intf.sv \
		my_packages.sv  tb.sv   
compile_sequence_item:
		vlib work
		vlog -sv  sequence_item.sv
compile_sequencer:
		vlib work
		vlog -sv sequencer.sv
compile_driver:
		vlib work
		vlog -sv driver.sv 
compile_monitor:
		vlib work
		vlog -sv monitor.sv 
compile_scoreboard:
		vlib work
		vlog -sv scoreboard.sv
sim:
		vsim -logfile sim.log -c -do "run -all" work.tb

sim_vcd :
		vsim -logfile sim.log -c -do "vcd file sim.vcd; vcd add -r /*; run -all; vcd flush; quit" work.tb

wave:
		vsim work.tb -voptargs=+acc
