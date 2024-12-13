4-bit CLA Adder
.include TSMC_180nm.txt
.include inverter.cir
.include dff.cir
.include carry_one.cir
.include carry_two.cir
.include carry_three.cir
.include carry_out.cir
.include cout_new.cir
.include two_input_xor.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

V1 A0_in gnd pulse 0 1.8 0 10p 10p 2n 4n
V2 B0_in gnd pulse 0 1.8 0 10p 10p 3n 5n
V3 A1_in gnd pulse 0 1.8 0 10p 10p 4n 6n
V4 B1_in gnd pulse 0 1.8 0 10p 10p 5n 7n
V5 A2_in gnd pulse 0 1.8 0 10p 10p 2n 4n
V6 B2_in gnd pulse 0 1.8 0 10p 10p 3n 5n
V7 A3_in gnd pulse 0 1.8 0 10p 10p 4n 6n
V8 B3_in gnd pulse 0 1.8 0 10p 10p 5n 7n

V9 clk gnd pulse 0 1.8 1.3n 10p 10p 2n 4n


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
* Xinv1 C1_dup_inv C1_dup vdd gnd inverter width_P=20*LAMBDA width_N=10*LAMBDA
* Xinv2 C1 C1_dup_inv vdd gnd inverter width_P=20*LAMBDA width_N=10*LAMBDA

*Carry 2 Test
X4 A1_in A1 clk vdd gnd dff
X5 B1_in B1 clk vdd gnd dff

X6 C2 A1 B1 A0 B0 Cin vdd gnd carry_two

X7 A2_in A2 clk vdd gnd dff
X8 B2_in B2 clk vdd gnd dff

X9 C3 A2 B2 A1 B1 A0 B0 Cin vdd gnd carry_three

X10 A3_in A3 clk vdd gnd dff
X11 B3_in B3 clk vdd gnd dff

* X12 Cout_dup A3 B3 A2 B2 A1 B1 A0 B0 Cin vdd gnd carry_out
X12 cout A3 B3 A2 B2 A1 B1 A0 B0 Cin clk vdd gnd cout_new

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

*For output drive
X25 S0_inv S0 vdd gnd inverter width_P = 20*LAMBDA width_N=10*LAMBDA
X26 S1_inv S1 vdd gnd inverter width_P = 20*LAMBDA width_N=10*LAMBDA
X27 S2_inv S2 vdd gnd inverter width_P = 20*LAMBDA width_N=10*LAMBDA
X28 S3_inv S3 vdd gnd inverter width_P = 20*LAMBDA width_N=10*LAMBDA


.tran 0.01n 20n

.meas tran tpcq trig v(clk) val=0.9 td=0 rise=4 targ v(a0) val=0.9 td=0 rise = 1
* .meas tran tpcq_f trig v(clk) val=0.9 td=0 fall=1 targ v(a0) val=0.9 td=0 fall=1

* .meas tran tpcq param = (tpcq_r + tpcq_f)/2


.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
set curplottitle = Madhan-2023102030
* plot V(clk) V(A0_in)+2 V(a0)+4 V(B0_in)+6 V(b0)+8
* plot V(clk) V(S0)+2 V(C1)+4

* plot V(clk) V(a0_in)+2 V(a0)+4
* plot V(clk) V(a1_in)+2 V(a1)+4
* plot V(clk) V(a2_in)+2 V(a2)+4
* plot V(clk) V(a3_in)+2 V(a3)+4
* plot V(clk) V(b0_in)+2 V(b0)+4
* plot V(clk) V(b1_in)+2 V(b1)+4
* plot V(clk) V(b2_in)+2 V(b2)+4
* plot V(clk) V(b3_in)+2 V(b3)+4



* plot V(a0) V(b0)+2 V(cin)+4 V(S0_out)+6 V(c1)+8
* plot V(a1) V(b1)+2 V(c1)+4 V(S1_out)+6 V(c2)+8
* plot V(a2) V(b2)+2 V(c2)+4 V(S2_out)+6 V(c3)+8
* plot V(a3) V(b3)+2 V(c3)+4 V(S3_out)+6
* plot V(clk) V(cout)+2

* plot V(clk) V(s0_out)+2 V(s0)+4
* plot V(clk) V(s1_out)+2 V(s1)+4
* plot V(clk) V(s2_out)+2 V(s2)+4
* plot V(clk) V(s3_out)+2 V(s3)+4
* plot V(clk) V(cout)+4

* plot V(clk) V(a0_in)+2 V(b0_in)+4 V(cin)+6
* plot V(clk) V(a1_in)+2 V(b1_in)+4
* plot V(clk) V(a2_in)+2 V(b2_in)+4
* plot V(clk) V(a3_in)+2 V(b3_in)+4

* plot V(clk) V(s0)+2 V(s1)+4 V(s2)+6 V(s3)+8 V(cout)+10

.endc