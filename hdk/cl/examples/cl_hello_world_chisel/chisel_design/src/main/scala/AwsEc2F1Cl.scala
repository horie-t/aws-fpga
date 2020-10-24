import chisel3._
import chisel3.experimental._
import chisel3.util.{HasBlackBoxInline, HasBlackBoxResource}

/**
 * AWS EC2 F1インスタンスの独自回路(Custom Logic)のトップ・モジュール
 */
class AwsEc2F1Cl extends RawModule {
  val clk_main_a0 = IO(Input(Bool()))
  val clk_extra_a1 = IO(Input(Bool()))
  val clk_extra_a2 = IO(Input(Bool()))
  val clk_extra_a3 = IO(Input(Bool()))
  val clk_extra_b0 = IO(Input(Bool()))
  val clk_extra_b1 = IO(Input(Bool()))
  val clk_extra_c0 = IO(Input(Bool()))
  val clk_extra_c1 = IO(Input(Bool()))
  val kernel_rst_n = IO(Input(Bool()))
  val rst_main_n = IO(Input(Bool()))
  val sh_cl_flr_assert = IO(Input(Bool()))
  val cl_sh_flr_done = IO(Output(Bool()))
  val cl_sh_status0 = IO(Output(UInt(32.W)))
  val cl_sh_status1 = IO(Output(UInt(32.W)))
  val cl_sh_id0 = IO(Output(UInt(32.W)))
  val cl_sh_id1 = IO(Output(UInt(32.W)))
  val sh_cl_ctl0 = IO(Input(UInt(32.W)))
  val sh_cl_ctl1 = IO(Input(UInt(32.W)))
  val sh_cl_status_vdip = IO(Input(UInt(16.W)))
  val cl_sh_status_vled = IO(Output(UInt(16.W)))
  val sh_cl_pwr_state = IO(Input(UInt(2.W)))
  val cl_sh_dma_wr_full = IO(Output(Bool()))
  val cl_sh_dma_rd_full = IO(Output(Bool()))
  val cl_sh_pcim_awid = IO(Output(UInt(16.W)))
  val cl_sh_pcim_awaddr = IO(Output(UInt(64.W)))
  val cl_sh_pcim_awlen = IO(Output(UInt(8.W)))
  val cl_sh_pcim_awsize = IO(Output(UInt(3.W)))
  val cl_sh_pcim_awuser = IO(Output(UInt(18.W)))
  val cl_sh_pcim_awvalid = IO(Output(Bool()))
  val sh_cl_pcim_awready = IO(Input(Bool()))
  val cl_sh_pcim_wdata = IO(Output(UInt(512.W)))
  val cl_sh_pcim_wstrb = IO(Output(UInt(64.W)))
  val cl_sh_pcim_wlast = IO(Output(Bool()))
  val cl_sh_pcim_wvalid = IO(Output(Bool()))
  val sh_cl_pcim_wready = IO(Input(Bool()))
  val sh_cl_pcim_bid = IO(Input(UInt(16.W)))
  val sh_cl_pcim_bresp = IO(Input(UInt(2.W)))
  val sh_cl_pcim_bvalid = IO(Input(Bool()))
  val cl_sh_pcim_bready = IO(Output(Bool()))
  val cl_sh_pcim_arid = IO(Output(UInt(16.W)))
  val cl_sh_pcim_araddr = IO(Output(UInt(64.W)))
  val cl_sh_pcim_arlen = IO(Output(UInt(8.W)))
  val cl_sh_pcim_arsize = IO(Output(UInt(3.W)))
  val cl_sh_pcim_aruser = IO(Output(UInt(19.W)))
  val cl_sh_pcim_arvalid = IO(Output(Bool()))
  val sh_cl_pcim_arready = IO(Input(Bool()))
  val sh_cl_pcim_rid = IO(Input(UInt(16.W)))
  val sh_cl_pcim_rdata = IO(Input(UInt(512.W)))
  val sh_cl_pcim_rresp = IO(Input(UInt(2.W)))
  val sh_cl_pcim_rlast = IO(Input(Bool()))
  val sh_cl_pcim_rvalid = IO(Input(Bool()))
  val cl_sh_pcim_rready = IO(Output(Bool()))
  val cfg_max_payload = IO(Input(UInt(2.W)))
  val cfg_max_read_req = IO(Input(UInt(3.W)))
  val CLK_300M_DIMM0_DP = IO(Input(Bool()))
  val CLK_300M_DIMM0_DN = IO(Input(Bool()))
  val M_A_ACT_N = IO(Output(Bool()))
  val M_A_MA = IO(Output(UInt(16.W)))
  val M_A_BA = IO(Output(UInt(2.W)))
  val M_A_BG = IO(Output(UInt(2.W)))
  val M_A_CKE = IO(Output(UInt(1.W)))
  val M_A_ODT = IO(Output(UInt(1.W)))
  val M_A_CS_N = IO(Output(UInt(1.W)))
  val M_A_CLK_DN = IO(Output(UInt(1.W)))
  val M_A_CLK_DP = IO(Output(UInt(1.W)))
  val M_A_PAR = IO(Output(Bool()))
  val M_A_DQ = IO(Analog(64.W))
  val M_A_ECC = IO(Analog(8.W))
  val M_A_DQS_DP = IO(Analog(18.W))
  val M_A_DQS_DN = IO(Analog(18.W))
  val cl_RST_DIMM_A_N = IO(Output(Bool()))
  val CLK_300M_DIMM1_DP = IO(Input(Bool()))
  val CLK_300M_DIMM1_DN = IO(Input(Bool()))
  val M_B_ACT_N = IO(Output(Bool()))
  val M_B_MA = IO(Output(UInt(16.W)))
  val M_B_BA = IO(Output(UInt(2.W)))
  val M_B_BG = IO(Output(UInt(2.W)))
  val M_B_CKE = IO(Output(UInt(1.W)))
  val M_B_ODT = IO(Output(UInt(1.W)))
  val M_B_CS_N = IO(Output(UInt(1.W)))
  val M_B_CLK_DN = IO(Output(UInt(1.W)))
  val M_B_CLK_DP = IO(Output(UInt(1.W)))
  val M_B_PAR = IO(Output(Bool()))
  val M_B_DQ = IO(Analog(64.W))
  val M_B_ECC = IO(Analog(8.W))
  val M_B_DQS_DP = IO(Analog(18.W))
  val M_B_DQS_DN = IO(Analog(18.W))
  val cl_RST_DIMM_B_N = IO(Output(Bool()))
  val CLK_300M_DIMM3_DP = IO(Input(Bool()))
  val CLK_300M_DIMM3_DN = IO(Input(Bool()))
  val M_D_ACT_N = IO(Output(Bool()))
  val M_D_MA = IO(Output(UInt(16.W)))
  val M_D_BA = IO(Output(UInt(2.W)))
  val M_D_BG = IO(Output(UInt(2.W)))
  val M_D_CKE = IO(Output(UInt(1.W)))
  val M_D_ODT = IO(Output(UInt(1.W)))
  val M_D_CS_N = IO(Output(UInt(1.W)))
  val M_D_CLK_DN = IO(Output(UInt(1.W)))
  val M_D_CLK_DP = IO(Output(UInt(1.W)))
  val M_D_PAR = IO(Output(Bool()))
  val M_D_DQ = IO(Analog(64.W))
  val M_D_ECC = IO(Analog(8.W))
  val M_D_DQS_DP = IO(Analog(18.W))
  val M_D_DQS_DN = IO(Analog(18.W))
  val cl_RST_DIMM_D_N = IO(Output(Bool()))
  val sh_ddr_stat_addr0 = IO(Input(UInt(8.W)))
  val sh_ddr_stat_wr0 = IO(Input(Bool()))
  val sh_ddr_stat_rd0 = IO(Input(Bool()))
  val sh_ddr_stat_wdata0 = IO(Input(UInt(32.W)))
  val ddr_sh_stat_ack0 = IO(Output(Bool()))
  val ddr_sh_stat_rdata0 = IO(Output(UInt(32.W)))
  val ddr_sh_stat_int0 = IO(Output(UInt(8.W)))
  val sh_ddr_stat_addr1 = IO(Input(UInt(8.W)))
  val sh_ddr_stat_wr1 = IO(Input(Bool()))
  val sh_ddr_stat_rd1 = IO(Input(Bool()))
  val sh_ddr_stat_wdata1 = IO(Input(UInt(32.W)))
  val ddr_sh_stat_ack1 = IO(Output(Bool()))
  val ddr_sh_stat_rdata1 = IO(Output(UInt(32.W)))
  val ddr_sh_stat_int1 = IO(Output(UInt(8.W)))
  val sh_ddr_stat_addr2 = IO(Input(UInt(8.W)))
  val sh_ddr_stat_wr2 = IO(Input(Bool()))
  val sh_ddr_stat_rd2 = IO(Input(Bool()))
  val sh_ddr_stat_wdata2 = IO(Input(UInt(32.W)))
  val ddr_sh_stat_ack2 = IO(Output(Bool()))
  val ddr_sh_stat_rdata2 = IO(Output(UInt(32.W)))
  val ddr_sh_stat_int2 = IO(Output(UInt(8.W)))
  val cl_sh_ddr_awid = IO(Output(UInt(16.W)))
  val cl_sh_ddr_awaddr = IO(Output(UInt(64.W)))
  val cl_sh_ddr_awlen = IO(Output(UInt(8.W)))
  val cl_sh_ddr_awsize = IO(Output(UInt(3.W)))
  val cl_sh_ddr_awburst = IO(Output(UInt(2.W)))
  val cl_sh_ddr_awvalid = IO(Output(Bool()))
  val sh_cl_ddr_awready = IO(Input(Bool()))
  val cl_sh_ddr_wid = IO(Output(UInt(16.W)))
  val cl_sh_ddr_wdata = IO(Output(UInt(512.W)))
  val cl_sh_ddr_wstrb = IO(Output(UInt(64.W)))
  val cl_sh_ddr_wlast = IO(Output(Bool()))
  val cl_sh_ddr_wvalid = IO(Output(Bool()))
  val sh_cl_ddr_wready = IO(Input(Bool()))
  val sh_cl_ddr_bid = IO(Input(UInt(16.W)))
  val sh_cl_ddr_bresp = IO(Input(UInt(2.W)))
  val sh_cl_ddr_bvalid = IO(Input(Bool()))
  val cl_sh_ddr_bready = IO(Output(Bool()))
  val cl_sh_ddr_arid = IO(Output(UInt(16.W)))
  val cl_sh_ddr_araddr = IO(Output(UInt(64.W)))
  val cl_sh_ddr_arlen = IO(Output(UInt(8.W)))
  val cl_sh_ddr_arsize = IO(Output(UInt(3.W)))
  val cl_sh_ddr_arburst = IO(Output(UInt(2.W)))
  val cl_sh_ddr_arvalid = IO(Output(Bool()))
  val sh_cl_ddr_arready = IO(Input(Bool()))
  val sh_cl_ddr_rid = IO(Input(UInt(16.W)))
  val sh_cl_ddr_rdata = IO(Input(UInt(512.W)))
  val sh_cl_ddr_rresp = IO(Input(UInt(2.W)))
  val sh_cl_ddr_rlast = IO(Input(Bool()))
  val sh_cl_ddr_rvalid = IO(Input(Bool()))
  val cl_sh_ddr_rready = IO(Output(Bool()))
  val sh_cl_ddr_is_ready = IO(Input(Bool()))
  val cl_sh_apppf_irq_req = IO(Output(UInt(16.W)))
  val sh_cl_apppf_irq_ack = IO(Input(UInt(16.W)))
  val sh_cl_dma_pcis_awid = IO(Input(UInt(6.W)))
  val sh_cl_dma_pcis_awaddr = IO(Input(UInt(64.W)))
  val sh_cl_dma_pcis_awlen = IO(Input(UInt(8.W)))
  val sh_cl_dma_pcis_awsize = IO(Input(UInt(3.W)))
  val sh_cl_dma_pcis_awvalid = IO(Input(Bool()))
  val cl_sh_dma_pcis_awready = IO(Output(Bool()))
  val sh_cl_dma_pcis_wdata = IO(Input(UInt(512.W)))
  val sh_cl_dma_pcis_wstrb = IO(Input(UInt(64.W)))
  val sh_cl_dma_pcis_wlast = IO(Input(Bool()))
  val sh_cl_dma_pcis_wvalid = IO(Input(Bool()))
  val cl_sh_dma_pcis_wready = IO(Output(Bool()))
  val cl_sh_dma_pcis_bid = IO(Output(UInt(6.W)))
  val cl_sh_dma_pcis_bresp = IO(Output(UInt(2.W)))
  val cl_sh_dma_pcis_bvalid = IO(Output(Bool()))
  val sh_cl_dma_pcis_bready = IO(Input(Bool()))
  val sh_cl_dma_pcis_arid = IO(Input(UInt(6.W)))
  val sh_cl_dma_pcis_araddr = IO(Input(UInt(64.W)))
  val sh_cl_dma_pcis_arlen = IO(Input(UInt(8.W)))
  val sh_cl_dma_pcis_arsize = IO(Input(UInt(3.W)))
  val sh_cl_dma_pcis_arvalid = IO(Input(Bool()))
  val cl_sh_dma_pcis_arready = IO(Output(Bool()))
  val cl_sh_dma_pcis_rid = IO(Output(UInt(6.W)))
  val cl_sh_dma_pcis_rdata = IO(Output(UInt(511.W)))
  val cl_sh_dma_pcis_rresp = IO(Output(UInt(2.W)))
  val cl_sh_dma_pcis_rlast = IO(Output(Bool()))
  val cl_sh_dma_pcis_rvalid = IO(Output(Bool()))
  val sh_cl_dma_pcis_rready = IO(Input(Bool()))
  val sda_cl_awvalid = IO(Input(Bool()))
  val sda_cl_awaddr = IO(Input(UInt(32.W)))
  val cl_sda_awready = IO(Output(Bool()))
  val sda_cl_wvalid = IO(Input(Bool()))
  val sda_cl_wdata = IO(Input(UInt(32.W)))
  val sda_cl_wstrb = IO(Input(UInt(4.W)))
  val cl_sda_wready = IO(Output(Bool()))
  val cl_sda_bvalid = IO(Output(Bool()))
  val cl_sda_bresp = IO(Output(UInt(2.W)))
  val sda_cl_bready = IO(Input(Bool()))
  val sda_cl_arvalid = IO(Input(Bool()))
  val sda_cl_araddr = IO(Input(UInt(32.W)))
  val cl_sda_arready = IO(Output(Bool()))
  val cl_sda_rvalid = IO(Output(Bool()))
  val cl_sda_rdata = IO(Output(UInt(32.W)))
  val cl_sda_rresp = IO(Output(UInt(2.W)))
  val sda_cl_rready = IO(Input(Bool()))
  val sh_ocl_awvalid = IO(Input(Bool()))
  val sh_ocl_awaddr = IO(Input(UInt(32.W)))
  val ocl_sh_awready = IO(Output(Bool()))
  val sh_ocl_wvalid = IO(Input(Bool()))
  val sh_ocl_wdata = IO(Input(UInt(32.W)))
  val sh_ocl_wstrb = IO(Input(UInt(4.W)))
  val ocl_sh_wready = IO(Output(Bool()))
  val ocl_sh_bvalid = IO(Output(Bool()))
  val ocl_sh_bresp = IO(Output(UInt(2.W)))
  val sh_ocl_bready = IO(Input(Bool()))
  val sh_ocl_arvalid = IO(Input(Bool()))
  val sh_ocl_araddr = IO(Input(UInt(32.W)))
  val ocl_sh_arready = IO(Output(Bool()))
  val ocl_sh_rvalid = IO(Output(Bool()))
  val ocl_sh_rdata = IO(Output(UInt(32.W)))
  val ocl_sh_rresp = IO(Output(UInt(2.W)))
  val sh_ocl_rready = IO(Input(Bool()))
  val sh_bar1_awvalid = IO(Input(Bool()))
  val sh_bar1_awaddr = IO(Input(UInt(32.W)))
  val bar1_sh_awready = IO(Output(Bool()))
  val sh_bar1_wvalid = IO(Input(Bool()))
  val sh_bar1_wdata = IO(Input(UInt(32.W)))
  val sh_bar1_wstrb = IO(Input(UInt(3.W)))
  val bar1_sh_wready = IO(Output(Bool()))
  val bar1_sh_bvalid = IO(Output(Bool()))
  val bar1_sh_bresp = IO(Output(UInt(2.W)))
  val sh_bar1_bready = IO(Input(Bool()))
  val sh_bar1_arvalid = IO(Input(Bool()))
  val sh_bar1_araddr = IO(Input(UInt(32.W)))
  val bar1_sh_arready = IO(Output(Bool()))
  val bar1_sh_rvalid = IO(Output(Bool()))
  val bar1_sh_rdata = IO(Output(UInt(32.W)))
  val bar1_sh_rresp = IO(Output(UInt(2.W)))
  val sh_bar1_rready = IO(Input(Bool()))
//  val drck = IO(Input(Bool()))
//  val shift = IO(Input(Bool()))
//  val tdi = IO(Input(Bool()))
//  val update = IO(Input(Bool()))
//  val sel = IO(Input(Bool()))
//  val tdo = IO(Output(Bool()))
//  val tms = IO(Input(Bool()))
//  val tck = IO(Input(Bool()))
//  val runtest = IO(Input(Bool()))
//  val reset = IO(Input(Bool()))
//  val capture = IO(Input(Bool()))
//  val bscanid_en = IO(Input(Bool()))
//  val sh_cl_glcount0 = IO(Input(UInt(64.W)))
//  val sh_cl_glcount1 = IO(Input(UInt(64.W)))

