`default_nettype none

module tt_um_jsabree11_fibonacci_checker (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    reg is_fib;

    always @(*) begin
        case (ui_in)
            8'd0,
            8'd1,
            8'd2,
            8'd3,
            8'd5,
            8'd8,
            8'd13,
            8'd21,
            8'd34,
            8'd55,
            8'd89,
            8'd144,
            8'd233: is_fib = 1'b1;
            default: is_fib = 1'b0;
        endcase
    end

    assign uo_out = {7'b0, is_fib};

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
