# Check if the correct number of arguments is provided
if {[llength $argv] < 2} {
    puts "Usage: tclsh impl.tcl <device> <probes_file>"
    exit 1
}
set DEVICE [lindex $argv 0]
set PROBE_FILE [lindex $argv 1]

start_gui
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
puts "Debugging on $DEVICE"
current_hw_device [get_hw_devices $DEVICE]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices $DEVICE] 0]
set_property PROBES.FILE $PROBE_FILE [get_hw_devices $DEVICE]
set_property FULL_PROBES.FILE $PROBE_FILE [get_hw_devices  $DEVICE]
refresh_hw_device [lindex [get_hw_devices $DEVICE] 0]
