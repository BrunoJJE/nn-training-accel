
################################################################
# This is a generated script based on design: design_2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_2_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# gentlast

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu3eg-sbva484-1-i
   set_property BOARD_PART avnet.com:ultra96v2:part0:1.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_vip:1.1\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:floating_point:7.1\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:sim_clk_gen:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:c_shift_ram:12.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
gentlast\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: gentlast_win
proc create_hier_cell_gentlast_win { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_gentlast_win() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type data Q
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_HAS_TLAST {1} \
   CONFIG.M_HAS_TREADY {1} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.S_HAS_TLAST {1} \
   CONFIG.S_TDATA_NUM_BYTES {4} \
   CONFIG.TDATA_REMAP {tdata[31:0]} \
   CONFIG.TLAST_REMAP {tlast[0]} \
 ] $axis_subset_converter_0

  # Create instance: faccum_shreg, and set properties
  set faccum_shreg [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 faccum_shreg ]
  set_property -dict [ list \
   CONFIG.AsyncInitVal {0} \
   CONFIG.DefaultData {0} \
   CONFIG.Depth {39} \
   CONFIG.SyncInitVal {0} \
   CONFIG.Width {1} \
 ] $faccum_shreg

  # Create instance: fmult_shreg, and set properties
  set fmult_shreg [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 fmult_shreg ]
  set_property -dict [ list \
   CONFIG.AsyncInitVal {0} \
   CONFIG.DefaultData {0} \
   CONFIG.Depth {11} \
   CONFIG.SyncInitVal {0} \
   CONFIG.Width {1} \
 ] $fmult_shreg

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_1

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins S_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins faccum_shreg/CLK] [get_bd_pins fmult_shreg/CLK]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_subset_converter_0/aresetn]
  connect_bd_net -net axis_subset_converter_0_m_axis_tlast [get_bd_pins axis_subset_converter_0/m_axis_tlast] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net axis_subset_converter_0_m_axis_tvalid [get_bd_pins axis_subset_converter_0/m_axis_tvalid] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net faccum_shreg_Q [get_bd_pins Q] [get_bd_pins faccum_shreg/Q]
  connect_bd_net -net fmult_shreg_Q [get_bd_pins faccum_shreg/D] [get_bd_pins fmult_shreg/Q]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins fmult_shreg/D] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins axis_subset_converter_0/m_axis_tready] [get_bd_pins xlconstant_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {0} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {3} \
 ] $axi_interconnect_1

  # Create instance: axi_vip_0, and set properties
  set axi_vip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip:1.1 axi_vip_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.INTERFACE_MODE {MASTER} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
 ] $axi_vip_0

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M01_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.S_TDATA_NUM_BYTES {4} \
 ] $axis_broadcaster_0

  # Create instance: din_size, and set properties
  set din_size [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 din_size ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000000} \
   CONFIG.C_GPIO_WIDTH {16} \
   CONFIG.C_IS_DUAL {0} \
 ] $din_size

  # Create instance: faccum, and set properties
  set faccum [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 faccum ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.Axi_Optimize_Goal {Performance} \
   CONFIG.C_Accum_Input_Msb {32} \
   CONFIG.C_Accum_Lsb {-149} \
   CONFIG.C_Accum_Msb {127} \
   CONFIG.C_Latency {39} \
   CONFIG.C_Mult_Usage {Medium_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_A_TLAST {true} \
   CONFIG.Operation_Type {Accumulator} \
   CONFIG.RESULT_TLAST_Behv {Pass_A_TLAST} \
   CONFIG.Result_Precision_Type {Single} \
 ] $faccum

  # Create instance: fmult, and set properties
  set fmult [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fmult ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Both} \
   CONFIG.Axi_Optimize_Goal {Performance} \
   CONFIG.C_Latency {11} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_A_TLAST {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.RESULT_TLAST_Behv {Pass_A_TLAST} \
   CONFIG.Result_Precision_Type {Single} \
 ] $fmult

  # Create instance: gentlast_din, and set properties
  set block_name gentlast
  set block_cell_name gentlast_din
  if { [catch {set gentlast_din [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $gentlast_din eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: gentlast_win
  create_hier_cell_gentlast_win [current_bd_instance .] gentlast_win

  # Create instance: in_a_dma, and set properties
  set in_a_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 in_a_dma ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $in_a_dma

  # Create instance: in_b_dma, and set properties
  set in_b_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 in_b_dma ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $in_b_dma

  # Create instance: out_dma, and set properties
  set out_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 out_dma ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $out_dma

  # Create instance: sim_clk_gen_axilite, and set properties
  set sim_clk_gen_axilite [ create_bd_cell -type ip -vlnv xilinx.com:ip:sim_clk_gen:1.0 sim_clk_gen_axilite ]
  set_property -dict [ list \
   CONFIG.INITIAL_RESET_CLOCK_CYCLES {1000} \
 ] $sim_clk_gen_axilite

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins din_size/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins in_a_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins in_b_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_interconnect_0/M03_AXI] [get_bd_intf_pins out_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_vip_0_M_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_vip_0/M_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins fmult/S_AXIS_B]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins gentlast_win/S_AXIS]
  connect_bd_intf_net -intf_net in_a_dma_M_AXIS_MM2S [get_bd_intf_pins fmult/S_AXIS_A] [get_bd_intf_pins in_a_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net in_a_dma_M_AXI_MM2S [get_bd_intf_pins axi_interconnect_1/S01_AXI] [get_bd_intf_pins in_a_dma/M_AXI_MM2S]
  connect_bd_intf_net -intf_net in_b_dma_M_AXIS_MM2S [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins in_b_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net in_b_dma_M_AXI_MM2S [get_bd_intf_pins axi_interconnect_1/S02_AXI] [get_bd_intf_pins in_b_dma/M_AXI_MM2S]
  connect_bd_intf_net -intf_net out_dma_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins out_dma/M_AXI_S2MM]

  # Create port connections
  connect_bd_net -net axi_resetn_1 [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_1/S02_ARESETN] [get_bd_pins axi_vip_0/aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins din_size/s_axi_aresetn] [get_bd_pins gentlast_din/rstn] [get_bd_pins gentlast_win/aresetn] [get_bd_pins in_a_dma/axi_resetn] [get_bd_pins in_b_dma/axi_resetn] [get_bd_pins out_dma/axi_resetn] [get_bd_pins sim_clk_gen_axilite/sync_rst]
  connect_bd_net -net din_size_gpio_io_o [get_bd_pins din_size/gpio_io_o] [get_bd_pins gentlast_din/i_size_m1]
  connect_bd_net -net faccum_m_axis_result_tdata [get_bd_pins faccum/m_axis_result_tdata] [get_bd_pins out_dma/s_axis_s2mm_tdata]
  connect_bd_net -net faccum_m_axis_result_tlast [get_bd_pins faccum/m_axis_result_tlast] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net faccum_m_axis_result_tvalid [get_bd_pins faccum/m_axis_result_tvalid] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net faccum_s_axis_a_tready [get_bd_pins faccum/s_axis_a_tready] [get_bd_pins fmult/m_axis_result_tready] [get_bd_pins gentlast_din/i_ready]
  connect_bd_net -net faccum_shreg_Q [get_bd_pins gentlast_win/Q] [get_bd_pins out_dma/s_axis_s2mm_tlast]
  connect_bd_net -net fmult_m_axis_result_tdata [get_bd_pins faccum/s_axis_a_tdata] [get_bd_pins fmult/m_axis_result_tdata]
  connect_bd_net -net fmult_m_axis_result_tvalid [get_bd_pins faccum/s_axis_a_tvalid] [get_bd_pins fmult/m_axis_result_tvalid] [get_bd_pins gentlast_din/i_valid]
  connect_bd_net -net gentlast_din_o_last [get_bd_pins faccum/s_axis_a_tlast] [get_bd_pins gentlast_din/o_last]
  connect_bd_net -net m_axi_s2mm_aclk_1 [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_1/S02_ACLK] [get_bd_pins axi_vip_0/aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins din_size/s_axi_aclk] [get_bd_pins faccum/aclk] [get_bd_pins fmult/aclk] [get_bd_pins gentlast_din/clk] [get_bd_pins gentlast_win/aclk] [get_bd_pins in_a_dma/m_axi_mm2s_aclk] [get_bd_pins in_a_dma/s_axi_lite_aclk] [get_bd_pins in_b_dma/m_axi_mm2s_aclk] [get_bd_pins in_b_dma/s_axi_lite_aclk] [get_bd_pins out_dma/m_axi_s2mm_aclk] [get_bd_pins out_dma/s_axi_lite_aclk] [get_bd_pins sim_clk_gen_axilite/clk]
  connect_bd_net -net out_dma_s_axis_s2mm_tready [get_bd_pins faccum/m_axis_result_tready] [get_bd_pins out_dma/s_axis_s2mm_tready]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins out_dma/s_axis_s2mm_tvalid] [get_bd_pins util_vector_logic_0/Res]

  # Create address segments
  assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs din_size/S_AXI/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs in_a_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs in_b_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_vip_0/Master_AXI] [get_bd_addr_segs out_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces in_a_dma/Data_MM2S] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces in_b_dma/Data_MM2S] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x00080000 -target_address_space [get_bd_addr_spaces out_dma/Data_S2MM] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


set_property used_in_simulation false [get_files  ./myproj/project_1.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v]
set_property used_in_simulation false [get_files  ./myproj/project_1.srcs/sources_1/bd/design_1/design_1.bd]
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse ./design_2_sim_behav.wcfg
add_files -fileset sim_1 -norecurse ./design_2_sim.v
set_property used_in_synthesis false [get_files  ./design_2_sim.v]
set_property used_in_implementation false [get_files  ./design_2_sim.v]
set_property file_type SystemVerilog [get_files  ./design_2_sim.v]
set_property used_in_synthesis false [get_files  ./myproj/project_1.srcs/sources_1/bd/design_2/design_2.bd]
set_property used_in_implementation false [get_files  ./myproj/project_1.srcs/sources_1/bd/design_2/design_2.bd]
make_wrapper -files [get_files ./myproj/project_1.srcs/sources_1/bd/design_2/design_2.bd] -top
add_files -norecurse ./myproj/project_1.gen/sources_1/bd/design_2/hdl/design_2_wrapper.v
set_property used_in_synthesis false [get_files  ./myproj/project_1.gen/sources_1/bd/design_2/hdl/design_2_wrapper.v]
set_property used_in_implementation false [get_files  ./myproj/project_1.gen/sources_1/bd/design_2/hdl/design_2_wrapper.v]
