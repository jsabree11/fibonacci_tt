// Fibonacci sequence generator, able to be scaled up.

`default_nettype none

module tt_um_jsabree11_fibonacci_checker (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    // Fibonacci registers
    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] next;

    // State/result registers
    reg done;
    reg is_fib;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a      <= 8'd0;
            b      <= 8'd1;
            next   <= 8'd1;

            is_fib <= 1'b0;
            done   <= 1'b0;
        end
        else begin

            // restart search every cycle
            if (!done) begin

                // direct checks for 0 and 1
                if ((ui_in == 8'd0) || (ui_in == 8'd1)) begin
                    is_fib <= 1'b1;
                    done   <= 1'b1;
                end

                // match found
                else if (b == ui_in) begin
                    is_fib <= 1'b1;
                    done   <= 1'b1;
                end

                // exceeded input or range
                else if ((b > ui_in) || (b > 8'd233)) begin
                    is_fib <= 1'b0;
                    done   <= 1'b1;
                end

                // generate next Fibonacci number
                else begin
                    next <= a + b;
                    a    <= b;
                    b    <= a + b;
                end
            end
            else begin
                // restart automatically for continuous operation
                a      <= 8'd0;
                b      <= 8'd1;
                next   <= 8'd1;

                done   <= 1'b0;
                is_fib <= 1'b0;
            end
        end
    end

    // Output:
    // bit0 = is_fib
    // bit1 = done
    assign uo_out = {6'b0, done, is_fib};

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, uio_in, 1'b0};

endmodule
