EESchema Schematic File Version 2
LIBS:sd_card
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
LIBS:24lc256
LIBS:74hc4050
LIBS:lm2937-3-3
LIBS:propeller_plug
LIBS:propeller_p8x32a-d40
LIBS:dfrobot_ftdi_basic
LIBS:levelconverter
LIBS:minim4-d40
LIBS:vga_daughter_board
LIBS:Zilog
LIBS:km681000blp-7
LIBS:28f512
LIBS:MOBO-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 3 4
Title "Alice 3 IO Board"
Date "2016-01-03"
Rev "1"
Comp "Earwing, Inc."
Comment1 "Brad Grantham, grantham@plunk.org"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L +3.3V #PWR19
U 1 1 5689970E
P 900 2900
F 0 "#PWR19" H 900 2750 50  0001 C CNN
F 1 "+3.3V" H 900 3040 50  0000 C CNN
F 2 "" H 900 2900 60  0000 C CNN
F 3 "" H 900 2900 60  0000 C CNN
	1    900  2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR22
U 1 1 5689975D
P 2400 4600
F 0 "#PWR22" H 2400 4350 50  0001 C CNN
F 1 "GND" H 2400 4450 50  0000 C CNN
F 2 "" H 2400 4600 60  0000 C CNN
F 3 "" H 2400 4600 60  0000 C CNN
	1    2400 4600
	1    0    0    -1  
$EndComp
NoConn ~ 7450 5500
NoConn ~ 7450 4700
$Comp
L GND #PWR26
U 1 1 56899C9B
P 8350 5900
F 0 "#PWR26" H 8350 5650 50  0001 C CNN
F 1 "GND" H 8350 5750 50  0000 C CNN
F 2 "" H 8350 5900 60  0000 C CNN
F 3 "" H 8350 5900 60  0000 C CNN
	1    8350 5900
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR27
U 1 1 56899CD4
P 8450 4050
F 0 "#PWR27" H 8450 3900 50  0001 C CNN
F 1 "+3.3V" H 8450 4190 50  0000 C CNN
F 2 "" H 8450 4050 60  0000 C CNN
F 3 "" H 8450 4050 60  0000 C CNN
	1    8450 4050
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 5689A6F4
P 7800 4500
F 0 "R6" V 7880 4500 50  0000 C CNN
F 1 "68K" V 7800 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 7730 4500 30  0001 C CNN
F 3 "" H 7800 4500 30  0000 C CNN
	1    7800 4500
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 5689A7DE
P 7600 4500
F 0 "R5" V 7680 4500 50  0000 C CNN
F 1 "68K" V 7600 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 7530 4500 30  0001 C CNN
F 3 "" H 7600 4500 30  0000 C CNN
	1    7600 4500
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 5689A7FF
P 8000 4500
F 0 "R7" V 8080 4500 50  0000 C CNN
F 1 "68K" V 8000 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 7930 4500 30  0001 C CNN
F 3 "" H 8000 4500 30  0000 C CNN
	1    8000 4500
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5689A887
P 8200 4500
F 0 "R8" V 8280 4500 50  0000 C CNN
F 1 "68K" V 8200 4500 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 8130 4500 30  0001 C CNN
F 3 "" H 8200 4500 30  0000 C CNN
	1    8200 4500
	1    0    0    -1  
$EndComp
Entry Wire Line
	8700 4800 8800 4900
Entry Wire Line
	8700 5100 8800 5200
Entry Wire Line
	8700 5400 8800 5500
Entry Wire Line
	8700 5300 8800 5400
Text GLabel 9000 4600 2    60   Input ~ 0
SPI0
Text Label 8550 4800 0    60   ~ 0
DO
Text Label 8550 5100 0    60   ~ 0
SCK
Text Label 8550 5300 0    60   ~ 0
DI
Text Label 8550 5400 0    60   ~ 0
CS
Entry Wire Line
	1550 3300 1650 3200
Entry Wire Line
	1550 3400 1650 3300
