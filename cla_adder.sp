4-bit CLA Adder
.include TSMC_180nm.txt
.include inverter.cir
.include dff.cir
.include carry_one.cir
.include carry_two.cir
.include carry_three.cir
.include carry_out.cir
.include two_input_xor.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

V1 A0_in gnd pulse 0 1.8 0u 10p 10p 1u 3u
V2 B0_in gnd pulse 0 1.8 0u 10p 10p 1u 3u
V3 A1_in gnd pulse 0 1.8 0.5u 10p 10p 1u 3u
V4 B1_in gnd pulse 0 1.8 0.9u 10p 10p 1u 3u
V5 A2_in gnd pulse 0 1.8 0u 10p 10p 1u 3u
V6 B2_in gnd pulse 0 1.8 0u 10p 10p 1u 3u
V7 A3_in gnd pulse 0 1.8 0u 10p 10p 1u 3u
V8 B3_in gnd pulse 0 1.8 0u 10p 10p 1u 3u

V9 clk gnd pulse 0 1.8 0.7u 10p 10p 1u 3u

V10 Cin gnd dc 0

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

X13 A0 B0 p0 vdd gnd two_xor
X14 p0 Cin S0_out vdd gnd two_xor

X15 A1 B1 p1 vdd gnd two_xor
X16 p1 C1 S1_out vdd gnd two_xor

X17 A2 B2 p2 vdd gnd two_xor
X18 p2 C2 S2_out vdd gnd two_xor

X19 A3 B3 p3 vdd gnd two_xor
X20 p3 C3 S3_out vdd gnd two_xor

X21 S0_out S0 clk vdd gnd dff
X22 S1_out S1 clk vdd gnd dff
X23 S2_out S2 clk vdd gnd dff
X24 S3_out S3 clk vdd gnd dff

.tran 10n 10u

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
plot V(clk) V(A1_in)+2 V(A1)+4 V(B1_in)+6 V(B1)+8 V(S1)+10 V(C1)+12 V(c2)+14
.endc