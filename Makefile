FILE = switches_to_leds

all : build prog

sim :
	iverilog -o ${FILE}_tb.out ${FILE}.v ${FILE}_tb.v 
	./${FILE}_tb.out
	open ${FILE}_tb.vcd ${FILE}_tb.gtkw -a /Applications/gtkwave.app

build :
	yosys -p "synth_ice40 -top ${FILE} -json ${FILE}.json" ${FILE}.v Debounce_Switch.v Binary_To_7Segment.v
	nextpnr-ice40 --hx1k --package vq100 --pcf ${FILE}.pcf --json ${FILE}.json --asc ${FILE}.asc
	icepack ${FILE}.asc ${FILE}.bin

prog :
	iceprog ${FILE}.bin

clean :
	rm -f *.out *.bin *.gtkw *.vcd *.asc *.json 
