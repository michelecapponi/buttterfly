onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_butterfly_core/CLK
add wave -noupdate /testbench_butterfly_core/RST_N
add wave -noupdate -color Magenta /testbench_butterfly_core/start
add wave -noupdate /testbench_butterfly_core/done
add wave -noupdate /testbench_butterfly_core/Ar
add wave -noupdate /testbench_butterfly_core/Ai
add wave -noupdate /testbench_butterfly_core/Br
add wave -noupdate /testbench_butterfly_core/Bi
add wave -noupdate /testbench_butterfly_core/Wr
add wave -noupdate /testbench_butterfly_core/Wi
add wave -noupdate /testbench_butterfly_core/Ar_out
add wave -noupdate /testbench_butterfly_core/Ai_out
add wave -noupdate /testbench_butterfly_core/Br_out
add wave -noupdate /testbench_butterfly_core/Bi_out
add wave -noupdate /testbench_butterfly_core/END_FILE
add wave -noupdate /testbench_butterfly_core/SAVE_DATA
add wave -noupdate /testbench_butterfly_core/CORE/cu/uAR/D
add wave -noupdate /testbench_butterfly_core/CORE/cu/uAR/CLOCK
add wave -noupdate -radix unsigned /testbench_butterfly_core/CORE/cu/uAR/Q
add wave -noupdate /testbench_butterfly_core/CORE/cu/uAR/ENABLE
add wave -noupdate /testbench_butterfly_core/CORE/cu/uAR/RESETN
add wave -noupdate /testbench_butterfly_core/CORE/eu/Ar
add wave -noupdate /testbench_butterfly_core/CORE/eu/Ai
add wave -noupdate /testbench_butterfly_core/CORE/eu/Br
add wave -noupdate /testbench_butterfly_core/CORE/eu/Bi
add wave -noupdate /testbench_butterfly_core/CORE/eu/Wr
add wave -noupdate /testbench_butterfly_core/CORE/eu/Wi
add wave -noupdate /testbench_butterfly_core/CORE/eu/clock
add wave -noupdate /testbench_butterfly_core/CORE/eu/resetn
add wave -noupdate /testbench_butterfly_core/CORE/eu/sh_mult_n
add wave -noupdate -color Magenta /testbench_butterfly_core/CORE/eu/sub_add_n
add wave -noupdate /testbench_butterfly_core/CORE/eu/sel_0
add wave -noupdate /testbench_butterfly_core/CORE/eu/sel_1
add wave -noupdate /testbench_butterfly_core/CORE/eu/sel_2
add wave -noupdate -color Blue /testbench_butterfly_core/CORE/eu/en_0
add wave -noupdate -color Blue /testbench_butterfly_core/CORE/eu/en_7
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_1
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_0
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_7
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/MULT_OUT
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_1
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_2
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_3
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_4
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_5
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_6
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_8
add wave -noupdate /testbench_butterfly_core/CORE/eu/en_round
add wave -noupdate /testbench_butterfly_core/CORE/eu/sw
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/Ar_out
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/Ai_out
add wave -noupdate -color {Orange Red} -radix decimal /testbench_butterfly_core/CORE/eu/Br_out
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/Bi_out
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/IN_REG_0
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/MUX_1_OUT
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/ROUNDED_DATA
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_1_EXT
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/AR_EXT
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/AI_EXT
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/IN_REG_2
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_2
add wave -noupdate -color Cyan -radix decimal /testbench_butterfly_core/CORE/eu/SUM_OUT
add wave -noupdate -color {Orange Red} -radix decimal /testbench_butterfly_core/CORE/eu/SUM_IN_A
add wave -noupdate -color {Orange Red} -radix decimal /testbench_butterfly_core/CORE/eu/SUM_IN_B
add wave -noupdate -color Cyan -radix decimal /testbench_butterfly_core/CORE/eu/OUT_REG_8
add wave -noupdate -radix decimal /testbench_butterfly_core/CORE/eu/IN_REG_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {182116 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 336
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {99875 ps} {217379 ps}
