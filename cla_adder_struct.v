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

    wire [3:0]A,B;
    wire P0,P1, P2, P3;
    wire G0, G1,G2,G3;

    dff ff1(clk,A_in[0],A[0]);
    dff ff2(clk,A_in[1],A[1]);
    dff ff3(clk,A_in[2],A[2]);
    dff ff4(clk,A_in[3],A[3]);

    dff ff5(clk,B_in[0],B[0]);
    dff ff6(clk,B_in[1],B[1]);
    dff ff7(clk,B_in[2],B[2]);
    dff ff8(clk,B_in[3],B[3]);

    
    my_xor g1(P0, A[0], B[0]);
    my_xor g2(P1, A[1], B[1]);
    my_xor g3(P2, A[2], B[2]);
    my_xor g4(P3, A[3], B[3]);

    my_and g5(G0, A[0], B[0]);
    my_and g6(G1, A[1], B[1]);
    my_and g7(G2, A[2], B[2]);
    my_and g8(G3, A[3], B[3]);

    my_and g9(pc0, P0,Cin);
    my_or g10(C1, pc0, G0);

    and g11(p1p0c0, P1, P0, Cin);
    and g12(p1g0, P1, G0);
    or g13(C2,p1p0c0, p1g0, G1);

    and g14(p2p1p0c0, P2, P1, P0, Cin);
    and g15(p2p1g0, P2, P1, G0);
    and g16(p2g1,P2, G1);
    or g17(C3, p2p1p0c0, p2p1g0, p2g1, G2);

    and g18(p3p2p1p0c0, P3, P2, P1, P0, Cin);
    and g19(p3p2p1g0, P3, P2, P1, G0);
    and g20(p3p2g1, P3, P2, G1);
    and g21(p3g2, P3, G2);
    or g22(Cout, p3p2p1p0c0, p3p2p1g0, p3p2g1, p3g2, G3);

    my_xor g23(P0, Cin, sum[0]);
    my_xor g24(P1, C1, sum[1]);
    my_xor g25(P2, C2, sum[2]);
    my_xor g26(P3, C3, sum[3]);

endmodule

module tb();
reg [3:0]A,B;
reg clk;
reg Cin;
wire [3:0]sum;
wire Cout;

// Generate clk
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Initial values
initial begin
    A = 4'b0000;
    B = 4'b0000;
    Cin = 0;
end

// DUT instantiation
adder dut(.A_in(A), .B_in(B), .Cin(Cin), .sum(sum), .Cout(Cout), .clk(clk));

// Testcases

initial begin
    // Monitoring the values
    $monitor("Time: %t | A: %b | B: %b | Cin : %b |Sum: %b | Cout: %b", $time, A, B,Cin, sum, Cout);

    #10 A = 4'b0000; B = 4'b0010; Cin = 0; // Test case 1
    #10 A = 4'b0010; B = 4'b0100; Cin = 1; // Test case 2
    #10 A = 4'b1111; B = 4'b0001; Cin = 0; // Test case for overflow
    #10 A = 4'b0111; B = 4'b0001; Cin = 1;

    #50 $finish;
end
endmodule