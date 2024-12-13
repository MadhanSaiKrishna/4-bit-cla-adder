.include TSMC_180nm.txt
.include dff.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

V1 A0_in gnd pulse 0 1.8 0 10p 10p 2n 4n
*Setup time
* V2 clk gnd pulse 0 1.8 2.015n 10p 10p 2n 4n
*tpcq 
* V2 clk gnd pulse 0 1.8 2.8n 10p 10p 2n 4n
*hold time
V2 clk gnd pulse 0 1.8 1.995n 10p 10p 1n 2n

X1 A0_in A0 clk vdd gnd dff

.tran 0.1n 5n

.measure tran result trig v(clk) val=0.9 td=0 rise=1 targ v(A0) val=0.9 td=0 fall=1

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
set curplottitle = Madhan-2023102030

plot V(clk) V(A0_in)+2 V(A0)+4
.endc
.end