Text Label 1650 3300 0    60   ~ 0
SCK
Text Label 1650 3200 0    60   ~ 0
CS
Text GLabel 1450 3200 0    60   Input ~ 0
SPI0
Text GLabel 4900 2400 2    60   Input ~ 0
SPI0
Entry Wire Line
	4700 2500 4800 2600
Entry Wire Line
	4700 2400 4800 2500
Text Label 4600 2400 0    60   ~ 0
DO
Text Label 4600 2500 0    60   ~ 0
DI
$Comp
L R R4
U 1 1 568A0A99
P 900 3950
F 0 "R4" V 980 3950 50  0000 C CNN
F 1 "10k" V 900 3950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 830 3950 30  0001 C CNN
F 3 "" H 900 3950 30  0000 C CNN
	1    900  3950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR20
U 1 1 568A1142
P 900 4200
F 0 "#PWR20" H 900 3950 50  0001 C CNN
F 1 "GND" H 900 4050 50  0000 C CNN
F 2 "" H 900 4200 60  0000 C CNN
F 3 "" H 900 4200 60  0000 C CNN
	1    900  4200
	1    0    0    -1  
$EndComp
$Comp
L DFROBOT_FTDI_BASIC U7
U 1 1 568A1F83
P 6150 2750
F 0 "U7" H 5900 3350 60  0000 C CNN
F 1 "DFROBOT_FTDI_BASIC" H 6150 2150 60  0000 C CNN
F 2 "ftdi basic breakout:FTDIBASIC" H 6150 2150 60  0001 C CNN
F 3 "" H 6150 2150 60  0000 C CNN
	1    6150 2750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR23
U 1 1 568A2172
P 5650 2550
F 0 "#PWR23" H 5650 2300 50  0001 C CNN
F 1 "GND" H 5650 2400 50  0000 C CNN
F 2 "" H 5650 2550 60  0000 C CNN
F 3 "" H 5650 2550 60  0000 C CNN
	1    5650 2550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR24
U 1 1 568A21B9
P 6650 3150
F 0 "#PWR24" H 6650 2900 50  0001 C CNN
F 1 "GND" H 6650 3000 50  0000 C CNN
F 2 "" H 6650 3150 60  0000 C CNN
F 3 "" H 6650 3150 60  0000 C CNN
	1    6650 3150
	0    -1   -1   0   
$EndComp
NoConn ~ 6650 2350
NoConn ~ 6650 2450
NoConn ~ 6650 2550
NoConn ~ 6650 2650
NoConn ~ 6650 2750
NoConn ~ 6650 2950
NoConn ~ 6650 3050
NoConn ~ 5650 2350
NoConn ~ 5650 2450
NoConn ~ 5650 2650
NoConn ~ 5650 2850
NoConn ~ 5650 2950
NoConn ~ 5650 3050
$Comp
L CP1 C3
U 1 1 568A9C8C
P 8150 5800
F 0 "C3" H 8175 5900 50  0000 L CNN
F 1 "22µF" H 8175 5700 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L11_P2.5" H 8150 5800 60  0001 C CNN
F 3 "" H 8150 5800 60  0000 C CNN
	1    8150 5800
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR25
U 1 1 568DC45F
P 7000 2850
F 0 "#PWR25" H 7000 2700 50  0001 C CNN
F 1 "+5V" H 7000 2990 50  0000 C CNN
F 2 "" H 7000 2850 60  0000 C CNN
F 3 "" H 7000 2850 60  0000 C CNN
	1    7000 2850
	1    0    0    -1  
