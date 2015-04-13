`include "cmd_defs.vh"

module phf_cmds
  (
   input 	     clk,
   input 	     rst_n,
   input 	     run,
   input [31:0]      cmd,
   input 	     sts,
   input 	     busy,
   output reg	     rsp_rdy,  //a flag for fcr to tell when rsp ready 
   output reg [31:0] rsp,
   output 	     clear_req
   );

   // State machine
   reg [1:0]  fsm;
   localparam
     S_IDLE         = 2'd0,
     S_PARSE        = 2'd1,
     S_CLEAR_REQ    = 2'd2,
     S_WAIT         = 2'd3;
   

   //Output Logic
   assign clear_req = (fsm == S_CLEAR_REQ);

   
   //State machine logic
   always @(posedge clk or negedge rst_n)
     if( !rst_n )
       begin
	  fsm <= S_IDLE;
	  rsp_rdy <= 1'b0;
	  rsp <= 32'b0;
       end
     else
       begin
	  rsp_rdy <= 1'b0;
	  case(fsm)
	    S_IDLE                : if(run && (`CMD_TARGET(cmd) == `C_TARGET_PHF)) fsm <= S_PARSE;
	    S_PARSE               :
	      begin
		 rsp_rdy <= 1'b1; 
		 case( `CMD_INSTR(cmd) )
		   // associate command with state machine
		   `C_PHF_CLEAR      : begin fsm <= S_CLEAR_REQ; rsp <= cmd;                                  end
		   `C_PHF_GET_STATUS : begin fsm <= S_IDLE;      rsp <= {cmd[31:16], 15'b0,sts};              end 
		   default           : begin fsm <= S_IDLE;      rsp <= `SET_CMD_ERR(cmd);                    end
		 endcase // case ( `CMD_INSTR(cmd) )
	      end
	    S_CLEAR_REQ:  if(busy)        fsm <= S_WAIT;
	    S_WAIT:       if(!busy)       fsm <= S_IDLE;
	  endcase // case (fsm)
       end
endmodule // phf           

   
