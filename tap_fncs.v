///////////////////////////////////////////////////////////////////////////////
// An approach at abstracting the cmd interface in verilog.
//////////////////////////////////////////////////////////////////////////////

`include "cmd_defs.vh"

// The TAP "greater than" flag
function ctl_tap_gt;
   input [`N_TAP_CTL_SIZE-1:0] ctl;
   begin
      ctl_tap_gt = ctl[0];
   end
endfunction 

// The TAP "equal to" flag
function ctl_tap_et;
   input [`N_TAP_CTL_SIZE-1:0] tap_cmd;
   begin
      ctl_tap_et = ctl[1];
   end
endfunction

// The TAP "less than" flag
function ctl_tap_lt;
   input [`N_TAP_CTL_SIZE-1:0] ctl;
   begin
      tap_lt = ctl[2];
   end
endfunction


// The TAP "trigger threshold"
function [13:0] ctl_tap_thr;
   input [`N_TAP_CTL_SIZE-1:0] ctl;
   begin
      ctl_tap_thr = ctl[16:3];
   end
endfunction
   
// The TAP "trigger enable"
function ctl_tap_trig_en;
   input [`N_TAP_CTL_SIZE-1:0] ctl;
   begin
      ctl_tap_trig_en = ctl[17];
   end
endfunction

// For ctl initialization
localparam DEF_TRIG_EN 1'b0;
localparam DEF_THR 14'h1000;
localparam DEF_LT 1'b0;
localparam DEF_ET 1'b0;
localparam DEF_GT 1'b0;
  
function ctl_tap_init;
   begin
      ctl_tap_init = {DEF_TRIG_EN,DEF_THR,DEF_LT,DEF_ET,DEF_GT};
   end
