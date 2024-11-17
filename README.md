## To Do List

- [ ] Task 1: Size the mosfets in TSPC d flip flop
- [ ] Task 2: Change the sizing of the mosfets in PUN and PDN of carry and check the output (depending on the path the sizing can be decreased)
- [ ] Task 3: Verify the output of S0_out, S1_out, S2_out, S3_out, C0,C1,C2,C3

## Tips
- While designing the cmos inverters, overshoots can be observed in the output when the input transition from high to low or low to high.  This might be due to rapid change in the input and there is no load capacitance to stabilize the output. You can model the parasitic capacitance at the output node with a small capacitance in the spice to avoid this. (`Note`: This is for pre layout simulations)
- Drain and Source nodes in mosfets can be interchanged due to the symmetry of mosfet.

## Doubts
- My CMOS static XOR gate designed intially for three inputs didn't work out. Why?
- Cascading two 2 input XOR gates which takes ai,bi,ai_inv, bi_inv as input didn't work but cascading two 2 input XOR gates which takes ai, bi and computes ai_inv, bi_inv worked. Why?


# NGSpice Syntax

`PULSE(V1 V2 TD TR TF PW PER NP)`

V1 - Initial value  
V2 - Pulsed value  
TD - Delay time 
TR - Rise time
TF - Fall time
PW - Pulse Width
PER - Period  

`MXXXXXXX nd ng ns nb mname <m=val> <l=val> <w=val> <ad=val> <as=val> <pd=val> <ps=val> <nrd=val> <nrs=val> <off> <ic=vds, vgs, vbs> <temp=t>`

nd - drain node  
ng - gate node  
ns - source node   
nb - body node  

`.tran tstep tstop <tstart <tmax>> <uic>`

tstep - plotting increment  
tstop - final time  
tstart - start time 
tmax - max step size 
uic -  use initial conditions