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
   output [`N_TAP_CTL_SIZE-1:0] tap_ctl,
   input 			tap_rsp_rdy,

   //PHF interface
   input 			phf_clear_busy,
   input 			phf_status,
   input 			phf_rsp_rdy, 
   output 			phf_clear_req 			
   );
      
   ////////////////////////////////////////////////////////////////////////////////////////
   // finite state machine (fsm) states
   reg [1:0] 		       fsm;
   localparam 
     S_IDLE   = 2'd0, 
     S_RD_CMD = 2'd1, 
     S_EXE    = 2'd2,
     S_WR_RSP = 2'd3;

   ////////////////////////////////////////////////////////////////////////////////////////
   // Useful assignments
   wire 		       exe_done;
   //assign exe_done = 1'b1;
   
   ////////////////////////////////////////////////////////////////////////////////////////
   // TAP command/control and status/response 
   wire [31:0] 		       tap_rsp_data;
   tap_cmds TAP_CMDS0(
		      .clk(clk),
		      .rst_n(rst_n),
		      .run(fsm == S_EXE),
		      .cmd(cmd_data),
		      .rsp(tap_rsp_data),
		      .ctl(tap_ctl),
		      .rsp_rdy(tap_rsp_rdy)
		      );
        

   //PHF
   wire [31:0] 		       phf_rsp_data;
   phf_cmds PHF_CMDS0(
		      .clk(clk),
		      .rst_n(rst_n),
		      .run(fsm == S_EXE),
		      .cmd(cmd_data),
		      .sts(phf_status),
		      .busy(phf_clear_busy),
		      .rsp_rdy(phf_rsp_rdy),
		      .rsp(phf_rsp_data),
		      .clear_req(phf_clear_req)
		      );
   
   // Combinational outputs
   assign cmd_rdreq = (fsm == S_RD_CMD);
   assign exe_done = (phf_rsp_rdy || tap_rsp_rdy);
   assign rsp_wrreq = ((fsm == S_WR_RSP)); // && phf_rsp_rdy);
   
   always @(`CMD_TARGET(cmd_data),tap_rsp_data, phf_rsp_data) // DEMUX the response
     case(`CMD_TARGET(cmd_data)) 
       `C_TARGET_TAP : rsp_data <= tap_rsp_data;
       `C_TARGET_PHF : rsp_data <= phf_rsp_data;
       default       : rsp_data <= 32'd0;  
     endcase // case (`CMD_TARGET(cmd_data))
      
   // sequental logic
   always @(posedge clk or negedge rst_n)
     begin
	if( !rst_n ) fsm <= S_IDLE;
	else
	  case(fsm)
	    S_IDLE:         if( !cmd_waitreq )             fsm <= S_RD_CMD;
	    S_RD_CMD:                                      fsm <= S_EXE;
	    S_EXE:          if( exe_done && !rsp_waitreq ) fsm <= S_WR_RSP; //add phf_rsp_rdy here?
	               else if( exe_done && rsp_waitreq )  fsm <= S_IDLE;
	    S_WR_RSP:                                      fsm <= S_IDLE;
	    default:                                       fsm <= S_IDLE;
	  endcase 
     end 				
endmodule
