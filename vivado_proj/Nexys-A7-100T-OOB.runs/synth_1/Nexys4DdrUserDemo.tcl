# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.runs/synth_1/Nexys4DdrUserDemo.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.cache/wt [current_project]
set_property parent.project_path E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part_repo_paths {E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.board} [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.0 [current_project]
set_property ip_repo_paths e:/Penny/graduate/repo [current_project]
update_ip_catalog
set_property ip_output_repo e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
add_files E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/other/Nexys4_all.coe
read_verilog -library xil_defaultlib {
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/audiodemo.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/dbncr.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/ledbar.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/pdmdes.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/pdmser.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/ram2ddr.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/ramcntrl.v
  E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/imports/src/hdl/nexys4ddruserdemo.v
}
read_ip -quiet E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ddr/ddr.xci
set_property used_in_implementation false [get_files -all e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ddr/ddr/user_design/constraints/ddr.xdc]
set_property used_in_implementation false [get_files -all e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ddr/ddr/user_design/constraints/ddr_ooc.xdc]

read_ip -quiet E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ClkGen/ClkGen.xci
set_property used_in_implementation false [get_files -all e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ClkGen/ClkGen_board.xdc]
set_property used_in_implementation false [get_files -all e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ClkGen/ClkGen.xdc]
set_property used_in_implementation false [get_files -all e:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/sources_1/ip/ClkGen/ClkGen_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/constrs_1/imports/constraints/Nexys-A7-100T-Master.xdc
set_property used_in_implementation false [get_files E:/Penny/graduate/1_1/AAML/Nexys-A7-100T-OOB-2018.2-1/vivado_proj/Nexys-A7-100T-OOB.srcs/constrs_1/imports/constraints/Nexys-A7-100T-Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top Nexys4DdrUserDemo -part xc7a100tcsg324-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Nexys4DdrUserDemo.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Nexys4DdrUserDemo_utilization_synth.rpt -pb Nexys4DdrUserDemo_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
