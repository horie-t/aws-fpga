import chisel3._
import chisel3.withClockAndReset
import chisel3.util._
import chisel3.experimental._

class ClHelloWorld extends RawModule {
  val clk_main_a0 = IO(Input(Clock()))
  val rst_main_n = IO(Input(Bool()))

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

  val sh_cl_status_vdip = IO(Input(Bool()))
  val cl_sh_status_vled = IO(Output(Bool()))

  /*----------------------------------------
   * リセット信号の同期化
   *----------------------------------------*/
  val resetSyncNegModule = Module(new ResetSyncNeg)
  val resetSyncNegIO = resetSyncNegModule.io
  resetSyncNegIO.clock := clk_main_a0.asBool()
  resetSyncNegIO.reset_n := rst_main_n

  /*----------------------------------------
   * AXI Lite レジスタ・スライス
   *----------------------------------------*/
  val axiRegisterSliceModule = Module(new axi_register_slice_light)
  axiRegisterSliceModule.aclk := clk_main_a0.asBool()
  axiRegisterSliceModule.aresetn := resetSyncNegIO.reset_sync_n
  axiRegisterSliceModule.s_axi_awaddr := sh_ocl_awaddr
  axiRegisterSliceModule.s_axi_awprot := 0.U(2.W)
  axiRegisterSliceModule.s_axi_awvalid := sh_ocl_awvalid
  ocl_sh_awready := axiRegisterSliceModule.s_axi_awready
  axiRegisterSliceModule.s_axi_wdata := sh_ocl_wdata
  axiRegisterSliceModule.s_axi_wstrb := sh_ocl_wstrb
  axiRegisterSliceModule.s_axi_wvalid := sh_ocl_wvalid
  ocl_sh_wready := axiRegisterSliceModule.s_axi_wready
  ocl_sh_bresp := axiRegisterSliceModule.s_axi_bresp
  ocl_sh_bvalid := axiRegisterSliceModule.s_axi_bvalid
  axiRegisterSliceModule.s_axi_bready := sh_ocl_bready
  axiRegisterSliceModule.s_axi_araddr := sh_ocl_araddr
  axiRegisterSliceModule.s_axi_arvalid := sh_ocl_arvalid
  ocl_sh_arready := axiRegisterSliceModule.s_axi_arready
  ocl_sh_rdata := axiRegisterSliceModule.s_axi_rdata
  ocl_sh_rresp := axiRegisterSliceModule.s_axi_rresp
  ocl_sh_rvalid := axiRegisterSliceModule.s_axi_rvalid
  axiRegisterSliceModule.s_axi_rready := sh_ocl_rready

  withClockAndReset(clk_main_a0, !resetSyncNegIO.reset_sync_n) {
    val clHelloWorldCoreModule = Module(new ClHelloWorldCore)
    clHelloWorldCoreModule.s_axi_awvalid := axiRegisterSliceModule.m_axi_awvalid
    clHelloWorldCoreModule.s_axi_awaddr := axiRegisterSliceModule.m_axi_awaddr
    clHelloWorldCoreModule.s_axi_wvalid := axiRegisterSliceModule.m_axi_wvalid
    clHelloWorldCoreModule.s_axi_wdata := axiRegisterSliceModule.m_axi_wdata
    clHelloWorldCoreModule.s_axi_wstrb := axiRegisterSliceModule.m_axi_wstrb
    clHelloWorldCoreModule.s_axi_bready := axiRegisterSliceModule.m_axi_bready
    clHelloWorldCoreModule.s_axi_arvalid := axiRegisterSliceModule.m_axi_arvalid
    clHelloWorldCoreModule.s_axi_araddr := axiRegisterSliceModule.m_axi_araddr
    clHelloWorldCoreModule.s_axi_rready := axiRegisterSliceModule.m_axi_rready
    axiRegisterSliceModule.m_axi_awready := clHelloWorldCoreModule.s_axi_awready
    axiRegisterSliceModule.m_axi_wready := clHelloWorldCoreModule.s_axi_wready
    axiRegisterSliceModule.m_axi_bvalid := clHelloWorldCoreModule.s_axi_bvalid
    axiRegisterSliceModule.m_axi_bresp := clHelloWorldCoreModule.s_axi_bresp
    axiRegisterSliceModule.m_axi_arready := clHelloWorldCoreModule.s_axi_arready
    axiRegisterSliceModule.m_axi_rvalid := clHelloWorldCoreModule.s_axi_rvalid
    axiRegisterSliceModule.m_axi_rdata := clHelloWorldCoreModule.s_axi_rdata
    axiRegisterSliceModule.m_axi_rresp := clHelloWorldCoreModule.s_axi_rresp

    clHelloWorldCoreModule.sh_cl_status_vdip := sh_cl_status_vdip
    cl_sh_status_vled := clHelloWorldCoreModule.cl_sh_status_vled
  }
}

