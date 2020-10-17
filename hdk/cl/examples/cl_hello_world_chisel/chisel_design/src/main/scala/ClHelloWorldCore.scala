import chisel3._
import chisel3.util._

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

object ClHelloWorldCore extends App {
  chisel3.Driver.execute(args, () => new ClHelloWorldCore)
}
