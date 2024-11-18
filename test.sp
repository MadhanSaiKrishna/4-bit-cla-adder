test
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'
.include TSMC_180nm.txt
.include inverter.cir
.include two_input_xor.cir

V1 A0 gnd pulse 0 1.8 3u 10p 10p 2u 5u

V3 A1 gnd pulse 0 1.8 0 10p 10p 2u 4u

V5 A2 gnd pulse 0 1.8 1u 10p 10p 2u 3u

V2 A0_inv gnd pulse 1.8 0 3u 10p 10p 2u 5u

V4 A1_inv gnd pulse 1.8 0 0 10p 10p 2u 4u

V6 A2_inv gnd pulse 1.8 0 1u 10p 10p 2u 3u


* X1 A0_inv A0 vdd gnd inverter width_P = 40*LAMBDA width_N=20*LAMBDA
* X2 A1_inv A1 vdd gnd inverter width_P = 40*LAMBDA width_N=20*LAMBDA
* X3 A2_inv A2 vdd gnd inverter width_P = 40*LAMBDA width_N=20*LAMBDA

X1 a0 a1 p0 vdd gnd two_xor
x2 p0 a2 p0_out vdd gnd two_xor 


.tran 10n 10u

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
plot V(a0) V(a1)+2 V(a2)+4 V(p0_out)+6
.endc