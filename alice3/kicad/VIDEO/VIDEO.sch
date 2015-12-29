EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:propeller_p8x32a-d40
LIBS:vga_daughter_board
LIBS:24lc256
LIBS:propeller_plug
LIBS:lm2937-3-3
LIBS:VIDEO-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "Alice 3 Video board"
Date "2000-12-31"
Rev ""
Comp "Earwig, Inc."
Comment1 "Lawrence Kesteloot"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Propeller_P8X32A-D40 U1
U 1 1 566E498F
P 5400 3500
F 0 "U1" H 5100 4800 60  0000 C CNN
F 1 "Propeller_P8X32A-D40" H 5400 2200 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W25.4mm" H 5400 3300 60  0001 C CNN
F 3 "" H 5400 3300 60  0000 C CNN
	1    5400 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 566E4A0D
P 4700 4800
F 0 "#PWR01" H 4700 4550 50  0001 C CNN
F 1 "GND" H 4700 4650 50  0000 C CNN
F 2 "" H 4700 4800 50  0000 C CNN
F 3 "" H 4700 4800 50  0000 C CNN
	1    4700 4800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR02
U 1 1 566E4A37
P 4700 2200
F 0 "#PWR02" H 4700 2050 50  0001 C CNN
F 1 "+3.3V" H 4700 2340 50  0000 C CNN
F 2 "" H 4700 2200 50  0000 C CNN
F 3 "" H 4700 2200 50  0000 C CNN
	1    4700 2200
	1    0    0    -1  
$EndComp
$Comp
L Crystal Y1
U 1 1 566E4A7D
P 6350 4550
F 0 "Y1" H 6350 4700 50  0000 C CNN
F 1 "5 MHz" H 6350 4400 50  0000 C CNN
F 2 "Crystals:Crystal_HC48-U_Vertical" H 6350 4550 50  0001 C CNN
F 3 "" H 6350 4550 50  0000 C CNN
	1    6350 4550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 566E4B37
P 6300 2500
F 0 "#PWR03" H 6300 2250 50  0001 C CNN
F 1 "GND" H 6300 2350 50  0000 C CNN
F 2 "" H 6300 2500 50  0000 C CNN
F 3 "" H 6300 2500 50  0000 C CNN
	1    6300 2500
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR04
U 1 1 566E4B67
P 6500 1800
F 0 "#PWR04" H 6500 1650 50  0001 C CNN
F 1 "+3.3V" H 6500 1940 50  0000 C CNN
F 2 "" H 6500 1800 50  0000 C CNN
F 3 "" H 6500 1800 50  0000 C CNN
	1    6500 1800
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 566E4B83
P 6500 2050
F 0 "R1" V 6580 2050 50  0000 C CNN
F 1 "10K" V 6500 2050 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 6430 2050 50  0001 C CNN
F 3 "" H 6500 2050 50  0000 C CNN
	1    6500 2050
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 566E4BAC
P 6900 2400
F 0 "SW1" H 7050 2510 50  0000 C CNN
F 1 "SW_PUSH" H 6900 2320 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_SMALL" H 6900 2400 50  0001 C CNN
F 3 "" H 6900 2400 50  0000 C CNN
	1    6900 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 566E4C07
P 7250 2500
F 0 "#PWR05" H 7250 2250 50  0001 C CNN
F 1 "GND" H 7250 2350 50  0000 C CNN
F 2 "" H 7250 2500 50  0000 C CNN
F 3 "" H 7250 2500 50  0000 C CNN
	1    7250 2500
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG06
U 1 1 566E4C94
P 1000 1200
F 0 "#FLG06" H 1000 1295 50  0001 C CNN
F 1 "PWR_FLAG" H 1000 1380 50  0000 C CNN
F 2 "" H 1000 1200 50  0000 C CNN
F 3 "" H 1000 1200 50  0000 C CNN
	1    1000 1200
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG07
U 1 1 566E4CCE
P 1500 1200
F 0 "#FLG07" H 1500 1295 50  0001 C CNN
F 1 "PWR_FLAG" H 1500 1380 50  0000 C CNN
F 2 "" H 1500 1200 50  0000 C CNN
F 3 "" H 1500 1200 50  0000 C CNN
	1    1500 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 566E4D40
