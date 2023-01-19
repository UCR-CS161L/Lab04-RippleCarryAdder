//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module full_adder (
  input wire a,
  input wire b,
  input wire c_in,
  output reg s,
  output reg c_out
);

  wire [2:0] level1;
  wire [2:0] level2;
  wire c_out_w;

  slow_and and1(.a(a), .b(b),    .result(level1[0]));
  slow_and and2(.a(a), .b(c_in), .result(level1[1]));
  slow_and and3(.a(b), .b(c_in), .result(level1[2]));

  slow_or #(.NUMINPUTS(3)) or1(.a(level1), .result(c_out_w));

  always @(*) begin
    s <= (~a & ~b &  c_in) |
         (~a &  b & ~c_in) |
         ( a &  b &  c_in) |
         ( a & ~b & ~c_in);

    c_out <= c_out_w;
  end

endmodule