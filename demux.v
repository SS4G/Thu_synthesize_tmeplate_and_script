
module axis_bus_demux(
bus_sel,
//*^^^_begin*
axis_out_^^^_tready,
//*^^^_end*
axis_in_tready
);

input [7:0] bus_sel;

//*^^^_begin*
output reg axis_out_^^^_tready;
//*^^^_end*

input  axis_in_tready;

//*^^^_begin*
parameter CHOOSE_FIFO_^^^   =8'd128+8'd_^^^;
//*^^^_end*
parameter NON_FIFO_CHOOSE=8'd0; 


always @ (bus_sel,axis_in_tready)
begin
            case (bus_sel)//ps:pay attention to the code of bus_sel 
            //*^^^_begin*
            CHOOSE_FIFO_^^^:begin
                    //*%%%static_begin*
                    axis_out_%%%_tready=0;
                    //*%%%static_end*
                    end
            //*^^^_end*
            default:begin//non fifo choosed
                    //*^^^_begin*
                    axis_out_^^^_tready=0;
                    //*^^^_end*                  
                    end
            endcase
end
endmodule