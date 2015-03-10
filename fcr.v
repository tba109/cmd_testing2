/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Do clock domain crossing in this module if necessary
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "cmd_defs.vh"

module fcr
  (
   // global to module
   input 			clk, // clock
   input 			rst_n, // active low reset
   
   // FIFO interface
   input [31:0] 		cmd_data, // incoming 32-bit command data
   output reg [31:0] 		rsp_data, // outgoing 32-bit response data
   output 			cmd_rdreq, // read flag for cmd fifo
   output 			rsp_wrreq, // write flag for cmd fifo
   input 			cmd_waitreq, // wait request for cmd fifo. Note that this goes low when data appears
   input 			rsp_waitreq, // wait request for rsp fifo. Note that this goes high when data app
   
   // TAP interface
   output [`N_TAP_CTL_SIZE-1:0] tap_ctl 
   );
   
`include "tap_fncs.v"
   
   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   // finite state machine (fsm) states
   reg [2:0] 		       fsm;
   localparam 
     S_IDLE   = 2'd0, 
     S_RD_CMD = 2'd1, 
     S_REQ    = 2'd2,
     S_BUSY   = 2'd3,
     S_WR_RSP = 2'd4;

   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   // Useful assignments
   wire 		       exe_done;
      
   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   // TAP command/control and status/response 
   wire [31:0] 		       tap_rsp_data;
   wire 		       tap_done;
   tap_exe TAP_EXE0(
		    .clk(clk),
		    .rst_n(rst_n),
		    .run(fsm == S_EXE),
		    .cmd(cmd_data),
		    .rsp(tap_rsp_data),
		    .ctl(tap_ctl),
		    .done(tap_done);
		    )
     
   // Combinational outputs
   assign cmd_rdreq = (fsm == S_RD_CMD);
   assign rsp_wrreq = (fsm == S_WR_RSP);
   always @(cmd_target(cmd_data)) // demux the response
     case(cmd_target(cmd_data)) 
       C_TARGET_TAP : rsp_data <= tap_rsp_data;
       default      : rsp_data <= 32'd0;
     endcase
   
   // sequental logic
   always @(posedge clk or negedge rst_n)
     begin
	if( !rst_n ) fsm <= S_IDLE;
	else
	  case(fsm)
	    S_IDLE:         if( !cmd_waitreq )             fsm <= S_RD_CMD;
	    S_RD_CMD:                                      fsm <= S_EXE;
	    S_EXE:          if( exe_done && !rsp_waitreq ) fsm <= S_WR_RSP;
	               else if( exe_done &&  rsp_waitreq ) fsm <= S_IDLE;
	    S_WR_RSP:                                      fsm <= S_IDLE;
	    default:                                       fsm <= S_IDLE;
	  endcase 
     end 				
endmodule
