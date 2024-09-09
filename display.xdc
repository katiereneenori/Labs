create_clock -period 10.0 [get_ports {Clk}]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# Reset button
set_property PACKAGE_PIN T18 [get_ports {Reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {Reset}]

# Clock signal
set_property PACKAGE_PIN W5 [get_ports {Clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {Clk}]

# Anode controls (matching with An in TopModule)
set_property PACKAGE_PIN U2 [get_ports {An[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {An[0]}]

set_property PACKAGE_PIN U4 [get_ports {An[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {An[1]}]

set_property PACKAGE_PIN V4 [get_ports {An[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {An[2]}]

set_property PACKAGE_PIN W4 [get_ports {An[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {An[3]}]

# Segment outputs (matching with Seg in TopModule)
set_property PACKAGE_PIN W7 [get_ports {Seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[6]}]

set_property PACKAGE_PIN W6 [get_ports {Seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[5]}]

set_property PACKAGE_PIN U8 [get_ports {Seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[4]}]

set_property PACKAGE_PIN V8 [get_ports {Seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {Seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[2]}]

set_property PACKAGE_PIN V5 [get_ports {Seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[1]}]

set_property PACKAGE_PIN U7 [get_ports {Seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg[0]}]

set_property PACKAGE_PIN V7 [get_ports {dp}]
set_property IOSTANDARD LVCMOS33 [get_ports {dp}]