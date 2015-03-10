///////////////////////////////////////////////////////////////////////////////
// Useful functions for command stuff
//////////////////////////////////////////////////////////////////////////////

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
