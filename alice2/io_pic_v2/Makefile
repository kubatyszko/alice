FAMILY          =       pic16
CHIP  =       18F452
# CHIP  =       18F4620

COMPILE_DEVICE  =       PIC$(CHIP)
BURN_DEVICE     =       PIC$(CHIP)

PIC_FIRMWARE_VERSION    := $(shell date)

WARN=-9

# BG: when thinking about turning on "pro" mode, remember that "pro"
# on Nov 22, 2015 caused PSP reads to stop working.  (Not analyzed
# any further)

io_pic.hex: io_pic.c
	"/Applications/microchip/xc8/v1.35/bin/xc8" --warn=$(WARN) --pass1 -DPIC_FIRMWARE_VERSION="$(PIC_FIRMWARE_VERSION)" --chip=$(CHIP) -Q -G  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,-debug --addrqual=ignore --mode=free -P -N255 --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -oio_pic.p1  io_pic.c 
	"/Applications/microchip/xc8/v1.35/bin/xc8" --warn=$(WARN) -DPIC_FIRMWARE_VERSION="$(PIC_FIRMWARE_VERSION)" --chip=$(CHIP) -G -mio_pic.map  --double=24 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,-debug --addrqual=ignore --mode=free -P -N255 --warn=0 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    --memorysummary memoryfile.xml -oio_pic.elf  io_pic.p1     

clean:
	rm io_pic.o io_pic.hex

burn: io_pic.hex
	echo extracting binary chunks to write...
	../emulator/hex2bin -r 256 0x300000 io_pic.hex io_pic.config.bin
	../emulator/hex2bin -r 32768 0 io_pic.hex io_pic.code.bin
	echo
	echo writing to device...
	minipro -p $(BURN_DEVICE) -c code -w io_pic.code.bin
	minipro -p $(BURN_DEVICE) -e -c data -w io_pic.config.bin
