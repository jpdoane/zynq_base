#Open list of nets to probe
set fh [open $DEBUG_NETS_FILE r]

if {[gets $fh DEBUG_CLK] > 0} {  
    #first net must be the debug clock
    #if file is empty, just skip...
    puts "Adding debug ILA core with clock $DEBUG_CLK"

    create_debug_core u_ila_0 ila
    set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
    set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
    set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
    set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
    set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
    set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
    set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
    set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
    set_property port_width 1 [get_debug_ports u_ila_0/clk]
    connect_debug_port u_ila_0/clk [get_nets $DEBUG_CLK]

    # add probe for each net listed in file


    set nprobes 0
    while {[gets $fh netname] >= 0} {
        puts "Adding net $netname to ILA"
        set nets [lsort -dictionary [get_nets "$netname*"]]
        set prb probe$nprobes
        if {$nprobes > 0} {
            create_debug_port u_ila_0 probe
        }
        set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/$prb]
        set_property port_width [llength $nets] [get_debug_ports u_ila_0/$prb]

        connect_debug_port u_ila_0/$prb $nets
        incr nprobes
    }
    close $fh

    set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
    set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
    set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
    connect_debug_port dbg_hub/clk [get_nets $DEBUG_CLK]

} else {
    puts "Skipping ILA core..."
}
