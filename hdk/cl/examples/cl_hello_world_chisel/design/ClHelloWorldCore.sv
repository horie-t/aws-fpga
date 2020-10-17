module ClHelloWorldCore(
  input         clock,
  input         reset,
  input         s_axi_awvalid,
  input  [31:0] s_axi_awaddr,
  input         s_axi_wvalid,
  input  [31:0] s_axi_wdata,
  input  [3:0]  s_axi_wstrb,
  input         s_axi_bready,
  input         s_axi_arvalid,
  input  [31:0] s_axi_araddr,
  input         s_axi_rready,
  output        s_axi_awready,
  output        s_axi_wready,
  output        s_axi_bvalid,
  output [1:0]  s_axi_bresp,
  output        s_axi_arready,
  output        s_axi_rvalid,
  output [31:0] s_axi_rdata,
  output [1:0]  s_axi_rresp,
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
  wire [15:0] _T_13 = vLedQ & shClStatusVDipQ2; // @[ClHelloWorldCore.scala 95:39]
  reg [15:0] clSHStatusVLedQ; // @[ClHelloWorldCore.scala 95:32]
  wire [15:0] s_axi_rdata_left = helloWorldReg[31:16]; // @[ClHelloWorldCore.scala 102:44]
  wire [31:0] _s_axi_rdata_T_1 = {helloWorldReg[15:0],s_axi_rdata_left}; // @[Cat.scala 29:58]
  wire [31:0] _s_axi_rdata_T_2 = {16'h0,vLedQ}; // @[Cat.scala 29:58]
  assign s_axi_awready = writeStateReg == 2'h1; // @[ClHelloWorldCore.scala 106:34]
  assign s_axi_wready = writeStateReg == 2'h1; // @[ClHelloWorldCore.scala 107:33]
  assign s_axi_bvalid = writeStateReg == 2'h2; // @[ClHelloWorldCore.scala 109:33]
  assign s_axi_bresp = 2'h0; // @[ClHelloWorldCore.scala 108:15]
  assign s_axi_arready = readStateReg == 2'h1; // @[ClHelloWorldCore.scala 99:33]
  assign s_axi_rvalid = readStateReg == 2'h2; // @[ClHelloWorldCore.scala 100:32]
  assign s_axi_rdata = readAddrReg == 32'h500 ? _s_axi_rdata_T_1 : _s_axi_rdata_T_2; // @[ClHelloWorldCore.scala 101:21]
  assign s_axi_rresp = 2'h0; // @[ClHelloWorldCore.scala 104:15]
  assign cl_sh_status_vled = clSHStatusVLedQ; // @[ClHelloWorldCore.scala 96:21]
  always @(posedge clock) begin
    if (reset) begin // @[ClHelloWorldCore.scala 52:29]
      readStateReg <= 2'h0; // @[ClHelloWorldCore.scala 52:29]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorldCore.scala 56:54]
      readStateReg <= 2'h1; // @[ClHelloWorldCore.scala 57:18]
    end else if (readStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 59:49]
      readStateReg <= 2'h2; // @[ClHelloWorldCore.scala 60:18]
    end else if (readStateReg == 2'h2 & s_axi_rready) begin // @[ClHelloWorldCore.scala 61:65]
      readStateReg <= 2'h0; // @[ClHelloWorldCore.scala 62:18]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 55:28]
      readAddrReg <= 32'h0; // @[ClHelloWorldCore.scala 55:28]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorldCore.scala 56:54]
      readAddrReg <= s_axi_araddr; // @[ClHelloWorldCore.scala 58:17]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 71:30]
      writeStateReg <= 2'h0; // @[ClHelloWorldCore.scala 71:30]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorldCore.scala 76:72]
      writeStateReg <= 2'h1; // @[ClHelloWorldCore.scala 77:19]
    end else if (writeStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 79:47]
      writeStateReg <= 2'h2; // @[ClHelloWorldCore.scala 80:19]
    end else if (writeStateReg == 2'h2 & s_axi_bready) begin // @[ClHelloWorldCore.scala 84:62]
      writeStateReg <= 2'h0; // @[ClHelloWorldCore.scala 85:19]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 74:29]
      writeAddrReg <= 32'h0; // @[ClHelloWorldCore.scala 74:29]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorldCore.scala 76:72]
      writeAddrReg <= s_axi_awaddr; // @[ClHelloWorldCore.scala 78:18]
    end
    if (reset) begin // @[ClHelloWorldCore.scala 75:30]
      helloWorldReg <= 32'h0; // @[ClHelloWorldCore.scala 75:30]
    end else if (!(writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid)) begin // @[ClHelloWorldCore.scala 76:72]
      if (writeStateReg == 2'h1) begin // @[ClHelloWorldCore.scala 79:47]
        if (writeAddrReg == 32'h500) begin // @[ClHelloWorldCore.scala 81:50]
          helloWorldReg <= s_axi_wdata; // @[ClHelloWorldCore.scala 82:21]
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
    if (reset) begin // @[ClHelloWorldCore.scala 95:32]
      clSHStatusVLedQ <= 16'h0; // @[ClHelloWorldCore.scala 95:32]
    end else begin
      clSHStatusVLedQ <= _T_13; // @[ClHelloWorldCore.scala 95:32]
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
  clSHStatusVLedQ = _RAND_8[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