class ClHelloWorldCore extends MultiIOModule {
  /*----------------------------------------
   * AXI LiteのI/O
   *----------------------------------------*/
  //// 入力
  // 書き込み
  val s_axi_awvalid = IO(Input(Bool()))
  val s_axi_awaddr = IO(Input(UInt(32.W)))
  val s_axi_wvalid = IO(Input(Bool()))
  val s_axi_wdata = IO(Input(UInt(32.W)))
  val s_axi_wstrb = IO(Input(UInt(4.W)))
  val s_axi_bready = IO(Input(Bool()))
  // 読み出し
  val s_axi_arvalid = IO(Input(Bool()))
  val s_axi_araddr = IO(Input(UInt(32.W)))
  val s_axi_rready = IO(Input(Bool()))

  //// 出力
  // 書き込み
  val s_axi_awready = IO(Output(Bool()))
  val s_axi_wready = IO(Output(Bool()))
  val s_axi_bvalid = IO(Output(Bool()))
  val s_axi_bresp = IO(Output(UInt(2.W)))
  // 読み出し
  val s_axi_arready = IO(Output(Bool()))
  val s_axi_rvalid = IO(Output(Bool()))
  val s_axi_rdata = IO(Output(UInt(32.W)))
  val s_axi_rresp = IO(Output(UInt(2.W)))

  /*----------------------------------------
   * 仮想LED用のI/O
   *----------------------------------------*/
  val sh_cl_status_vdip = IO(Input(UInt(16.W)))
  val cl_sh_status_vled = IO(Output(UInt(16.W)))

  // 定数定義
  val HELLO_WORLD_REG_ADDR = "h0000_0500".U(32.W)
  val AXI_OK = 0.U(2.W)

  /*----------------------------------------
   * AXI Liteの読み書き
   *----------------------------------------*/
  /*
   * 読み出し
   */
  /* 読み出しステート定義
   * アイドル、アドレス・準備完了、データ有効 */
  val sReadIdle :: sReadAddrReady :: sReadDateValid:: Nil = Enum(3)
  val readStateReg = RegInit(sReadIdle)

  //ステートマシン
  val readAddrReg = RegInit(0.U(32.W))
  when (readStateReg === sReadIdle && s_axi_arvalid) {
    readStateReg := sReadAddrReady
    readAddrReg := s_axi_araddr
  } .elsewhen (readStateReg === sReadAddrReady) {
    readStateReg := sReadDateValid
  } .elsewhen (readStateReg === sReadDateValid && s_axi_rready) {
    readStateReg := sReadIdle
  }

  /*
   * 書き込み
   */
  /* 書き込みステート定義
   *  */
  val sWriteIdle :: sWriteReady :: sWriteDone :: Nil = Enum(3)
  val writeStateReg = RegInit(sWriteIdle)

  // ステートマシン
  val writeAddrReg = RegInit(0.U(32.W))
  val helloWorldReg = RegInit(0.U(32.W))
  when (writeStateReg === sWriteIdle && s_axi_awvalid && s_axi_wvalid) {
    writeStateReg := sWriteReady
    writeAddrReg := s_axi_awaddr
  } .elsewhen (writeStateReg === sWriteReady) {
    writeStateReg := sWriteDone
    when (writeAddrReg === HELLO_WORLD_REG_ADDR) {
      helloWorldReg := s_axi_wdata
    }
  } .elsewhen (writeStateReg === sWriteDone && s_axi_bready) {
    writeStateReg := sWriteIdle
  }

