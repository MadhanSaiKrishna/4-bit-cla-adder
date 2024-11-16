CMOS Inverter with equal Rise and Fall time
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
Vdd vdd gnd 'SUPPLY'
vin a gnd pulse 0 1.8 0ns 1ns 1ns 10ns 20ns


.subckt inv y x vdd gnd width_P=20*LAMBDA
+width_N=10*LAMBDA

.param width_P=20*LAMBDA
.param width_N=10*LAMBDA

M1 y x gnd gnd CMOSN W={width_N} L={2*LAMBDA} 
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
+ AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M2 y x vdd vdd CMOSP W={width_P} L={2*LAMBDA}
+AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P}
+AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

.ends inv

x1 b a vdd gnd inv width_P = 90*LAMBDA width_N=30*LAMBDA
    Cout b gnd 100f

.measure tran tr
+ TRIG v(a) VAL='SUPPLY/10' RISE=1
+ TARG v(b) VAL='(9*SUPPLY)/10' RISE=1

.measure tran tf
+ TRIG v(a) VAL='SUPPLY/10' FALL=1
+ TARG v(b) VAL='(9*SUPPLY)/10' FALL=1


.tran 0.1n 200n 10n
.control
run
plot v(b)
set hcopypscolor = 1

.endc