P 1500 1500
F 0 "#PWR08" H 1500 1250 50  0001 C CNN
F 1 "GND" H 1500 1350 50  0000 C CNN
F 2 "" H 1500 1500 50  0000 C CNN
F 3 "" H 1500 1500 50  0000 C CNN
	1    1500 1500
	1    0    0    -1  
$EndComp
$Comp
L VGA_daughter_board U2
U 1 1 5681E1A9
P 3800 3950
F 0 "U2" H 3550 4450 60  0000 C CNN
F 1 "VGA_daughter_board" H 3700 3400 60  0000 C CNN
F 2 "" H 3800 4000 60  0000 C CNN
F 3 "" H 3800 4000 60  0000 C CNN
	1    3800 3950
	1    0    0    -1  
$EndComp
$Comp
L 24LC256 U3
U 1 1 5681F117
P 7500 4250
F 0 "U3" H 7250 4550 60  0000 C CNN
F 1 "24LC256" H 7400 3950 60  0000 C CNN
F 2 "" H 7500 4150 60  0000 C CNN
F 3 "" H 7500 4150 60  0000 C CNN
	1    7500 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 5681F164
P 6950 4500
F 0 "#PWR09" H 6950 4250 50  0001 C CNN
F 1 "GND" H 6950 4350 50  0000 C CNN
F 2 "" H 6950 4500 50  0000 C CNN
F 3 "" H 6950 4500 50  0000 C CNN
	1    6950 4500
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR010
U 1 1 5681F2C2
P 8050 3950
F 0 "#PWR010" H 8050 3800 50  0001 C CNN
F 1 "+3.3V" H 8050 4090 50  0000 C CNN
F 2 "" H 8050 3950 50  0000 C CNN
F 3 "" H 8050 3950 50  0000 C CNN
	1    8050 3950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 5681F2E8
P 8300 4250
F 0 "#PWR011" H 8300 4000 50  0001 C CNN
F 1 "GND" H 8300 4100 50  0000 C CNN
F 2 "" H 8300 4250 50  0000 C CNN
F 3 "" H 8300 4250 50  0000 C CNN
	1    8300 4250
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR012
U 1 1 5681F435
P 6700 3700
F 0 "#PWR012" H 6700 3550 50  0001 C CNN
F 1 "+3.3V" H 6700 3840 50  0000 C CNN
F 2 "" H 6700 3700 50  0000 C CNN
F 3 "" H 6700 3700 50  0000 C CNN
	1    6700 3700
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5681F454
P 6700 3900
F 0 "R2" V 6780 3900 50  0000 C CNN
F 1 "10k" V 6700 3900 50  0000 C CNN
F 2 "" V 6630 3900 50  0000 C CNN
F 3 "" H 6700 3900 50  0000 C CNN
	1    6700 3900
	1    0    0    -1  
$EndComp
$Comp
L Propeller_Plug U4
U 1 1 5681F4AC
P 8200 2950
F 0 "U4" H 8100 3250 60  0000 C CNN
F 1 "Propeller_Plug" H 8250 2600 60  0000 C CNN
F 2 "" H 8200 2950 60  0000 C CNN
F 3 "" H 8200 2950 60  0000 C CNN
	1    8200 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4500 4700 4500
Wire Wire Line
	4700 4500 4700 4800
Wire Wire Line
	4800 4600 4700 4600
Connection ~ 4700 4600
Wire Wire Line
	4700 2500 4800 2500
Wire Wire Line
	4700 2200 4700 2500
Wire Wire Line
	4800 2400 4700 2400
Connection ~ 4700 2400
Wire Wire Line
	6000 4500 6100 4500