  /*----------------------------------------
   * 出力
   *----------------------------------------*/
  // 仮想LED
  val shClStatusVDipQ = RegNext(sh_cl_status_vdip , 0.U(16.W))
  val shClStatusVDipQ2 = RegNext(shClStatusVDipQ, 0.U(16.W))
  val vLedQ = RegNext(helloWorldReg(15, 0), 0.U(16.W))
  val clSHStatusVLedQ = RegNext(vLedQ & shClStatusVDipQ2, 0.U(16.W))
  cl_sh_status_vled := clSHStatusVLedQ

  // HelloWorldレジスタ
  s_axi_arready := readStateReg === sReadAddrReady
  s_axi_rvalid := readStateReg === sReadDateValid
  s_axi_rdata := Mux(readAddrReg === HELLO_WORLD_REG_ADDR,
    Cat(helloWorldReg(15, 0), helloWorldReg(31, 16)),
    Cat(0.U(16.W), vLedQ))
  s_axi_rresp := AXI_OK    // エラーは起きないものとする

  s_axi_awready := writeStateReg === sWriteReady
  s_axi_wready := writeStateReg === sWriteReady
  s_axi_bresp := AXI_OK   // エラーは起きないものとする
  s_axi_bvalid := writeStateReg === sWriteDone
}

class ResetSyncNeg extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle() {
    val clock = Input(Bool())
    val reset_n = Input(Bool())
    val reset_sync_n = Output(Bool())
  })
  addResource("/ResetSyncNeg.sv")
}

//noinspection ScalaStyle
class axi_register_slice_light extends ExtModule(Map()) {
  val aclk = IO(Input(Bool()))
  val aresetn = IO(Input(Bool()))
  val s_axi_awaddr = IO(Input(UInt(32.W)))
  val s_axi_awprot = IO(Input(UInt(3.W)))
  val s_axi_awvalid = IO(Input(Bool()))
  val s_axi_awready = IO(Output(Bool()))
  val s_axi_wdata = IO(Input(UInt(32.W)))
  val s_axi_wstrb = IO(Input(UInt(4.W)))
  val s_axi_wvalid = IO(Input(Bool()))
  val s_axi_wready = IO(Output(Bool()))
  val s_axi_bresp = IO(Output(UInt(2.W)))
  val s_axi_bvalid = IO(Output(Bool()))
  val s_axi_bready = IO(Input(Bool()))
  val s_axi_araddr = IO(Input(UInt(32.W)))
  val s_axi_arprot = IO(Input(UInt(3.W)))
  val s_axi_arvalid = IO(Input(Bool()))
  val s_axi_arready = IO(Output(Bool()))
  val s_axi_rdata = IO(Output(UInt(32.W)))
  val s_axi_rresp = IO(Output(UInt(2.W)))
  val s_axi_rvalid = IO(Output(Bool()))
  val s_axi_rready = IO(Input(Bool()))
  val m_axi_awaddr = IO(Output(UInt(32.W)))
  val m_axi_awprot = IO(Output(UInt(3.W)))
  val m_axi_awvalid = IO(Output(Bool()))
  val m_axi_awready = IO(Input(Bool()))
  val m_axi_wdata = IO(Output(UInt(32.W)))
  val m_axi_wstrb = IO(Output(UInt(4.W)))
  val m_axi_wvalid = IO(Output(Bool()))
  val m_axi_wready = IO(Input(Bool()))
  val m_axi_bresp = IO(Input(UInt(2.W)))
  val m_axi_bvalid = IO(Input(Bool()))
  val m_axi_bready = IO(Output(Bool()))
  val m_axi_araddr = IO(Output(UInt(32.W)))
  val m_axi_arprot = IO(Output(UInt(3.W)))
  val m_axi_arvalid = IO(Output(Bool()))
  val m_axi_arready = IO(Input(Bool()))
  val m_axi_rdata = IO(Input(UInt(32.W)))
  val m_axi_rresp = IO(Input(UInt(2.W)))
  val m_axi_rvalid = IO(Input(Bool()))
  val m_axi_rready = IO(Output(Bool()))
}

object ClHelloWorld extends App {
  chisel3.Driver.execute(args, () => new ClHelloWorld)
}
