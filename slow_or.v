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

module slow_or # ( parameter NUMINPUTS = 2 ) (
  input wire [NUMINPUTS-1:0] a,
  output reg result
);

always @(*) begin
  result = |a;
end

endmodule