  /*----------------------------------------
   * リセット信号の同期化
   *----------------------------------------*/
  val resetSyncNegModule = Module(new ResetSyncNeg)
  val resetSyncNegIO = resetSyncNegModule.io
  resetSyncNegIO.clock := clk_main_a0
  resetSyncNegIO.reset_n := rst_main_n
  val rst_main_n_sync = resetSyncNegIO.reset_sync_n
}

/**
 * リセット信号の同期化
 */
class ResetSyncNeg extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle() {
    val clock = Input(Bool())
    val reset_n = Input(Bool())
    val reset_sync_n = Output(Bool())
  })
  addResource("/ResetSyncNeg.sv")
}

/**
 * 割込みの接続を無しにする。
 */
trait TieOffAppPfIrq {
  this: AwsEc2F1Cl =>

  def tieOffAppPfIrq(): Unit = {
    cl_sh_apppf_irq_req := 0.U(16.W)
  }
}

/**
 * SHからCL間のPCIeスレーブ(sda)の接続を無しにする。
 */
trait TieOffClSda {
  this: AwsEc2F1Cl =>

  def tieOffClSda(): Unit = {
    cl_sda_awready := 0.U(1.W)
    cl_sda_wready := 0.U(1.W)
    cl_sda_bvalid := 0.U(1.W)
    cl_sda_bresp := 0.U(2.W)
    cl_sda_arready := 0.U(1.W)
    cl_sda_rvalid := 0.U(1.W)
    cl_sda_rdata := 0.U(32.W)
    cl_sda_rresp := 0.U(2.W)
  }
}

