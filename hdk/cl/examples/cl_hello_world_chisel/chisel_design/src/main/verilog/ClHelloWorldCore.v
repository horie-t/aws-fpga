module ClHelloWorldCore(
  input         clock,
  input         reset,
  input  [31:0] io_wrAddr,
  input  [31:0] io_wData,
  input         io_wrReady,
  input  [15:0] io_shClStatusVDip,
  output [31:0] io_helloWorldQByteSwapped,
  output [15:0] io_clShStatusVLed,
  output [15:0] io_vLed
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] helloWorldQ; // @[ClHelloWorldCore.scala 21:28]
  wire [15:0] io_helloWorldQByteSwapped_right = helloWorldQ[15:0]; // @[ClHelloWorldCore.scala 25:47]
  wire [15:0] io_helloWorldQByteSwapped_left = helloWorldQ[31:16]; // @[ClHelloWorldCore.scala 25:67]
  reg [15:0] shClStatusVDipQ; // @[ClHelloWorldCore.scala 31:32]
  reg [15:0] shClStatusVDipQ2; // @[ClHelloWorldCore.scala 32:33]
  reg [15:0] vLedQ; // @[ClHelloWorldCore.scala 34:22]
  wire [15:0] preClShStatusVLed = vLedQ & shClStatusVDipQ2; // @[ClHelloWorldCore.scala 35:33]
  reg [15:0] clShStatusVLed; // @[ClHelloWorldCore.scala 36:31]
  assign io_helloWorldQByteSwapped = {io_helloWorldQByteSwapped_right,io_helloWorldQByteSwapped_left}; // @[Cat.scala 29:58]
  assign io_clShStatusVLed = clShStatusVLed; // @[ClHelloWorldCore.scala 39:21]
  assign io_vLed = vLedQ; // @[ClHelloWorldCore.scala 38:11]
  always @(posedge clock) begin
    if (reset) begin // @[ClHelloWorldCore.scala 21:28]
      helloWorldQ <= 32'h0; // @[ClHelloWorldCore.scala 21:28]
    end else if (io_wrReady & io_wrAddr == 32'h500) begin // @[ClHelloWorldCore.scala 22:69]
      helloWorldQ <= io_wData; // @[ClHelloWorldCore.scala 23:17]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 31:32]
      shClStatusVDipQ <= 16'h0; // @[ClHelloWorldCore.scala 31:32]
    end else begin
      shClStatusVDipQ <= io_shClStatusVDip; // @[ClHelloWorldCore.scala 31:32]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 32:33]
      shClStatusVDipQ2 <= 16'h0; // @[ClHelloWorldCore.scala 32:33]
    end else begin
      shClStatusVDipQ2 <= shClStatusVDipQ; // @[ClHelloWorldCore.scala 32:33]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 34:22]
      vLedQ <= 16'h0; // @[ClHelloWorldCore.scala 34:22]
    end else begin
      vLedQ <= io_helloWorldQByteSwapped_right; // @[ClHelloWorldCore.scala 34:22]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 36:31]
      clShStatusVLed <= 16'h0; // @[ClHelloWorldCore.scala 36:31]
    end else begin
      clShStatusVLed <= preClShStatusVLed; // @[ClHelloWorldCore.scala 36:31]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  helloWorldQ = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  shClStatusVDipQ = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  shClStatusVDipQ2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  vLedQ = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  clShStatusVLed = _RAND_4[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
