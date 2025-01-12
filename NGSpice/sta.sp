.include TSMC_180nm.txt
.include dff.cir
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'

*Calculate setup, hold time properly

* V1 clk gnd pulse 0 1.8 1n 10p 10p 2n 4n
* *Setup time
* V2 A0_in gnd pulse 0 1.8 2.99n 10p 10p 2n 4n
* *Find proper Setup time

* *tpcq 
* * V2 A0_in gnd pulse 0 1.8 3.8n 10p 10p 2n 4n

* *hold time
* * V2 A0_in gnd pulse 0 1.8 2.991n 10p 10p 2n 4n
* * violation
* * V2 A0_in gnd pulse 0 1.8 2.993n 10p 10p 2n 4n
* * No violation

V1 clk gnd pulse 0 1.8 1n 0p 0p 2n 4n
V2 A0_in gnd pulse 0 1.8 2.95n 0p 0p 1.5n 3n

.ic v(A0) = 1.8

X1 A0_in A0 clk vdd gnd dff

.tran 0.1n 10n

* .measure tran c_q trig v(clk) val=0.9 td=0 rise=1 targ v(A0) val=0.9 td=0 rise=1

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