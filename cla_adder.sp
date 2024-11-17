4-bit CLA Adder
.include TSMC_180nm.txt
.include inverter.cir
.include dff.cir
.include carry_one.cir
.include carry_two.cir
.include carry_three.cir
.include carry_out.cir
.include three_input_xor.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

V1 A0_in gnd pulse 0 1.8 1u 10p 10p 2u 3u
V2 B0_in gnd pulse 0 1.8 3u 10p 10p 1u 2u
V3 A1_in gnd pulse 0 1.8 2u 10p 10p 2u 5u
V4 B1_in gnd pulse 0 1.8 1.5u 10p 10p 3u 5u
V5 A2_in gnd pulse 0 1.8 0 10p 10p 2u 5u
V6 B2_in gnd pulse 0 1.8 3u 1n 1n 2u 5u
V7 A3_in gnd pulse 0 1.8 1.5u 10p 10p 1u 2u
V8 B3_in gnd pulse 0 1.8 4u 10p 10p 1u 2u

V9 clk gnd pulse 0 1.8 0u 10p 10p 1u 2u

V10 Cin gnd dc 'SUPPLY'

*D Flip-flop test
* X1 A0_in a clk vdd gnd dff
* C1 a gnd 100f

* .measure tran tpcq
* + TRIG v(clk) VAL='SUPPLY/2' RISE=2
* + TARG v(a) VAL='(SUPPLY)/2' RISE=1

*Carry 1 Test
X1 A0_in A0 clk vdd gnd dff
X2 B0_in B0 clk vdd gnd dff

X3 C1 A0 B0 Cin vdd gnd carry_one

*Carry 2 Test
X4 A1_in A1 clk vdd gnd dff
X5 B1_in B1 clk vdd gnd dff

X6 C2 A1 B1 A0 B0 Cin vdd gnd carry_two

X7 A2_in A2 clk vdd gnd dff
X8 B2_in B2 clk vdd gnd dff

X9 C3 A2 B2 A1 B1 A0 B0 Cin vdd gnd carry_three

X10 A3_in A3 clk vdd gnd dff
X11 B3_in B3 clk vdd gnd dff

X12 Cout A3 B3 A2 B2 A1 B1 A0 B0 Cin vdd gnd carry_out

X13 A0_inv A0 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X14 B0_inv B0 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X15 Cin_inv Cin vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA 

X16 A0 B0 C0 S0_out A0_inv B0_inv Cin_inv vdd gnd xor

X17 A1_inv A1 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X18 B1_inv B1 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X19 C1_inv C1 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA

X20 A1 B1 C1 S1_out A1_inv B1_inv C1_inv vdd gnd xor

X21 A2_inv A2 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X22 B2_inv B2 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X23 C2_inv C2 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA

X24 A2 B2 C2 S2_out A2_inv B2_inv C2_inv vdd gnd xor

X25 A3_inv A3 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X26 B3_inv B3 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA
X27 C3_inv C3 vdd gnd inverter width_P=40*LAMBDA width_N=20*LAMBDA

X28 A3 B3 C3 S3_out A3_inv B3_inv C3_inv vdd gnd xor

.tran 10n 10u 0

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
plot V(A2) V(B2)+2 V(c2)+4 V(S2_out)+6
.endc