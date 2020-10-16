import chisel3._
import chisel3.util._

class ClHelloWorldCore extends MultiIOModule {
  val io = IO(new Bundle {
    val wrAddr = Input(UInt(32.W))
    val wData = Input(UInt(32.W))
    val wrReady = Input(Bool())
    val shClStatusVDip = Input(UInt(16.W))
    val helloWorldQByteSwapped = Output(UInt(32.W))
    val clShStatusVLed = Output(UInt(16.W))
    val vLed = Output(UInt(16.W))
  })

  //// 入力
  // 書き込み
  val awwarid = IO(Input(Bool()))
  val awadder = IO(Input(UInt(32.W)))
  val wvalid = IO(Input(Bool()))
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

  val HELLO_WORLD_REG_ADDR = "h0000_0500".U(32.W)

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

  // 出力
  arready := readStateReg === sReadAddrReady
  rvalid := readStateReg === sReadDateValid
  rdata := Mux(readAddrReg === HELLO_WORLD_REG_ADDR,
    Cat(helloWorldQ(15, 0), helloWorldQ(31, 16)),
    Cat(0.U(16.W), vLedQ))

  //-------------------------------------------------
  // Hello World Register
  //-------------------------------------------------
  // When read it, returns the byte-flipped value.
  val helloWorldQ = RegInit(0.U(32.W))
  when(io.wrReady === true.B && io.wrAddr === HELLO_WORLD_REG_ADDR) {
    helloWorldQ := io.wData
  }
  io.helloWorldQByteSwapped := Cat(helloWorldQ(15, 0), helloWorldQ(31, 16))

  //-------------------------------------------------
  // Virtual LED Register
  //-------------------------------------------------
  // Flop/synchronize interface signals
  val shClStatusVDipQ = RegNext(io.shClStatusVDip , 0.U(16.W))
  val shClStatusVDipQ2 = RegNext(shClStatusVDipQ, 0.U(16.W))

  val vLedQ = RegNext(helloWorldQ(15, 0), 0.U(16.W))
  val preClShStatusVLed = vLedQ & shClStatusVDipQ2
  val clShStatusVLed = RegNext(preClShStatusVLed, 0.U(16.W))

  io.vLed := vLedQ
  io.clShStatusVLed := clShStatusVLed
}

object ClHelloWorldCore extends App {
  chisel3.Driver.execute(args, () => new ClHelloWorldCore)
}
