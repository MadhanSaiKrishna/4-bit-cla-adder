// Structural Codes

`timescale 1ns/1ps
module dff(clk,d,q);
input clk, d;
output q;

wire d_not;
not(d_not,d);

wire s_bar,r_bar;

nand gate1(s_bar,d,clk);
nand gate2(r_bar,d_not,clk);

wire q_not;
nand gate3(q_not,r_bar,q);
nand gate4(q,s_bar,q_not);

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


dff flipflop1(clk,A_in[0],A[0]);
dff flipflop2(clk,A_in[1],A[1]);
dff flipflop3(clk,A_in[2],A[2]);
dff flipflop4(clk,A_in[3],A[3]);

dff flipflop5(clk,B_in[0],B[0]);
dff flipflop6(clk,B_in[1],B[1]);
dff flipflop7(clk,B_in[2],B[2]);
dff flipflop8(clk,B_in[3],B[3]);

xor gate1(P0, A[0], B[0]);
xor gate2(P1, A[1], B[1]);
xor gate3(P2, A[2], B[2]);
xor gate4(P3, A[3], B[3]);

and gate5(G0, A[0], B[0]);
and gate6(G1, A[1], B[1]);
and gate7(G2, A[2], B[2]);
and gate8(G3, A[3], B[3]);

wire p0c0;
and gate9(pc0, P0,Cin);
or gate10(C1, pc0, G0);

wire p1p0c0, p1g0;
and gate11(p1p0c0, P1, P0, Cin);
and gate12(p1g0, P1, G0);
or gate13(C2,p1p0c0, p1g0, G1);

wire p2p1p0c0, p2p1g0, p2g1, g2;
and gate14(p2p1p0c0, P2, P1, P0, Cin);
and gate15(p2p1g0, P2, P1, G0);
and gate16(p2g1,P2, G1);
or gate17(C3, p2p1p0c0, p2p1g0, p2g1, g2);

wire p3p2p1p0c0 , p3p2p1g0, p3p2g1, p3g2, g3;
and gate18(p3p2p1p0c0, P3, P2, P1, P0, Cin);
and gate19(p3p2p1g0, P3, P2, P1, G0);
and gate20(p3p2g1, P3, P2, G1);
and gate21(p3g2, P3, G2);
or gate22(Cout, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2, g3);

xor gate23(S[0], P0, Cin);
xor gate24(S[1], P1, C1);
xor gate25(S[2], P2, C2);
xor gate26(S[3], P3, C3);

endmodule

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

module adder_tb();
reg [3:0]A,B;
reg Cin;
reg clk;
wire [3:0] sum;
wire Cout;

adder dut(.A_in(A),.B_in(B),.Cin(Cin),.S(sum), .Cout(Cout),.clk(clk));

initial begin
    A = 4'b0000;
    B = 4'b0000;
    Cin = 1'b0;
    clk = 0;
    $monitor("Time : %t | A = %b | B = %b | C = %b | Cout = %b | Sum = %b", $time,A,B,Cin,Cout,sum );
    #100;
    $finish
end

always #5 clk = clk;
endmodule