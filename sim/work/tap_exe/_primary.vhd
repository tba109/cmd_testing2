library verilog;
use verilog.vl_types.all;
entity tap_exe is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        run             : in     vl_logic;
        cmd             : in     vl_logic_vector(31 downto 0);
        rsp             : out    vl_logic_vector(31 downto 0);
        ctl             : out    vl_logic_vector(17 downto 0)
    );
end tap_exe;
