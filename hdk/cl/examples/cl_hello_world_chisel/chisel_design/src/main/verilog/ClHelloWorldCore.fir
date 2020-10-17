;buildInfoPackage: chisel3, version: 3.4.0, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit ClHelloWorldCore : 
  module ClHelloWorldCore : 
    input clock : Clock
    input reset : UInt<1>
    input awvarid : UInt<1>
    input awadder : UInt<32>
    input wvalid : UInt<1>
    input wdata : UInt<32>
    input wstrb : UInt<4>
    input bready : UInt<1>
    input arvaild : UInt<1>
    input araddr : UInt<32>
    input rready : UInt<1>
    output awready : UInt<1>
    output wready : UInt<1>
    output bvalid : UInt<1>
    output bresp : UInt<2>
    output arready : UInt<1>
    output rvalid : UInt<1>
    output rdata : UInt<32>
    output rresp : UInt<2>
    input sh_cl_status_vdip : UInt<16>
    output cl_sh_status_vled : UInt<16>
    
    reg readStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorldCore.scala 52:29]
    reg readAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 55:28]
    node _T = eq(readStateReg, UInt<2>("h00")) @[ClHelloWorldCore.scala 56:22]
    node _T_1 = and(_T, arvaild) @[ClHelloWorldCore.scala 56:36]
    when _T_1 : @[ClHelloWorldCore.scala 56:48]
      readStateReg <= UInt<2>("h01") @[ClHelloWorldCore.scala 57:18]
      readAddrReg <= araddr @[ClHelloWorldCore.scala 58:17]
      skip @[ClHelloWorldCore.scala 56:48]
    else : @[ClHelloWorldCore.scala 59:49]
      node _T_2 = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 59:29]
      when _T_2 : @[ClHelloWorldCore.scala 59:49]
        readStateReg <= UInt<2>("h02") @[ClHelloWorldCore.scala 60:18]
        skip @[ClHelloWorldCore.scala 59:49]
      else : @[ClHelloWorldCore.scala 61:59]
        node _T_3 = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 61:29]
        node _T_4 = and(_T_3, rready) @[ClHelloWorldCore.scala 61:48]
        when _T_4 : @[ClHelloWorldCore.scala 61:59]
          readStateReg <= UInt<2>("h00") @[ClHelloWorldCore.scala 62:18]
          skip @[ClHelloWorldCore.scala 61:59]
    reg writeStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorldCore.scala 71:30]
    reg writeAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 74:29]
    reg helloWorldReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 75:30]
    node _T_5 = eq(writeStateReg, UInt<2>("h00")) @[ClHelloWorldCore.scala 76:23]
    node _T_6 = and(_T_5, awvarid) @[ClHelloWorldCore.scala 76:38]
    node _T_7 = and(_T_6, wvalid) @[ClHelloWorldCore.scala 76:49]
    when _T_7 : @[ClHelloWorldCore.scala 76:60]
      writeStateReg <= UInt<2>("h01") @[ClHelloWorldCore.scala 77:19]
      writeAddrReg <= awadder @[ClHelloWorldCore.scala 78:18]
      skip @[ClHelloWorldCore.scala 76:60]
    else : @[ClHelloWorldCore.scala 79:47]
      node _T_8 = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 79:30]
      when _T_8 : @[ClHelloWorldCore.scala 79:47]
        writeStateReg <= UInt<2>("h02") @[ClHelloWorldCore.scala 80:19]
        node _T_9 = eq(writeAddrReg, UInt<32>("h0500")) @[ClHelloWorldCore.scala 81:24]
        when _T_9 : @[ClHelloWorldCore.scala 81:50]
          helloWorldReg <= wdata @[ClHelloWorldCore.scala 82:21]
          skip @[ClHelloWorldCore.scala 81:50]
        skip @[ClHelloWorldCore.scala 79:47]
      else : @[ClHelloWorldCore.scala 84:56]
        node _T_10 = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 84:30]
        node _T_11 = and(_T_10, bready) @[ClHelloWorldCore.scala 84:45]
        when _T_11 : @[ClHelloWorldCore.scala 84:56]
          writeStateReg <= UInt<2>("h00") @[ClHelloWorldCore.scala 85:19]
          skip @[ClHelloWorldCore.scala 84:56]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 92:32]
    shClStatusVDipQ <= sh_cl_status_vdip @[ClHelloWorldCore.scala 92:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 93:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorldCore.scala 93:33]
    node _T_12 = bits(helloWorldReg, 15, 0) @[ClHelloWorldCore.scala 94:36]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 94:22]
    vLedQ <= _T_12 @[ClHelloWorldCore.scala 94:22]
    node preClShStatusVLed = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorldCore.scala 95:33]
    reg clShStatusVLed : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 96:31]
    clShStatusVLed <= preClShStatusVLed @[ClHelloWorldCore.scala 96:31]
    cl_sh_status_vled <= clShStatusVLed @[ClHelloWorldCore.scala 97:21]
    node _arready_T = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 100:27]
    arready <= _arready_T @[ClHelloWorldCore.scala 100:11]
    node _rvalid_T = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 101:26]
    rvalid <= _rvalid_T @[ClHelloWorldCore.scala 101:10]
    node _rdata_T = eq(readAddrReg, UInt<32>("h0500")) @[ClHelloWorldCore.scala 102:28]
    node rdata_right = bits(helloWorldReg, 15, 0) @[ClHelloWorldCore.scala 103:22]
    node rdata_left = bits(helloWorldReg, 31, 16) @[ClHelloWorldCore.scala 103:44]
    node _rdata_T_1 = cat(rdata_right, rdata_left) @[Cat.scala 29:58]
    node _rdata_T_2 = cat(UInt<16>("h00"), vLedQ) @[Cat.scala 29:58]
    node _rdata_T_3 = mux(_rdata_T, _rdata_T_1, _rdata_T_2) @[ClHelloWorldCore.scala 102:15]
    rdata <= _rdata_T_3 @[ClHelloWorldCore.scala 102:9]
    rresp <= UInt<2>("h00") @[ClHelloWorldCore.scala 105:9]
    node _awready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 107:28]
    awready <= _awready_T @[ClHelloWorldCore.scala 107:11]
    node _wready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 108:27]
    wready <= _wready_T @[ClHelloWorldCore.scala 108:10]
    bresp <= UInt<2>("h00") @[ClHelloWorldCore.scala 109:9]
    node _bvalid_T = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 110:27]
    bvalid <= _bvalid_T @[ClHelloWorldCore.scala 110:10]
    
