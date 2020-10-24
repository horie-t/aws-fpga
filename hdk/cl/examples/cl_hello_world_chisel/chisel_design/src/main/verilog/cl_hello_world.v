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
  reg [1:0] readStateReg; // @[ClHelloWorld.scala 136:29]
  reg [31:0] readAddrReg; // @[ClHelloWorld.scala 139:28]
  reg [1:0] writeStateReg; // @[ClHelloWorld.scala 155:30]
  reg [31:0] writeAddrReg; // @[ClHelloWorld.scala 158:29]
  reg [31:0] helloWorldReg; // @[ClHelloWorld.scala 159:30]
  reg [15:0] shClStatusVDipQ; // @[ClHelloWorld.scala 176:32]
  reg [15:0] shClStatusVDipQ2; // @[ClHelloWorld.scala 177:33]
  reg [15:0] vLedQ; // @[ClHelloWorld.scala 178:22]
  wire [15:0] _T_13 = vLedQ & shClStatusVDipQ2; // @[ClHelloWorld.scala 179:39]
  reg [15:0] clSHStatusVLedQ; // @[ClHelloWorld.scala 179:32]
  wire [15:0] s_axi_rdata_left = helloWorldReg[31:16]; // @[ClHelloWorld.scala 186:44]
  wire [31:0] _s_axi_rdata_T_1 = {helloWorldReg[15:0],s_axi_rdata_left}; // @[Cat.scala 29:58]
  wire [31:0] _s_axi_rdata_T_2 = {16'h0,vLedQ}; // @[Cat.scala 29:58]
  assign s_axi_awready = writeStateReg == 2'h1; // @[ClHelloWorld.scala 190:34]
  assign s_axi_wready = writeStateReg == 2'h1; // @[ClHelloWorld.scala 191:33]
  assign s_axi_bvalid = writeStateReg == 2'h2; // @[ClHelloWorld.scala 193:33]
  assign s_axi_arready = readStateReg == 2'h1; // @[ClHelloWorld.scala 183:33]
  assign s_axi_rvalid = readStateReg == 2'h2; // @[ClHelloWorld.scala 184:32]
  assign s_axi_rdata = readAddrReg == 32'h500 ? _s_axi_rdata_T_1 : _s_axi_rdata_T_2; // @[ClHelloWorld.scala 185:21]
  assign cl_sh_status_vled = clSHStatusVLedQ; // @[ClHelloWorld.scala 180:21]
  always @(posedge clock) begin
    if (reset) begin // @[ClHelloWorld.scala 136:29]
      readStateReg <= 2'h0; // @[ClHelloWorld.scala 136:29]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorld.scala 140:54]
      readStateReg <= 2'h1; // @[ClHelloWorld.scala 141:18]
    end else if (readStateReg == 2'h1) begin // @[ClHelloWorld.scala 143:49]
      readStateReg <= 2'h2; // @[ClHelloWorld.scala 144:18]
    end else if (readStateReg == 2'h2 & s_axi_rready) begin // @[ClHelloWorld.scala 145:65]
      readStateReg <= 2'h0; // @[ClHelloWorld.scala 146:18]
    end
    if (reset) begin // @[ClHelloWorld.scala 139:28]
      readAddrReg <= 32'h0; // @[ClHelloWorld.scala 139:28]
    end else if (readStateReg == 2'h0 & s_axi_arvalid) begin // @[ClHelloWorld.scala 140:54]
      readAddrReg <= s_axi_araddr; // @[ClHelloWorld.scala 142:17]
    end
    if (reset) begin // @[ClHelloWorld.scala 155:30]
      writeStateReg <= 2'h0; // @[ClHelloWorld.scala 155:30]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorld.scala 160:72]
      writeStateReg <= 2'h1; // @[ClHelloWorld.scala 161:19]
    end else if (writeStateReg == 2'h1) begin // @[ClHelloWorld.scala 163:47]
      writeStateReg <= 2'h2; // @[ClHelloWorld.scala 164:19]
    end else if (writeStateReg == 2'h2 & s_axi_bready) begin // @[ClHelloWorld.scala 168:62]
      writeStateReg <= 2'h0; // @[ClHelloWorld.scala 169:19]
    end
    if (reset) begin // @[ClHelloWorld.scala 158:29]
      writeAddrReg <= 32'h0; // @[ClHelloWorld.scala 158:29]
    end else if (writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid) begin // @[ClHelloWorld.scala 160:72]
      writeAddrReg <= s_axi_awaddr; // @[ClHelloWorld.scala 162:18]
    end
    if (reset) begin // @[ClHelloWorld.scala 159:30]
      helloWorldReg <= 32'h0; // @[ClHelloWorld.scala 159:30]
    end else if (!(writeStateReg == 2'h0 & s_axi_awvalid & s_axi_wvalid)) begin // @[ClHelloWorld.scala 160:72]
      if (writeStateReg == 2'h1) begin // @[ClHelloWorld.scala 163:47]
        if (writeAddrReg == 32'h500) begin // @[ClHelloWorld.scala 165:50]
          helloWorldReg <= s_axi_wdata; // @[ClHelloWorld.scala 166:21]
        end
      end
    end
    if (reset) begin // @[ClHelloWorld.scala 176:32]
      shClStatusVDipQ <= 16'h0; // @[ClHelloWorld.scala 176:32]
    end else begin
      shClStatusVDipQ <= sh_cl_status_vdip; // @[ClHelloWorld.scala 176:32]
    end
    if (reset) begin // @[ClHelloWorld.scala 177:33]
      shClStatusVDipQ2 <= 16'h0; // @[ClHelloWorld.scala 177:33]
    end else begin
      shClStatusVDipQ2 <= shClStatusVDipQ; // @[ClHelloWorld.scala 177:33]
    end
    if (reset) begin // @[ClHelloWorld.scala 178:22]
      vLedQ <= 16'h0; // @[ClHelloWorld.scala 178:22]
    end else begin
      vLedQ <= helloWorldReg[15:0]; // @[ClHelloWorld.scala 178:22]
    end
    if (reset) begin // @[ClHelloWorld.scala 179:32]
      clSHStatusVLedQ <= 16'h0; // @[ClHelloWorld.scala 179:32]
    end else begin
      clSHStatusVLedQ <= _T_13; // @[ClHelloWorld.scala 179:32]
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
module cl_hello_world(
  input          clk_main_a0,
  input          clk_extra_a1,
  input          clk_extra_a2,
  input          clk_extra_a3,
  input          clk_extra_b0,
  input          clk_extra_b1,
  input          clk_extra_c0,
  input          clk_extra_c1,
  input          kernel_rst_n,
  input          rst_main_n,
  input          sh_cl_flr_assert,
  output         cl_sh_flr_done,
  output [31:0]  cl_sh_status0,
  output [31:0]  cl_sh_status1,
  output [31:0]  cl_sh_id0,
  output [31:0]  cl_sh_id1,
  input  [31:0]  sh_cl_ctl0,
  input  [31:0]  sh_cl_ctl1,
  input  [15:0]  sh_cl_status_vdip,
  output [15:0]  cl_sh_status_vled,
  input  [1:0]   sh_cl_pwr_state,
  output         cl_sh_dma_wr_full,
  output         cl_sh_dma_rd_full,
  output [15:0]  cl_sh_pcim_awid,
  output [63:0]  cl_sh_pcim_awaddr,
  output [7:0]   cl_sh_pcim_awlen,
  output [2:0]   cl_sh_pcim_awsize,
  output [17:0]  cl_sh_pcim_awuser,
  output         cl_sh_pcim_awvalid,
  input          sh_cl_pcim_awready,
  output [511:0] cl_sh_pcim_wdata,
  output [63:0]  cl_sh_pcim_wstrb,
  output         cl_sh_pcim_wlast,
  output         cl_sh_pcim_wvalid,
  input          sh_cl_pcim_wready,
  input  [15:0]  sh_cl_pcim_bid,
  input  [1:0]   sh_cl_pcim_bresp,
  input          sh_cl_pcim_bvalid,
  output         cl_sh_pcim_bready,
  output [15:0]  cl_sh_pcim_arid,
  output [63:0]  cl_sh_pcim_araddr,
  output [7:0]   cl_sh_pcim_arlen,
  output [2:0]   cl_sh_pcim_arsize,
  output [18:0]  cl_sh_pcim_aruser,
  output         cl_sh_pcim_arvalid,
  input          sh_cl_pcim_arready,
  input  [15:0]  sh_cl_pcim_rid,
  input  [511:0] sh_cl_pcim_rdata,
  input  [1:0]   sh_cl_pcim_rresp,
  input          sh_cl_pcim_rlast,
  input          sh_cl_pcim_rvalid,
  output         cl_sh_pcim_rready,
  input  [1:0]   cfg_max_payload,
  input  [2:0]   cfg_max_read_req,
  input          CLK_300M_DIMM0_DP,
  input          CLK_300M_DIMM0_DN,
  output         M_A_ACT_N,
  output [15:0]  M_A_MA,
  output [1:0]   M_A_BA,
  output [1:0]   M_A_BG,
  output         M_A_CKE,
  output         M_A_ODT,
  output         M_A_CS_N,
  output         M_A_CLK_DN,
  output         M_A_CLK_DP,
  output         M_A_PAR,
  inout  [63:0]  M_A_DQ,
  inout  [7:0]   M_A_ECC,
  inout  [17:0]  M_A_DQS_DP,
  inout  [17:0]  M_A_DQS_DN,
  output         cl_RST_DIMM_A_N,
  input          CLK_300M_DIMM1_DP,
  input          CLK_300M_DIMM1_DN,
  output         M_B_ACT_N,
  output [15:0]  M_B_MA,
  output [1:0]   M_B_BA,
  output [1:0]   M_B_BG,
  output         M_B_CKE,
  output         M_B_ODT,
  output         M_B_CS_N,
  output         M_B_CLK_DN,
  output         M_B_CLK_DP,
  output         M_B_PAR,
  inout  [63:0]  M_B_DQ,
  inout  [7:0]   M_B_ECC,
  inout  [17:0]  M_B_DQS_DP,
  inout  [17:0]  M_B_DQS_DN,
  output         cl_RST_DIMM_B_N,
  input          CLK_300M_DIMM3_DP,
  input          CLK_300M_DIMM3_DN,
  output         M_D_ACT_N,
  output [15:0]  M_D_MA,
  output [1:0]   M_D_BA,
  output [1:0]   M_D_BG,
  output         M_D_CKE,
  output         M_D_ODT,
  output         M_D_CS_N,
  output         M_D_CLK_DN,
  output         M_D_CLK_DP,
  output         M_D_PAR,
  inout  [63:0]  M_D_DQ,
  inout  [7:0]   M_D_ECC,
  inout  [17:0]  M_D_DQS_DP,
  inout  [17:0]  M_D_DQS_DN,
  output         cl_RST_DIMM_D_N,
  input  [7:0]   sh_ddr_stat_addr0,
  input          sh_ddr_stat_wr0,
  input          sh_ddr_stat_rd0,
  input  [31:0]  sh_ddr_stat_wdata0,
  output         ddr_sh_stat_ack0,
  output [31:0]  ddr_sh_stat_rdata0,
  output [7:0]   ddr_sh_stat_int0,
  input  [7:0]   sh_ddr_stat_addr1,
  input          sh_ddr_stat_wr1,
  input          sh_ddr_stat_rd1,
  input  [31:0]  sh_ddr_stat_wdata1,
  output         ddr_sh_stat_ack1,
  output [31:0]  ddr_sh_stat_rdata1,
  output [7:0]   ddr_sh_stat_int1,
  input  [7:0]   sh_ddr_stat_addr2,
  input          sh_ddr_stat_wr2,
  input          sh_ddr_stat_rd2,
  input  [31:0]  sh_ddr_stat_wdata2,
  output         ddr_sh_stat_ack2,
  output [31:0]  ddr_sh_stat_rdata2,
  output [7:0]   ddr_sh_stat_int2,
  output [15:0]  cl_sh_ddr_awid,
  output [63:0]  cl_sh_ddr_awaddr,
  output [7:0]   cl_sh_ddr_awlen,
  output [2:0]   cl_sh_ddr_awsize,
  output [1:0]   cl_sh_ddr_awburst,
  output         cl_sh_ddr_awvalid,
  input          sh_cl_ddr_awready,
  output [15:0]  cl_sh_ddr_wid,
  output [511:0] cl_sh_ddr_wdata,
  output [63:0]  cl_sh_ddr_wstrb,
  output         cl_sh_ddr_wlast,
  output         cl_sh_ddr_wvalid,
  input          sh_cl_ddr_wready,
  input  [15:0]  sh_cl_ddr_bid,
  input  [1:0]   sh_cl_ddr_bresp,
  input          sh_cl_ddr_bvalid,
  output         cl_sh_ddr_bready,
  output [15:0]  cl_sh_ddr_arid,
  output [63:0]  cl_sh_ddr_araddr,
  output [7:0]   cl_sh_ddr_arlen,
  output [2:0]   cl_sh_ddr_arsize,
  output [1:0]   cl_sh_ddr_arburst,
  output         cl_sh_ddr_arvalid,
  input          sh_cl_ddr_arready,
  input  [15:0]  sh_cl_ddr_rid,
  input  [511:0] sh_cl_ddr_rdata,
  input  [1:0]   sh_cl_ddr_rresp,
  input          sh_cl_ddr_rlast,
  input          sh_cl_ddr_rvalid,
  output         cl_sh_ddr_rready,
  input          sh_cl_ddr_is_ready,
  output [15:0]  cl_sh_apppf_irq_req,
  input  [15:0]  sh_cl_apppf_irq_ack,
  input  [5:0]   sh_cl_dma_pcis_awid,
  input  [63:0]  sh_cl_dma_pcis_awaddr,
  input  [7:0]   sh_cl_dma_pcis_awlen,
  input  [2:0]   sh_cl_dma_pcis_awsize,
  input          sh_cl_dma_pcis_awvalid,
  output         cl_sh_dma_pcis_awready,
  input  [511:0] sh_cl_dma_pcis_wdata,
  input  [63:0]  sh_cl_dma_pcis_wstrb,
  input          sh_cl_dma_pcis_wlast,
  input          sh_cl_dma_pcis_wvalid,
  output         cl_sh_dma_pcis_wready,
  output [5:0]   cl_sh_dma_pcis_bid,
  output [1:0]   cl_sh_dma_pcis_bresp,
  output         cl_sh_dma_pcis_bvalid,
  input          sh_cl_dma_pcis_bready,
  input  [5:0]   sh_cl_dma_pcis_arid,
  input  [63:0]  sh_cl_dma_pcis_araddr,
  input  [7:0]   sh_cl_dma_pcis_arlen,
  input  [2:0]   sh_cl_dma_pcis_arsize,
  input          sh_cl_dma_pcis_arvalid,
  output         cl_sh_dma_pcis_arready,
  output [5:0]   cl_sh_dma_pcis_rid,
  output [510:0] cl_sh_dma_pcis_rdata,
  output [1:0]   cl_sh_dma_pcis_rresp,
  output         cl_sh_dma_pcis_rlast,
  output         cl_sh_dma_pcis_rvalid,
  input          sh_cl_dma_pcis_rready,
  input          sda_cl_awvalid,
  input  [31:0]  sda_cl_awaddr,
  output         cl_sda_awready,
  input          sda_cl_wvalid,
  input  [31:0]  sda_cl_wdata,
  input  [3:0]   sda_cl_wstrb,
  output         cl_sda_wready,
  output         cl_sda_bvalid,
  output [1:0]   cl_sda_bresp,
  input          sda_cl_bready,
  input          sda_cl_arvalid,
  input  [31:0]  sda_cl_araddr,
  output         cl_sda_arready,
  output         cl_sda_rvalid,
  output [31:0]  cl_sda_rdata,
  output [1:0]   cl_sda_rresp,
  input          sda_cl_rready,
  input          sh_ocl_awvalid,
  input  [31:0]  sh_ocl_awaddr,
  output         ocl_sh_awready,
  input          sh_ocl_wvalid,
  input  [31:0]  sh_ocl_wdata,
  input  [3:0]   sh_ocl_wstrb,
  output         ocl_sh_wready,
  output         ocl_sh_bvalid,
  output [1:0]   ocl_sh_bresp,
  input          sh_ocl_bready,
  input          sh_ocl_arvalid,
  input  [31:0]  sh_ocl_araddr,
  output         ocl_sh_arready,
  output         ocl_sh_rvalid,
  output [31:0]  ocl_sh_rdata,
  output [1:0]   ocl_sh_rresp,
  input          sh_ocl_rready,
  input          sh_bar1_awvalid,
  input  [31:0]  sh_bar1_awaddr,
  output         bar1_sh_awready,
  input          sh_bar1_wvalid,
  input  [31:0]  sh_bar1_wdata,
  input  [2:0]   sh_bar1_wstrb,
  output         bar1_sh_wready,
  output         bar1_sh_bvalid,
  output [1:0]   bar1_sh_bresp,
  input          sh_bar1_bready,
  input          sh_bar1_arvalid,
  input  [31:0]  sh_bar1_araddr,
  output         bar1_sh_arready,
  output         bar1_sh_rvalid,
  output [31:0]  bar1_sh_rdata,
  output [1:0]   bar1_sh_rresp,
  input          sh_bar1_rready,
  input          drck,
  input          shift,
  input          tdi,
  input          update,
  input          sel,
  output         tdo,
  input          tms,
  input          tck,
  input          runtest,
  input          reset,
  input          capture,
  input          bscanid_en,
  input  [63:0]  sh_cl_glcount0,
  input  [63:0]  sh_cl_glcount1
);
  wire  resetSyncNegModule_clock; // @[AwsEc2F1Cl.scala 264:34]
  wire  resetSyncNegModule_reset_n; // @[AwsEc2F1Cl.scala 264:34]
  wire  resetSyncNegModule_reset_sync_n; // @[AwsEc2F1Cl.scala 264:34]
  wire  TieOffDdrABDBlackBox_clk_main_a0; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_rst_main_n_sync; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM0_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM0_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_ACT_N; // @[AwsEc2F1Cl.scala 580:38]
  wire [16:0] TieOffDdrABDBlackBox_M_A_MA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_A_BA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_A_BG; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_CKE; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_ODT; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_CS_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_CLK_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_CLK_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_A_PAR; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_cl_RST_DIMM_A_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM1_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM1_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_ACT_N; // @[AwsEc2F1Cl.scala 580:38]
  wire [16:0] TieOffDdrABDBlackBox_M_B_MA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_B_BA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_B_BG; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_CKE; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_ODT; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_CS_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_CLK_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_CLK_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_B_PAR; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_cl_RST_DIMM_B_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM3_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_CLK_300M_DIMM3_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_ACT_N; // @[AwsEc2F1Cl.scala 580:38]
  wire [16:0] TieOffDdrABDBlackBox_M_D_MA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_D_BA; // @[AwsEc2F1Cl.scala 580:38]
  wire [1:0] TieOffDdrABDBlackBox_M_D_BG; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_CKE; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_ODT; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_CS_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_CLK_DN; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_CLK_DP; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_M_D_PAR; // @[AwsEc2F1Cl.scala 580:38]
  wire  TieOffDdrABDBlackBox_cl_RST_DIMM_D_N; // @[AwsEc2F1Cl.scala 580:38]
  wire  axiRegisterSliceModule_aclk; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_aresetn; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_s_axi_awaddr; // @[ClHelloWorld.scala 31:38]
  wire [2:0] axiRegisterSliceModule_s_axi_awprot; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_awvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_awready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_s_axi_wdata; // @[ClHelloWorld.scala 31:38]
  wire [3:0] axiRegisterSliceModule_s_axi_wstrb; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_wvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_wready; // @[ClHelloWorld.scala 31:38]
  wire [1:0] axiRegisterSliceModule_s_axi_bresp; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_bvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_bready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_s_axi_araddr; // @[ClHelloWorld.scala 31:38]
  wire [2:0] axiRegisterSliceModule_s_axi_arprot; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_arvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_arready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_s_axi_rdata; // @[ClHelloWorld.scala 31:38]
  wire [1:0] axiRegisterSliceModule_s_axi_rresp; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_rvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_s_axi_rready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_m_axi_awaddr; // @[ClHelloWorld.scala 31:38]
  wire [2:0] axiRegisterSliceModule_m_axi_awprot; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_awvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_awready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_m_axi_wdata; // @[ClHelloWorld.scala 31:38]
  wire [3:0] axiRegisterSliceModule_m_axi_wstrb; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_wvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_wready; // @[ClHelloWorld.scala 31:38]
  wire [1:0] axiRegisterSliceModule_m_axi_bresp; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_bvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_bready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_m_axi_araddr; // @[ClHelloWorld.scala 31:38]
  wire [2:0] axiRegisterSliceModule_m_axi_arprot; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_arvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_arready; // @[ClHelloWorld.scala 31:38]
  wire [31:0] axiRegisterSliceModule_m_axi_rdata; // @[ClHelloWorld.scala 31:38]
  wire [1:0] axiRegisterSliceModule_m_axi_rresp; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_rvalid; // @[ClHelloWorld.scala 31:38]
  wire  axiRegisterSliceModule_m_axi_rready; // @[ClHelloWorld.scala 31:38]
  wire  ClHelloWorldCore_clock; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_reset; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_awvalid; // @[ClHelloWorld.scala 58:40]
  wire [31:0] ClHelloWorldCore_s_axi_awaddr; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_wvalid; // @[ClHelloWorld.scala 58:40]
  wire [31:0] ClHelloWorldCore_s_axi_wdata; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_bready; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_arvalid; // @[ClHelloWorld.scala 58:40]
  wire [31:0] ClHelloWorldCore_s_axi_araddr; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_rready; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_awready; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_wready; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_bvalid; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_arready; // @[ClHelloWorld.scala 58:40]
  wire  ClHelloWorldCore_s_axi_rvalid; // @[ClHelloWorld.scala 58:40]
  wire [31:0] ClHelloWorldCore_s_axi_rdata; // @[ClHelloWorld.scala 58:40]
  wire [15:0] ClHelloWorldCore_sh_cl_status_vdip; // @[ClHelloWorld.scala 58:40]
  wire [15:0] ClHelloWorldCore_cl_sh_status_vled; // @[ClHelloWorld.scala 58:40]
  ResetSyncNeg resetSyncNegModule ( // @[AwsEc2F1Cl.scala 264:34]
    .clock(resetSyncNegModule_clock),
    .reset_n(resetSyncNegModule_reset_n),
    .reset_sync_n(resetSyncNegModule_reset_sync_n)
  );
  TieOffDdrABDBlackBox TieOffDdrABDBlackBox ( // @[AwsEc2F1Cl.scala 580:38]
    .clk_main_a0(TieOffDdrABDBlackBox_clk_main_a0),
    .rst_main_n_sync(TieOffDdrABDBlackBox_rst_main_n_sync),
    .CLK_300M_DIMM0_DP(TieOffDdrABDBlackBox_CLK_300M_DIMM0_DP),
    .CLK_300M_DIMM0_DN(TieOffDdrABDBlackBox_CLK_300M_DIMM0_DN),
    .M_A_ACT_N(TieOffDdrABDBlackBox_M_A_ACT_N),
    .M_A_MA(TieOffDdrABDBlackBox_M_A_MA),
    .M_A_BA(TieOffDdrABDBlackBox_M_A_BA),
    .M_A_BG(TieOffDdrABDBlackBox_M_A_BG),
    .M_A_CKE(TieOffDdrABDBlackBox_M_A_CKE),
    .M_A_ODT(TieOffDdrABDBlackBox_M_A_ODT),
    .M_A_CS_N(TieOffDdrABDBlackBox_M_A_CS_N),
    .M_A_CLK_DN(TieOffDdrABDBlackBox_M_A_CLK_DN),
    .M_A_CLK_DP(TieOffDdrABDBlackBox_M_A_CLK_DP),
    .M_A_PAR(TieOffDdrABDBlackBox_M_A_PAR),
    .M_A_DQ(M_A_DQ),
    .M_A_ECC(M_A_ECC),
    .M_A_DQS_DP(M_A_DQS_DP),
    .M_A_DQS_DN(M_A_DQS_DN),
    .cl_RST_DIMM_A_N(TieOffDdrABDBlackBox_cl_RST_DIMM_A_N),
    .CLK_300M_DIMM1_DP(TieOffDdrABDBlackBox_CLK_300M_DIMM1_DP),
    .CLK_300M_DIMM1_DN(TieOffDdrABDBlackBox_CLK_300M_DIMM1_DN),
    .M_B_ACT_N(TieOffDdrABDBlackBox_M_B_ACT_N),
    .M_B_MA(TieOffDdrABDBlackBox_M_B_MA),
    .M_B_BA(TieOffDdrABDBlackBox_M_B_BA),
    .M_B_BG(TieOffDdrABDBlackBox_M_B_BG),
    .M_B_CKE(TieOffDdrABDBlackBox_M_B_CKE),
    .M_B_ODT(TieOffDdrABDBlackBox_M_B_ODT),
    .M_B_CS_N(TieOffDdrABDBlackBox_M_B_CS_N),
    .M_B_CLK_DN(TieOffDdrABDBlackBox_M_B_CLK_DN),
    .M_B_CLK_DP(TieOffDdrABDBlackBox_M_B_CLK_DP),
    .M_B_PAR(TieOffDdrABDBlackBox_M_B_PAR),
    .M_B_DQ(M_B_DQ),
    .M_B_ECC(M_B_ECC),
    .M_B_DQS_DP(M_B_DQS_DP),
    .M_B_DQS_DN(M_B_DQS_DN),
    .cl_RST_DIMM_B_N(TieOffDdrABDBlackBox_cl_RST_DIMM_B_N),
    .CLK_300M_DIMM3_DP(TieOffDdrABDBlackBox_CLK_300M_DIMM3_DP),
    .CLK_300M_DIMM3_DN(TieOffDdrABDBlackBox_CLK_300M_DIMM3_DN),
    .M_D_ACT_N(TieOffDdrABDBlackBox_M_D_ACT_N),
    .M_D_MA(TieOffDdrABDBlackBox_M_D_MA),
    .M_D_BA(TieOffDdrABDBlackBox_M_D_BA),
    .M_D_BG(TieOffDdrABDBlackBox_M_D_BG),
    .M_D_CKE(TieOffDdrABDBlackBox_M_D_CKE),
    .M_D_ODT(TieOffDdrABDBlackBox_M_D_ODT),
    .M_D_CS_N(TieOffDdrABDBlackBox_M_D_CS_N),
    .M_D_CLK_DN(TieOffDdrABDBlackBox_M_D_CLK_DN),
    .M_D_CLK_DP(TieOffDdrABDBlackBox_M_D_CLK_DP),
    .M_D_PAR(TieOffDdrABDBlackBox_M_D_PAR),
    .M_D_DQ(M_D_DQ),
    .M_D_ECC(M_D_ECC),
    .M_D_DQS_DP(M_D_DQS_DP),
    .M_D_DQS_DN(M_D_DQS_DN),
    .cl_RST_DIMM_D_N(TieOffDdrABDBlackBox_cl_RST_DIMM_D_N)
  );
  axi_register_slice_light axiRegisterSliceModule ( // @[ClHelloWorld.scala 31:38]
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
  ClHelloWorldCore ClHelloWorldCore ( // @[ClHelloWorld.scala 58:40]
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
  assign cl_sh_flr_done = 1'h0; // @[AwsEc2F1Cl.scala 704:20]
  assign cl_sh_status0 = 32'h0; // @[ClHelloWorld.scala 82:17]
  assign cl_sh_status1 = 32'h0; // @[ClHelloWorld.scala 83:17]
  assign cl_sh_id0 = 32'hf0001d0f; // @[ClHelloWorld.scala 54:13]
  assign cl_sh_id1 = 32'h1d51fedd; // @[ClHelloWorld.scala 55:13]
  assign cl_sh_status_vled = ClHelloWorldCore_cl_sh_status_vled; // @[ClHelloWorld.scala 78:46]
  assign cl_sh_dma_wr_full = 1'h0; // @[AwsEc2F1Cl.scala 695:23]
  assign cl_sh_dma_rd_full = 1'h0; // @[AwsEc2F1Cl.scala 696:23]
  assign cl_sh_pcim_awid = 16'h0; // @[AwsEc2F1Cl.scala 715:21]
  assign cl_sh_pcim_awaddr = 64'h0; // @[AwsEc2F1Cl.scala 716:23]
  assign cl_sh_pcim_awlen = 8'h0; // @[AwsEc2F1Cl.scala 717:22]
  assign cl_sh_pcim_awsize = 3'h0; // @[AwsEc2F1Cl.scala 718:23]
  assign cl_sh_pcim_awuser = 18'h0; // @[AwsEc2F1Cl.scala 719:23]
  assign cl_sh_pcim_awvalid = 1'h0; // @[AwsEc2F1Cl.scala 720:24]
  assign cl_sh_pcim_wdata = 512'h0; // @[AwsEc2F1Cl.scala 721:22]
  assign cl_sh_pcim_wstrb = 64'h0; // @[AwsEc2F1Cl.scala 722:22]
  assign cl_sh_pcim_wlast = 1'h0; // @[AwsEc2F1Cl.scala 723:22]
  assign cl_sh_pcim_wvalid = 1'h0; // @[AwsEc2F1Cl.scala 724:23]
  assign cl_sh_pcim_bready = 1'h0; // @[AwsEc2F1Cl.scala 725:23]
  assign cl_sh_pcim_arid = 16'h0; // @[AwsEc2F1Cl.scala 726:21]
  assign cl_sh_pcim_araddr = 64'h0; // @[AwsEc2F1Cl.scala 727:23]
  assign cl_sh_pcim_arlen = 8'h0; // @[AwsEc2F1Cl.scala 728:22]
  assign cl_sh_pcim_arsize = 3'h0; // @[AwsEc2F1Cl.scala 729:23]
  assign cl_sh_pcim_aruser = 19'h0; // @[AwsEc2F1Cl.scala 730:23]
  assign cl_sh_pcim_arvalid = 1'h0; // @[AwsEc2F1Cl.scala 731:24]
  assign cl_sh_pcim_rready = 1'h0; // @[AwsEc2F1Cl.scala 732:23]
  assign M_A_ACT_N = TieOffDdrABDBlackBox_M_A_ACT_N; // @[AwsEc2F1Cl.scala 586:24]
  assign M_A_MA = TieOffDdrABDBlackBox_M_A_MA[15:0]; // @[AwsEc2F1Cl.scala 587:21]
  assign M_A_BA = TieOffDdrABDBlackBox_M_A_BA; // @[AwsEc2F1Cl.scala 588:21]
  assign M_A_BG = TieOffDdrABDBlackBox_M_A_BG; // @[AwsEc2F1Cl.scala 589:21]
  assign M_A_CKE = TieOffDdrABDBlackBox_M_A_CKE; // @[AwsEc2F1Cl.scala 590:22]
  assign M_A_ODT = TieOffDdrABDBlackBox_M_A_ODT; // @[AwsEc2F1Cl.scala 591:22]
  assign M_A_CS_N = TieOffDdrABDBlackBox_M_A_CS_N; // @[AwsEc2F1Cl.scala 592:23]
  assign M_A_CLK_DN = TieOffDdrABDBlackBox_M_A_CLK_DN; // @[AwsEc2F1Cl.scala 593:25]
  assign M_A_CLK_DP = TieOffDdrABDBlackBox_M_A_CLK_DP; // @[AwsEc2F1Cl.scala 594:25]
  assign M_A_PAR = TieOffDdrABDBlackBox_M_A_PAR; // @[AwsEc2F1Cl.scala 595:22]
  assign cl_RST_DIMM_A_N = TieOffDdrABDBlackBox_cl_RST_DIMM_A_N; // @[AwsEc2F1Cl.scala 600:30]
  assign M_B_ACT_N = TieOffDdrABDBlackBox_M_B_ACT_N; // @[AwsEc2F1Cl.scala 603:24]
  assign M_B_MA = TieOffDdrABDBlackBox_M_B_MA[15:0]; // @[AwsEc2F1Cl.scala 604:21]
  assign M_B_BA = TieOffDdrABDBlackBox_M_B_BA; // @[AwsEc2F1Cl.scala 605:21]
  assign M_B_BG = TieOffDdrABDBlackBox_M_B_BG; // @[AwsEc2F1Cl.scala 606:21]
  assign M_B_CKE = TieOffDdrABDBlackBox_M_B_CKE; // @[AwsEc2F1Cl.scala 607:22]
  assign M_B_ODT = TieOffDdrABDBlackBox_M_B_ODT; // @[AwsEc2F1Cl.scala 608:22]
  assign M_B_CS_N = TieOffDdrABDBlackBox_M_B_CS_N; // @[AwsEc2F1Cl.scala 609:23]
  assign M_B_CLK_DN = TieOffDdrABDBlackBox_M_B_CLK_DN; // @[AwsEc2F1Cl.scala 610:25]
  assign M_B_CLK_DP = TieOffDdrABDBlackBox_M_B_CLK_DP; // @[AwsEc2F1Cl.scala 611:25]
  assign M_B_PAR = TieOffDdrABDBlackBox_M_B_PAR; // @[AwsEc2F1Cl.scala 612:22]
  assign cl_RST_DIMM_B_N = TieOffDdrABDBlackBox_cl_RST_DIMM_B_N; // @[AwsEc2F1Cl.scala 617:30]
  assign M_D_ACT_N = TieOffDdrABDBlackBox_M_D_ACT_N; // @[AwsEc2F1Cl.scala 620:24]
  assign M_D_MA = TieOffDdrABDBlackBox_M_D_MA[15:0]; // @[AwsEc2F1Cl.scala 621:21]
  assign M_D_BA = TieOffDdrABDBlackBox_M_D_BA; // @[AwsEc2F1Cl.scala 622:21]
  assign M_D_BG = TieOffDdrABDBlackBox_M_D_BG; // @[AwsEc2F1Cl.scala 623:21]
  assign M_D_CKE = TieOffDdrABDBlackBox_M_D_CKE; // @[AwsEc2F1Cl.scala 624:22]
  assign M_D_ODT = TieOffDdrABDBlackBox_M_D_ODT; // @[AwsEc2F1Cl.scala 625:22]
  assign M_D_CS_N = TieOffDdrABDBlackBox_M_D_CS_N; // @[AwsEc2F1Cl.scala 626:23]
  assign M_D_CLK_DN = TieOffDdrABDBlackBox_M_D_CLK_DN; // @[AwsEc2F1Cl.scala 627:25]
  assign M_D_CLK_DP = TieOffDdrABDBlackBox_M_D_CLK_DP; // @[AwsEc2F1Cl.scala 628:25]
  assign M_D_PAR = TieOffDdrABDBlackBox_M_D_PAR; // @[AwsEc2F1Cl.scala 629:22]
  assign cl_RST_DIMM_D_N = TieOffDdrABDBlackBox_cl_RST_DIMM_D_N; // @[AwsEc2F1Cl.scala 634:30]
  assign ddr_sh_stat_ack0 = 1'h1; // @[AwsEc2F1Cl.scala 636:22]
  assign ddr_sh_stat_rdata0 = 32'h0; // @[AwsEc2F1Cl.scala 637:24]
  assign ddr_sh_stat_int0 = 8'h0; // @[AwsEc2F1Cl.scala 638:22]
  assign ddr_sh_stat_ack1 = 1'h1; // @[AwsEc2F1Cl.scala 639:22]
  assign ddr_sh_stat_rdata1 = 32'h0; // @[AwsEc2F1Cl.scala 640:24]
  assign ddr_sh_stat_int1 = 8'h0; // @[AwsEc2F1Cl.scala 641:22]
  assign ddr_sh_stat_ack2 = 1'h1; // @[AwsEc2F1Cl.scala 642:22]
  assign ddr_sh_stat_rdata2 = 32'h0; // @[AwsEc2F1Cl.scala 643:24]
  assign ddr_sh_stat_int2 = 8'h0; // @[AwsEc2F1Cl.scala 644:22]
  assign cl_sh_ddr_awid = 16'h0; // @[AwsEc2F1Cl.scala 655:20]
  assign cl_sh_ddr_awaddr = 64'h0; // @[AwsEc2F1Cl.scala 656:22]
  assign cl_sh_ddr_awlen = 8'h0; // @[AwsEc2F1Cl.scala 657:21]
  assign cl_sh_ddr_awsize = 3'h0; // @[AwsEc2F1Cl.scala 658:22]
  assign cl_sh_ddr_awburst = 2'h0; // @[AwsEc2F1Cl.scala 660:23]
  assign cl_sh_ddr_awvalid = 1'h0; // @[AwsEc2F1Cl.scala 659:23]
  assign cl_sh_ddr_wid = 16'h0; // @[AwsEc2F1Cl.scala 661:19]
  assign cl_sh_ddr_wdata = 512'h0; // @[AwsEc2F1Cl.scala 662:21]
  assign cl_sh_ddr_wstrb = 64'h0; // @[AwsEc2F1Cl.scala 663:21]
  assign cl_sh_ddr_wlast = 1'h0; // @[AwsEc2F1Cl.scala 664:21]
  assign cl_sh_ddr_wvalid = 1'h0; // @[AwsEc2F1Cl.scala 665:22]
  assign cl_sh_ddr_bready = 1'h0; // @[AwsEc2F1Cl.scala 666:22]
  assign cl_sh_ddr_arid = 16'h0; // @[AwsEc2F1Cl.scala 667:20]
  assign cl_sh_ddr_araddr = 64'h0; // @[AwsEc2F1Cl.scala 668:22]
  assign cl_sh_ddr_arlen = 8'h0; // @[AwsEc2F1Cl.scala 669:21]
  assign cl_sh_ddr_arsize = 3'h0; // @[AwsEc2F1Cl.scala 670:22]
  assign cl_sh_ddr_arburst = 2'h0; // @[AwsEc2F1Cl.scala 672:23]
  assign cl_sh_ddr_arvalid = 1'h0; // @[AwsEc2F1Cl.scala 671:23]
  assign cl_sh_ddr_rready = 1'h0; // @[AwsEc2F1Cl.scala 673:22]
  assign cl_sh_apppf_irq_req = 16'h0; // @[AwsEc2F1Cl.scala 290:25]
  assign cl_sh_dma_pcis_awready = 1'h0; // @[AwsEc2F1Cl.scala 684:28]
  assign cl_sh_dma_pcis_wready = 1'h0; // @[AwsEc2F1Cl.scala 685:27]
  assign cl_sh_dma_pcis_bid = 6'h0; // @[AwsEc2F1Cl.scala 686:24]
  assign cl_sh_dma_pcis_bresp = 2'h0; // @[AwsEc2F1Cl.scala 687:26]
  assign cl_sh_dma_pcis_bvalid = 1'h0; // @[AwsEc2F1Cl.scala 688:27]
  assign cl_sh_dma_pcis_arready = 1'h0; // @[AwsEc2F1Cl.scala 689:28]
  assign cl_sh_dma_pcis_rid = 6'h0; // @[AwsEc2F1Cl.scala 690:24]
  assign cl_sh_dma_pcis_rdata = 511'h0; // @[AwsEc2F1Cl.scala 691:26]
  assign cl_sh_dma_pcis_rresp = 2'h0; // @[AwsEc2F1Cl.scala 692:26]
  assign cl_sh_dma_pcis_rlast = 1'h0; // @[AwsEc2F1Cl.scala 693:26]
  assign cl_sh_dma_pcis_rvalid = 1'h0; // @[AwsEc2F1Cl.scala 694:27]
  assign cl_sda_awready = 1'h0; // @[AwsEc2F1Cl.scala 301:20]
  assign cl_sda_wready = 1'h0; // @[AwsEc2F1Cl.scala 302:19]
  assign cl_sda_bvalid = 1'h0; // @[AwsEc2F1Cl.scala 303:19]
  assign cl_sda_bresp = 2'h0; // @[AwsEc2F1Cl.scala 304:18]
  assign cl_sda_arready = 1'h0; // @[AwsEc2F1Cl.scala 305:20]
  assign cl_sda_rvalid = 1'h0; // @[AwsEc2F1Cl.scala 306:19]
  assign cl_sda_rdata = 32'h0; // @[AwsEc2F1Cl.scala 307:18]
  assign cl_sda_rresp = 2'h0; // @[AwsEc2F1Cl.scala 308:18]
  assign ocl_sh_awready = axiRegisterSliceModule_s_axi_awready; // @[ClHelloWorld.scala 37:40]
  assign ocl_sh_wready = axiRegisterSliceModule_s_axi_wready; // @[ClHelloWorld.scala 41:39]
  assign ocl_sh_bvalid = axiRegisterSliceModule_s_axi_bvalid; // @[ClHelloWorld.scala 43:39]
  assign ocl_sh_bresp = axiRegisterSliceModule_s_axi_bresp; // @[ClHelloWorld.scala 42:38]
  assign ocl_sh_arready = axiRegisterSliceModule_s_axi_arready; // @[ClHelloWorld.scala 47:40]
  assign ocl_sh_rvalid = axiRegisterSliceModule_s_axi_rvalid; // @[ClHelloWorld.scala 50:39]
  assign ocl_sh_rdata = axiRegisterSliceModule_s_axi_rdata; // @[ClHelloWorld.scala 48:38]
  assign ocl_sh_rresp = axiRegisterSliceModule_s_axi_rresp; // @[ClHelloWorld.scala 49:38]
  assign bar1_sh_awready = 1'h0; // @[AwsEc2F1Cl.scala 743:21]
  assign bar1_sh_wready = 1'h0; // @[AwsEc2F1Cl.scala 744:20]
  assign bar1_sh_bvalid = 1'h0; // @[AwsEc2F1Cl.scala 745:20]
  assign bar1_sh_bresp = 2'h0; // @[AwsEc2F1Cl.scala 746:19]
  assign bar1_sh_arready = 1'h0; // @[AwsEc2F1Cl.scala 747:21]
  assign bar1_sh_rvalid = 1'h0; // @[AwsEc2F1Cl.scala 748:20]
  assign bar1_sh_rdata = 32'h0; // @[AwsEc2F1Cl.scala 749:19]
  assign bar1_sh_rresp = 2'h0; // @[AwsEc2F1Cl.scala 750:19]
  assign tdo = 1'h0; // @[ClHelloWorld.scala 85:7]
  assign resetSyncNegModule_clock = clk_main_a0; // @[AwsEc2F1Cl.scala 266:24]
  assign resetSyncNegModule_reset_n = rst_main_n; // @[AwsEc2F1Cl.scala 267:26]
  assign TieOffDdrABDBlackBox_clk_main_a0 = clk_main_a0; // @[AwsEc2F1Cl.scala 582:26]
  assign TieOffDdrABDBlackBox_rst_main_n_sync = resetSyncNegModule_reset_sync_n; // @[AwsEc2F1Cl.scala 583:30]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM0_DP = CLK_300M_DIMM0_DP; // @[AwsEc2F1Cl.scala 584:32]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM0_DN = CLK_300M_DIMM0_DN; // @[AwsEc2F1Cl.scala 585:32]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM1_DP = CLK_300M_DIMM1_DP; // @[AwsEc2F1Cl.scala 601:32]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM1_DN = CLK_300M_DIMM1_DN; // @[AwsEc2F1Cl.scala 602:32]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM3_DP = CLK_300M_DIMM3_DP; // @[AwsEc2F1Cl.scala 618:32]
  assign TieOffDdrABDBlackBox_CLK_300M_DIMM3_DN = CLK_300M_DIMM3_DN; // @[AwsEc2F1Cl.scala 619:32]
  assign axiRegisterSliceModule_aclk = clk_main_a0; // @[ClHelloWorld.scala 32:52]
  assign axiRegisterSliceModule_aresetn = resetSyncNegModule_reset_sync_n; // @[ClHelloWorld.scala 33:34]
  assign axiRegisterSliceModule_s_axi_awaddr = sh_ocl_awaddr; // @[ClHelloWorld.scala 34:39]
  assign axiRegisterSliceModule_s_axi_awprot = 3'h0; // @[ClHelloWorld.scala 35:39]
  assign axiRegisterSliceModule_s_axi_awvalid = sh_ocl_awvalid; // @[ClHelloWorld.scala 36:40]
  assign axiRegisterSliceModule_s_axi_wdata = sh_ocl_wdata; // @[ClHelloWorld.scala 38:38]
  assign axiRegisterSliceModule_s_axi_wstrb = sh_ocl_wstrb; // @[ClHelloWorld.scala 39:38]
  assign axiRegisterSliceModule_s_axi_wvalid = sh_ocl_wvalid; // @[ClHelloWorld.scala 40:39]
  assign axiRegisterSliceModule_s_axi_bready = sh_ocl_bready; // @[ClHelloWorld.scala 44:39]
  assign axiRegisterSliceModule_s_axi_araddr = sh_ocl_araddr; // @[ClHelloWorld.scala 45:39]
  assign axiRegisterSliceModule_s_axi_arprot = 3'h0;
  assign axiRegisterSliceModule_s_axi_arvalid = sh_ocl_arvalid; // @[ClHelloWorld.scala 46:40]
  assign axiRegisterSliceModule_s_axi_rready = sh_ocl_rready; // @[ClHelloWorld.scala 51:39]
  assign axiRegisterSliceModule_m_axi_awready = ClHelloWorldCore_s_axi_awready; // @[ClHelloWorld.scala 68:42]
  assign axiRegisterSliceModule_m_axi_wready = ClHelloWorldCore_s_axi_wready; // @[ClHelloWorld.scala 69:41]
  assign axiRegisterSliceModule_m_axi_bresp = 2'h0; // @[ClHelloWorld.scala 71:40]
  assign axiRegisterSliceModule_m_axi_bvalid = ClHelloWorldCore_s_axi_bvalid; // @[ClHelloWorld.scala 70:41]
  assign axiRegisterSliceModule_m_axi_arready = ClHelloWorldCore_s_axi_arready; // @[ClHelloWorld.scala 72:42]
  assign axiRegisterSliceModule_m_axi_rdata = ClHelloWorldCore_s_axi_rdata; // @[ClHelloWorld.scala 74:40]
  assign axiRegisterSliceModule_m_axi_rresp = 2'h0; // @[ClHelloWorld.scala 75:40]
  assign axiRegisterSliceModule_m_axi_rvalid = ClHelloWorldCore_s_axi_rvalid; // @[ClHelloWorld.scala 73:41]
  assign ClHelloWorldCore_clock = clk_main_a0; // @[ClHelloWorld.scala 57:40]
  assign ClHelloWorldCore_reset = ~resetSyncNegModule_reset_sync_n; // @[ClHelloWorld.scala 57:44]
  assign ClHelloWorldCore_s_axi_awvalid = axiRegisterSliceModule_m_axi_awvalid; // @[ClHelloWorld.scala 59:42]
  assign ClHelloWorldCore_s_axi_awaddr = axiRegisterSliceModule_m_axi_awaddr; // @[ClHelloWorld.scala 60:41]
  assign ClHelloWorldCore_s_axi_wvalid = axiRegisterSliceModule_m_axi_wvalid; // @[ClHelloWorld.scala 61:41]
  assign ClHelloWorldCore_s_axi_wdata = axiRegisterSliceModule_m_axi_wdata; // @[ClHelloWorld.scala 62:40]
  assign ClHelloWorldCore_s_axi_bready = axiRegisterSliceModule_m_axi_bready; // @[ClHelloWorld.scala 64:41]
  assign ClHelloWorldCore_s_axi_arvalid = axiRegisterSliceModule_m_axi_arvalid; // @[ClHelloWorld.scala 65:42]
  assign ClHelloWorldCore_s_axi_araddr = axiRegisterSliceModule_m_axi_araddr; // @[ClHelloWorld.scala 66:41]
  assign ClHelloWorldCore_s_axi_rready = axiRegisterSliceModule_m_axi_rready; // @[ClHelloWorld.scala 67:41]
  assign ClHelloWorldCore_sh_cl_status_vdip = sh_cl_status_vdip; // @[ClHelloWorld.scala 77:46]
endmodule