Wire Wire Line
	6100 4500 6100 4400
Wire Wire Line
	6100 4400 6350 4400
Wire Wire Line
	6000 4600 6100 4600
Wire Wire Line
	6100 4600 6100 4700
Wire Wire Line
	6100 4700 6350 4700
Wire Wire Line
	6000 2500 6300 2500
Wire Wire Line
	6500 1900 6500 1800
Wire Wire Line
	6000 2400 6600 2400
Wire Wire Line
	6500 2400 6500 2200
Connection ~ 6500 2400
Wire Wire Line
	1500 1200 1500 1500
Wire Wire Line
	1000 1200 1000 1500
Wire Wire Line
	4100 3600 4800 3600
Wire Wire Line
	4100 3700 4800 3700
Wire Wire Line
	4100 3800 4800 3800
Wire Wire Line
	4100 3900 4800 3900
Wire Wire Line
	4100 4000 4800 4000
Wire Wire Line
	4100 4100 4800 4100
Wire Wire Line
	4100 4200 4800 4200
Wire Wire Line
	4100 4300 4800 4300
Wire Wire Line
	7000 4100 6950 4100
Wire Wire Line
	6950 4100 6950 4500
Wire Wire Line
	7000 4200 6950 4200
Connection ~ 6950 4200
Wire Wire Line
	7000 4300 6950 4300
Connection ~ 6950 4300
Wire Wire Line
	7000 4400 6950 4400
Connection ~ 6950 4400
Wire Wire Line
	8000 4100 8050 4100
Wire Wire Line
	8050 4100 8050 3950
Wire Wire Line
	8000 4200 8300 4200
Wire Wire Line
	8300 4200 8300 4250
Wire Wire Line
	8000 4300 8150 4300
Wire Wire Line
	8150 4300 8150 4900
Wire Wire Line
	8150 4900 6600 4900
Wire Wire Line
	6600 4900 6600 4000
Wire Wire Line
	6600 4000 6000 4000
Wire Wire Line
	8000 4400 8050 4400
Wire Wire Line
	8050 4400 8050 4800
Wire Wire Line
	6700 4800 8050 4800
Wire Wire Line
	6700 4050 6700 4800
Wire Wire Line
	6700 4100 6000 4100
Connection ~ 6700 4100
Wire Wire Line
	6700 3750 6700 3700
Wire Wire Line
	7850 2900 6450 2900
Wire Wire Line
	6450 2900 6450 2400
Connection ~ 6450 2400
Wire Wire Line
	7850 3000 6300 3000
Wire Wire Line
	6300 3000 6300 4300
Wire Wire Line
	6300 4300 6000 4300
Wire Wire Line
	7850 3100 6400 3100
Wire Wire Line
	6400 3100 6400 4200
Wire Wire Line
	6400 4200 6000 4200
Wire Wire Line
	7850 2400 7850 2800
Wire Wire Line
	7200 2400 7850 2400
Wire Wire Line
	7250 2400 7250 2500
Connection ~ 7250 2400
$Comp
L LM2937-3.3 U5
U 1 1 5681F8BE
P 2500 2550
F 0 "U5" H 2250 2750 60  0000 C CNN
F 1 "LM2937-3.3" H 2700 2750 60  0000 C CNN
F 2 "" H 2500 2550 60  0000 C CNN
F 3 "" H 2500 2550 60  0000 C CNN
	1    2500 2550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 5681F91B
P 2500 3100
F 0 "#PWR013" H 2500 2850 50  0001 C CNN
F 1 "GND" H 2500 2950 50  0000 C CNN
F 2 "" H 2500 3100 50  0000 C CNN
F 3 "" H 2500 3100 50  0000 C CNN
	1    2500 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 2900 2500 3100
