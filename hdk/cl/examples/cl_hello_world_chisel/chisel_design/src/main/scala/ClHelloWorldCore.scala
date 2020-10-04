import chisel3._
import chisel3.util._

class ClHelloWorldCore extends Module {
  val io = IO(new Bundle {
    val wrAddr = Input(UInt(32.W))
    val wData = Input(UInt(32.W))
    val wrReady = Input(Bool())
    val shClStatusVDip = Input(UInt(16.W))
    val helloWorldQByteSwapped = Output(UInt(32.W))
    val clShStatusVLed = Output(UInt(16.W))
    val vLed = Output(UInt(16.W))
  })

  val HELLO_WORLD_REG_ADDR = "h0000_0500".U(32.W)

  //-------------------------------------------------
  // Hello World Register
  //-------------------------------------------------
  // When read it, returns the byte-flipped value.
  val helloWorldQ = RegInit(0.U(32.W))
  when(io.wrReady === true.B && io.wrAddr === HELLO_WORLD_REG_ADDR) {
    helloWorldQ := io.wData
  }
  io.helloWorldQByteSwapped := Cat(helloWorldQ(7, 0), helloWorldQ(15, 8),
    helloWorldQ(23, 16), helloWorldQ(31, 24))

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
