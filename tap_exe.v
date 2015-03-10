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
   
   always @(posedge clk or negedge rst_n)
     if( !rst_n ) 
       begin
	  ctl <= `CTL_TAP_INIT;
	  rsp <= 32'b0;
       end
     else if( run && (cmd_target(cmd) == C_TARGET_TAP) )
       case( cmd_instr(cmd) )
	 // C_TAP_SET_GT      : begin ctl_tap_gt(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_ET      : begin ctl_tap_et(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_LT      : begin ctl_tap_lt(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_THR     : begin ctl_tap_thr(ctl)     <= cmd[13:0]; rsp <=         cmd;  end
	 // C_TAP_SET_TRIG_EN : begin ctl_tap_trig_en(ctl) <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_GT      : begin ctl[0]      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_ET      : Begin ctl[1]      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_LT      : begin Ctl[2]      <= cmd[0];    rsp <=         cmd;  end
	 // C_TAP_SET_THR     : begin ctl[16:3]   <= cmd[13:0]; rsp <=         cmd;  end
	 // C_TAP_SET_TRIG_EN : begin ctl[17]     <= cmd[0];    rsp <=         cmd;  end
	 C_TAP_SET_GT      : begin `CTL_TAP_GT(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 C_TAP_SET_ET      : begin `CTL_TAP_ET(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 C_TAP_SET_LT      : begin `CTL_TAP_LT(ctl)      <= cmd[0];    rsp <=         cmd;  end
	 C_TAP_SET_THR     : begin `CTL_TAP_THR(ctl)     <= cmd[13:0]; rsp <=         cmd;  end
	 C_TAP_SET_TRIG_EN : begin `CTL_TAP_TRIG_EN(ctl) <= cmd[0];    rsp <=         cmd;  end
	 
	 default           : begin                           rsp <= set_cmd_err(cmd); end		
       endcase
endmodule
