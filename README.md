## Major Issues
1. In the layout, substrate connections are not given.
2. In the SPICE, body and source terminals are not connected.

## To Do List

- [ ] Task 1: Find the timing constraints, delay and power consumption
- [ ] Task 2: Calculate the propogation delay of the combinational circuit between the flip flops independently without these flip flops.
- [ ] Task 3: Find the setup time and hold time of the d flip flops i've used.
- [ ] Task 4: magic layout of the circuit
- [ ] Task 5: Post layout simulations
- [ ] Task 6: Fix the Verilog code - Output is appearing in the same rising edge
- [ ] Task 7: Complete the FPGA work
- [ ] Task 8: Stick diagrams, Pre-layout & Post-layout comaprisons, Floor Plan
- [ ] Task 9: Complete the report
- [ ] Task 10: Connect flip-flop for the Cin bit in layout
- [ ] Task 11: Change the d-ff in the layout




## Tips
- While designing the cmos inverters, overshoots can be observed in the output when the input transition from high to low or low to high.  This might be due to rapid change in the input and there is no load capacitance to stabilize the output. You can model the parasitic capacitance at the output node with a small capacitance in the spice to avoid this. (`Note`: This is for pre layout simulations)
- Drain and Source nodes in mosfets can be interchanged due to the symmetry of mosfet.
- For a static cmos design, which has a boolean expression for pun and pdn, layout can easily be drawn using euler's graph method.
- Do not use Metal 2 for polysilicon contacts, we can only use m1.

## Doubts
- My CMOS static XOR gate designed intially for three inputs didn't work out. Why?
- Cascading two 2 input XOR gates which takes ai,bi,ai_inv, bi_inv as input didn't work but cascading two 2 input XOR gates which takes ai, bi and computes ai_inv, bi_inv worked. Why?

## Note
1. In the carry circuit, i've considered equal sizing for all the mosfets in PDN and PUN to make the layout symmetric and easier.  
Sizing the mosfets in PDN and PUN of the carry circuits will help in reducing the delay and can drive larger loads.

2. The sizing of TSPC dff in cout_new cir is different than the individual dff module, in cout_new all the pmos have identical sizing and nmos have identical sizing.

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

## Design Parameters
lambda = 0.09u  
L = 2 x lambda = 0.18u  
width_N = 20 x lambda = 1.8u  
width_P = 40 x lambda = 3.6u

## Design Rules
1. Metal and diffusion have minimum `width` and `spacing` of 4 x lambda
2. Polysilicon uses a width of 2 x lambda
3. Polysilicon overlaps diffusion by 2 x lambda where a transistor is desired and has a spacing 1 x lambda away where no transistor is desired
4. Polysilicon and contacts have a spacing of 3 x lambda  from other polysilicon or contacts.
5. N-well surrounds pMOS transistors by 6 x lambda and avoids nMOS transistors by 6 x lambda.
6. length of ndiffusion and pdiffusion 12 x lambda  



## Magic Syntax

