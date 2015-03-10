///////////////////////////////////////////////////////////////////////////////
// Useful functions for command stuff
//////////////////////////////////////////////////////////////////////////////

// Targets
localparam C_TARGET_TOP = 8'h00;
localparam C_TARGET_TAP = 8'h01;
localparam C_TARGET_LTC = 8'h02;
localparam C_TARGET_PEF = 8'h03;
localparam C_TARGET_PHF = 8'h04;
localparam C_TARGET_AF  = 8'h05;

// Instructions
// Top level is MSByte 0x00
localparam C_VERSION_NUMBER     = 8'h01;
localparam C_TRIG_MODE       = 8'h02;

// TAP is MSByte 0x01
localparam C_TAP_SET_GT         = 8'h01;
localparam C_TAP_SET_ET         = 8'h02;
localparam C_TAP_SET_LT         = 8'h03;
localparam C_TAP_SET_THR        = 8'h04;
localparam C_TAP_SET_TRIG_EN    = 8'h05;
localparam C_TAP_SET_RUN        = 8'h06;

// LTC is MSByte 0x02
localparam C_LTC_UPDATE         = 8'h01;
localparam C_LTC_GET_HIGH       = 8'h02;
localparam C_LTC_GET_MID        = 8'h03;
localparam C_LTC_GET_LOW        = 8'h04;

// PEF is MSByte 0x03
localparam C_PEF_CLEAR          = 8'h01;
localparam C_PEF_UPDATE_STATUS  = 8'h02;
localparam C_PEF_GET_STATUS     = 8'h03;

// PHF is MSByte 0x04
localparam C_PHF_CLEAR          = 8'h01;
localparam C_PHF_GET_STATUS     = 8'h02;
localparam C_PHF_UPDATE_STATUS  = 8'h03;

// AF is MSByte 0x05  
localparam C_AF_SET_PRE_CONFIG  = 8'h01;
localparam C_AF_SET_POST_CONFIG = 8'h02;
localparam C_AF_GET_STATUS      = 8'h03;
localparam C_AF_UPDATE_STATUS   = 8'h04;
localparam C_AF_SET_TEST_CONFIG = 8'h05;
localparam C_AF_SET_CNST_CONFIG = 8'h06;
localparam C_AF_SET_CNST_RUN    = 8'h07;

function set_cmd_err;
   input [31:0] cmd;
   begin
      set_cmd_err = {1'b1,cmd[30:0]};
   end
endfunction
   
function cmd_target;
   input [31:0] cmd;
   begin
      cmd_target = cmd[31:24];
   end
endfunction

function cmd_instr;
   input [31:0] cmd;
   begin
      cmd_instr = cmd[31:16];
   end
endfunction
