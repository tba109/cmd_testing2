library verilog;
use verilog.vl_types.all;
entity fcr is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        cmd_data        : in     vl_logic_vector(31 downto 0);
        rsp_data        : out    vl_logic_vector(31 downto 0);
        cmd_rdreq       : out    vl_logic;
        rsp_wrreq       : out    vl_logic;
        cmd_waitreq     : in     vl_logic;
        rsp_waitreq     : in     vl_logic;
        tap_ctl         : out    vl_logic_vector(17 downto 0)
    );
end fcr;
