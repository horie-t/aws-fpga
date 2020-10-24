import chisel3._
import chisel3.withClockAndReset
import chisel3.util._
import chisel3.experimental._

class ClHelloWorld extends AwsEc2F1Cl
  with TieOffFlr
  with TieOffDdrABD
  with TieOffDdrC
  with TieOffPciM
  with TieOffDmaPciS
  with TieOffClSda
  with TieOffShBar1
  with TieOffAppPfIrq {

  tieOffFlr()
  tieOffDdrABD()
  tieOffDdrC()
  tieOffPciM()
  tieOffDmaPciS()
  tieOffClSda()
  tieOffShBar1()
  tieOffAppPfIrq()

  val CL_SH_ID0 = "hF000_1D0F".U(32.W)
  val CL_SH_ID1 = "h1D51_FEDD".U(32.W)

  /*----------------------------------------
   * AXI Lite レジスタ・スライス
   *----------------------------------------*/
  val axiRegisterSliceModule = Module(new axi_register_slice_light)
  axiRegisterSliceModule.aclk <> clk_main_a0.asBool()
  axiRegisterSliceModule.aresetn <> resetSyncNegIO.reset_sync_n
  axiRegisterSliceModule.s_axi_awaddr <> sh_ocl_awaddr
  axiRegisterSliceModule.s_axi_awprot <> 0.U(2.W)
  axiRegisterSliceModule.s_axi_awvalid <> sh_ocl_awvalid
  axiRegisterSliceModule.s_axi_awready <> ocl_sh_awready
  axiRegisterSliceModule.s_axi_wdata <> sh_ocl_wdata
  axiRegisterSliceModule.s_axi_wstrb <> sh_ocl_wstrb
  axiRegisterSliceModule.s_axi_wvalid <> sh_ocl_wvalid
  axiRegisterSliceModule.s_axi_wready <> ocl_sh_wready
  axiRegisterSliceModule.s_axi_bresp <> ocl_sh_bresp
  axiRegisterSliceModule.s_axi_bvalid <> ocl_sh_bvalid
  axiRegisterSliceModule.s_axi_bready <> sh_ocl_bready
  axiRegisterSliceModule.s_axi_araddr <> sh_ocl_araddr
  axiRegisterSliceModule.s_axi_arvalid <> sh_ocl_arvalid
  axiRegisterSliceModule.s_axi_arready <> ocl_sh_arready
  axiRegisterSliceModule.s_axi_rdata <> ocl_sh_rdata
  axiRegisterSliceModule.s_axi_rresp <> ocl_sh_rresp
  axiRegisterSliceModule.s_axi_rvalid <> ocl_sh_rvalid
  axiRegisterSliceModule.s_axi_rready <> sh_ocl_rready

  // ID
  cl_sh_id0 := CL_SH_ID0
  cl_sh_id1 := CL_SH_ID1

  withClockAndReset(clk_main_a0.asClock(), !resetSyncNegIO.reset_sync_n) {
    val clHelloWorldCoreModule = Module(new ClHelloWorldCore)
    clHelloWorldCoreModule.s_axi_awvalid <> axiRegisterSliceModule.m_axi_awvalid
    clHelloWorldCoreModule.s_axi_awaddr <> axiRegisterSliceModule.m_axi_awaddr
    clHelloWorldCoreModule.s_axi_wvalid <> axiRegisterSliceModule.m_axi_wvalid
    clHelloWorldCoreModule.s_axi_wdata <> axiRegisterSliceModule.m_axi_wdata
    clHelloWorldCoreModule.s_axi_wstrb <> axiRegisterSliceModule.m_axi_wstrb
    clHelloWorldCoreModule.s_axi_bready <> axiRegisterSliceModule.m_axi_bready
    clHelloWorldCoreModule.s_axi_arvalid <> axiRegisterSliceModule.m_axi_arvalid
    clHelloWorldCoreModule.s_axi_araddr <> axiRegisterSliceModule.m_axi_araddr
    clHelloWorldCoreModule.s_axi_rready <> axiRegisterSliceModule.m_axi_rready
    clHelloWorldCoreModule.s_axi_awready <> axiRegisterSliceModule.m_axi_awready
    clHelloWorldCoreModule.s_axi_wready <> axiRegisterSliceModule.m_axi_wready
    clHelloWorldCoreModule.s_axi_bvalid <> axiRegisterSliceModule.m_axi_bvalid
    clHelloWorldCoreModule.s_axi_bresp <> axiRegisterSliceModule.m_axi_bresp
    clHelloWorldCoreModule.s_axi_arready <> axiRegisterSliceModule.m_axi_arready
    clHelloWorldCoreModule.s_axi_rvalid <> axiRegisterSliceModule.m_axi_rvalid
    clHelloWorldCoreModule.s_axi_rdata <> axiRegisterSliceModule.m_axi_rdata
    clHelloWorldCoreModule.s_axi_rresp <> axiRegisterSliceModule.m_axi_rresp

    clHelloWorldCoreModule.sh_cl_status_vdip <> sh_cl_status_vdip
    clHelloWorldCoreModule.cl_sh_status_vled <> cl_sh_status_vled
  }

  // グローバル信号の接続を無しにする。
  cl_sh_status0 := 0.U(32.W)
  cl_sh_status1 := 0.U(32.W)
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

class AnalogSample extends MultiIOModule with Untie {
  val analogPort = IO(Analog(2.W))

  untie2()
}

trait Untie {
  this: AnalogSample =>
  class AnalogUntie extends BlackBox with HasBlackBoxInline {
    val io = IO(new Bundle() {
      val a = Analog(2.W)
    })
    setInline("AnalogUntie.sv",
      """
        |module AnalogUntie(inout [1:0] a);
        |assign a = '0;
        |endmodule
        |""".stripMargin)

  }

  def untie2(): Unit = {
    val analogUntie = Module(new AnalogUntie)
    analogUntie.io.a <> analogPort
  }
}

object ClHelloWorld extends App {
  chisel3.Driver.execute(args, () => new ClHelloWorld)
}

object AnalogSample extends App {
  chisel3.Driver.execute(args, () => new AnalogSample)
}
