.PHONY: build
build:
	yosys -p "synth_ecp5 -top top -json blink.json" blink.v
	nextpnr-ecp5 --json blink.json --textcfg blink_out.config --25k --package CABGA256 --lpf blink.lpf
	ecppack --svf blink.svf blink_out.config blink.bit
	openocd -f buspirate_jtag.cfg -c "svf -quiet -progress blink.svf"
