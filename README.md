## To Do List

- [ ] Task 1: Size the mosfets in TSPC d flip flop


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