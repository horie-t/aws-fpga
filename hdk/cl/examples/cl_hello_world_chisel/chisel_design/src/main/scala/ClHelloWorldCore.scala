import chisel3._
import chisel3.util._

class ClHelloWorldCore extends MultiIOModule {
  /*----------------------------------------
   * AXI LiteのI/O
   *----------------------------------------*/
  //// 入力
  // 書き込み
  val awvalid = IO(Input(Bool()))
  val awadder = IO(Input(UInt(32.W)))
  val wvalid = IO(Input(Bool()))
  val wdata = IO(Input(UInt(32.W)))
  val wstrb = IO(Input(UInt(4.W)))
  val bready = IO(Input(Bool()))
  // 読み出し
  val arvaild = IO(Input(Bool()))
  val araddr = IO(Input(UInt(32.W)))
  val rready = IO(Input(Bool()))

  //// 出力
  // 書き込み
  val awready = IO(Output(Bool()))
  val wready = IO(Output(Bool()))
  val bvalid = IO(Output(Bool()))
  val bresp = IO(Output(UInt(2.W)))
  // 読み出し
  val arready = IO(Output(Bool()))
  val rvalid = IO(Output(Bool()))
  val rdata = IO(Output(UInt(32.W)))
  val rresp = IO(Output(UInt(2.W)))

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
  when (readStateReg === sReadIdle && arvaild) {
    readStateReg := sReadAddrReady
    readAddrReg := araddr
  } .elsewhen (readStateReg === sReadAddrReady) {
    readStateReg := sReadDateValid
  } .elsewhen (readStateReg === sReadDateValid && rready) {
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
  when (writeStateReg === sWriteIdle && awvalid && wvalid) {
    writeStateReg := sWriteReady
    writeAddrReg := awadder
  } .elsewhen (writeStateReg === sWriteReady) {
    writeStateReg := sWriteDone
    when (writeAddrReg === HELLO_WORLD_REG_ADDR) {
      helloWorldReg := wdata
    }
  } .elsewhen (writeStateReg === sWriteDone && bready) {
    writeStateReg := sWriteIdle
  }

  /*----------------------------------------
   * 出力
   *----------------------------------------*/
  // 仮想LED
  val shClStatusVDipQ = RegNext(sh_cl_status_vdip , 0.U(16.W))
  val shClStatusVDipQ2 = RegNext(shClStatusVDipQ, 0.U(16.W))
  val vLedQ = RegNext(helloWorldReg(15, 0), 0.U(16.W))
  val preClShStatusVLed = vLedQ & shClStatusVDipQ2
  val clShStatusVLed = RegNext(preClShStatusVLed, 0.U(16.W))
  cl_sh_status_vled := clShStatusVLed

  // HelloWorldレジスタ
  arready := readStateReg === sReadAddrReady
  rvalid := readStateReg === sReadDateValid
  rdata := Mux(readAddrReg === HELLO_WORLD_REG_ADDR,
    Cat(helloWorldReg(15, 0), helloWorldReg(31, 16)),
    Cat(0.U(16.W), vLedQ))
  rresp := AXI_OK    // エラーは起きないものとする

  awready := writeStateReg === sWriteReady
  wready := writeStateReg === sWriteReady
  bresp := AXI_OK   // エラーは起きないものとする
  bvalid := writeStateReg === sWriteDone
}

object ClHelloWorldCore extends App {
  chisel3.Driver.execute(args, () => new ClHelloWorldCore)
}
