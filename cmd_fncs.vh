///////////////////////////////////////////////////////////////////////////////
// Command definitions
//////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// These are for parsing commands

// Useful substitution definitions
`define SET_CMD_ERR(x) {1'b1,x[30:0]}
`define CMD_TARGET(x) x[31:24]
`define CMD_INSTR(x) x[23:16]   

// Targets
`define C_TARGET_TOP 8'h00
`define C_TARGET_TAP 8'h01
`define C_TARGET_LTC 8'h02
`define C_TARGET_PEF 8'h03
`define C_TARGET_PHF 8'h04
`define C_TARGET_AF  8'h05

// TOP
`define C_TOP_VERSION_NUMBER  8'h01
`define C_TOP_TRIG_MODE       8'h02

// TAP
`define C_TAP_SET_GT         8'h01
`define C_TAP_SET_ET         8'h02
`define C_TAP_SET_LT         8'h03
`define C_TAP_SET_THR        8'h04
`define C_TAP_SET_TRIG_EN    8'h05
`define C_TAP_SET_RUN        8'h06

// LTC
`define C_LTC_UPDATE         8'h01
`define C_LTC_GET_HIGH       8'h02
`define C_LTC_GET_MID        8'h03
`define C_LTC_GET_LOW        8'h04

// PEF
`define C_PEF_CLEAR          8'h01
`define C_PEF_UPDATE_STATUS  8'h02
`define C_PEF_GET_STATUS     8'h03

// PHF
`define C_PHF_CLEAR          8'h01
`define C_PHF_GET_STATUS     8'h02
`define C_PHF_UPDATE_STATUS  8'h03

// AF  
`define C_AF_SET_PRE_CONFIG  8'h01
`define C_AF_SET_POST_CONFIG 8'h02
`define C_AF_GET_STATUS      8'h03
`define C_AF_UPDATE_STATUS   8'h04
`define C_AF_SET_TEST_CONFIG 8'h05
`define C_AF_SET_CNST_CONFIG 8'h06
`define C_AF_SET_CNST_RUN    8'h07


