# Make file to automate and split up tasks related to the building of the verilog files.
# Commands originally from Nandland.com's build files.

all : build prog

sim :
	iverilog -o ${FILE}_tb.out ${FILE}.v ${FILE}_tb.v 
	./${FILE}_tb.out
	open ${FILE}_tb.vcd ${FILE}_tb.gtkw -a /Applications/gtkwave.app

build :
	yosys -p "synth_ice40 -top top -json artifacts/output.json" top.v libs/Debounce_Switch.v libs/Binary_To_7Segment.v
	nextpnr-ice40 --hx1k --package vq100 --pcf libs/goboard.pcf --json artifacts/output.json --asc artifacts/output.asc
	icepack artifacts/output.asc output.bin

prog :
	iceprog output.bin

clean :
	rm -f *.out *.bin *.gtkw *.vcd *.asc *.json 
	rm -f artifacts/*.out artifacts/*.bin artifacts/*.gtkw artifacts/*.vcd artifacts/*.asc artifacts/*.json 
