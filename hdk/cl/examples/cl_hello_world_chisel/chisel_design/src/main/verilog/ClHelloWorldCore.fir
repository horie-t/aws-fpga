;buildInfoPackage: chisel3, version: 3.2.7, scalaVersion: 2.11.12, sbtVersion: 1.3.2
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
    node _T_3 = bits(helloWorldQ, 7, 0) @[ClHelloWorldCore.scala 25:47]
    node _T_4 = bits(helloWorldQ, 15, 8) @[ClHelloWorldCore.scala 25:66]
    node _T_5 = bits(helloWorldQ, 23, 16) @[ClHelloWorldCore.scala 26:16]
    node _T_6 = bits(helloWorldQ, 31, 24) @[ClHelloWorldCore.scala 26:37]
    node _T_7 = cat(_T_5, _T_6) @[Cat.scala 29:58]
    node _T_8 = cat(_T_3, _T_4) @[Cat.scala 29:58]
    node _T_9 = cat(_T_8, _T_7) @[Cat.scala 29:58]
    io.helloWorldQByteSwapped <= _T_9 @[ClHelloWorldCore.scala 25:29]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 32:32]
    shClStatusVDipQ <= io.shClStatusVDip @[ClHelloWorldCore.scala 32:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 33:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorldCore.scala 33:33]
    node _T_10 = bits(helloWorldQ, 15, 0) @[ClHelloWorldCore.scala 35:34]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 35:22]
    vLedQ <= _T_10 @[ClHelloWorldCore.scala 35:22]
    node preClShStatusVLed = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorldCore.scala 36:33]
    reg clShStatusVLed : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 37:31]
    clShStatusVLed <= preClShStatusVLed @[ClHelloWorldCore.scala 37:31]
    io.vLed <= vLedQ @[ClHelloWorldCore.scala 39:11]
    io.clShStatusVLed <= clShStatusVLed @[ClHelloWorldCore.scala 40:21]
    
