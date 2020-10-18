module ClHelloWorldCore(
  input         clock,
  input         reset,
  input         s_axi_awvalid,
  input  [31:0] s_axi_awaddr,
  input         s_axi_wvalid,
  input  [31:0] s_axi_wdata,
  input         s_axi_bready,
  input         s_axi_arvalid,
  input  [31:0] s_axi_araddr,
  input         s_axi_rready,
  output        s_axi_awready,
  output        s_axi_wready,
  output        s_axi_bvalid,
  output        s_axi_arready,
  output        s_axi_rvalid,
  output [31:0] s_axi_rdata,
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
  reg [1:0] readStateReg; // @[ClHelloWorld.scala 137:29]
  reg [31:0] readAddrReg; // @[ClHelloWorld.scala 140:28]
  reg [1:0] writeStateReg; // @[ClHelloWorld.scala 156:30]
  reg [31:0] writeAddrReg; // @[ClHelloWorld.scala 159:29]
  reg [31:0] helloWorldReg; // @[ClHelloWorld.scala 160:30]
  reg [15:0] shClStatusVDipQ; // @[ClHelloWorld.scala 177:32]
  reg [15:0] shClStatusVDipQ2; // @[ClHelloWorld.scala 178:33]
  reg [15:0] vLedQ; // @[ClHelloWorld.scala 179:22]
  wire [15:0] _T_13 = vLedQ & shClStatusVDipQ2; // @[ClHelloWorld.scala 180:39]
  reg [15:0] clSHStatusVLedQ; // @[ClHelloWorld.scala 180:32]
  wire [15:0] s_axi_rdata_left = helloWorldReg[31:16]; // @[ClHelloWorld.scala 187:44]
  wire [31:0] _s_axi_rdata_T_1 = {helloWorldReg[15:0],s_axi_rdata_left}; // @[Cat.scala 29:58]
  wire [31:0] _s_axi_rdata_T_2 = {16'h0,vLedQ}; // @[Cat.scala 29:58]
  assign s_axi_awready = writeStateReg == 2'h1; // @[ClHelloWorld.scala 191:34]
  assign s_axi_wready = writeStateReg == 2'h1; // @[ClHelloWorld.scala 192:33]
  assign s_axi_bvalid = writeStateReg == 2'h2; // @[ClHelloWorld.scala 194:33]
  assign s_axi_arready = readStateReg == 2'h1; // @[ClHelloWorld.scala 184:33]
  assign s_axi_rvalid = readStateReg == 2'h2; // @[ClHelloWorld.scala 185:32]
  assign s_axi_rdata = readAddrReg == 32'h500 ? _s_axi_rdata_T_1 : _s_axi_rdata_T_2; // @[ClHelloWorld.scala 186:21]
  assign cl_sh_status_vled = clSHStatusVLedQ; // @[ClHelloWorld.scala 181:21]
  always @(posedge clock) begin
    if (reset) begin // @[ClHelloWorld.scala 137:29]
      readStateReg <= 2'h0; // @[ClHelloWorld.scala 137:29]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorld.scala 141:54]
      readStateReg <= 2'h1; // @[ClHelloWorld.scala 142:18]
    end else if (readStateReg == 2'h1) begin // @[ClHelloWorld.scala 144:49]
      readStateReg <= 2'h2; // @[ClHelloWorld.scala 145:18]
    end else if (readStateReg == 2'h2 & s_axi_rready) begin // @[ClHelloWorld.scala 146:65]
      readStateReg <= 2'h0; // @[ClHelloWorld.scala 147:18]
    end
    if (reset) begin // @[ClHelloWorld.scala 140:28]
      readAddrReg <= 32'h0; // @[ClHelloWorld.scala 140:28]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorld.scala 141:54]
      readAddrReg <= s_axi_araddr; // @[ClHelloWorld.scala 143:17]
    end
    if (reset) begin // @[ClHelloWorld.scala 156:30]
      writeStateReg <= 2'h0; // @[ClHelloWorld.scala 156:30]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorld.scala 161:72]
      writeStateReg <= 2'h1; // @[ClHelloWorld.scala 162:19]
    end else if (writeStateReg == 2'h1) begin // @[ClHelloWorld.scala 164:47]
      writeStateReg <= 2'h2; // @[ClHelloWorld.scala 165:19]
    end else if (writeStateReg == 2'h2 & s_axi_bready) begin // @[ClHelloWorld.scala 169:62]
      writeStateReg <= 2'h0; // @[ClHelloWorld.scala 170:19]
    end
    if (reset) begin // @[ClHelloWorld.scala 159:29]
      writeAddrReg <= 32'h0; // @[ClHelloWorld.scala 159:29]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorld.scala 161:72]
      writeAddrReg <= s_axi_awaddr; // @[ClHelloWorld.scala 163:18]
    end
    if (reset) begin // @[ClHelloWorld.scala 160:30]
      helloWorldReg <= 32'h0; // @[ClHelloWorld.scala 160:30]
    end else if (!(writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid)) begin // @[ClHelloWorld.scala 161:72]
      if (writeStateReg == 2'h1) begin // @[ClHelloWorld.scala 164:47]
        if (writeAddrReg == 32'h500) begin // @[ClHelloWorld.scala 166:50]
          helloWorldReg <= s_axi_wdata; // @[ClHelloWorld.scala 167:21]
        end
      end
    end
    if (reset) begin // @[ClHelloWorld.scala 177:32]
      shClStatusVDipQ <= 16'h0; // @[ClHelloWorld.scala 177:32]
    end else begin
      shClStatusVDipQ <= sh_cl_status_vdip; // @[ClHelloWorld.scala 177:32]
    end
    if (reset) begin // @[ClHelloWorld.scala 178:33]
      shClStatusVDipQ2 <= 16'h0; // @[ClHelloWorld.scala 178:33]
    end else begin
      shClStatusVDipQ2 <= shClStatusVDipQ; // @[ClHelloWorld.scala 178:33]
    end
    if (reset) begin // @[ClHelloWorld.scala 179:22]
      vLedQ <= 16'h0; // @[ClHelloWorld.scala 179:22]
    end else begin
      vLedQ <= helloWorldReg[15:0]; // @[ClHelloWorld.scala 179:22]
    end
    if (reset) begin // @[ClHelloWorld.scala 180:32]
      clSHStatusVLedQ <= 16'h0; // @[ClHelloWorld.scala 180:32]
    end else begin
      clSHStatusVLedQ <= _T_13; // @[ClHelloWorld.scala 180:32]
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
module ClHelloWorld(
  input         clk_main_a0,
  input         rst_main_n,
  input         sh_ocl_awvalid,
  input  [31:0] sh_ocl_awaddr,
  output        ocl_sh_awready,
  input         sh_ocl_wvalid,
  input  [31:0] sh_ocl_wdata,
  input  [3:0]  sh_ocl_wstrb,
  output        ocl_sh_wready,
  output        ocl_sh_bvalid,
  output [1:0]  ocl_sh_bresp,
  input         sh_ocl_bready,
  input         sh_ocl_arvalid,
  input  [31:0] sh_ocl_araddr,
  output        ocl_sh_arready,
  output        ocl_sh_rvalid,
  output [31:0] ocl_sh_rdata,
  output [1:0]  ocl_sh_rresp,
  input         sh_ocl_rready,
  input         sh_cl_status_vdip,
  output        cl_sh_status_vled
);
  wire  resetSyncNegModule_clock; // @[ClHelloWorld.scala 34:34]
  wire  resetSyncNegModule_reset_n; // @[ClHelloWorld.scala 34:34]
  wire  resetSyncNegModule_reset_sync_n; // @[ClHelloWorld.scala 34:34]
  wire  axiRegisterSliceModule_aclk; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_aresetn; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_s_axi_awaddr; // @[ClHelloWorld.scala 42:38]
  wire [2:0] axiRegisterSliceModule_s_axi_awprot; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_awvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_awready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_s_axi_wdata; // @[ClHelloWorld.scala 42:38]
  wire [3:0] axiRegisterSliceModule_s_axi_wstrb; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_wvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_wready; // @[ClHelloWorld.scala 42:38]
  wire [1:0] axiRegisterSliceModule_s_axi_bresp; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_bvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_bready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_s_axi_araddr; // @[ClHelloWorld.scala 42:38]
  wire [2:0] axiRegisterSliceModule_s_axi_arprot; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_arvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_arready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_s_axi_rdata; // @[ClHelloWorld.scala 42:38]
  wire [1:0] axiRegisterSliceModule_s_axi_rresp; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_rvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_s_axi_rready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_m_axi_awaddr; // @[ClHelloWorld.scala 42:38]
  wire [2:0] axiRegisterSliceModule_m_axi_awprot; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_awvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_awready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_m_axi_wdata; // @[ClHelloWorld.scala 42:38]
  wire [3:0] axiRegisterSliceModule_m_axi_wstrb; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_wvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_wready; // @[ClHelloWorld.scala 42:38]
  wire [1:0] axiRegisterSliceModule_m_axi_bresp; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_bvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_bready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_m_axi_araddr; // @[ClHelloWorld.scala 42:38]
  wire [2:0] axiRegisterSliceModule_m_axi_arprot; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_arvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_arready; // @[ClHelloWorld.scala 42:38]
  wire [31:0] axiRegisterSliceModule_m_axi_rdata; // @[ClHelloWorld.scala 42:38]
  wire [1:0] axiRegisterSliceModule_m_axi_rresp; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_rvalid; // @[ClHelloWorld.scala 42:38]
  wire  axiRegisterSliceModule_m_axi_rready; // @[ClHelloWorld.scala 42:38]
  wire  ClHelloWorldCore_clock; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_reset; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_awvalid; // @[ClHelloWorld.scala 65:40]
  wire [31:0] ClHelloWorldCore_s_axi_awaddr; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_wvalid; // @[ClHelloWorld.scala 65:40]
  wire [31:0] ClHelloWorldCore_s_axi_wdata; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_bready; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_arvalid; // @[ClHelloWorld.scala 65:40]
  wire [31:0] ClHelloWorldCore_s_axi_araddr; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_rready; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_awready; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_wready; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_bvalid; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_arready; // @[ClHelloWorld.scala 65:40]
  wire  ClHelloWorldCore_s_axi_rvalid; // @[ClHelloWorld.scala 65:40]
  wire [31:0] ClHelloWorldCore_s_axi_rdata; // @[ClHelloWorld.scala 65:40]
  wire [15:0] ClHelloWorldCore_sh_cl_status_vdip; // @[ClHelloWorld.scala 65:40]
  wire [15:0] ClHelloWorldCore_cl_sh_status_vled; // @[ClHelloWorld.scala 65:40]
  ResetSyncNeg resetSyncNegModule ( // @[ClHelloWorld.scala 34:34]
    .clock(resetSyncNegModule_clock),
    .reset_n(resetSyncNegModule_reset_n),
    .reset_sync_n(resetSyncNegModule_reset_sync_n)
  );
  axi_register_slice_light axiRegisterSliceModule ( // @[ClHelloWorld.scala 42:38]
    .aclk(axiRegisterSliceModule_aclk),
    .aresetn(axiRegisterSliceModule_aresetn),
    .s_axi_awaddr(axiRegisterSliceModule_s_axi_awaddr),
    .s_axi_awprot(axiRegisterSliceModule_s_axi_awprot),
    .s_axi_awvalid(axiRegisterSliceModule_s_axi_awvalid),
    .s_axi_awready(axiRegisterSliceModule_s_axi_awready),
    .s_axi_wdata(axiRegisterSliceModule_s_axi_wdata),
    .s_axi_wstrb(axiRegisterSliceModule_s_axi_wstrb),
    .s_axi_wvalid(axiRegisterSliceModule_s_axi_wvalid),
    .s_axi_wready(axiRegisterSliceModule_s_axi_wready),
    .s_axi_bresp(axiRegisterSliceModule_s_axi_bresp),
    .s_axi_bvalid(axiRegisterSliceModule_s_axi_bvalid),
    .s_axi_bready(axiRegisterSliceModule_s_axi_bready),
    .s_axi_araddr(axiRegisterSliceModule_s_axi_araddr),
    .s_axi_arprot(axiRegisterSliceModule_s_axi_arprot),
    .s_axi_arvalid(axiRegisterSliceModule_s_axi_arvalid),
    .s_axi_arready(axiRegisterSliceModule_s_axi_arready),
    .s_axi_rdata(axiRegisterSliceModule_s_axi_rdata),
    .s_axi_rresp(axiRegisterSliceModule_s_axi_rresp),
    .s_axi_rvalid(axiRegisterSliceModule_s_axi_rvalid),
    .s_axi_rready(axiRegisterSliceModule_s_axi_rready),
    .m_axi_awaddr(axiRegisterSliceModule_m_axi_awaddr),
    .m_axi_awprot(axiRegisterSliceModule_m_axi_awprot),
    .m_axi_awvalid(axiRegisterSliceModule_m_axi_awvalid),
    .m_axi_awready(axiRegisterSliceModule_m_axi_awready),
    .m_axi_wdata(axiRegisterSliceModule_m_axi_wdata),
    .m_axi_wstrb(axiRegisterSliceModule_m_axi_wstrb),
    .m_axi_wvalid(axiRegisterSliceModule_m_axi_wvalid),
    .m_axi_wready(axiRegisterSliceModule_m_axi_wready),
    .m_axi_bresp(axiRegisterSliceModule_m_axi_bresp),
    .m_axi_bvalid(axiRegisterSliceModule_m_axi_bvalid),
    .m_axi_bready(axiRegisterSliceModule_m_axi_bready),
    .m_axi_araddr(axiRegisterSliceModule_m_axi_araddr),
    .m_axi_arprot(axiRegisterSliceModule_m_axi_arprot),
    .m_axi_arvalid(axiRegisterSliceModule_m_axi_arvalid),
    .m_axi_arready(axiRegisterSliceModule_m_axi_arready),
    .m_axi_rdata(axiRegisterSliceModule_m_axi_rdata),
    .m_axi_rresp(axiRegisterSliceModule_m_axi_rresp),
    .m_axi_rvalid(axiRegisterSliceModule_m_axi_rvalid),
    .m_axi_rready(axiRegisterSliceModule_m_axi_rready)
  );
  ClHelloWorldCore ClHelloWorldCore ( // @[ClHelloWorld.scala 65:40]
    .clock(ClHelloWorldCore_clock),
    .reset(ClHelloWorldCore_reset),
    .s_axi_awvalid(ClHelloWorldCore_s_axi_awvalid),
    .s_axi_awaddr(ClHelloWorldCore_s_axi_awaddr),
    .s_axi_wvalid(ClHelloWorldCore_s_axi_wvalid),
    .s_axi_wdata(ClHelloWorldCore_s_axi_wdata),
    .s_axi_bready(ClHelloWorldCore_s_axi_bready),
    .s_axi_arvalid(ClHelloWorldCore_s_axi_arvalid),
    .s_axi_araddr(ClHelloWorldCore_s_axi_araddr),
    .s_axi_rready(ClHelloWorldCore_s_axi_rready),
    .s_axi_awready(ClHelloWorldCore_s_axi_awready),
    .s_axi_wready(ClHelloWorldCore_s_axi_wready),
    .s_axi_bvalid(ClHelloWorldCore_s_axi_bvalid),
    .s_axi_arready(ClHelloWorldCore_s_axi_arready),
    .s_axi_rvalid(ClHelloWorldCore_s_axi_rvalid),
    .s_axi_rdata(ClHelloWorldCore_s_axi_rdata),
    .sh_cl_status_vdip(ClHelloWorldCore_sh_cl_status_vdip),
    .cl_sh_status_vled(ClHelloWorldCore_cl_sh_status_vled)
  );
  assign ocl_sh_awready = axiRegisterSliceModule_s_axi_awready; // @[ClHelloWorld.scala 48:18]
  assign ocl_sh_wready = axiRegisterSliceModule_s_axi_wready; // @[ClHelloWorld.scala 52:17]
  assign ocl_sh_bvalid = axiRegisterSliceModule_s_axi_bvalid; // @[ClHelloWorld.scala 54:17]
  assign ocl_sh_bresp = axiRegisterSliceModule_s_axi_bresp; // @[ClHelloWorld.scala 53:16]
  assign ocl_sh_arready = axiRegisterSliceModule_s_axi_arready; // @[ClHelloWorld.scala 58:18]
  assign ocl_sh_rvalid = axiRegisterSliceModule_s_axi_rvalid; // @[ClHelloWorld.scala 61:17]
  assign ocl_sh_rdata = axiRegisterSliceModule_s_axi_rdata; // @[ClHelloWorld.scala 59:16]
  assign ocl_sh_rresp = axiRegisterSliceModule_s_axi_rresp; // @[ClHelloWorld.scala 60:16]
  assign cl_sh_status_vled = ClHelloWorldCore_cl_sh_status_vled[0]; // @[ClHelloWorld.scala 85:23]
  assign resetSyncNegModule_clock = clk_main_a0; // @[ClHelloWorld.scala 36:45]
  assign resetSyncNegModule_reset_n = rst_main_n; // @[ClHelloWorld.scala 37:26]
  assign axiRegisterSliceModule_aclk = clk_main_a0; // @[ClHelloWorld.scala 43:52]
  assign axiRegisterSliceModule_aresetn = resetSyncNegModule_reset_sync_n; // @[ClHelloWorld.scala 44:34]
  assign axiRegisterSliceModule_s_axi_awaddr = sh_ocl_awaddr; // @[ClHelloWorld.scala 45:39]
  assign axiRegisterSliceModule_s_axi_awprot = 3'h0; // @[ClHelloWorld.scala 46:39]
  assign axiRegisterSliceModule_s_axi_awvalid = sh_ocl_awvalid; // @[ClHelloWorld.scala 47:40]
  assign axiRegisterSliceModule_s_axi_wdata = sh_ocl_wdata; // @[ClHelloWorld.scala 49:38]
  assign axiRegisterSliceModule_s_axi_wstrb = sh_ocl_wstrb; // @[ClHelloWorld.scala 50:38]
  assign axiRegisterSliceModule_s_axi_wvalid = sh_ocl_wvalid; // @[ClHelloWorld.scala 51:39]
  assign axiRegisterSliceModule_s_axi_bready = sh_ocl_bready; // @[ClHelloWorld.scala 55:39]
  assign axiRegisterSliceModule_s_axi_araddr = sh_ocl_araddr; // @[ClHelloWorld.scala 56:39]
  assign axiRegisterSliceModule_s_axi_arprot = 3'h0;
  assign axiRegisterSliceModule_s_axi_arvalid = sh_ocl_arvalid; // @[ClHelloWorld.scala 57:40]
  assign axiRegisterSliceModule_s_axi_rready = sh_ocl_rready; // @[ClHelloWorld.scala 62:39]
  assign axiRegisterSliceModule_m_axi_awready = ClHelloWorldCore_s_axi_awready; // @[ClHelloWorld.scala 75:42]
  assign axiRegisterSliceModule_m_axi_wready = ClHelloWorldCore_s_axi_wready; // @[ClHelloWorld.scala 76:41]
  assign axiRegisterSliceModule_m_axi_bresp = 2'h0; // @[ClHelloWorld.scala 78:40]
  assign axiRegisterSliceModule_m_axi_bvalid = ClHelloWorldCore_s_axi_bvalid; // @[ClHelloWorld.scala 77:41]
  assign axiRegisterSliceModule_m_axi_arready = ClHelloWorldCore_s_axi_arready; // @[ClHelloWorld.scala 79:42]
  assign axiRegisterSliceModule_m_axi_rdata = ClHelloWorldCore_s_axi_rdata; // @[ClHelloWorld.scala 81:40]
  assign axiRegisterSliceModule_m_axi_rresp = 2'h0; // @[ClHelloWorld.scala 82:40]
  assign axiRegisterSliceModule_m_axi_rvalid = ClHelloWorldCore_s_axi_rvalid; // @[ClHelloWorld.scala 80:41]
  assign ClHelloWorldCore_clock = clk_main_a0;
  assign ClHelloWorldCore_reset = ~resetSyncNegModule_reset_sync_n; // @[ClHelloWorld.scala 64:34]
  assign ClHelloWorldCore_s_axi_awvalid = axiRegisterSliceModule_m_axi_awvalid; // @[ClHelloWorld.scala 66:42]
  assign ClHelloWorldCore_s_axi_awaddr = axiRegisterSliceModule_m_axi_awaddr; // @[ClHelloWorld.scala 67:41]
  assign ClHelloWorldCore_s_axi_wvalid = axiRegisterSliceModule_m_axi_wvalid; // @[ClHelloWorld.scala 68:41]
  assign ClHelloWorldCore_s_axi_wdata = axiRegisterSliceModule_m_axi_wdata; // @[ClHelloWorld.scala 69:40]
  assign ClHelloWorldCore_s_axi_bready = axiRegisterSliceModule_m_axi_bready; // @[ClHelloWorld.scala 71:41]
  assign ClHelloWorldCore_s_axi_arvalid = axiRegisterSliceModule_m_axi_arvalid; // @[ClHelloWorld.scala 72:42]
  assign ClHelloWorldCore_s_axi_araddr = axiRegisterSliceModule_m_axi_araddr; // @[ClHelloWorld.scala 73:41]
  assign ClHelloWorldCore_s_axi_rready = axiRegisterSliceModule_m_axi_rready; // @[ClHelloWorld.scala 74:41]
  assign ClHelloWorldCore_sh_cl_status_vdip = {{15'd0}, sh_cl_status_vdip}; // @[ClHelloWorld.scala 84:46]
endmodule
