// distributed under the mit license
// https://opensource.org/licenses/mit-license.php

`timescale 1 ns / 1 ps
`default_nettype none

module ModuleName

    #(
    parameter NAME = 0
    )(
    input  logic        aclk,
    input  logic        aresetn,
    input  logic        wen,
    input  logic [15:0] wdata,
    output logic        wout
    );


endmodule

`resetall
