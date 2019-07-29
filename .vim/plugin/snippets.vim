"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Verilog snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iab <for> for (i=0;i<max;i=i+1)<cr>begin<cr>end

iab <always> always @ (posedge aclk or negedge arstn) begin<cr><cr>
            \if (arstn == 1'b0) begin<cr>end<cr>else begin<cr>end<cr><bs>end

iab <fsm> localparam [3:0] IDLE = 0, STATE1 = 1;<cr>reg[3:0] state;<cr><cr>
            \always @ (posedge aclk or negedge arstn)<cr>begin<cr>if (arstn==1'b0)
            \begin<cr>state <= IDLE;<cr>end<cr>else begin<cr>case (state)<cr>
            \default : begin<cr>end<cr>STATE1: begin<cr>end<cr><bs>endcase<cr><bs>end<cr><bs>end

iab <function> function integer myFunc(input integer i);<cr>begin<cr>end<cr>endfunction

iab <task> task myTask;<cr>begin<cr>end<cr>endtask<cr>
