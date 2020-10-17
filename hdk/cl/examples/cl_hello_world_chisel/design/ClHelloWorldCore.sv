module ClHelloWorldCore(
  input         clock,
  input         reset,
  input         awvalid,
  input  [31:0] awadder,
  input         wvalid,
  input  [31:0] wdata,
  input  [3:0]  wstrb,
  input         bready,
  input         arvaild,
  input  [31:0] araddr,
  input         rready,
  output        awready,
  output        wready,
  output        bvalid,
  output [1:0]  bresp,
  output        arready,
  output        rvalid,
  output [31:0] rdata,
  output [1:0]  rresp,
  input  [15:0] sh_cl_status_vdip,
  output [15:0] cl_sh_status_vled
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] readStateReg; // @[ClHelloWorldCore.scala 52:29]
  reg [31:0] readAddrReg; // @[ClHelloWorldCore.scala 55:28]
  reg [1:0] writeStateReg; // @[ClHelloWorldCore.scala 71:30]
  reg [31:0] writeAddrReg; // @[ClHelloWorldCore.scala 74:29]
  reg [31:0] helloWorldReg; // @[ClHelloWorldCore.scala 75:30]
  reg [15:0] shClStatusVDipQ; // @[ClHelloWorldCore.scala 92:32]
  reg [15:0] shClStatusVDipQ2; // @[ClHelloWorldCore.scala 93:33]
  reg [15:0] vLedQ; // @[ClHelloWorldCore.scala 94:22]
  wire [15:0] preClShStatusVLed = vLedQ & shClStatusVDipQ2; // @[ClHelloWorldCore.scala 95:33]
  reg [15:0] clShStatusVLed; // @[ClHelloWorldCore.scala 96:31]
  wire [15:0] rdata_left = helloWorldReg[31:16]; // @[ClHelloWorldCore.scala 103:44]
  wire [31:0] _rdata_T_1 = {helloWorldReg[15:0],rdata_left}; // @[Cat.scala 29:58]
  wire [31:0] _rdata_T_2 = {16'h0,vLedQ}; // @[Cat.scala 29:58]
  assign awready = writeStateReg == 2'h1; // @[ClHelloWorldCore.scala 107:28]
  assign wready = writeStateReg == 2'h1; // @[ClHelloWorldCore.scala 108:27]
  assign bvalid = writeStateReg == 2'h2; // @[ClHelloWorldCore.scala 110:27]
  assign bresp = 2'h0; // @[ClHelloWorldCore.scala 109:9]
  assign arready = readStateReg == 2'h1; // @[ClHelloWorldCore.scala 100:27]
  assign rvalid = readStateReg == 2'h2; // @[ClHelloWorldCore.scala 101:26]
  assign rdata = readAddrReg == 32'h500 ? _rdata_T_1 : _rdata_T_2; // @[ClHelloWorldCore.scala 102:15]
  assign rresp = 2'h0; // @[ClHelloWorldCore.scala 105:9]
  assign cl_sh_status_vled = clShStatusVLed; // @[ClHelloWorldCore.scala 97:21]
  always @(posedge clock) begin
    if (reset) begin // @[ClHelloWorldCore.scala 52:29]
      readStateReg <= 2'h0; // @[ClHelloWorldCore.scala 52:29]
    end else if (readStateReg == 2'h0 & arvaild) begin // @[ClHelloWorldCore.scala 56:48]
      readStateReg <= 2'h1; // @[ClHelloWorldCore.scala 57:18]
    end else if (readStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 59:49]
      readStateReg <= 2'h2; // @[ClHelloWorldCore.scala 60:18]
    end else if (readStateReg == 2'h2 & rready) begin // @[ClHelloWorldCore.scala 61:59]
      readStateReg <= 2'h0; // @[ClHelloWorldCore.scala 62:18]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 55:28]
      readAddrReg <= 32'h0; // @[ClHelloWorldCore.scala 55:28]
    end else if (readStateReg == 2'h0 & arvaild) begin // @[ClHelloWorldCore.scala 56:48]
      readAddrReg <= araddr; // @[ClHelloWorldCore.scala 58:17]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 71:30]
      writeStateReg <= 2'h0; // @[ClHelloWorldCore.scala 71:30]
    end else if (writeStateReg == 2'h0 & awvalid & wvalid) begin // @[ClHelloWorldCore.scala 76:60]
      writeStateReg <= 2'h1; // @[ClHelloWorldCore.scala 77:19]
    end else if (writeStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 79:47]
      writeStateReg <= 2'h2; // @[ClHelloWorldCore.scala 80:19]
    end else if (writeStateReg == 2'h2 & bready) begin // @[ClHelloWorldCore.scala 84:56]
      writeStateReg <= 2'h0; // @[ClHelloWorldCore.scala 85:19]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 74:29]
      writeAddrReg <= 32'h0; // @[ClHelloWorldCore.scala 74:29]
    end else if (writeStateReg == 2'h0 & awvalid & wvalid) begin // @[ClHelloWorldCore.scala 76:60]
      writeAddrReg <= awadder; // @[ClHelloWorldCore.scala 78:18]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 75:30]
      helloWorldReg <= 32'h0; // @[ClHelloWorldCore.scala 75:30]
    end else if (!(writeStateReg == 2'h0 & awvalid & wvalid)) begin // @[ClHelloWorldCore.scala 76:60]
      if (writeStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 79:47]
        if (writeAddrReg == 32'h500) begin // @[ClHelloWorldCore.scala 81:50]
          helloWorldReg <= wdata; // @[ClHelloWorldCore.scala 82:21]
        end
      end
    end
    if (reset) begin // @[ClHelloWorldCore.scala 92:32]
      shClStatusVDipQ <= 16'h0; // @[ClHelloWorldCore.scala 92:32]
    end else begin
      shClStatusVDipQ <= sh_cl_status_vdip; // @[ClHelloWorldCore.scala 92:32]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 93:33]
      shClStatusVDipQ2 <= 16'h0; // @[ClHelloWorldCore.scala 93:33]
    end else begin
      shClStatusVDipQ2 <= shClStatusVDipQ; // @[ClHelloWorldCore.scala 93:33]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 94:22]
      vLedQ <= 16'h0; // @[ClHelloWorldCore.scala 94:22]
    end else begin
      vLedQ <= helloWorldReg[15:0]; // @[ClHelloWorldCore.scala 94:22]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 96:31]
      clShStatusVLed <= 16'h0; // @[ClHelloWorldCore.scala 96:31]
    end else begin
      clShStatusVLed <= preClShStatusVLed; // @[ClHelloWorldCore.scala 96:31]
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
  readStateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  readAddrReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  writeStateReg = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  writeAddrReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  helloWorldReg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  shClStatusVDipQ = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  shClStatusVDipQ2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  vLedQ = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  clShStatusVLed = _RAND_8[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
