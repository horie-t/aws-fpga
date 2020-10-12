;buildInfoPackage: chisel3, version: 3.4.0, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit ClHelloWorldCore : 
  module ClHelloWorldCore : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip wrAddr : UInt<32>, flip wData : UInt<32>, flip wrReady : UInt<1>, flip shClStatusVDip : UInt<16>, helloWorldQByteSwapped : UInt<32>, clShStatusVLed : UInt<16>, vLed : UInt<16>}
    
    reg helloWorldQ : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 21:28]
    node _T = eq(io.wrReady, UInt<1>("h01")) @[ClHelloWorldCore.scala 22:19]
    node _T_1 = eq(io.wrAddr, UInt<32>("h0500")) @[ClHelloWorldCore.scala 22:43]
    node _T_2 = and(_T, _T_1) @[ClHelloWorldCore.scala 22:30]
    when _T_2 : @[ClHelloWorldCore.scala 22:69]
      helloWorldQ <= io.wData @[ClHelloWorldCore.scala 23:17]
      skip @[ClHelloWorldCore.scala 22:69]
    node io_helloWorldQByteSwapped_right = bits(helloWorldQ, 15, 0) @[ClHelloWorldCore.scala 25:47]
    node io_helloWorldQByteSwapped_left = bits(helloWorldQ, 31, 16) @[ClHelloWorldCore.scala 25:67]
    node _io_helloWorldQByteSwapped_T = cat(io_helloWorldQByteSwapped_right, io_helloWorldQByteSwapped_left) @[Cat.scala 29:58]
    io.helloWorldQByteSwapped <= _io_helloWorldQByteSwapped_T @[ClHelloWorldCore.scala 25:29]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 31:32]
    shClStatusVDipQ <= io.shClStatusVDip @[ClHelloWorldCore.scala 31:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 32:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorldCore.scala 32:33]
    node _T_3 = bits(helloWorldQ, 15, 0) @[ClHelloWorldCore.scala 34:34]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 34:22]
    vLedQ <= _T_3 @[ClHelloWorldCore.scala 34:22]
    node preClShStatusVLed = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorldCore.scala 35:33]
    reg clShStatusVLed : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 36:31]
    clShStatusVLed <= preClShStatusVLed @[ClHelloWorldCore.scala 36:31]
    io.vLed <= vLedQ @[ClHelloWorldCore.scala 38:11]
    io.clShStatusVLed <= clShStatusVLed @[ClHelloWorldCore.scala 39:21]
    
