vlib work
vlog -timescale 1ns/1ns Signal_Analyser.v
vsim pitch_counter
log {/*}
add wave {/*}

force {read_ready} 0 0, 1 2 -r 4
force {reset_n} 0 0, 1 4 -r 64
force {value} 16#0F0000 0
force {value} 16#000001 2
force {value} 16#F00000 6
force {value} 16#000002 10
force {value} 16#000003 14
force {value} 16#000002 18
force {value} 16#F00000 22
force {value} 16#000001 26
force {value} 16#000001 30
force {value} 16#000001 34
force {value} 16#000001 38
force {value} 16#000001 42
force {value} 16#000001 46
force {value} 16#F00000 50
# force {value} 16# 54
# force {value} 16# 58
# force {value} 16# 62

run 64ns
