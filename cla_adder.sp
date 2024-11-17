4-bit CLA Adder
.include TSMC_180nm.txt
.include inverter.cir
.include dff.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

V1 A0_in gnd pulse 0 1.8 3u 10p 10p 2u 3u
V2 B0_in gnd pulse 0 1.8 3u 10p 10p 1u 2u
V3 A1_in gnd pulse 0 1.8 0 10p 10p 1u 2u
V4 B1_in gnd pulse 0 1.8 1.5u 10p 10p 3u 5u
V5 A2_in gnd pulse 0 1.8 4u 10p 10p 1u 2u
V6 B2_in gnd pulse 0 1.8 0 1n 1n 4u 5u
V7 A3_in gnd pulse 0 1.8 1.5u 10p 10p 1u 2u
V8 B3_in gnd pulse 0 1.8 4u 10p 10p 1u 2u

V9 clk gnd pulse 0 1.8 0.5u 10p 10p 1u 2u

X1 b A0_in vdd gnd inverter width_P={40*LAMBDA} width_N={20*LAMBDA}

.tran 10n 10u 0

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
plot v(b)
.endc