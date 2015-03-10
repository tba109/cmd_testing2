/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Do clock domain crossing in this module if necessary
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "cmd_defs.vh"

module tap_exe
  (
   input 			    clk,
   input 			    rst_n,
   input 			    run,
   input [31:0] 		    cmd,
   output reg [31:0] 		    rsp, 
   output reg [`N_TAP_CTL_SIZE-1:0] ctl
   );
   
`include "tap_fncs.vh"   
`include "cmd_fncs.vh"
         
   // FSM 
   always @(posedge clk or negedge rst_n)
     if( !rst_n ) ctl <= ctl_tap_init();
     else if( run && (cmd_target(cmd) == C_TAP) )
       case( cmd_instr(cmd) )
	 C_TAP_SET_GT      : begin ctl_tap_gt(ctl)      <= cmd_data[0];    rsp <=         cmd_data;  end
	 C_TAP_SET_ET      : begin ctl_tap_et(ctl)      <= cmd_data[0];    rsp <=         cmd_data;  end
	 C_TAP_SET_LT      : begin ctl_tap_lt(ctl)      <= cmd_data[0];    rsp <=         cmd_data;  end
	 C_TAP_SET_THR     : begin ctl_tap_thr(ctl)     <= cmd_data[13:0]; rsp <=         cmd_data;  end
	 C_TAP_SET_TRIG_EN : begin ctl_tap_trig_en(ctl) <= cmd_data[0];    rsp <=         cmd_data;  end
	 default           : begin                                         rsp <= set_err(cmd_data); end		
       endcase
endmodule