/**
 * DDR-4-A,B,Dへの接続を無しにする。
 */
trait TieOffDdrABD {
  this: AwsEc2F1Cl =>

  class TieOffDdrABDBlackBox extends BlackBox with HasBlackBoxInline {
    val io = IO(new Bundle() {
      val clk_main_a0 = Input(Bool())
      val rst_main_n_sync = Input(Bool())
      val CLK_300M_DIMM0_DP = Input(Bool())
      val CLK_300M_DIMM0_DN = Input(Bool())
      val M_A_ACT_N = Output(Bool())
      val M_A_MA = Output(UInt(17.W))
      val M_A_BA = Output(UInt(2.W))
      val M_A_BG = Output(UInt(2.W))
      val M_A_CKE = Output(UInt(1.W))
      val M_A_ODT = Output(UInt(1.W))
      val M_A_CS_N = Output(UInt(1.W))
      val M_A_CLK_DN = Output(UInt(1.W))
      val M_A_CLK_DP = Output(UInt(1.W))
      val M_A_PAR = Output(Bool())
      val M_A_DQ = Analog(64.W)
      val M_A_ECC = Analog(8.W)
      val M_A_DQS_DP = Analog(18.W)
      val M_A_DQS_DN = Analog(18.W)
      val cl_RST_DIMM_A_N = Output(Bool())
      val CLK_300M_DIMM1_DP = Input(Bool())
      val CLK_300M_DIMM1_DN = Input(Bool())
      val M_B_ACT_N = Output(Bool())
      val M_B_MA = Output(UInt(17.W))
      val M_B_BA = Output(UInt(2.W))
      val M_B_BG = Output(UInt(2.W))
      val M_B_CKE = Output(UInt(1.W))
      val M_B_ODT = Output(UInt(1.W))
      val M_B_CS_N = Output(UInt(1.W))
      val M_B_CLK_DN = Output(UInt(1.W))
      val M_B_CLK_DP = Output(UInt(1.W))
      val M_B_PAR = Output(Bool())
      val M_B_DQ = Analog(64.W)
      val M_B_ECC = Analog(8.W)
      val M_B_DQS_DP = Analog(18.W)
      val M_B_DQS_DN = Analog(18.W)
      val cl_RST_DIMM_B_N = Output(Bool())
      val CLK_300M_DIMM3_DP = Input(Bool())
      val CLK_300M_DIMM3_DN = Input(Bool())
      val M_D_ACT_N = Output(Bool())
      val M_D_MA = Output(UInt(17.W))
      val M_D_BA = Output(UInt(2.W))
      val M_D_BG = Output(UInt(2.W))
      val M_D_CKE = Output(UInt(1.W))
      val M_D_ODT = Output(UInt(1.W))
      val M_D_CS_N = Output(UInt(1.W))
      val M_D_CLK_DN = Output(UInt(1.W))
      val M_D_CLK_DP = Output(UInt(1.W))
      val M_D_PAR = Output(Bool())
      val M_D_DQ = Analog(64.W)
      val M_D_ECC = Analog(8.W)
      val M_D_DQS_DP = Analog(18.W)
      val M_D_DQS_DN = Analog(18.W)
      val cl_RST_DIMM_D_N = Output(Bool())
    })
    setInline("TieOffDdrABDBlackBox.sv",
      """
        |module TieOffDdrABDBlackBox
        |  (
        |   input         clk_main_a0,
        |   input         rst_main_n_sync,
        |   input         CLK_300M_DIMM0_DP,
        |   input         CLK_300M_DIMM0_DN,
        |   output        M_A_ACT_N,
        |   output [16:0] M_A_MA,
        |   output [1:0]  M_A_BA,
        |   output [1:0]  M_A_BG,
        |   output [0:0]  M_A_CKE,
        |   output [0:0]  M_A_ODT,
        |   output [0:0]  M_A_CS_N,
        |   output [0:0]  M_A_CLK_DN,
        |   output [0:0]  M_A_CLK_DP,
        |   output        M_A_PAR,
        |   inout [63:0]  M_A_DQ,
        |   inout [7:0]   M_A_ECC,
        |   inout [17:0]  M_A_DQS_DP,
        |   inout [17:0]  M_A_DQS_DN,
        |   output        cl_RST_DIMM_A_N,
        |   input         CLK_300M_DIMM1_DP,
        |   input         CLK_300M_DIMM1_DN,
        |   output        M_B_ACT_N,
        |   output [16:0] M_B_MA,
        |   output [1:0]  M_B_BA,
        |   output [1:0]  M_B_BG,
        |   output [0:0]  M_B_CKE,
        |   output [0:0]  M_B_ODT,
        |   output [0:0]  M_B_CS_N,
        |   output [0:0]  M_B_CLK_DN,
        |   output [0:0]  M_B_CLK_DP,
        |   output        M_B_PAR,
        |   inout [63:0]  M_B_DQ,
        |   inout [7:0]   M_B_ECC,
        |   inout [17:0]  M_B_DQS_DP,
        |   inout [17:0]  M_B_DQS_DN,
        |   output        cl_RST_DIMM_B_N,
        |   input         CLK_300M_DIMM3_DP,
        |   input         CLK_300M_DIMM3_DN,
        |   output        M_D_ACT_N,
        |   output [16:0] M_D_MA,
        |   output [1:0]  M_D_BA,
        |   output [1:0]  M_D_BG,
        |   output [0:0]  M_D_CKE,
        |   output [0:0]  M_D_ODT,
        |   output [0:0]  M_D_CS_N,
        |   output [0:0]  M_D_CLK_DN,
        |   output [0:0]  M_D_CLK_DP,
        |   output        M_D_PAR,
        |   inout [63:0]  M_D_DQ,
        |   inout [7:0]   M_D_ECC,
        |   inout [17:0]  M_D_DQS_DP,
        |   inout [17:0]  M_D_DQS_DN,
        |   output        cl_RST_DIMM_D_N
        |   );
        |
        |   logic         zero[2:0];
        |   logic [  1:0] zero_burst[2:0];
        |   logic [ 15:0] zero_id[2:0];
        |   logic [ 63:0] zero_addr[2:0];
        |   logic [  7:0] zero_len[2:0];
        |   logic [511:0] zero_data[2:0];
        |   logic [ 63:0] zero_strb[2:0];
        |
        |   assign zero[2] = 1'b0;
        |   assign zero[1] = 1'b0;
        |   assign zero[0] = 1'b0;
        |   assign zero_burst[2] = 2'b01;
        |   assign zero_burst[1] = 2'b01;
        |   assign zero_burst[0] = 2'b01;
        |   assign zero_id[2] = 16'b0;
        |   assign zero_id[1] = 16'b0;
        |   assign zero_id[0] = 16'b0;
        |   assign zero_addr[2] = 64'b0;
        |   assign zero_addr[1] = 64'b0;
        |   assign zero_addr[0] = 64'b0;
        |   assign zero_len[2] = 8'b0;
        |   assign zero_len[1] = 8'b0;
        |   assign zero_len[0] = 8'b0;
        |   assign zero_data[2] = 512'b0;
        |   assign zero_data[1] = 512'b0;
        |   assign zero_data[0] = 512'b0;
        |   assign zero_strb[2] = 64'b0;
        |   assign zero_strb[1] = 64'b0;
        |   assign zero_strb[0] = 64'b0;
        |
        |   sh_ddr #(.DDR_A_PRESENT(0),
        |            .DDR_B_PRESENT(0),
        |            .DDR_D_PRESENT(0))
        |   SH_DDR(
        |          .clk(clk_main_a0),
        |          .rst_n(rst_main_n_sync),
        |          .stat_clk(clk_main_a0),
        |          .stat_rst_n(clk_main_a0),
        |          .CLK_300M_DIMM0_DP(CLK_300M_DIMM0_DP),
        |          .CLK_300M_DIMM0_DN(CLK_300M_DIMM0_DN),
        |          .M_A_ACT_N(M_A_ACT_N),
        |          .M_A_MA(M_A_MA),
        |          .M_A_BA(M_A_BA),
        |          .M_A_BG(M_A_BG),
        |          .M_A_CKE(M_A_CKE),
        |          .M_A_ODT(M_A_ODT),
        |          .M_A_CS_N(M_A_CS_N),
        |          .M_A_CLK_DN(M_A_CLK_DN),
        |          .M_A_CLK_DP(M_A_CLK_DP),
        |          .M_A_PAR(M_A_PAR),
        |          .M_A_DQ(M_A_DQ),
        |          .M_A_ECC(M_A_ECC),
        |          .M_A_DQS_DP(M_A_DQS_DP),
        |          .M_A_DQS_DN(M_A_DQS_DN),
        |          .cl_RST_DIMM_A_N(),
        |          .CLK_300M_DIMM1_DP(CLK_300M_DIMM1_DP),
        |          .CLK_300M_DIMM1_DN(CLK_300M_DIMM1_DN),
        |          .M_B_ACT_N(M_B_ACT_N),
        |          .M_B_MA(M_B_MA),
        |          .M_B_BA(M_B_BA),
        |          .M_B_BG(M_B_BG),
        |          .M_B_CKE(M_B_CKE),
        |          .M_B_ODT(M_B_ODT),
        |          .M_B_CS_N(M_B_CS_N),
        |          .M_B_CLK_DN(M_B_CLK_DN),
        |          .M_B_CLK_DP(M_B_CLK_DP),
        |          .M_B_PAR(M_B_PAR),
        |          .M_B_DQ(M_B_DQ),
        |          .M_B_ECC(M_B_ECC),
        |          .M_B_DQS_DP(M_B_DQS_DP),
        |          .M_B_DQS_DN(M_B_DQS_DN),
        |          .cl_RST_DIMM_B_N(),
        |          .CLK_300M_DIMM3_DP(CLK_300M_DIMM3_DP),
        |          .CLK_300M_DIMM3_DN(CLK_300M_DIMM3_DN),
        |          .M_D_ACT_N(M_D_ACT_N),
        |          .M_D_MA(M_D_MA),
        |          .M_D_BA(M_D_BA),
        |          .M_D_BG(M_D_BG),
        |          .M_D_CKE(M_D_CKE),
        |          .M_D_ODT(M_D_ODT),
        |          .M_D_CS_N(M_D_CS_N),
        |          .M_D_CLK_DN(M_D_CLK_DN),
        |          .M_D_CLK_DP(M_D_CLK_DP),
        |          .M_D_PAR(M_D_PAR),
        |          .M_D_DQ(M_D_DQ),
        |          .M_D_ECC(M_D_ECC),
        |          .M_D_DQS_DP(M_D_DQS_DP),
        |          .M_D_DQS_DN(M_D_DQS_DN),
        |          .cl_RST_DIMM_D_N(),
        |          .cl_sh_ddr_awid(zero_id),
        |          .cl_sh_ddr_awaddr(zero_addr),
        |          .cl_sh_ddr_awlen(zero_len),
        |          .cl_sh_ddr_awvalid(zero),
        |          .cl_sh_ddr_awburst(zero_burst),
        |          .sh_cl_ddr_awready(),
        |          .cl_sh_ddr_wid(zero_id),
        |          .cl_sh_ddr_wdata(zero_data),
        |          .cl_sh_ddr_wstrb(zero_strb),
        |          .cl_sh_ddr_wlast(3'b0),
        |          .cl_sh_ddr_wvalid(3'b0),
        |          .sh_cl_ddr_wready(),
        |          .sh_cl_ddr_bid(),
        |          .sh_cl_ddr_bresp(),
        |          .sh_cl_ddr_bvalid(),
        |          .cl_sh_ddr_bready(3'b0),
        |          .cl_sh_ddr_arid(zero_id),
        |          .cl_sh_ddr_araddr(zero_addr),
        |          .cl_sh_ddr_arlen(zero_len),
        |          .cl_sh_ddr_arvalid(3'b0),
        |          .cl_sh_ddr_arburst(zero_burst),
        |          .sh_cl_ddr_arready(),
        |          .sh_cl_ddr_rid(),
        |          .sh_cl_ddr_rdata(),
        |          .sh_cl_ddr_rresp(),
        |          .sh_cl_ddr_rlast(),
        |          .sh_cl_ddr_rvalid(),
        |          .cl_sh_ddr_rready(3'b0),
        |          .sh_cl_ddr_is_ready(),
        |          .sh_ddr_stat_addr0(8'h00),
        |          .sh_ddr_stat_wr0(1'b0),
        |          .sh_ddr_stat_rd0(1'b0),
        |          .sh_ddr_stat_wdata0(32'b0),
        |          .ddr_sh_stat_ack0(),
        |          .ddr_sh_stat_rdata0(),
        |          .ddr_sh_stat_int0(),
        |          .sh_ddr_stat_addr1(8'h00),
        |          .sh_ddr_stat_wr1(1'b0),
        |          .sh_ddr_stat_rd1(1'b0),
        |          .sh_ddr_stat_wdata1(32'b0),
        |          .ddr_sh_stat_ack1(),
        |          .ddr_sh_stat_rdata1(),
        |          .ddr_sh_stat_int1(),
        |          .sh_ddr_stat_addr2(8'h00),
        |          .sh_ddr_stat_wr2(1'b0),
        |          .sh_ddr_stat_rd2(1'b0),
        |          .sh_ddr_stat_wdata2(32'b0),
        |          .ddr_sh_stat_ack2(),
        |          .ddr_sh_stat_rdata2(),
        |          .ddr_sh_stat_int2()
        |          );
        |
        |endmodule
        |""".stripMargin
    )
  }

