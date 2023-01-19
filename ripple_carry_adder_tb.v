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

module ripple_carry_adder_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab02.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    ripple_carry_adder #(.NUMBITS(NUMBITS)) uut (
        .A(A), 
        .B(B), 
        .carryin(1'b0),
        .result(result), 
        .carryout(carryout)
    );

    reg [15:0] A_16;
    reg [15:0] B_16;

    // Outputs
    wire [15:0] result_16;
    reg [15:0] expected_result_16;
    wire carryout_16;

    ripple_carry_adder #(.NUMBITS(16)) uut16 (
    .A(A_16), 
    .B(B_16), 
    .carryin(1'b0),
    .result(result_16), 
    .carryout(carryout_16)
    );

    reg [31:0] A_32;
    reg [31:0] B_32;

    // Outputs
    wire [31:0] result_32;
    reg [31:0] expected_result_32;
    wire carryout_32;

    ripple_carry_adder #(.NUMBITS(32)) uut32 (
    .A(A_32), 
    .B(B_32), 
    .carryin(1'b0),
    .result(result_32), 
    .carryout(carryout_32)
    );
    
    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h00;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2: 127+  1 = 128, c_out = 0 ... ");
        A = 8'h7F;
        B = 8'h01;
        expected_result = 8'h80;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.3: 255+  1 =   0, c_out = 1 ... ");
        A = 8'hFF;
        B = 8'h01;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.4: 123+ 46 = 169, c_out = 0 ... ");
        A = 8'd123;
        B = 8'd46;
        expected_result = 8'd169;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.5: 123+146 =  13, c_out = 1 ... ");
        A = 8'd123;
        B = 8'd146;
        expected_result = 8'd13;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // ----------------------------------------
        // Div 2 
        // ----------------------------------------
        $write("Test Group 2: Increasing size of adder ...\n");
        
        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 2.1: 16-bit adder xFFFF + x0001 =  0, c_out = 1 ... ");
        A_16 = 16'hFFFF;
        B_16 = 16'h0001;
        expected_result_16 = 16'h0000;

        #100; // Wait 
        if (expected_result_16 !== result_16 || carryout_16 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 2.1: 32-bit adder xFFFFFFFF + x00000001 =  0, c_out = 1 ... ");
        A_32 = 32'hFFFFffff;
        B_32 = 32'h00000001;
        expected_result_32 = 32'h00000000;

        #100; // Wait 
        if (expected_result_32 !== result_32 || carryout_32 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule