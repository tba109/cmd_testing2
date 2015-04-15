library verilog;
use verilog.vl_types.all;
entity phf_cmds is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        run             : in     vl_logic;
        cmd             : in     vl_logic_vector(31 downto 0);
        sts             : in     vl_logic;
        busy            : in     vl_logic;
        rsp_rdy         : out    vl_logic;
        rsp             : out    vl_logic_vector(31 downto 0);
        clear_req       : out    vl_logic
    );
end phf_cmds;
