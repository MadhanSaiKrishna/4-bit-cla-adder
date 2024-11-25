`timescale 1ns/1ps

module my_and(A,B,Y);
    input A,B;
    output Y;
    assign Y = A & B;
endmodule

module my_not(A,Y);
    input A;
    output Y;
    assign Y = ~A;
endmodule

module my_or(A,B,Y);
    input A,B;
    output Y;
    assign Y = A | B;
endmodule

module my_xor(A,B,Y);
    input A,B;
    output Y;
    assign Y = A^B;
endmodule

module my_nand(A,B,Y);
    input A,B;
    output Y;
    assign Y = ~(A & B);
endmodule

module dff(clk,d,q);
    input clk;
    input d;
    output q;
    my_not not_gate(d,d_not);
    my_nand g1(d,clk,s_bar);
    my_nand g2(d_not,clk,r_bar);
    my_nand g3(s_bar,q_not,q);
    my_nand g4(r_bar,q, q_not);
endmodule

module adder(A_in, B_in, Cin, sum, Cout,clk);
    input clk;
    input [3:0]A_in, B_in;
    input Cin;
    output [3:0]sum;
    output Cout;

    wire [3:0] A, B;
    wire P0, P1, P2, P3;
    wire G0, G1, G2, G3;
    wire C1, C2, C3;
    wire pc0, p1p0c0, p1g0, p2p1p0c0, p2p1g0, p2g1, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2;

    dff ff1(clk,A_in[0],A[0]);
    dff ff2(clk,A_in[1],A[1]);
    dff ff3(clk,A_in[2],A[2]);
    dff ff4(clk,A_in[3],A[3]);

    dff ff5(clk,B_in[0],B[0]);
    dff ff6(clk,B_in[1],B[1]);
    dff ff7(clk,B_in[2],B[2]);
    dff ff8(clk,B_in[3],B[3]);

    
    my_xor g1(A[0], B[0],P0);
    my_xor g2(A[1], B[1],P1);
    my_xor g3(A[2], B[2],P2);
    my_xor g4(A[3], B[3],P3);

    my_and g5(A[0], B[0], G0);
    my_and g6(A[1], B[1], G1);
    my_and g7(A[2], B[2], G2);
    my_and g8(A[3], B[3], G3);

    my_and g9(P0,Cin,pc0);
    my_or g10(pc0, G0,C1);

    and g11(p1p0c0, P1, P0, Cin);
    and g12(p1g0, P1, G0);
    or g13(C2,p1p0c0, p1g0, G1);

    and g14(p2p1p0c0, P2, P1, P0, Cin);
    and g15(p2p1g0, P2, P1, G0);
    and g16(p2g1,P2, G1);
    or g17(C3, p2p1p0c0, p2p1g0, p2g1, G2);

    wire Cout_out;
    wire [3:0]sum_out;

    and g18(p3p2p1p0c0, P3, P2, P1, P0, Cin);
    and g19(p3p2p1g0, P3, P2, P1, G0);
    and g20(p3p2g1, P3, P2, G1);
    and g21(p3g2, P3, G2);
    or g22(Cout_out, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2, G3);

    my_xor g23(P0, Cin, sum_out[0]);
    my_xor g24(P1, C1, sum_out[1]);
    my_xor g25(P2, C2, sum_out[2]);
    my_xor g26(P3, C3, sum_out[3]);

    dff ff9(clk,sum_out[0],sum[0]);
    dff ff10(clk,sum_out[1],sum[1]);
    dff ff11(clk,sum_out[2],sum[2]);
    dff ff12(clk,sum_out[3],sum[3]);
    dff ff13(clk, Cout_out,Cout);

endmodule

module tb();

reg [3:0] A,B;
reg Cin;
reg clk;

wire [3:0] sum;
wire Cout;
integer i;

adder dut(.A_in(A),.B_in(B),.Cout(Cout),.sum(sum),.Cin(Cin),.clk(clk));

initial begin
    A = 4'b0;
    B = 4'b0;
    Cin = 1'b0;
end

initial begin 
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    for(i = 0; i< 16 ; i = i+1)
    begin
        A = i;
        B = i;
        Cin = 0;
        #10;
    end
end

initial begin
    $monitor($time, " A = %4b , B = %4b , Cin = %b , Sum = %4b , Cout = %b, Clk : ", A, B, Cin, sum, Cout,clk);
    #160;
    $finish;
end
endmodule