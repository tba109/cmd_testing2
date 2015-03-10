`timescale 1ns / 100ps
`include "cmd_defs.vh"

`define TEST_GT_0
// `define TEST_GT_1
// `define TEST_THR_0

module cmd_testing2_tb();   
   reg clk;
   reg rst_n;
   reg [31:0] cmd_data;
   wire [31:0] rsp_data;
   reg 	       rsp_waitreq;
   reg 	       cmd_waitreq;
   wire        rsp_wrreq;
   wire        cmd_rdreq;
   wire [`N_TAP_CTL_SIZE-1:0] tap_ctl;
   
   fcr FCR0(
	    .clk(clk),
	    .rst_n(rst_n),
	    .cmd_data(cmd_data),
	    .rsp_data(rsp_data),
	    .cmd_rdreq(cmd_rdreq),
	    .rsp_wrreq(rsp_wrreq),
	    .cmd_waitreq(cmd_waitreq),
	    .rsp_waitreq(rsp_waitreq),
	    .tap_ctl(tap_ctl)
	    );

   // Clock generator
   localparam PERIOD = 10.0;
   always #(PERIOD/2) clk = ~clk;


`ifdef TEST_GT_0
   // Inputs and outputs
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;

	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1; cmd_data = {`C_TARGET_TAP,`C_TAP_SET_GT,16'd1};
     end // initial begin
`endif

   // Test what happens if I pass a instruction error
`ifdef TEST_GT_1
   // Inputs and outputs
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;

	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1; cmd_data = {`C_TARGET_TAP,8'hAA,16'd1};
     end // initial begin
`endif
   
`ifdef TEST_THR_0
   // Inputs and outputs
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;

	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1; cmd_data = {`C_TARGET_TAP,`C_TAP_SET_THR,16'hAAAA};
     end // initial begin
`endif
   
endmodule
	