  def tieOffDdrABD(): Unit = {
    val tieOffDdrABDBlackBox = Module(new TieOffDdrABDBlackBox)
    val tieOffIO = tieOffDdrABDBlackBox.io
    tieOffIO.clk_main_a0 <> clk_main_a0
    tieOffIO.rst_main_n_sync <> rst_main_n_sync
    tieOffIO.CLK_300M_DIMM0_DP <> CLK_300M_DIMM0_DP
    tieOffIO.CLK_300M_DIMM0_DN <> CLK_300M_DIMM0_DN
    tieOffIO.M_A_ACT_N <> M_A_ACT_N
    tieOffIO.M_A_MA <> M_A_MA
    tieOffIO.M_A_BA <> M_A_BA
    tieOffIO.M_A_BG <> M_A_BG
    tieOffIO.M_A_CKE <> M_A_CKE
    tieOffIO.M_A_ODT <> M_A_ODT
    tieOffIO.M_A_CS_N <> M_A_CS_N
    tieOffIO.M_A_CLK_DN <> M_A_CLK_DN
    tieOffIO.M_A_CLK_DP <> M_A_CLK_DP
    tieOffIO.M_A_PAR <> M_A_PAR
    tieOffIO.M_A_DQ <> M_A_DQ
    tieOffIO.M_A_ECC <> M_A_ECC
    tieOffIO.M_A_DQS_DP <> M_A_DQS_DP
    tieOffIO.M_A_DQS_DN <> M_A_DQS_DN
    tieOffIO.cl_RST_DIMM_A_N <> cl_RST_DIMM_A_N
    tieOffIO.CLK_300M_DIMM1_DP <> CLK_300M_DIMM1_DP
    tieOffIO.CLK_300M_DIMM1_DN <> CLK_300M_DIMM1_DN
    tieOffIO.M_B_ACT_N <> M_B_ACT_N
    tieOffIO.M_B_MA <> M_B_MA
    tieOffIO.M_B_BA <> M_B_BA
    tieOffIO.M_B_BG <> M_B_BG
    tieOffIO.M_B_CKE <> M_B_CKE
    tieOffIO.M_B_ODT <> M_B_ODT
    tieOffIO.M_B_CS_N <> M_B_CS_N
    tieOffIO.M_B_CLK_DN <> M_B_CLK_DN
    tieOffIO.M_B_CLK_DP <> M_B_CLK_DP
    tieOffIO.M_B_PAR <> M_B_PAR
    tieOffIO.M_B_DQ <> M_B_DQ
    tieOffIO.M_B_ECC <> M_B_ECC
    tieOffIO.M_B_DQS_DP <> M_B_DQS_DP
    tieOffIO.M_B_DQS_DN <> M_B_DQS_DN
    tieOffIO.cl_RST_DIMM_B_N <> cl_RST_DIMM_B_N
    tieOffIO.CLK_300M_DIMM3_DP <> CLK_300M_DIMM3_DP
    tieOffIO.CLK_300M_DIMM3_DN <> CLK_300M_DIMM3_DN
    tieOffIO.M_D_ACT_N <> M_D_ACT_N
    tieOffIO.M_D_MA <> M_D_MA
    tieOffIO.M_D_BA <> M_D_BA
    tieOffIO.M_D_BG <> M_D_BG
    tieOffIO.M_D_CKE <> M_D_CKE
    tieOffIO.M_D_ODT <> M_D_ODT
    tieOffIO.M_D_CS_N <> M_D_CS_N
    tieOffIO.M_D_CLK_DN <> M_D_CLK_DN
    tieOffIO.M_D_CLK_DP <> M_D_CLK_DP
    tieOffIO.M_D_PAR <> M_D_PAR
    tieOffIO.M_D_DQ <> M_D_DQ
    tieOffIO.M_D_ECC <> M_D_ECC
    tieOffIO.M_D_DQS_DP <> M_D_DQS_DP
    tieOffIO.M_D_DQS_DN <> M_D_DQS_DN
    tieOffIO.cl_RST_DIMM_D_N <> cl_RST_DIMM_D_N

    ddr_sh_stat_ack0 := 1.U(1.W)
    ddr_sh_stat_rdata0 := 0.U(32.W)
    ddr_sh_stat_int0 := 0.U(8.W)
    ddr_sh_stat_ack1 := 1.U(1.W)
    ddr_sh_stat_rdata1 := 0.U(32.W)
    ddr_sh_stat_int1 := 0.U(8.W)
    ddr_sh_stat_ack2 := 1.U(1.W)
    ddr_sh_stat_rdata2 := 0.U(32.W)
    ddr_sh_stat_int2 := 0.U(8.W)
  }
}

