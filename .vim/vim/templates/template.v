//-----------------------------------------------------------------------------
// This confidential and proprietary software may be used only as authorized by
// a licensing agreement from PLDA. In the event of publication, a copyright
// notice must be reproduced on all authorized copies.
//-----------------------------------------------------------------------------
// Project  :
// Name     : 
//-----------------------------------------------------------------------------
// Description:
//             
//-----------------------------------------------------------------------------  


`timescale 1ns/1ps
`default_nettype none

// Synthesis

module ModuleName

    #(
    )(
    input wire  clk,
    input wire  rstn
    );

endmodule

// Simulation

module tb_ModuleName;

    reg         clk;
    reg         rstn;
    integer     clk_period = 10;



    initial begin
        
        clk         <= 1'b0;
        rstn        <= 1'b0;
        #100;
        rstn        <= 1'b0;
        
        $display("\n\n");
        $display("Design initialized");
        $display("clock period = %d ns",clk_period);
        $display("\n\n");
   
    end

    always begin
        #clk_period;
        clk <= ~clk;
    end

endmodule


`resetall


