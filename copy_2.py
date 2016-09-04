
def file_open_at_present_dir(file_name="DEFAULT",open_mode="r"):
    try :
        file_root=open(file_name,open_mode)
    except FileNotFoundError:
        print("ERROR:"+file_name+" not found at present dirctory !")
    else:
        return file_root
def repeat_block(
block=[],
repeat_time=1,
block_endline="\n",
pattern="&&&"
):
    block_repeated=[]
    pat_len=len(pattern)
    tmp_str=""
    for number in range(repeat_time):#generate whole segment
        for lines in block:#generate 1 block
            line_len=len(lines)
            tmp_str=lines
            tmp_list=tmp_str.split(pattern)
            block_repeated.append(str(number).join(tmp_list))              
        block_repeated.append(block_endline) #add 1 block end line 
    block_repeated.append("\n//-------------------\n") #add segment end line
    return block_repeated
    
def extend_pattern_block(pattern,buffer,repeat_time):
    wr_lines=[]
    pattern_block=[]    
    state="IDLE"
    for line in buffer:        
            if state=="IDLE":
                if "*"+pattern+"_begin*" in line:   
                    state="BULID_BLOCK"
                    pattern_block=[]#empty tmp_block
                else :
                    wr_lines.append(line)#add the non-repeat line into write_base derectly
            elif state=="BULID_BLOCK":
                if "*"+pattern+"_end*" in line:                  
                    repeated_pattern_block=repeat_block(
                    block=pattern_block,
                    repeat_time=repeat_time,
                    block_endline="",
                    pattern=pattern
                    )                      
                    wr_lines.extend(repeated_pattern_block)#add extended pattern blocks in write lines
                    state="IDLE"
                else :
                    pattern_block.append(line)   
    return wr_lines
def demux_specal(buffer,repeat_time):
    wr_lines=[]
    pattern_block=[]    
    state="IDLE"
    static_cnt=0
    for line in buffer:        
            if state=="IDLE":
                if "//*%%%static_begin*" in line:
                    state="BULID_BLOCK"
                    static_cnt+=1
                    pattern_block=[]#empty tmp_block
                else :
                    wr_lines.append(line)#add the non-repeat line into write_base derectly
            elif state=="BULID_BLOCK":
                if "//*%%%static_end*" in line:
                    repeated_pattern_block=repeat_block(
                    block=pattern_block,
                    repeat_time=repeat_time,
                    block_endline="",
                    pattern="%%%"
                    )
                    
                    #special handle
                    axis_out_cnt=0
                    axis_out_index=0 # record the index of tready should appear
                    for i in repeated_pattern_block:
                        if "axis_out_" in i:
                            axis_out_cnt+=1
                        if axis_out_cnt==static_cnt:
                            break
                        axis_out_index+=1
                    
                    repeated_pattern_block[axis_out_index]=repeated_pattern_block[axis_out_index].replace("=0;","=axis_in_tready;")
                    wr_lines.extend(repeated_pattern_block)#add extended pattern blocks in write lines
                    
                    state="IDLE"
                else :
                    pattern_block.append(line)   
    return wr_lines

def generate_file(src_file="src.txt",dst_file="dst.txt",port_num=2):
    """
    handle "###" first
    handle "^^^" second
    """
    file_src=file_open_at_present_dir(file_name=src_file,open_mode="r")
    file_dst=file_open_at_present_dir(file_name=dst_file,open_mode="w")
    buffer=file_src.readlines()
    buf_len=len(buffer)
    for i in range(buf_len):#replace parameter in module
        buffer[i]=buffer[i].replace("PORT_NUM=X;","PORT_NUM="+str(port_num)+";")
    
    tmp_lines=extend_pattern_block(pattern="###",buffer=buffer,repeat_time=port_num)
    wr_lines=extend_pattern_block(pattern="^^^",buffer=tmp_lines,repeat_time=port_num)
    if "demux" in src_file:
        wr_lines=demux_specal(wr_lines,port_num)
    
    final_len=len(wr_lines)
    for i in range(final_len):#handle end of module instance
        if "//*replace_last*" in wr_lines[i]:
            parameters=wr_lines[i].split("*")
            tobe_delete=parameters[2]
            replace_with=parameters[4]
            k=i-1
            while tobe_delete not in wr_lines[k]:
                k-=1
            back_index=-1
            while (wr_lines[k])[back_index]!=tobe_delete:
                back_index-=1
            wr_lines[k]=(wr_lines[k])[:back_index]+replace_with+(wr_lines[k])[back_index+1:]
            
        i+=1        
    
    file_dst.writelines(wr_lines)
    file_dst.close()
    file_src.close()
    return 
    
#process

generate_file(src_file="F:\\syn_work\\sw_warpper.v",      dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_sw_warpper.v",    port_num=32)    
generate_file(src_file="F:\\syn_work\\demux.v",           dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_demux.v",         port_num=32)    
generate_file(src_file="F:\\syn_work\\mux.v",             dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_mux.v",           port_num=32)    
generate_file(src_file="F:\\syn_work\\bus_sel_intc.v",    dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_bus_sel_intc.v",  port_num=32)    
generate_file(src_file="F:\\syn_work\\bus_cross_bar.v",   dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_bus_cross_bar.v", port_num=32)    
generate_file(src_file="F:\\syn_work\\fifo_sel_cal.v",    dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_fifo_sel_cal.v",  port_num=32)    
generate_file(src_file="F:\\syn_work\\frame_decoder.v",   dst_file="F:\\THU3\\THU_syn_v2\\THU_syn_v2.srcs\\sources_1\\imports\\syn_work\\x_x_frame_decoder.v", port_num=32)    
  
input("Process end!!")