/**
 * DDR4-Cへの接続を無しにする。
 */
trait TieOffDdrC {
  this: AwsEc2F1Cl =>

  def tieOffDdrC(): Unit = {
    cl_sh_ddr_awid := 0.U(16.W)
    cl_sh_ddr_awaddr := 0.U(64.W)
    cl_sh_ddr_awlen := 0.U(8.W)
    cl_sh_ddr_awsize := 0.U(3.W)
    cl_sh_ddr_awvalid := 0.U(1.W)
    cl_sh_ddr_awburst := 0.U(2.W)
    cl_sh_ddr_wid := 0.U(16.W)
    cl_sh_ddr_wdata := 0.U(512.W)
    cl_sh_ddr_wstrb := 0.U(64.W)
    cl_sh_ddr_wlast := 0.U(1.W)
    cl_sh_ddr_wvalid := 0.U(1.W)
    cl_sh_ddr_bready := 0.U(1.W)
    cl_sh_ddr_arid := 0.U(16.W)
    cl_sh_ddr_araddr := 0.U(64.W)
    cl_sh_ddr_arlen := 0.U(8.W)
    cl_sh_ddr_arsize := 0.U(3.W)
    cl_sh_ddr_arvalid := 0.U(1.W)
    cl_sh_ddr_arburst := 0.U(2.W)
    cl_sh_ddr_rready := 0.U(1.W)
  }
}

