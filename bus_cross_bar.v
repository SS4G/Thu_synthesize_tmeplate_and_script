
module bus_cross_bar(
glb_clk,
glb_areset_n,

//fifo endian port
//*^^^_begin*
fifo_m_axis_^^^_tvalid ,
fifo_m_axis_^^^_tready ,
fifo_m_axis_^^^_tdata  ,
fifo_m_axis_^^^_tkeep  ,
fifo_m_axis_^^^_tlast  ,
//*^^^_end*

//rxd endian port
//*^^^_begin*
rx_s_axis_^^^_tvalid ,
rx_s_axis_^^^_tready ,
rx_s_axis_^^^_tdata  ,
rx_s_axis_^^^_tkeep  ,
rx_s_axis_^^^_tlast  ,
//*^^^_end*

//--0--
//*^^^_begin*
fifo_sel_bits_^^^      ,
//*^^^_end*
//*replace_last*,*with* *
);
parameter       PORT_NUM=X;
input           glb_clk     ;
input           glb_areset_n;

//fifo endian port
//*^^^_begin*
output          fifo_m_axis_^^^_tvalid ;
input           fifo_m_axis_^^^_tready ;
output   [31:0] fifo_m_axis_^^^_tdata  ;
output   [3:0]  fifo_m_axis_^^^_tkeep  ;
output          fifo_m_axis_^^^_tlast  ;
//*^^^_end*

//rxd endian port
//*^^^_begin*
input           rx_s_axis_^^^_tvalid ;
output          rx_s_axis_^^^_tready ;
input   [31:0]  rx_s_axis_^^^_tdata  ;
input   [3:0]   rx_s_axis_^^^_tkeep  ;
input           rx_s_axis_^^^_tlast  ;
//*^^^_end*

//*^^^_begin*
input   [PORT_NUM-1:0]   fifo_sel_bits_^^^;
//*^^^_end*

//*^^^_begin*
wire [PORT_NUM-1:0] fifo_^^^_tready_torx;
//*^^^_end*

//*^^^_begin*
wire [7:0] bus_sel_tofifo_^^^;
//*^^^_end*

//*^^^_begin*
fifo_sel_cal #(.PORT_NUM(PORT_NUM)) CAL_^^^(
.glb_clk            (glb_clk     ),
.glb_areset_n       (glb_areset_n),
.fifo_sel_bits      (fifo_sel_bits_^^^),
.fifo_sel_res_final (bus_sel_tofifo_^^^)
);
//*^^^_end*

//*^^^_begin*
axis_bus_demux DEMUX_^^^(
.bus_sel             (bus_sel_tofifo_^^^),
//*###_begin*
.axis_out_###_tready  (fifo_^^^_tready_torx[###]),
//*###_end*

.axis_in_tready      (fifo_m_axis_^^^_tready)
);
//*^^^_end*

//-----
//*^^^_begin*
axis_bus_mux MUX_^^^(
.bus_sel          (bus_sel_tofifo_^^^),
//                ()
//*###_begin*
.axis_in_###_tvalid  (rx_s_axis_###_tvalid),
.axis_in_###_tdata   (rx_s_axis_###_tdata ),
.axis_in_###_tkeep   (rx_s_axis_###_tkeep ),
.axis_in_###_tlast   (rx_s_axis_###_tlast ),
 //*###_end*
.axis_out_tvalid  (fifo_m_axis_^^^_tvalid),
.axis_out_tdata   (fifo_m_axis_^^^_tdata ),
.axis_out_tkeep   (fifo_m_axis_^^^_tkeep ),
.axis_out_tlast   (fifo_m_axis_^^^_tlast )
);
//*^^^_end*


//*^^^_begin*
assign rx_s_axis_^^^_tready=  
                              //*###_begin*
                              fifo_###_tready_torx [^^^]|
                              //*###_end*
                              //*replace_last*|*with* *
                              ;
//*^^^_end*
                       
endmodule