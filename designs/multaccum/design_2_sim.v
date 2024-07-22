//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Sat Jul 20 08:00:34 2024
//Host        : biboyang-windows running 64-bit major release  (build 9200)
//Command     : generate_target design_2_wrapper.bd
//Design      : design_2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1ns / 1ps

import axi_vip_pkg::*;
import design_2_axi_vip_0_0_pkg::*;

//AXI4-Lite signals
xil_axi_resp_t 	resp;
bit[31:0]  addr, data, base_addr = 32'hA000_0000, switch_state;

module design_2_sim();

  design_2_wrapper design_2_wrapper_i();

  parameter int M = 128;
  parameter int K = 784;
  parameter int N = 128;

  // XilinxAXIVIP: Found at Path: design_2_sim.design_2_wrapper_i.design_2_i.axi_vip_0.inst
  design_2_axi_vip_0_0_mst_t BFM_axilite_pynq;

  initial begin
    BFM_axilite_pynq = new("Config Pynq", design_2_sim.design_2_wrapper_i.design_2_i.axi_vip_0.inst.IF);
    BFM_axilite_pynq.start_master();

    wait(design_2_sim.design_2_wrapper_i.design_2_i.sim_clk_gen_axilite.sync_rst == 1'b1);
    #500ns

    // Config GPIO
    addr = 32'hA003_0000; //din_size
    data = K - 1;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    
    // Config DDR_out_dma
    addr = 32'hA000_0000 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_out_dma.status = %h\n", data);
    addr = 32'hA000_0030 + 'h0; //control
    data = 3;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA000_0030 + 'h18; //low_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA000_0030 + 'h1c; //high_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA000_0030 + 'h28; //length
    data = N;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    #10ns
    addr = 32'hA000_0030 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_out_dma.status = %h\n", data);
    
    // Config DDR_in_a_dma
    addr = 32'hA001_0000 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_in_a_dma.status = %h\n", data);
    addr = 32'hA001_0000 + 'h0; //control
    data = 3;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA001_0000 + 'h18; //low_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA001_0000 + 'h1c; //high_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA001_0000 + 'h28; //length
    data = M * K;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    #10ns
    addr = 32'hA001_0000 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_in_a_dma.status = %h\n", data);
    
    // Config DDR_in_b_dma
    addr = 32'hA002_0000 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_in_b_dma.status = %h\n", data);
    addr = 32'hA002_0000 + 'h0; //control
    data = 3;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA002_0000 + 'h18; //low_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA002_0000 + 'h1c; //high_addr
    data = 0;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    addr = 32'hA002_0000 + 'h28; //length
    data = K * N;
    BFM_axilite_pynq.AXI4LITE_WRITE_BURST(addr,0,data,resp);
    #10ns
    addr = 32'hA002_0000 + 'h04; //status
    data = 0;
    BFM_axilite_pynq.AXI4LITE_READ_BURST(addr,0,data,resp);
    $display("DDR_in_b_dma.status = %h\n", data);
  end

endmodule
