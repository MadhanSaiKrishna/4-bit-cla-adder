// Behavioral Code for reference 
`timescale 1ns/1ps

module adder(A,B,Cout,sum,Cin);

input [3:0] A,B;
input Cin;
output [3:0] sum;
output Cout;

wire P0,P1,P2,P3;
wire G0,G1,G2,G3;
wire C0,C1,C2,C3,C4;

assign P0 = A[0] ^ B[0];
assign P1 = A[1] ^ B[1];
assign P2 = A[2] ^ B[2];
assign P3 = A[3] ^ B[3];

assign G0 = A[0] & B[0];
assign G1 = A[1] & B[1];
assign G2 = A[2] & B[2];
assign G3 = A[3] & B[3];

assign C0 = Cin;
assign C1 = (P0 & C0) | G0;
assign C2 = (P1 & P0 & C0) | (P1 & G0) | G1;
assign C3 = (P2 & P1 & P0 & C0) | (P2 & P1 & G0) | (P2 & G1) |G2;
assign C4 = (P3 & P2 & P1 & P0& C0) | (P3 & P2 & P1 & G0) | (P3 & P2 & G1) | (P3 & G2) | G3;

assign Cout = C4;

assign sum[0] = P0^C0;
assign sum[1] = P1 ^ C1;
assign sum[2] = P2 ^ C2;
assign sum[3] = P3 ^ C3;

endmodule    

module tb();

reg [3:0] A,B;
reg Cin;

wire [3:0] sum;
wire Cout;
integer i;

adder dut(A,B,Cout,sum,Cin);

initial begin
    A = 4'b0;
    B = 4'b0;
    Cin = 1'b0;
end

initial begin 
    for(i = 0; i< 16 ; i = i+1)
    begin
        A = i;
        B = i;
        Cin = 0;
        #5;
    end
end

initial begin
    $monitor($time, "A = %4b , B = %4b , Cin = %b , Sum = %4b , Cout = %b", A, B, Cin, sum, Cout);
    #80;
    $finish;
end
endmodule