`timescale 1ns / 100ps
`include "cmd_defs.vh"   

`define TEST_CLEAR_0
//`define TEST_CLEAR_1
//`define TEST_GET_STATUS_0

module phf_testing_tb();
   reg                        clk;
   reg                        rst_n;
   reg  [31:0]                cmd_data;
   wire [31:0]                rsp_data;
   reg                        rsp_waitreq;
   reg                        cmd_waitreq;
   wire                       rsp_wrreq;
   wire                       cmd_rdreq;
   wire [`N_TAP_CTL_SIZE-1:0] tap_ctl;
   reg  		      phf_clear_busy;
   reg  		      phf_status;
   wire                       phf_rsp_rdy;			      
   wire 		      phf_clear_req;

   fcr FCR0(
	    .clk(clk),
	    .rst_n(rst_n),
	    .cmd_data(cmd_data),
	    .rsp_data(rsp_data),
	    .cmd_rdreq(cmd_rdreq),
	    .rsp_wrreq(rsp_wrreq),
	    .cmd_waitreq(cmd_waitreq),
	    .rsp_waitreq(rsp_waitreq),
	    .tap_ctl(tap_ctl),
	    .phf_clear_busy(phf_clear_busy),
	    .phf_status(phf_status),
	    .phf_rsp_rdy(phf_rsp_rdy),
	    .phf_clear_req(phf_clear_req)
	    );

   // Clock generator
   localparam PERIOD = 10.0;
   always #(PERIOD/2) clk = ~clk;
          
`ifdef TEST_CLEAR_0
   // Inputs and outputs
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;
	phf_clear_busy = 1'b0;
	phf_status = 1'b0;
	
	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1;
	cmd_data = {`C_TARGET_PHF,`C_PHF_CLEAR, 16'd1};
	#(5*PERIOD) if (phf_clear_req) phf_clear_busy = 1'b1;
	#(5*PERIOD) phf_clear_busy = 1'b0;
     end // initial begin
`endif                                  

   
`ifdef TEST_CLEAR_1 //intruction error
   // Inputs and outputs
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;
	phf_clear_busy = 1'b0;
	phf_status = 1'b0;

	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1;
	cmd_data = {`C_TARGET_PHF,8'hAA,16'd1};
	#(5*PERIOD) if (phf_clear_req) phf_clear_busy = 1'b1;
	#(5*PERIOD) phf_clear_busy = 1'b0;
     end // initial begin
`endif                                                                    
          
`ifdef TEST_GET_STATUS_0
   // Inputs and outputs
   //read command, toggle status input 
   initial
     begin
	clk = 1'b0;
	rst_n = 1'b0;
	cmd_data = 32'b0;
	cmd_waitreq = 1'b1;
	rsp_waitreq = 1'b0;
	phf_clear_busy = 1'b0;
	phf_status = 1'b0;
	
	#(5*PERIOD) rst_n = 1'b1;
	#(5*PERIOD) cmd_waitreq = 1'b0;
	#(1*PERIOD) cmd_waitreq = 1'b1;
	cmd_data = {`C_TARGET_PHF,`C_PHF_GET_STATUS,16'd1};
	phf_status = 1'b1;
	#(5*PERIOD) phf_status = 1'b0;
     end // initial begin
`endif                                               

endmodule //phf_testing_tb.v
