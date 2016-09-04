
module axis_bus_mux(
bus_sel,
//*^^^_begin*
axis_in_^^^_tvalid ,
axis_in_^^^_tdata  ,
axis_in_^^^_tkeep  ,
axis_in_^^^_tlast  ,
//*^^^_end*

axis_out_tvalid  ,
axis_out_tdata   ,
axis_out_tkeep   ,
axis_out_tlast   

);

input  [7:0]    bus_sel;
//*^^^_begin*
input           axis_in_^^^_tvalid ;
input  [31:0]   axis_in_^^^_tdata  ;
input  [3:0]    axis_in_^^^_tkeep  ;
input           axis_in_^^^_tlast  ;
//*^^^_end*

//-----

output reg           axis_out_tvalid  ;
output reg  [31:0]   axis_out_tdata   ;
output reg  [3:0]    axis_out_tkeep   ;
output reg           axis_out_tlast   ;
//*^^^_begin*
parameter CHOOSE_FIFO_^^^   =8'd128+8'd_^^^;
//*^^^_end*

parameter NON_FIFO_CHOOSE=8'd0; 


always @(bus_sel,
                //*^^^_begin*
                axis_in_^^^_tvalid,
                axis_in_^^^_tdata,
                axis_in_^^^_tkeep,
                axis_in_^^^_tlast,
                //*^^^_end* 
                //*replace_last*,*with* *
                )
begin
            case (bus_sel)//ps:pay attention to the code of bus_sel
            //*^^^_begin*
            CHOOSE_FIFO_^^^:begin
                   axis_out_tvalid=axis_in_^^^_tvalid;
                   axis_out_tkeep =axis_in_^^^_tkeep;
                   axis_out_tlast =axis_in_^^^_tlast;
                   axis_out_tdata =axis_in_^^^_tdata;
                   end
            //*^^^_end*

            default:begin
                   axis_out_tvalid=0;axis_out_tkeep=0;
                   axis_out_tlast= 0;axis_out_tdata=0;
                   end
            endcase
end
endmodule