/**
 * SHからCL間のDMA PCIeスレーブ(DMA_PCIS)の接続を無しにする。
 */
trait TieOffDmaPciS {
  this: AwsEc2F1Cl =>

  def tieOffDmaPciS(): Unit = {
    cl_sh_dma_pcis_awready := 0.U(1.W)
    cl_sh_dma_pcis_wready := 0.U(1.W)
    cl_sh_dma_pcis_bid := 0.U(6.W)
    cl_sh_dma_pcis_bresp := 0.U(2.W)
    cl_sh_dma_pcis_bvalid := 0.U(1.W)
    cl_sh_dma_pcis_arready := 0.U(1.W)
    cl_sh_dma_pcis_rid := 0.U(6.W)
    cl_sh_dma_pcis_rdata := 0.U(512.W)
    cl_sh_dma_pcis_rresp := 0.U(2.W)
    cl_sh_dma_pcis_rlast := 0.U(1.W)
    cl_sh_dma_pcis_rvalid := 0.U(1.W)
    cl_sh_dma_wr_full := 0.U(1.W)
    cl_sh_dma_rd_full := 0.U(1.W)
  }
}

trait TieOffFlr {
  this: AwsEc2F1Cl =>

  def tieOffFlr(): Unit = {
    cl_sh_flr_done := 0.U(1.W)
  }
}

