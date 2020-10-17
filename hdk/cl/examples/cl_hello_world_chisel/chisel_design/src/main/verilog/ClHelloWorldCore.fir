;buildInfoPackage: chisel3, version: 3.4.0, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit ClHelloWorldCore : 
  module ClHelloWorldCore : 
    input clock : Clock
    input reset : UInt<1>
    input s_axi_awvalid : UInt<1>
    input s_axi_awaddr : UInt<32>
    input s_axi_wvalid : UInt<1>
    input s_axi_wdata : UInt<32>
    input s_axi_wstrb : UInt<4>
    input s_axi_bready : UInt<1>
    input s_axi_arvalid : UInt<1>
    input s_axi_araddr : UInt<32>
    input s_axi_rready : UInt<1>
    output s_axi_awready : UInt<1>
    output s_axi_wready : UInt<1>
    output s_axi_bvalid : UInt<1>
    output s_axi_bresp : UInt<2>
    output s_axi_arready : UInt<1>
    output s_axi_rvalid : UInt<1>
    output s_axi_rdata : UInt<32>
    output s_axi_rresp : UInt<2>
    input sh_cl_status_vdip : UInt<16>
    output cl_sh_status_vled : UInt<16>
    
    reg readStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorldCore.scala 52:29]
    reg readAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 55:28]
    node _T = eq(readStateReg, UInt<2>("h00")) @[ClHelloWorldCore.scala 56:22]
    node _T_1 = and(_T, s_axi_arvalid) @[ClHelloWorldCore.scala 56:36]
    when _T_1 : @[ClHelloWorldCore.scala 56:54]
      readStateReg <= UInt<2>("h01") @[ClHelloWorldCore.scala 57:18]
      readAddrReg <= s_axi_araddr @[ClHelloWorldCore.scala 58:17]
      skip @[ClHelloWorldCore.scala 56:54]
    else : @[ClHelloWorldCore.scala 59:49]
      node _T_2 = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 59:29]
      when _T_2 : @[ClHelloWorldCore.scala 59:49]
        readStateReg <= UInt<2>("h02") @[ClHelloWorldCore.scala 60:18]
        skip @[ClHelloWorldCore.scala 59:49]
      else : @[ClHelloWorldCore.scala 61:65]
        node _T_3 = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 61:29]
        node _T_4 = and(_T_3, s_axi_rready) @[ClHelloWorldCore.scala 61:48]
        when _T_4 : @[ClHelloWorldCore.scala 61:65]
          readStateReg <= UInt<2>("h00") @[ClHelloWorldCore.scala 62:18]
          skip @[ClHelloWorldCore.scala 61:65]
    reg writeStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorldCore.scala 71:30]
    reg writeAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 74:29]
    reg helloWorldReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorldCore.scala 75:30]
    node _T_5 = eq(writeStateReg, UInt<2>("h00")) @[ClHelloWorldCore.scala 76:23]
    node _T_6 = and(_T_5, s_axi_awvalid) @[ClHelloWorldCore.scala 76:38]
    node _T_7 = and(_T_6, s_axi_wvalid) @[ClHelloWorldCore.scala 76:55]
    when _T_7 : @[ClHelloWorldCore.scala 76:72]
      writeStateReg <= UInt<2>("h01") @[ClHelloWorldCore.scala 77:19]
      writeAddrReg <= s_axi_awaddr @[ClHelloWorldCore.scala 78:18]
      skip @[ClHelloWorldCore.scala 76:72]
    else : @[ClHelloWorldCore.scala 79:47]
      node _T_8 = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 79:30]
      when _T_8 : @[ClHelloWorldCore.scala 79:47]
        writeStateReg <= UInt<2>("h02") @[ClHelloWorldCore.scala 80:19]
        node _T_9 = eq(writeAddrReg, UInt<32>("h0500")) @[ClHelloWorldCore.scala 81:24]
        when _T_9 : @[ClHelloWorldCore.scala 81:50]
          helloWorldReg <= s_axi_wdata @[ClHelloWorldCore.scala 82:21]
          skip @[ClHelloWorldCore.scala 81:50]
        skip @[ClHelloWorldCore.scala 79:47]
      else : @[ClHelloWorldCore.scala 84:62]
        node _T_10 = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 84:30]
        node _T_11 = and(_T_10, s_axi_bready) @[ClHelloWorldCore.scala 84:45]
        when _T_11 : @[ClHelloWorldCore.scala 84:62]
          writeStateReg <= UInt<2>("h00") @[ClHelloWorldCore.scala 85:19]
          skip @[ClHelloWorldCore.scala 84:62]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 92:32]
    shClStatusVDipQ <= sh_cl_status_vdip @[ClHelloWorldCore.scala 92:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 93:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorldCore.scala 93:33]
    node _T_12 = bits(helloWorldReg, 15, 0) @[ClHelloWorldCore.scala 94:36]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 94:22]
    vLedQ <= _T_12 @[ClHelloWorldCore.scala 94:22]
    node _T_13 = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorldCore.scala 95:39]
    reg clSHStatusVLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorldCore.scala 95:32]
    clSHStatusVLedQ <= _T_13 @[ClHelloWorldCore.scala 95:32]
    cl_sh_status_vled <= clSHStatusVLedQ @[ClHelloWorldCore.scala 96:21]
    node _s_axi_arready_T = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 99:33]
    s_axi_arready <= _s_axi_arready_T @[ClHelloWorldCore.scala 99:17]
    node _s_axi_rvalid_T = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 100:32]
    s_axi_rvalid <= _s_axi_rvalid_T @[ClHelloWorldCore.scala 100:16]
    node _s_axi_rdata_T = eq(readAddrReg, UInt<32>("h0500")) @[ClHelloWorldCore.scala 101:34]
    node s_axi_rdata_right = bits(helloWorldReg, 15, 0) @[ClHelloWorldCore.scala 102:22]
    node s_axi_rdata_left = bits(helloWorldReg, 31, 16) @[ClHelloWorldCore.scala 102:44]
    node _s_axi_rdata_T_1 = cat(s_axi_rdata_right, s_axi_rdata_left) @[Cat.scala 29:58]
    node _s_axi_rdata_T_2 = cat(UInt<16>("h00"), vLedQ) @[Cat.scala 29:58]
    node _s_axi_rdata_T_3 = mux(_s_axi_rdata_T, _s_axi_rdata_T_1, _s_axi_rdata_T_2) @[ClHelloWorldCore.scala 101:21]
    s_axi_rdata <= _s_axi_rdata_T_3 @[ClHelloWorldCore.scala 101:15]
    s_axi_rresp <= UInt<2>("h00") @[ClHelloWorldCore.scala 104:15]
    node _s_axi_awready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 106:34]
    s_axi_awready <= _s_axi_awready_T @[ClHelloWorldCore.scala 106:17]
    node _s_axi_wready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorldCore.scala 107:33]
    s_axi_wready <= _s_axi_wready_T @[ClHelloWorldCore.scala 107:16]
    s_axi_bresp <= UInt<2>("h00") @[ClHelloWorldCore.scala 108:15]
    node _s_axi_bvalid_T = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorldCore.scala 109:33]
    s_axi_bvalid <= _s_axi_bvalid_T @[ClHelloWorldCore.scala 109:16]
    
