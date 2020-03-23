module ModuleName

    #(
    parameter NAME = 0
    )(
    input         aclk,
    input         arstn,
    input         wen,
    input  [15:0] wdata,
    output logic  wout
    );

    always_ff (posedge aclk) wout <= wdata;

endmodule
