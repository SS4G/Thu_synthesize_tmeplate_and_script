
module sw_warpper(
glb_clk,
glb_areset_n,

//*^^^_begin*
rxd_s_axis_^^^_tvalid,
rxd_s_axis_^^^_tready,
rxd_s_axis_^^^_tdata ,
rxd_s_axis_^^^_tkeep ,
rxd_s_axis_^^^_tlast ,
//*^^^_end*

//-----
//txd_fifo_axis_port
//*^^^_begin*
txd_m_axis_^^^_tvalid,
txd_m_axis_^^^_tready,
txd_m_axis_^^^_tdata ,
txd_m_axis_^^^_tkeep ,
txd_m_axis_^^^_tlast ,
//*^^^_end*

//-----
//*^^^_begin*
fifo_^^^_space_used ,
//*^^^_end*
//*replace_last*,*with* *
);
parameter PORT_NUM=X;

input           glb_clk     ;
input           glb_areset_n;

//*^^^_begin*
input           rxd_s_axis_^^^_tvalid;
output          rxd_s_axis_^^^_tready;
input   [31:0]  rxd_s_axis_^^^_tdata ;
input   [3:0]   rxd_s_axis_^^^_tkeep ;
input           rxd_s_axis_^^^_tlast ;
//*^^^_end*

//*^^^_begin*
output          txd_m_axis_^^^_tvalid;
input           txd_m_axis_^^^_tready;
output  [31:0]  txd_m_axis_^^^_tdata ;
output  [3:0]   txd_m_axis_^^^_tkeep ;
output          txd_m_axis_^^^_tlast ;
//*^^^_end*

//*^^^_begin*
input   [31:0]  fifo_^^^_space_used ;
//*^^^_end*

//*^^^_begin*
wire            fd_bar_axis_^^^_tvalid;
wire            fd_bar_axis_^^^_tready;
wire    [31:0]  fd_bar_axis_^^^_tdata ;
wire    [3:0]   fd_bar_axis_^^^_tkeep ;
wire            fd_bar_axis_^^^_tlast ;
//*^^^_end*

//*^^^_begin*
wire    [PORT_NUM-1:0]   bus_sel_from_^^^_fd   ;
//*^^^_end*

//*^^^_begin*
wire    [PORT_NUM-1:0]   bus_sel_to_^^^_fifo   ;
//*^^^_end*


bus_cross_bar #(.PORT_NUM(PORT_NUM)) BCB(
.glb_clk     (glb_clk     ),
.glb_areset_n(glb_areset_n),

//port 0
//fifo endian port

//*^^^_begin*          
.fifo_m_axis_^^^_tvalid (txd_m_axis_^^^_tvalid),
.fifo_m_axis_^^^_tready (txd_m_axis_^^^_tready),
.fifo_m_axis_^^^_tdata  (txd_m_axis_^^^_tdata ),
.fifo_m_axis_^^^_tkeep  (txd_m_axis_^^^_tkeep ),
.fifo_m_axis_^^^_tlast  (txd_m_axis_^^^_tlast ),
//*^^^_end*

//rxd endian port
//*^^^_begin*
.rx_s_axis_^^^_tvalid (fd_bar_axis_^^^_tvalid),
.rx_s_axis_^^^_tready (fd_bar_axis_^^^_tready),
.rx_s_axis_^^^_tdata  (fd_bar_axis_^^^_tdata ),
.rx_s_axis_^^^_tkeep  (fd_bar_axis_^^^_tkeep ),
.rx_s_axis_^^^_tlast  (fd_bar_axis_^^^_tlast ),
//*^^^_end*

//*^^^_begin*
.fifo_sel_bits_^^^     (bus_sel_to_^^^_fifo),
//*^^^_end*
//*replace_last*,*with* *
);

//*^^^_begin*
frame_decoder #(.PORT_NUM(PORT_NUM)) FD_^^^ ( 
.glb_clk     (glb_clk     ),
.glb_areset_n(glb_areset_n),

.fd_s_axis_tvalid ( rxd_s_axis_^^^_tvalid),
.fd_s_axis_tready ( rxd_s_axis_^^^_tready),
.fd_s_axis_tdata  ( rxd_s_axis_^^^_tdata ),
.fd_s_axis_tkeep  ( rxd_s_axis_^^^_tkeep ),
.fd_s_axis_tlast  ( rxd_s_axis_^^^_tlast ),
//                  ()         
.fd_m_axis_tvalid (fd_bar_axis_^^^_tvalid),
.fd_m_axis_tready (fd_bar_axis_^^^_tready),
.fd_m_axis_tdata  (fd_bar_axis_^^^_tdata ),
.fd_m_axis_tkeep  (fd_bar_axis_^^^_tkeep ),
.fd_m_axis_tlast  (fd_bar_axis_^^^_tlast ),
 //                 ()
.fd_bus_sel_bits  (bus_sel_from_^^^_fd),
 //                 ()
//*###_begin*
.fifo_###_space_used (fifo_###_space_used ),
//*###_end*
//*replace_last*,*with* *
);
//*^^^_end*

bus_sel_bits_interconnect #(.PORT_NUM(PORT_NUM)) BSBIC(
//fifo_port
//*^^^_begin*
.fifo_^^^_bus_sel(bus_sel_to_^^^_fifo),
//*^^^_end*

//decoder port
//*^^^_begin*
.fd_^^^_bus_sel(bus_sel_from_^^^_fd),
//*^^^_end*
//*replace_last*,*with* *
);
endmodule