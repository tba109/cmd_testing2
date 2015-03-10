`define N_TAP_CTL_SIZE 18

localparam // targets
  C_TARGET_TOP = 8'h00,
  C_TARGET_TAP = 8'h01,
  C_TARGET_LTC = 8'h02,
  C_TARGET_PEF = 8'h03,
  C_TARGET_PHF = 8'h04,
  C_TARGET_AF  = 8'h05;

localparam // instructions

  // Top level is MSByte 0x00
  C_VERSION_NUMBER     = 16'h0001,
  C_DT_TRIG_MODE       = 16'h0002,

  // TAP is MSByte 0x01
  C_TAP_SET_GT         = 16'h0101,
  C_TAP_SET_ET         = 16'h0102,
  C_TAP_SET_LT         = 16'h0103,
  C_TAP_SET_THR        = 16'h0104,
  C_TAP_SET_TRIG_EN    = 16'h0105,
  C_TAP_SET_RUN        = 16'h0106,
  
  // LTC is MSByte 0x02
  C_LTC_UPDATE         = 16'h0201,
  C_LTC_GET_HIGH       = 16'h0202,
  C_LTC_GET_MID        = 16'h0203,
  C_LTC_GET_LOW        = 16'h0204,
  
  // PEF is MSByte 0x03
  C_PEF_CLEAR          = 16'h0301,
  C_PEF_UPDATE_STATUS  = 16'h0302,
  C_PEF_GET_STATUS     = 16'h0303,
  
  // PHF is MSByte 0x04
  C_PHF_CLEAR          = 16'h0401,
  C_PHF_GET_STATUS     = 16'h0402,
  C_PHF_UPDATE_STATUS  = 16'h0403,

  // AF is MSByte 0x05  
  C_AF_SET_PRE_CONFIG  = 16'h0501,
  C_AF_SET_POST_CONFIG = 16'h0502,
  C_AF_GET_STATUS      = 16'h0503,
  C_AF_UPDATE_STATUS   = 16'h0504,
  C_AF_SET_TEST_CONFIG = 16'h0505,
  C_AF_SET_CNST_CONFIG = 16'h0506,
  C_AF_SET_CNST_RUN    = 16'h0507;


  
