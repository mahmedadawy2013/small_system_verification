
package pack1; 
    import uvm_pkg::*   ;
    `include "uvm_macros.svh"           
    `include "sequence_item.sv"
    `include "sequence.sv"
    `include "sequencer.sv"
    `include "driver.sv"   
    `include "monitor.sv"
    `include "agent.sv"
    //******************************************************************************************************
        `include "../register_memory_environment/reg_sequence_item.sv"
        `include "../register_memory_environment/reg_sequence.sv"
        `include "../register_memory_environment/reg_sequencer.sv"
        `include "../register_memory_environment/reg_driver.sv"   
        `include "../register_memory_environment/reg_monitor.sv"
        `include "../register_memory_environment/reg_agent_config.sv"  
        `include "../register_memory_environment/reg_agent.sv"
    // ******************************************************************************************************
        `include "../register_memory_2_environment/reg2_sequence_item.sv"
        `include "../register_memory_2_environment/reg2_sequence.sv"
        `include "../register_memory_2_environment/reg2_sequencer.sv"
        `include "../register_memory_2_environment/reg2_driver.sv"   
        `include "../register_memory_2_environment/reg2_monitor.sv"
        `include "../register_memory_2_environment/reg2_agent_config.sv"  
        `include "../register_memory_2_environment/reg2_agent.sv"
    // ******************************************************************************************************
        `include "../alu/alu_sequence_item.sv"
        `include "../alu/alu_sequence.sv"
        `include "../alu/alu_sequencer.sv"
        `include "../alu/alu_driver.sv"   
        `include "../alu/alu_agent_config.sv"
        `include "../alu/alu_monitor.sv"
        `include "../alu/alu_agent.sv"
    // ******************************************************************************************************
    `include "parent_sequencer.sv"
    `include "parent_sequence.sv"
    `include "scoreboard.sv"  
    `include "subscriber.sv"
    `include "environment.sv"
    `include "test.sv"
endpackage 