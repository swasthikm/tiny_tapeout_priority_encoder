/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_priority_encoder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    reg [2:0] a;
  // All output pins must be assigned. If not used, assign to 0
  assign uio_out = 0;
  assign uio_oe  = 0; 
  assign uo_out[7:3] = 0;
  always@(ui_in)
      begin
          casez(ui_in)
 
              8'b00000001:a = 3'b000;
              8'b0000001?:a  = 3'b001;
              8'b000001??:a  = 3'b010;
              8'b00001???:a = 3'b011;
              8'b0001????:a  = 3'b100;
              8'b001?????:a  = 3'b101;
              8'b01??????:a  = 3'b110;
              8'b1???????:a = 3'b111;
 
          default:a = 3'bzzz;
          endcase
     end
    assign uo_out[2:0] = a;
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