$EndComp
Text GLabel 2450 2900 0    60   Input ~ 0
KBD_DATA
Text GLabel 4000 2800 2    60   Input ~ 0
KBD_CLK
Text GLabel 2450 2400 0    60   BiDi ~ 0
D0
Text GLabel 2450 2500 0    60   BiDi ~ 0
D1
Text GLabel 2450 2600 0    60   BiDi ~ 0
D2
Text GLabel 2450 2700 0    60   BiDi ~ 0
D3
Text GLabel 2450 2800 0    60   BiDi ~ 0
/IORQ
Text GLabel 2450 3000 0    60   BiDi ~ 0
/RD
Text GLabel 2450 3100 0    60   BiDi ~ 0
/WR
Text GLabel 2450 3900 0    60   Output ~ 0
/Z80_RESET
Text GLabel 4300 3300 2    60   BiDi ~ 0
A7
Text GLabel 4300 3600 2    60   BiDi ~ 0
D4
Text GLabel 4300 3700 2    60   BiDi ~ 0
D5
Text GLabel 4300 3800 2    60   BiDi ~ 0
D7
Text GLabel 4300 3900 2    60   BiDi ~ 0
D6
Wire Wire Line
	8350 4900 8350 5900
Wire Wire Line
	7450 4900 8350 4900
Connection ~ 2400 2000
Connection ~ 2400 4300
Wire Wire Line
	2700 4300 2400 4300
Wire Wire Line
	2400 4200 2400 4600
Wire Wire Line
	2700 4200 2400 4200
Connection ~ 2400 1900
Wire Wire Line
	2400 2000 2700 2000
Wire Wire Line
	2400 1900 2700 1900
Connection ~ 7600 5300
Wire Wire Line
	8200 4650 8200 4800
Connection ~ 8200 4800
Wire Wire Line
	7600 4350 7600 4100
Wire Wire Line
	7600 4100 8450 4100
Connection ~ 8450 4100
Wire Wire Line
	7800 4350 7800 4100
Connection ~ 7800 4100
Wire Wire Line
	8000 4100 8000 4350
Connection ~ 8000 4100
Wire Wire Line
	8200 4350 8200 4100
Connection ~ 8200 4100
Connection ~ 7800 5400
Wire Wire Line
	8000 5800 7900 5800
Wire Wire Line
	8300 5800 8350 5800
Connection ~ 8350 5800
Wire Wire Line
	7450 5300 8700 5300
Wire Wire Line
	7450 4800 8700 4800
Wire Wire Line
	7450 5400 8700 5400
Wire Bus Line
	8800 4600 8800 5500
Wire Bus Line
	8800 4600 9000 4600
Wire Wire Line
	7600 5300 7600 4650
Wire Wire Line
	7800 5400 7800 4650
Wire Bus Line
	1450 3200 1550 3200
Wire Bus Line
	1550 3200 1550 3400
Wire Bus Line
	4900 2400 4800 2400
Wire Bus Line
	4800 2400 4800 2600
Wire Wire Line
	4000 2400 4700 2400
Wire Wire Line
	4000 2500 4700 2500
Wire Wire Line
	2450 2400 2700 2400
Wire Wire Line
	2450 2500 2700 2500
Wire Wire Line
	2700 2600 2450 2600
Wire Wire Line
	2450 2700 2700 2700
Wire Wire Line
	2700 2800 2450 2800
Wire Wire Line
	2450 3000 2700 3000
Wire Wire Line
	2700 3100 2450 3100
Wire Wire Line
	2700 3900 2450 3900
Wire Wire Line
	1650 3200 2700 3200
Wire Wire Line
	1650 3300 1850 3300
Wire Wire Line
	4000 3300 4300 3300
Wire Wire Line
	4000 3600 4300 3600
Wire Wire Line
	4000 3700 4300 3700
Wire Wire Line
	4000 3800 4300 3800
Wire Wire Line
	4000 3900 4300 3900
Wire Wire Line
	1850 3800 2700 3800
Wire Wire Line
	900  3700 2700 3700
Wire Wire Line
	5650 2750 4700 2750
Wire Wire Line
	4700 2750 4700 2600
Wire Wire Line
	4700 2600 4000 2600
Wire Wire Line
	4000 2700 4600 2700
Wire Wire Line
	4600 2700 4600 2900
Wire Wire Line
	4600 2900 5500 2900
Wire Wire Line
	5500 2900 5500 3150
Wire Wire Line
	5500 3150 5650 3150
Wire Wire Line
	2400 1600 2400 2000
Wire Wire Line
	1850 3300 1850 3800
