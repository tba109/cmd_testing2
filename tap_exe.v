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
   
   always @(posedge clk or negedge rst_n)
     if( !rst_n ) 
       begin
	  ctl <= `CTL_TAP_INIT;
	  rsp <= 32'b0;
       end
     else if( run && (`CMD_TARGET(cmd) == `C_TARGET_TAP) )
       case( `CMD_INSTR(cmd) )
	 `C_TAP_SET_GT      : begin `CTL_TAP_GT(ctl)      <= cmd[0];    rsp <=              cmd;  end
	 `C_TAP_SET_ET      : begin `CTL_TAP_ET(ctl)      <= cmd[0];    rsp <=              cmd;  end
	 `C_TAP_SET_LT      : begin `CTL_TAP_LT(ctl)      <= cmd[0];    rsp <=              cmd;  end
	 `C_TAP_SET_THR     : begin `CTL_TAP_THR(ctl)     <= cmd[13:0]; rsp <=              cmd;  end
	 `C_TAP_SET_TRIG_EN : begin `CTL_TAP_TRIG_EN(ctl) <= cmd[0];    rsp <=              cmd;  end
	 default            : begin                                     rsp <= `SET_CMD_ERR(cmd); end		
       endcase
endmodule
