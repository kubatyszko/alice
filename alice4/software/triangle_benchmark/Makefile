.PHONY: clean run copy_cmd_to_mmc

include ../platform.mk

APP=bench
SRC=bench.c 
LIBGL_SRC=../libgl/gl.c ../libgl/vector.c $(RASTERIZER_SRCS) $(EVENTS_SRCS)

$(APP): $(SRC) $(LIBGL_SRC)
	cc -DNDEBUG -O2 -g -I../sys_include -I../demo_include \
		-Wno-implicit-function-declaration -Wno-implicit-int -Wno-unused-value \
		-Wno-return-type \
		-o $(APP) $(SRC) $(LIBGL_SRC) -lm

run: $(APP)
	./$(APP)

clean:
	rm -f $(APP)

# Make cmd.txt by defining STOP_AFTER_ANIMATION in bench.c and
# DUMP_ALL_COMMANDS in hardware_rasterizer.c, then piping
# the output of bench to cmd.txt. Copy the resulting cmd.bin
# file to the SD card's FAT partition using the copy_cmd_to_mmc target.
cmd.bin: cmd.txt ../tools/convert_command_dump.py
	python ../tools/convert_command_dump.py < cmd.txt > cmd.bin

copy_cmd_to_mmc: cmd.bin
	mkdir -p mmc
	sudo mount /dev/mmcblk0p1 mmc
	sudo cp cmd.bin mmc/bench.bin
	ls -l mmc/bench.bin
	sudo umount mmc
	rmdir mmc
