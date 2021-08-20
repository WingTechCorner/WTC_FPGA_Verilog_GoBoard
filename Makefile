# Makefile to build files written in Verilog 
# ./top.v					- in main folder.
# ./libs/*				- all dependencies are in libs folder
# ./artifacts/* 	- all produced artifacts in the artifacts folder
# ./tb/* 					- testbenches
# ./output/*      - output bin files
all : clean build prog

build :
	mkdir -p artifacts  output
	yosys -p "synth_ice40 -top top -json artifacts/output.json" top.v libs/*.v
	nextpnr-ice40 --hx1k --package vq100 --pcf libs/goboard.pcf --json artifacts/output.json --asc artifacts/output.asc
	icepack artifacts/output.asc output/output.bin

prog :
	iceprog output/output.bin

clean :
	rm -f *.out *.bin *.gtkw *.vcd *.asc *.json 
	rm -f artifacts/*.out artifacts/*.bin artifacts/*.gtkw artifacts/*.vcd artifacts/*.asc artifacts/*.json output/*
