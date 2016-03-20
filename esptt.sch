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
LIBS:ESP8266
LIBS:aalay
LIBS:OPL-Antenna
LIBS:esptt-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LM1117-SOT223 U?
U 1 1 56EF32B9
P 4750 2650
F 0 "U?" H 4750 2936 50  0000 C CNN
F 1 "LM1117-SOT223" H 4750 2845 50  0000 C CNN
F 2 "aalay-SOT223" H 4750 2800 50  0001 C CNN
F 3 "" H 4750 2650 60  0000 C CNN
F 4 "LM1117 Ajustable/Fixed LDO Regulator" H 4750 2650 60  0001 C CNN "Desc"
F 5 "NIL" H 4750 2650 60  0001 C CNN "MFG NO"
F 6 "NIL" H 4750 2650 60  0001 C CNN "MFR"
F 7 "NIL" H 4750 2650 60  0001 C CNN "Notes"
	1    4750 2650
	1    0    0    -1  
$EndComp
$Comp
L SMD-BUILT-IN-ANTENNA-2.4GHZ(2P-9.5X2.1MM)'AN9520' ANT?
U 1 1 56EF333D
P 3600 4150
F 0 "ANT?" H 3600 4365 50  0000 C CNN
F 1 "SMD-BUILT-IN-ANTENNA-2.4GHZ(2P-9.5X2.1MM)'AN9520'" H 3600 4274 50  0000 C CNN
F 2 "OPL-Antenna-ANT2-SMD-9.5X2.1X1.0MM" H 3600 4300 50  0001 C CNN
F 3 "" H 3600 4150 60  0000 C CNN
F 4 "318010004" H 3600 4150 60  0001 C CNN "Desc"
F 5 "NIL" H 3600 4150 60  0001 C CNN "MFG NO"
F 6 "NIL" H 3600 4150 60  0001 C CNN "MFR"
F 7 "NIL" H 3600 4150 60  0001 C CNN "Notes"
	1    3600 4150
	1    0    0    -1  
$EndComp
$Comp
L USB_B P?
U 1 1 56EF3418
P 5450 1900
F 0 "P?" H 5473 2231 50  0000 C CNN
F 1 "USB_B" H 5473 2140 50  0000 C CNN
F 2 "" V 5400 1800 50  0000 C CNN
F 3 "" V 5400 1800 50  0000 C CNN
	1    5450 1900
	1    0    0    -1  
$EndComp
$Comp
L ESP-06 U?
U 1 1 56EF3B27
P 5400 4250
F 0 "U?" H 5400 5328 50  0000 C CNN
F 1 "ESP-06" H 5400 5237 50  0000 C CNN
F 2 "" H 5400 4400 50  0001 C CNN
F 3 "" H 5400 4400 50  0001 C CNN
	1    5400 4250
	1    0    0    -1  
$EndComp
$EndSCHEMATC
