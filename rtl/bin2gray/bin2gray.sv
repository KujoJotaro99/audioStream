`timescale 1ns/1ps

module bin2gray
#(
    parameter WIDTH_P = 8
) (
  input logic [WIDTH_P-1:0] bin_i,
  output logic [WIDTH_P-1:0] gray_o
);
    assign gray_o = bin_i ^ (bin_i >> 1);
endmodule
