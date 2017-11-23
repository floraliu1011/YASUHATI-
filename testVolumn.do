vlib work
vlog -timescale 1ns/1ns Signal_Analyser.v
vsim volumn
log {/*}
add wave {/*}

force {clk_60hz} 0 0, 1 8 -r 10
force {read_ready} 0 0, 1 2 -r 4
force {left} 16#000000 0
force {left} 16#000700 2
force {left} 16#000080 6
force {left} 16#009000 10
force {left} 16#0C0000 14
force {left} 16#00F000 18

run 20ns
