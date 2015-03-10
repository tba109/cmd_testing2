`include "cmd_defs.vh"
`include "tap_defs.vh"

module tap_cmds
  (
   input 			    clk,
   input 			    rst_n,
   input [31:0] 		    cmd,
   output 			    req,
   input 			    busy,
   output reg [`N_TAP_CTL_SIZE-1:0] ctl,
   );

`include "tap_fncs.vh"   
   
   reg [2:0] 			fsm;
   localparam
     S_IDLE  = 3'd0,
     S_PARSE = 3'd1,
     S_REQ   = 3'd2,
     S_BUSY  = 3'd3,
     S_DONE  = 3'd4;

   wire [7:0] 			target;
   wire [7:0] 			instr;
   wire [15:0] 			data;
   assign target = cmd[31:24];
   assign instr = cmd[23:16];
   assign data = cmd[15:0];

   // Combinational outputs
   assign req = (fsm == S_REQ);
      
   // FSM 
   always @(posedge clk or negedge rst_n)
     if( !rst_n ) ctl <={`N_TAP_CTL_SIZE{1'b0}};
     else
       case(fsm)
	 S_IDLE : if(target == C_TARGET_TAP) fsm <= S_PARSE ;
	 S_PARSE :
	   begin
              case( instr )
		C_TAP_SET_GT      : begin ctl_tap_gt(ctl)      <= cmd_data[0];    fsm <= S_REQ;  end
		C_TAP_SET_ET      : begin ctl_tap_et(ctl)      <= cmd_data[0];    fsm <= S_REQ;  end
		C_TAP_SET_LT      : begin ctl_tap_lt(ctl)      <= cmd_data[0];    fsm <= S_REQ;  end
		C_TAP_SET_THR     : begin ctl_tap_thr(ctl)     <= cmd_data[13:0]; fsm <= S_REQ;  end
		C_TAP_SET_TRIG_EN : begin ctl_tap_trig_en(ctl) <= cmd_data[0];    fsm <= S_REQ;  end
		default           :                                               fsm <= S_DONE; end		
	      endcase
	   end
	 S_REQ  : if(  busy ) fsm <= S_BUSY;
	 S_BUSY : if( !busy ) fsm <= S_DONE;
	 S_DONE : fsm <= S_IDLE;
      
endmodule
   
