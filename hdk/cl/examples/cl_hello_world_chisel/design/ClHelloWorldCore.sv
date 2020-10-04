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
  reg [31:0] helloWorldQ; // @[ClHelloWorldCore.scala 21:28]
  reg [31:0] _RAND_0;
  wire  _T_1 = io_wrAddr == 32'h500; // @[ClHelloWorldCore.scala 22:43]
  wire  _T_2 = io_wrReady & _T_1; // @[ClHelloWorldCore.scala 22:30]
  reg [15:0] shClStatusVDipQ; // @[ClHelloWorldCore.scala 31:32]
  reg [31:0] _RAND_1;
  reg [15:0] shClStatusVDipQ2; // @[ClHelloWorldCore.scala 32:33]
  reg [31:0] _RAND_2;
  reg [15:0] vLedQ; // @[ClHelloWorldCore.scala 34:22]
  reg [31:0] _RAND_3;
  wire [15:0] preClShStatusVLed = vLedQ & shClStatusVDipQ2; // @[ClHelloWorldCore.scala 35:33]
  reg [15:0] clShStatusVLed; // @[ClHelloWorldCore.scala 36:31]
  reg [31:0] _RAND_4;
  assign io_helloWorldQByteSwapped = {helloWorldQ[15:0],helloWorldQ[31:16]}; // @[ClHelloWorldCore.scala 25:29]
  assign io_clShStatusVLed = clShStatusVLed; // @[ClHelloWorldCore.scala 39:21]
  assign io_vLed = vLedQ; // @[ClHelloWorldCore.scala 38:11]
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
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  shClStatusVDipQ = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  shClStatusVDipQ2 = _RAND_2[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  vLedQ = _RAND_3[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  clShStatusVLed = _RAND_4[15:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      helloWorldQ <= 32'h0;
    end else if (_T_2) begin
      helloWorldQ <= io_wData;
    end
    if (reset) begin
      shClStatusVDipQ <= 16'h0;
    end else begin
      shClStatusVDipQ <= io_shClStatusVDip;
    end
    if (reset) begin
      shClStatusVDipQ2 <= 16'h0;
    end else begin
      shClStatusVDipQ2 <= shClStatusVDipQ;
    end
    if (reset) begin
      vLedQ <= 16'h0;
    end else begin
      vLedQ <= helloWorldQ[15:0];
    end
    if (reset) begin
      clShStatusVLed <= 16'h0;
    end else begin
      clShStatusVLed <= preClShStatusVLed;
    end
  end
endmodule