$Comp
L +5V #PWR014
U 1 1 5681FA03
P 1900 2400
F 0 "#PWR014" H 1900 2250 50  0001 C CNN
F 1 "+5V" H 1900 2540 50  0000 C CNN
F 2 "" H 1900 2400 50  0000 C CNN
F 3 "" H 1900 2400 50  0000 C CNN
	1    1900 2400
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR015
U 1 1 5681FA32
P 3100 2400
F 0 "#PWR015" H 3100 2250 50  0001 C CNN
F 1 "+3.3V" H 3100 2540 50  0000 C CNN
F 2 "" H 3100 2400 50  0000 C CNN
F 3 "" H 3100 2400 50  0000 C CNN
	1    3100 2400
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR016
U 1 1 5681FAF3
P 1000 1500
F 0 "#PWR016" H 1000 1350 50  0001 C CNN
F 1 "+5V" H 1000 1640 50  0000 C CNN
F 2 "" H 1000 1500 50  0000 C CNN
F 3 "" H 1000 1500 50  0000 C CNN
	1    1000 1500
	-1   0    0    1   
$EndComp
Wire Wire Line
	2000 2500 1900 2500
Wire Wire Line
	1900 2500 1900 2400
$Comp
L CP1 C1
U 1 1 5681FB9D
P 3100 2750
F 0 "C1" H 3125 2850 50  0000 L CNN
F 1 "1000 µF" H 3125 2650 50  0000 L CNN
F 2 "" H 3100 2750 50  0000 C CNN
F 3 "" H 3100 2750 50  0000 C CNN
	1    3100 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2500 3400 2500
Wire Wire Line
	3100 2400 3100 2600
Connection ~ 3100 2500
Wire Wire Line
	3100 2900 3100 2950
Wire Wire Line
	2500 2950 3900 2950
Connection ~ 2500 2950
$Comp
L LED D1
U 1 1 5681FD4E
P 3600 2500
F 0 "D1" H 3600 2600 50  0000 C CNN
F 1 "LED" H 3600 2400 50  0000 C CNN
F 2 "" H 3600 2500 50  0000 C CNN
F 3 "" H 3600 2500 50  0000 C CNN
	1    3600 2500
	-1   0    0    1   
$EndComp
$Comp
L R R3
U 1 1 5681FD9C
P 3900 2700
F 0 "R3" V 3980 2700 50  0000 C CNN
F 1 "100" V 3900 2700 50  0000 C CNN
F 2 "" V 3830 2700 50  0000 C CNN
F 3 "" H 3900 2700 50  0000 C CNN
	1    3900 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 2500 3900 2500
Wire Wire Line
	3900 2500 3900 2550
Wire Wire Line
	3900 2950 3900 2850
Connection ~ 3100 2950
$Comp
L LED D2
U 1 1 56821EAA
P 4500 2700
F 0 "D2" H 4500 2800 50  0000 C CNN
F 1 "LED" H 4500 2600 50  0000 C CNN
F 2 "" H 4500 2700 50  0000 C CNN
F 3 "" H 4500 2700 50  0000 C CNN
	1    4500 2700
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 56821F00
P 4300 2950
F 0 "R4" V 4380 2950 50  0000 C CNN
F 1 "100" V 4300 2950 50  0000 C CNN
F 2 "" V 4230 2950 50  0000 C CNN
F 3 "" H 4300 2950 50  0000 C CNN
	1    4300 2950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 56821F3F
P 4300 3200
F 0 "#PWR017" H 4300 2950 50  0001 C CNN
F 1 "GND" H 4300 3050 50  0000 C CNN
F 2 "" H 4300 3200 50  0000 C CNN
F 3 "" H 4300 3200 50  0000 C CNN
	1    4300 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2800 4300 2700
Wire Wire Line
	4700 2700 4800 2700
Wire Wire Line
	4300 3200 4300 3100
NoConn ~ 4800 2800
NoConn ~ 4800 2900
NoConn ~ 4800 3000
NoConn ~ 4800 3100
NoConn ~ 4800 3200
NoConn ~ 4800 3300
NoConn ~ 4800 3400
$EndSCHEMATC
