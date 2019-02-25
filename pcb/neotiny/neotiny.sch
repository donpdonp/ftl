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
LIBS:neotiny-cache
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
L ATTINY85-S IC1
U 1 1 58965CB8
P 5850 2850
F 0 "IC1" H 4700 3250 50  0000 C CNN
F 1 "ATTINY85-S" H 6850 2450 50  0000 C CNN
F 2 "SMD_Packages:SOIC-8-N" H 6800 2850 50  0000 C CIN
F 3 "" H 5850 2850 50  0000 C CNN
	1    5850 2850
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR01
U 1 1 58965CF2
P 7200 2150
F 0 "#PWR01" H 7200 2000 50  0001 C CNN
F 1 "+3.3V" H 7200 2290 50  0000 C CNN
F 2 "" H 7200 2150 50  0000 C CNN
F 3 "" H 7200 2150 50  0000 C CNN
	1    7200 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 58965D08
P 7200 3500
F 0 "#PWR02" H 7200 3250 50  0001 C CNN
F 1 "GND" H 7200 3350 50  0000 C CNN
F 2 "" H 7200 3500 50  0000 C CNN
F 3 "" H 7200 3500 50  0000 C CNN
	1    7200 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 2150 7200 2600
Wire Wire Line
	7200 3100 7200 3500
$Comp
L CONN_01X04 P1
U 1 1 5896639C
P 5900 1800
F 0 "P1" H 5900 2050 50  0000 C CNN
F 1 "CONN_01X04" V 6000 1800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5900 1800 50  0001 C CNN
F 3 "" H 5900 1800 50  0000 C CNN
	1    5900 1800
	0    -1   -1   0   
$EndComp
Connection ~ 7200 2200
Wire Wire Line
	7200 2200 6050 2200
Wire Wire Line
	6050 2200 6050 2000
Wire Wire Line
	7200 3400 7500 3400
Wire Wire Line
	7500 3400 7500 1800
Wire Wire Line
	7500 1800 6300 1800
Wire Wire Line
	6300 1800 6300 2300
Wire Wire Line
	6300 2300 5950 2300
Wire Wire Line
	5950 2300 5950 2000
Connection ~ 7200 3400
Wire Wire Line
	4500 2250 4500 2600
Wire Wire Line
	4500 2250 5850 2250
Wire Wire Line
	5850 2250 5850 2000
$EndSCHEMATC
