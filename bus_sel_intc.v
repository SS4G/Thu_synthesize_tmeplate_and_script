
module bus_sel_bits_interconnect(
//fifo port
//*^^^_begin*
fifo_^^^_bus_sel, 
//*^^^_end*

//*^^^_begin*
fd_^^^_bus_sel, 
//*^^^_end*
//*replace_last*,*with* *
);
parameter PORT_NUM=X;

//*^^^_begin*
output [PORT_NUM-1:0]   fifo_^^^_bus_sel;
//*^^^_end*
//*^^^_begin*
input  [PORT_NUM-1:0]   fd_^^^_bus_sel;//
//*^^^_end*

//Connect mode example:
//Fd_0[1]-----Fifi_1[0]
//general formula
//Fd_x[y]-----Fifi_y[x]
//*^^^_begin*
//*###_begin*
assign fifo_^^^_bus_sel[###]=fd_###_bus_sel[^^^];
//*###_end*
//*^^^_end*
endmodule