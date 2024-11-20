// Structural Codes

`timescale 1ns/1ps
module dff(clk,d,q);
input clk, d;
output q;

wire d_not;
not(d_not,d);

wire s_bar,r_bar;

nand(s_bar,d,clk);
nand(r_bar,d_not,clk);

wire q_not;
nand(q_not,r_bar,q);
nand(q,s_bar,q_not);

endmodule

module adder(A_in,B_in,Cin,S,Cout,clk);
input [3:0]A_in;
input [3:0]B_in;
input Cin;
output [3:0]S;
output Cout;

wire P0,P1,P2,P3;
wire G0,G1,G2,G3;
wire C1,C2,C3;

reg [3:0]A;
reg [3:0]B;


dff(clk,A_in[0],A[0]);
dff(clk,A_in[1],A[1]);
dff(clk,A_in[2],A[2]);
dff(clk,A_in[3],A[3]);

dff(clk,B_in[0],B[0]);
dff(clk,B_in[1],B[1]);
dff(clk,B_in[2],B[2]);
dff(clk,B_in[3],B[3]);

xor(P0, A[0], B[0]);
xor(P1, A[1], B[1]);
xor(P2, A[2], B[2]);
xor(P3, A[3], B[3]);

and(G0, A[0], B[0]);
and(G1, A[1], B[1]);
and(G2, A[2], B[2]);
and(G3, A[3], B[3]);

wire p0c0;
and(pc0, P0,Cin);
or(C1, pc0, G0);

wire p1p0c0, p1g0;
and(p1p0c0, P1, P0, Cin);
and(p1g0, P1, G0);
or(C2,p1p0c0, p1g0, G1);

wire p2p1p0c0, p2p1g0, p2g1, g2;
and(p2p1p0c0, P2, P1, P0, Cin);
and(p2p1g0, P2, P1, G0);
and(p2g1,P2, G1);
or(C3, p2p1p0c0, p2p1g0, p2g1, g2);

wire p3p2p1p0c0 , p3p2p1g0, p3p2g1, p3g2, g3;
and(p3p2p1p0c0, P3, P2, P1, P0, Cin);
and(p3p2p1g0, P3, P2, P1, G0);
and(p3p2g1, P3, P2, G1);
and(p3g2, P3, G2);
or(Cout, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2, g3);

xor(S[0], P0, Cin);
xor(S[1], P1, C1);
xor(S[2], P2, C2);
xor(S[3], P3, C3);

// module tb();
// reg clk;
// reg d;
// wire q;

// dff dut(.clk(clk), .d(d), .q(q));


// initial begin
//     clk = 0;
//     d = 0;
//     $monitor("Time : %t | Clk : %b | d : %b | q : %b", $time,clk, d, q);

//     #5 d = 1;
//     #10;
//     #5 d = 0;
//     #10;
//     #5 d = 1;
//     #15; 
//     $finish;
// end
// always #5 clk = ~clk;
// endmodule