/**
 * CLからSHへのPCIeマスター(PCIM)接続を無しにする。
 */
trait TieOffPciM {
  this: AwsEc2F1Cl =>

  def tieOffPciM(): Unit = {
    cl_sh_pcim_awid := 0.U(16.W)
    cl_sh_pcim_awaddr := 0.U(64.W)
    cl_sh_pcim_awlen := 0.U(8.W)
    cl_sh_pcim_awsize := 0.U(3.W)
    cl_sh_pcim_awuser := 0.U(19.W)
    cl_sh_pcim_awvalid := 0.U(1.W)
    cl_sh_pcim_wdata := 0.U(512.W)
    cl_sh_pcim_wstrb := 0.U(64.W)
    cl_sh_pcim_wlast := 0.U(1.W)
    cl_sh_pcim_wvalid := 0.U(1.W)
    cl_sh_pcim_bready := 0.U(1.W)
    cl_sh_pcim_arid := 0.U(16.W)
    cl_sh_pcim_araddr := 0.U(64.W)
    cl_sh_pcim_arlen := 0.U(8.W)
    cl_sh_pcim_arsize := 0.U(3.W)
    cl_sh_pcim_aruser := 0.U(19.W)
    cl_sh_pcim_arvalid := 0.U(1.W)
    cl_sh_pcim_rready := 0.U(1.W)
  }
}

/**
 * SHからCLへのBAR1の接続を無しにする。
 */
trait TieOffShBar1 {
  this: AwsEc2F1Cl =>

  def tieOffShBar1(): Unit = {
    bar1_sh_awready := 0.U(1.W)
    bar1_sh_wready := 0.U(1.W)
    bar1_sh_bvalid := 0.U(1.W)
    bar1_sh_bresp := 0.U(2.W)
    bar1_sh_arready := 0.U(1.W)
    bar1_sh_rvalid := 0.U(1.W)
    bar1_sh_rdata := 0.U(32.W)
    bar1_sh_rresp := 0.U(2.W)
  }
}

/**
 * SHからCLへのOCLの接続を無しにする。
 */
trait TieOffOclSh {
  this: AwsEc2F1Cl =>

  def tieOffOclSh(): Unit = {
    ocl_sh_awready := 0.U(1.W)
    ocl_sh_wready := 0.U(1.W)
    ocl_sh_bvalid := 0.U(1.W)
    ocl_sh_bresp := 0.U(2.W)
    ocl_sh_arready := 0.U(1.W)
    ocl_sh_rvalid := 0.U(1.W)
    ocl_sh_rdata := 0.U(32.W)
    ocl_sh_rresp := 0.U(2.W)
  }
}