
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param VGG=1.5
.param LAMBDA=0.09u
.param width_N={5*20*LAMBDA}
.param width_P={2.5*20*LAMBDA}
.global gnd vdd
.include dff.cir

vdd vdd gnd 1.8 
* .param Ton=4n
* .param Tperiod=n
.param Ton=5n
.param Tperiod={2*Ton}
.param shift=10.2n
V_clk_org clk_org 0 pulse(0 1.8 {Ton} 10p 10p {Ton} {Tperiod})

* V1 a1 0 pulse(0 1.8 {0.5*Ton} 10p 10p {0.7*Ton} {Tperiod})
V1 a1 0 PWL(0 0 {shift} 0 {shift+10p} 1.8 {shift+10p+0.7*Ton} 1.8 {shift+10p+0.7*Ton+10p} 0)

.ic v(q_a1) = 0

X1 a1 q_a1 clk_org vdd gnd dff

.tran 0.001n  {5*Ton+3n} 
.measure tran tsetup TRIG v(a1) VAL=0.9 rise=1 TARG v(clk_org) VAL=0.9 RISE=2
.measure tran tpcq TRIG v(clk_org) VAL=0.9 RISE=1 TARG v(q_a1) VAL=0.9 RISE=1

.control
* set hcopypscolor = 1 *White background for saving plots
* set color0=b ** color0 is used to set the background of the plot (manual sec:17.7))
* set color1=blue ** color1 is used to set the grid color of the plot (manual sec:17.7))

run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
set curplottitle = Madhan-2023102030
plot v(clk_org)+4 v(a1)+2 v(q_a1) 


.endc