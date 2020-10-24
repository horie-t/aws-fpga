
module TieOffDdrABDBlackBox
  (
   input         clk_main_a0,
   input         rst_main_n_sync,
   input         CLK_300M_DIMM0_DP,
   input         CLK_300M_DIMM0_DN,
   output        M_A_ACT_N,
   output [16:0] M_A_MA,
   output [1:0]  M_A_BA,
   output [1:0]  M_A_BG,
   output [0:0]  M_A_CKE,
   output [0:0]  M_A_ODT,
   output [0:0]  M_A_CS_N,
   output [0:0]  M_A_CLK_DN,
   output [0:0]  M_A_CLK_DP,
   output        M_A_PAR,
   inout [63:0]  M_A_DQ,
   inout [7:0]   M_A_ECC,
   inout [17:0]  M_A_DQS_DP,
   inout [17:0]  M_A_DQS_DN,
   output        cl_RST_DIMM_A_N,
   input         CLK_300M_DIMM1_DP,
   input         CLK_300M_DIMM1_DN,
   output        M_B_ACT_N,
   output [16:0] M_B_MA,
   output [1:0]  M_B_BA,
   output [1:0]  M_B_BG,
   output [0:0]  M_B_CKE,
   output [0:0]  M_B_ODT,
   output [0:0]  M_B_CS_N,
   output [0:0]  M_B_CLK_DN,
   output [0:0]  M_B_CLK_DP,
   output        M_B_PAR,
   inout [63:0]  M_B_DQ,
   inout [7:0]   M_B_ECC,
   inout [17:0]  M_B_DQS_DP,
   inout [17:0]  M_B_DQS_DN,
   output        cl_RST_DIMM_B_N,
   input         CLK_300M_DIMM3_DP,
   input         CLK_300M_DIMM3_DN,
   output        M_D_ACT_N,
   output [16:0] M_D_MA,
   output [1:0]  M_D_BA,
   output [1:0]  M_D_BG,
   output [0:0]  M_D_CKE,
   output [0:0]  M_D_ODT,
   output [0:0]  M_D_CS_N,
   output [0:0]  M_D_CLK_DN,
   output [0:0]  M_D_CLK_DP,
   output        M_D_PAR,
   inout [63:0]  M_D_DQ,
   inout [7:0]   M_D_ECC,
   inout [17:0]  M_D_DQS_DP,
   inout [17:0]  M_D_DQS_DN,
   output        cl_RST_DIMM_D_N
   );

   logic         zero[2:0];
   logic [  1:0] zero_burst[2:0];
   logic [ 15:0] zero_id[2:0];
   logic [ 63:0] zero_addr[2:0];
   logic [  7:0] zero_len[2:0];
   logic [511:0] zero_data[2:0];
   logic [ 63:0] zero_strb[2:0];

   assign zero[2] = 1'b0;
   assign zero[1] = 1'b0;
   assign zero[0] = 1'b0;
   assign zero_burst[2] = 2'b01;
   assign zero_burst[1] = 2'b01;
   assign zero_burst[0] = 2'b01;
   assign zero_id[2] = 16'b0;
   assign zero_id[1] = 16'b0;
   assign zero_id[0] = 16'b0;
   assign zero_addr[2] = 64'b0;
   assign zero_addr[1] = 64'b0;
   assign zero_addr[0] = 64'b0;
   assign zero_len[2] = 8'b0;
   assign zero_len[1] = 8'b0;
   assign zero_len[0] = 8'b0;
   assign zero_data[2] = 512'b0;
   assign zero_data[1] = 512'b0;
   assign zero_data[0] = 512'b0;
   assign zero_strb[2] = 64'b0;
   assign zero_strb[1] = 64'b0;
   assign zero_strb[0] = 64'b0;

   sh_ddr #(.DDR_A_PRESENT(0),
            .DDR_B_PRESENT(0),
            .DDR_D_PRESENT(0))
   SH_DDR(
          .clk(clk_main_a0),
          .rst_n(rst_main_n_sync),
          .stat_clk(clk_main_a0),
          .stat_rst_n(clk_main_a0),
          .CLK_300M_DIMM0_DP(CLK_300M_DIMM0_DP),
          .CLK_300M_DIMM0_DN(CLK_300M_DIMM0_DN),
          .M_A_ACT_N(M_A_ACT_N),
          .M_A_MA(M_A_MA),
          .M_A_BA(M_A_BA),
          .M_A_BG(M_A_BG),
          .M_A_CKE(M_A_CKE),
          .M_A_ODT(M_A_ODT),
          .M_A_CS_N(M_A_CS_N),
          .M_A_CLK_DN(M_A_CLK_DN),
          .M_A_CLK_DP(M_A_CLK_DP),
          .M_A_PAR(M_A_PAR),
          .M_A_DQ(M_A_DQ),
          .M_A_ECC(M_A_ECC),
          .M_A_DQS_DP(M_A_DQS_DP),
          .M_A_DQS_DN(M_A_DQS_DN),
          .cl_RST_DIMM_A_N(),
          .CLK_300M_DIMM1_DP(CLK_300M_DIMM1_DP),
          .CLK_300M_DIMM1_DN(CLK_300M_DIMM1_DN),
          .M_B_ACT_N(M_B_ACT_N),
          .M_B_MA(M_B_MA),
          .M_B_BA(M_B_BA),
          .M_B_BG(M_B_BG),
          .M_B_CKE(M_B_CKE),
          .M_B_ODT(M_B_ODT),
          .M_B_CS_N(M_B_CS_N),
          .M_B_CLK_DN(M_B_CLK_DN),
          .M_B_CLK_DP(M_B_CLK_DP),
          .M_B_PAR(M_B_PAR),
          .M_B_DQ(M_B_DQ),
          .M_B_ECC(M_B_ECC),
          .M_B_DQS_DP(M_B_DQS_DP),
          .M_B_DQS_DN(M_B_DQS_DN),
          .cl_RST_DIMM_B_N(),
          .CLK_300M_DIMM3_DP(CLK_300M_DIMM3_DP),
          .CLK_300M_DIMM3_DN(CLK_300M_DIMM3_DN),
          .M_D_ACT_N(M_D_ACT_N),
          .M_D_MA(M_D_MA),
          .M_D_BA(M_D_BA),
          .M_D_BG(M_D_BG),
          .M_D_CKE(M_D_CKE),
          .M_D_ODT(M_D_ODT),
          .M_D_CS_N(M_D_CS_N),
          .M_D_CLK_DN(M_D_CLK_DN),
          .M_D_CLK_DP(M_D_CLK_DP),
          .M_D_PAR(M_D_PAR),
          .M_D_DQ(M_D_DQ),
          .M_D_ECC(M_D_ECC),
          .M_D_DQS_DP(M_D_DQS_DP),
          .M_D_DQS_DN(M_D_DQS_DN),
          .cl_RST_DIMM_D_N(),
          .cl_sh_ddr_awid(zero_id),
          .cl_sh_ddr_awaddr(zero_addr),
          .cl_sh_ddr_awlen(zero_len),
          .cl_sh_ddr_awvalid(zero),
          .cl_sh_ddr_awburst(zero_burst),
          .sh_cl_ddr_awready(),
          .cl_sh_ddr_wid(zero_id),
          .cl_sh_ddr_wdata(zero_data),
          .cl_sh_ddr_wstrb(zero_strb),
          .cl_sh_ddr_wlast(3'b0),
          .cl_sh_ddr_wvalid(3'b0),
          .sh_cl_ddr_wready(),
          .sh_cl_ddr_bid(),
          .sh_cl_ddr_bresp(),
          .sh_cl_ddr_bvalid(),
          .cl_sh_ddr_bready(3'b0),
          .cl_sh_ddr_arid(zero_id),
          .cl_sh_ddr_araddr(zero_addr),
          .cl_sh_ddr_arlen(zero_len),
          .cl_sh_ddr_arvalid(3'b0),
          .cl_sh_ddr_arburst(zero_burst),
          .sh_cl_ddr_arready(),
          .sh_cl_ddr_rid(),
          .sh_cl_ddr_rdata(),
          .sh_cl_ddr_rresp(),
          .sh_cl_ddr_rlast(),
          .sh_cl_ddr_rvalid(),
          .cl_sh_ddr_rready(3'b0),
          .sh_cl_ddr_is_ready(),
          .sh_ddr_stat_addr0(8'h00),
          .sh_ddr_stat_wr0(1'b0),
          .sh_ddr_stat_rd0(1'b0),
          .sh_ddr_stat_wdata0(32'b0),
          .ddr_sh_stat_ack0(),
          .ddr_sh_stat_rdata0(),
          .ddr_sh_stat_int0(),
          .sh_ddr_stat_addr1(8'h00),
          .sh_ddr_stat_wr1(1'b0),
          .sh_ddr_stat_rd1(1'b0),
          .sh_ddr_stat_wdata1(32'b0),
          .ddr_sh_stat_ack1(),
          .ddr_sh_stat_rdata1(),
          .ddr_sh_stat_int1(),
          .sh_ddr_stat_addr2(8'h00),
          .sh_ddr_stat_wr2(1'b0),
          .sh_ddr_stat_rd2(1'b0),
          .sh_ddr_stat_wdata2(32'b0),
          .ddr_sh_stat_ack2(),
          .ddr_sh_stat_rdata2(),
          .ddr_sh_stat_int2()
          );

endmodule