Text GLabel 4000 2300 2    60   Output ~ 0
/BUSRQ
$Comp
L MiniM4-D40 U6
U 1 1 568996B3
P 3350 3100
F 0 "U6" H 3000 4550 60  0000 C CNN
F 1 "MiniM4-D40" H 3350 1650 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm" H 3200 1600 60  0001 C CNN
F 3 "" H 3200 1600 60  0000 C CNN
	1    3350 3100
	1    0    0    -1  
$EndComp
Text GLabel 4000 2200 2    60   Input ~ 0
/BUSACK
Wire Wire Line
	7000 2850 6650 2850
Wire Wire Line
	2450 2900 2700 2900
$Comp
L SW_PUSH SW2
U 1 1 56A02E79
P 900 3300
F 0 "SW2" H 1050 3410 50  0000 C CNN
F 1 "SOFT RESET" H 900 3220 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_SMALL" H 900 3300 50  0001 C CNN
F 3 "" H 900 3300 50  0000 C CNN
	1    900  3300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	900  2900 900  3000
Wire Wire Line
	900  3600 900  3800
Wire Wire Line
	900  4100 900  4200
Connection ~ 900  3700
Text GLabel 2450 2200 0    60   Input ~ 0
/RESET
Wire Wire Line
	2450 2200 2700 2200
$Comp
L SD_Card CON1
U 1 1 56A0251E
P 6550 5050
F 0 "CON1" H 5900 5600 50  0000 C CNN
F 1 "SD_Card" H 7150 4500 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x10" H 6750 5400 50  0000 C CNN
F 3 "" H 6550 5050 50  0000 C CNN
	1    6550 5050
	-1   0    0    1   
$EndComp
NoConn ~ 7450 4600
Wire Wire Line
	8450 5000 7450 5000
Wire Wire Line
	8450 4050 8450 5000
Wire Wire Line
	7450 5100 8700 5100
Wire Wire Line
	7900 5800 7900 5000
Connection ~ 7900 5000
Wire Wire Line
	8000 4650 8000 5100
Connection ~ 8000 5100
NoConn ~ 7450 5200
Text GLabel 4300 3500 2    60   BiDi ~ 0
A0
Text GLabel 4300 3400 2    60   BiDi ~ 0
A1
Text GLabel 4300 3200 2    60   BiDi ~ 0
A2
Text GLabel 4300 3000 2    60   BiDi ~ 0
A3
Text GLabel 4300 2900 2    60   BiDi ~ 0
A4
Text GLabel 2450 3300 0    60   BiDi ~ 0
A5
Text GLabel 2450 3400 0    60   BiDi ~ 0
A6
Text GLabel 2450 3500 0    60   BiDi ~ 0
A8
Text GLabel 2450 3600 0    60   BiDi ~ 0
A9
Wire Wire Line
	4300 2900 4000 2900
Wire Wire Line
	4000 3000 4300 3000
Wire Wire Line
	4300 3200 4000 3200
Wire Wire Line
	4000 3400 4300 3400
Wire Wire Line
	4300 3500 4000 3500
Wire Wire Line
	2700 3600 2450 3600
Wire Wire Line
	2450 3500 2700 3500
Wire Wire Line
	2700 3400 2450 3400
Wire Wire Line
	2450 3300 2700 3300
Text GLabel 2450 4000 0    60   Output ~ 0
/MREQ
Wire Wire Line
	2450 4000 2700 4000
$Comp
L +3.3V #PWR21
U 1 1 56A03E02
P 2400 1600
F 0 "#PWR21" H 2400 1450 50  0001 C CNN
F 1 "+3.3V" H 2400 1740 50  0000 C CNN
F 2 "" H 2400 1600 60  0000 C CNN
F 3 "" H 2400 1600 60  0000 C CNN
	1    2400 1600
	1    0    0    -1  
$EndComp
Text GLabel 4300 3100 2    60   Input ~ 0
/HALT
Wire Wire Line
	4000 3100 4300 3100
$EndSCHEMATC
