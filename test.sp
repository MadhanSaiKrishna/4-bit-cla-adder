test
.param SUPPLY=1.8
.param LAMBDA=0.09u
.global gnd vdd
.include TSMC_180nm.txt
Vdd vdd gnd 'SUPPLY'

V1 A0 gnd pulse (0 1.8 0 10p 10p 20n 50n)

V3 B0 gnd pulse (0 1.8 0 10p 10p 20n 40n)

V2 Cin gnd pulse (0 1.8 0 10p 10p 20n 30n)


M1 a_13_n59# b0 n010 Gnd CMOSN w=20 l=2
+  ad=200 pd=60 as=300 ps=150
M2 n010 b0 a_37_n59# Gnd CMOSN w=20 l=2
+  ad=0 pd=0 as=300 ps=110
M3 gnd a0 a_13_n59# Gnd CMOSN w=20 l=2
+  ad=300 pd=110 as=0 ps=0
M14 c1 n010 vdd vdd CMOSP w=40 l=2
+  ad=200 pd=90 as=600 ps=190
M5 a_13_5# b0 n010 w_0_n1# CMOSP w=40 l=2
+  ad=400 pd=100 as=600 ps=270
M6 a_37_n59# cin gnd Gnd CMOSN w=20 l=2
+  ad=0 pd=0 as=0 ps=0
M7 vdd a0 a_13_5# w_0_n1# CMOSP w=40 l=2
+  ad=0 pd=0 as=0 ps=0
M8 n010 b0 n003 w_72_n1# CMOSP w=40 l=2
+  ad=0 pd=0 as=600 ps=190
M9 c1 n010 gnd Gnd CMOSN w=20 l=2
+  ad=100 pd=50 as=0 ps=0
M10 n003 cin vdd w_0_n1# CMOSP w=40 l=2
+  ad=0 pd=0 as=0 ps=0
M11 n010 a0 a_37_n59# Gnd CMOSN w=20 l=2
+  ad=0 pd=0 as=0 ps=0
M12 n010 a0 n003 w_0_n1# CMOSP w=40 l=2
+  ad=0 pd=0 as=0 ps=0


* C0 gnd c1 0.23fF
* C1 a_13_n59# n010 0.27fF
* C2 b0 n010 0.01fF
* C3 vdd c1 0.49fF
* C4 a_37_n59# gnd 0.21fF
* C5 n010 a_13_5# 0.50fF
* C6 gnd n010 0.11fF
* C7 a0 w_0_n1# 0.21fF
* C8 vdd n010 0.10fF
* C9 vdd n003 0.41fF
* C10 w_0_n1# n010 0.34fF
* C11 n003 w_0_n1# 0.03fF
* C12 w_72_n1# n010 0.06fF
* C13 w_72_n1# n003 0.06fF
* C14 cin w_0_n1# 0.10fF
* C15 c1 n010 0.05fF
* C16 gnd a_13_n59# 0.21fF
* C17 a_37_n59# n010 0.61fF
* C18 a0 n010 0.01fF
* C19 n003 a0 0.08fF
* C20 b0 w_0_n1# 0.10fF
* C21 n003 n010 1.03fF
* C22 vdd a_13_5# 0.41fF
* C23 w_72_n1# b0 0.10fF
* C24 w_0_n1# a_13_5# 0.03fF
* C25 cin n010 0.00fF
* C26 vdd w_0_n1# 0.03fF
* C27 gnd Gnd 0.16fF
* C28 a_37_n59# Gnd 0.23fF
* C29 a_13_n59# Gnd 0.05fF
* C30 c1 Gnd 0.07fF
* C31 n003 Gnd 0.14fF
* C32 vdd Gnd 1.34fF
* C33 a_13_5# Gnd 0.03fF
* C34 n010 Gnd 3.04fF
* C35 b0 Gnd 0.58fF
* C36 a0 Gnd 0.63fF
* C37 cin Gnd 0.33fF
* C38 w_72_n1# Gnd 1.38fF
* C39 w_0_n1# Gnd 3.51fF

.tran 1n 200n

.control
run
set hcopypscolor = 1
*Background plot color
set color0 = white
*Grid and text color
set color1 = black
plot V(a0)
.endc