;buildInfoPackage: chisel3, version: 3.4.0, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit ClHelloWorld : 
  extmodule ResetSyncNeg : 
    input clock : UInt<1>
    input reset_n : UInt<1>
    output reset_sync_n : UInt<1>
    
    defname = ResetSyncNeg
    
    
  extmodule axi_register_slice_light : 
    input aclk : UInt<1>
    input aresetn : UInt<1>
    input s_axi_awaddr : UInt<32>
    input s_axi_awprot : UInt<3>
    input s_axi_awvalid : UInt<1>
    output s_axi_awready : UInt<1>
    input s_axi_wdata : UInt<32>
    input s_axi_wstrb : UInt<4>
    input s_axi_wvalid : UInt<1>
    output s_axi_wready : UInt<1>
    output s_axi_bresp : UInt<2>
    output s_axi_bvalid : UInt<1>
    input s_axi_bready : UInt<1>
    input s_axi_araddr : UInt<32>
    input s_axi_arprot : UInt<3>
    input s_axi_arvalid : UInt<1>
    output s_axi_arready : UInt<1>
    output s_axi_rdata : UInt<32>
    output s_axi_rresp : UInt<2>
    output s_axi_rvalid : UInt<1>
    input s_axi_rready : UInt<1>
    output m_axi_awaddr : UInt<32>
    output m_axi_awprot : UInt<3>
    output m_axi_awvalid : UInt<1>
    input m_axi_awready : UInt<1>
    output m_axi_wdata : UInt<32>
    output m_axi_wstrb : UInt<4>
    output m_axi_wvalid : UInt<1>
    input m_axi_wready : UInt<1>
    input m_axi_bresp : UInt<2>
    input m_axi_bvalid : UInt<1>
    output m_axi_bready : UInt<1>
    output m_axi_araddr : UInt<32>
    output m_axi_arprot : UInt<3>
    output m_axi_arvalid : UInt<1>
    input m_axi_arready : UInt<1>
    input m_axi_rdata : UInt<32>
    input m_axi_rresp : UInt<2>
    input m_axi_rvalid : UInt<1>
    output m_axi_rready : UInt<1>
    
    defname = axi_register_slice_light
    
    
  module ClHelloWorldCore : 
    input clock : Clock
    input reset : Reset
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
    
    reg readStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorld.scala 137:29]
    reg readAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 140:28]
    node _T = eq(readStateReg, UInt<2>("h00")) @[ClHelloWorld.scala 141:22]
    node _T_1 = and(_T, s_axi_arvalid) @[ClHelloWorld.scala 141:36]
    when _T_1 : @[ClHelloWorld.scala 141:54]
      readStateReg <= UInt<2>("h01") @[ClHelloWorld.scala 142:18]
      readAddrReg <= s_axi_araddr @[ClHelloWorld.scala 143:17]
      skip @[ClHelloWorld.scala 141:54]
    else : @[ClHelloWorld.scala 144:49]
      node _T_2 = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 144:29]
      when _T_2 : @[ClHelloWorld.scala 144:49]
        readStateReg <= UInt<2>("h02") @[ClHelloWorld.scala 145:18]
        skip @[ClHelloWorld.scala 144:49]
      else : @[ClHelloWorld.scala 146:65]
        node _T_3 = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 146:29]
        node _T_4 = and(_T_3, s_axi_rready) @[ClHelloWorld.scala 146:48]
        when _T_4 : @[ClHelloWorld.scala 146:65]
          readStateReg <= UInt<2>("h00") @[ClHelloWorld.scala 147:18]
          skip @[ClHelloWorld.scala 146:65]
    reg writeStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorld.scala 156:30]
    reg writeAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 159:29]
    reg helloWorldReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 160:30]
    node _T_5 = eq(writeStateReg, UInt<2>("h00")) @[ClHelloWorld.scala 161:23]
    node _T_6 = and(_T_5, s_axi_awvalid) @[ClHelloWorld.scala 161:38]
    node _T_7 = and(_T_6, s_axi_wvalid) @[ClHelloWorld.scala 161:55]
    when _T_7 : @[ClHelloWorld.scala 161:72]
      writeStateReg <= UInt<2>("h01") @[ClHelloWorld.scala 162:19]
      writeAddrReg <= s_axi_awaddr @[ClHelloWorld.scala 163:18]
      skip @[ClHelloWorld.scala 161:72]
    else : @[ClHelloWorld.scala 164:47]
      node _T_8 = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 164:30]
      when _T_8 : @[ClHelloWorld.scala 164:47]
        writeStateReg <= UInt<2>("h02") @[ClHelloWorld.scala 165:19]
        node _T_9 = eq(writeAddrReg, UInt<32>("h0500")) @[ClHelloWorld.scala 166:24]
        when _T_9 : @[ClHelloWorld.scala 166:50]
          helloWorldReg <= s_axi_wdata @[ClHelloWorld.scala 167:21]
          skip @[ClHelloWorld.scala 166:50]
        skip @[ClHelloWorld.scala 164:47]
      else : @[ClHelloWorld.scala 169:62]
        node _T_10 = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 169:30]
        node _T_11 = and(_T_10, s_axi_bready) @[ClHelloWorld.scala 169:45]
        when _T_11 : @[ClHelloWorld.scala 169:62]
          writeStateReg <= UInt<2>("h00") @[ClHelloWorld.scala 170:19]
          skip @[ClHelloWorld.scala 169:62]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 177:32]
    shClStatusVDipQ <= sh_cl_status_vdip @[ClHelloWorld.scala 177:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 178:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorld.scala 178:33]
    node _T_12 = bits(helloWorldReg, 15, 0) @[ClHelloWorld.scala 179:36]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 179:22]
    vLedQ <= _T_12 @[ClHelloWorld.scala 179:22]
    node _T_13 = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorld.scala 180:39]
    reg clSHStatusVLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 180:32]
    clSHStatusVLedQ <= _T_13 @[ClHelloWorld.scala 180:32]
    cl_sh_status_vled <= clSHStatusVLedQ @[ClHelloWorld.scala 181:21]
    node _s_axi_arready_T = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 184:33]
    s_axi_arready <= _s_axi_arready_T @[ClHelloWorld.scala 184:17]
    node _s_axi_rvalid_T = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 185:32]
    s_axi_rvalid <= _s_axi_rvalid_T @[ClHelloWorld.scala 185:16]
    node _s_axi_rdata_T = eq(readAddrReg, UInt<32>("h0500")) @[ClHelloWorld.scala 186:34]
    node s_axi_rdata_right = bits(helloWorldReg, 15, 0) @[ClHelloWorld.scala 187:22]
    node s_axi_rdata_left = bits(helloWorldReg, 31, 16) @[ClHelloWorld.scala 187:44]
    node _s_axi_rdata_T_1 = cat(s_axi_rdata_right, s_axi_rdata_left) @[Cat.scala 29:58]
    node _s_axi_rdata_T_2 = cat(UInt<16>("h00"), vLedQ) @[Cat.scala 29:58]
    node _s_axi_rdata_T_3 = mux(_s_axi_rdata_T, _s_axi_rdata_T_1, _s_axi_rdata_T_2) @[ClHelloWorld.scala 186:21]
    s_axi_rdata <= _s_axi_rdata_T_3 @[ClHelloWorld.scala 186:15]
    s_axi_rresp <= UInt<2>("h00") @[ClHelloWorld.scala 189:15]
    node _s_axi_awready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 191:34]
    s_axi_awready <= _s_axi_awready_T @[ClHelloWorld.scala 191:17]
    node _s_axi_wready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 192:33]
    s_axi_wready <= _s_axi_wready_T @[ClHelloWorld.scala 192:16]
    s_axi_bresp <= UInt<2>("h00") @[ClHelloWorld.scala 193:15]
    node _s_axi_bvalid_T = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 194:33]
    s_axi_bvalid <= _s_axi_bvalid_T @[ClHelloWorld.scala 194:16]
    
  module ClHelloWorld : 
    input clk_main_a0 : Clock
    input rst_main_n : UInt<1>
    input sh_ocl_awvalid : UInt<1>
    input sh_ocl_awaddr : UInt<32>
    output ocl_sh_awready : UInt<1>
    input sh_ocl_wvalid : UInt<1>
    input sh_ocl_wdata : UInt<32>
    input sh_ocl_wstrb : UInt<4>
    output ocl_sh_wready : UInt<1>
    output ocl_sh_bvalid : UInt<1>
    output ocl_sh_bresp : UInt<2>
    input sh_ocl_bready : UInt<1>
    input sh_ocl_arvalid : UInt<1>
    input sh_ocl_araddr : UInt<32>
    output ocl_sh_arready : UInt<1>
    output ocl_sh_rvalid : UInt<1>
    output ocl_sh_rdata : UInt<32>
    output ocl_sh_rresp : UInt<2>
    input sh_ocl_rready : UInt<1>
    input sh_cl_status_vdip : UInt<1>
    output cl_sh_status_vled : UInt<1>
    
    inst resetSyncNegModule of ResetSyncNeg @[ClHelloWorld.scala 34:34]
    resetSyncNegModule.reset_sync_n is invalid
    resetSyncNegModule.reset_n is invalid
    resetSyncNegModule.clock is invalid
    node _resetSyncNegModule_clock_T = asUInt(clk_main_a0) @[ClHelloWorld.scala 36:45]
    node _resetSyncNegModule_clock_T_1 = bits(_resetSyncNegModule_clock_T, 0, 0) @[ClHelloWorld.scala 36:45]
    resetSyncNegModule.clock <= _resetSyncNegModule_clock_T_1 @[ClHelloWorld.scala 36:24]
    resetSyncNegModule.reset_n <= rst_main_n @[ClHelloWorld.scala 37:26]
    inst axiRegisterSliceModule of axi_register_slice_light @[ClHelloWorld.scala 42:38]
    axiRegisterSliceModule.aclk is invalid
    axiRegisterSliceModule.aresetn is invalid
    axiRegisterSliceModule.s_axi_awaddr is invalid
    axiRegisterSliceModule.s_axi_awprot is invalid
    axiRegisterSliceModule.s_axi_awvalid is invalid
    axiRegisterSliceModule.s_axi_awready is invalid
    axiRegisterSliceModule.s_axi_wdata is invalid
    axiRegisterSliceModule.s_axi_wstrb is invalid
    axiRegisterSliceModule.s_axi_wvalid is invalid
    axiRegisterSliceModule.s_axi_wready is invalid
    axiRegisterSliceModule.s_axi_bresp is invalid
    axiRegisterSliceModule.s_axi_bvalid is invalid
    axiRegisterSliceModule.s_axi_bready is invalid
    axiRegisterSliceModule.s_axi_araddr is invalid
    axiRegisterSliceModule.s_axi_arprot is invalid
    axiRegisterSliceModule.s_axi_arvalid is invalid
    axiRegisterSliceModule.s_axi_arready is invalid
    axiRegisterSliceModule.s_axi_rdata is invalid
    axiRegisterSliceModule.s_axi_rresp is invalid
    axiRegisterSliceModule.s_axi_rvalid is invalid
    axiRegisterSliceModule.s_axi_rready is invalid
    axiRegisterSliceModule.m_axi_awaddr is invalid
    axiRegisterSliceModule.m_axi_awprot is invalid
    axiRegisterSliceModule.m_axi_awvalid is invalid
    axiRegisterSliceModule.m_axi_awready is invalid
    axiRegisterSliceModule.m_axi_wdata is invalid
    axiRegisterSliceModule.m_axi_wstrb is invalid
    axiRegisterSliceModule.m_axi_wvalid is invalid
    axiRegisterSliceModule.m_axi_wready is invalid
    axiRegisterSliceModule.m_axi_bresp is invalid
    axiRegisterSliceModule.m_axi_bvalid is invalid
    axiRegisterSliceModule.m_axi_bready is invalid
    axiRegisterSliceModule.m_axi_araddr is invalid
    axiRegisterSliceModule.m_axi_arprot is invalid
    axiRegisterSliceModule.m_axi_arvalid is invalid
    axiRegisterSliceModule.m_axi_arready is invalid
    axiRegisterSliceModule.m_axi_rdata is invalid
    axiRegisterSliceModule.m_axi_rresp is invalid
    axiRegisterSliceModule.m_axi_rvalid is invalid
    axiRegisterSliceModule.m_axi_rready is invalid
    node _axiRegisterSliceModule_aclk_T = asUInt(clk_main_a0) @[ClHelloWorld.scala 43:52]
    node _axiRegisterSliceModule_aclk_T_1 = bits(_axiRegisterSliceModule_aclk_T, 0, 0) @[ClHelloWorld.scala 43:52]
    axiRegisterSliceModule.aclk <= _axiRegisterSliceModule_aclk_T_1 @[ClHelloWorld.scala 43:31]
    axiRegisterSliceModule.aresetn <= resetSyncNegModule.reset_sync_n @[ClHelloWorld.scala 44:34]
    axiRegisterSliceModule.s_axi_awaddr <= sh_ocl_awaddr @[ClHelloWorld.scala 45:39]
    axiRegisterSliceModule.s_axi_awprot <= UInt<2>("h00") @[ClHelloWorld.scala 46:39]
    axiRegisterSliceModule.s_axi_awvalid <= sh_ocl_awvalid @[ClHelloWorld.scala 47:40]
    ocl_sh_awready <= axiRegisterSliceModule.s_axi_awready @[ClHelloWorld.scala 48:18]
    axiRegisterSliceModule.s_axi_wdata <= sh_ocl_wdata @[ClHelloWorld.scala 49:38]
    axiRegisterSliceModule.s_axi_wstrb <= sh_ocl_wstrb @[ClHelloWorld.scala 50:38]
    axiRegisterSliceModule.s_axi_wvalid <= sh_ocl_wvalid @[ClHelloWorld.scala 51:39]
    ocl_sh_wready <= axiRegisterSliceModule.s_axi_wready @[ClHelloWorld.scala 52:17]
    ocl_sh_bresp <= axiRegisterSliceModule.s_axi_bresp @[ClHelloWorld.scala 53:16]
    ocl_sh_bvalid <= axiRegisterSliceModule.s_axi_bvalid @[ClHelloWorld.scala 54:17]
    axiRegisterSliceModule.s_axi_bready <= sh_ocl_bready @[ClHelloWorld.scala 55:39]
    axiRegisterSliceModule.s_axi_araddr <= sh_ocl_araddr @[ClHelloWorld.scala 56:39]
    axiRegisterSliceModule.s_axi_arvalid <= sh_ocl_arvalid @[ClHelloWorld.scala 57:40]
    ocl_sh_arready <= axiRegisterSliceModule.s_axi_arready @[ClHelloWorld.scala 58:18]
    ocl_sh_rdata <= axiRegisterSliceModule.s_axi_rdata @[ClHelloWorld.scala 59:16]
    ocl_sh_rresp <= axiRegisterSliceModule.s_axi_rresp @[ClHelloWorld.scala 60:16]
    ocl_sh_rvalid <= axiRegisterSliceModule.s_axi_rvalid @[ClHelloWorld.scala 61:17]
    axiRegisterSliceModule.s_axi_rready <= sh_ocl_rready @[ClHelloWorld.scala 62:39]
    node _T = eq(resetSyncNegModule.reset_sync_n, UInt<1>("h00")) @[ClHelloWorld.scala 64:34]
    inst ClHelloWorldCore of ClHelloWorldCore @[ClHelloWorld.scala 65:40]
    ClHelloWorldCore.clock <= clk_main_a0
    ClHelloWorldCore.reset <= _T
    ClHelloWorldCore.s_axi_awvalid <= axiRegisterSliceModule.m_axi_awvalid @[ClHelloWorld.scala 66:42]
    ClHelloWorldCore.s_axi_awaddr <= axiRegisterSliceModule.m_axi_awaddr @[ClHelloWorld.scala 67:41]
    ClHelloWorldCore.s_axi_wvalid <= axiRegisterSliceModule.m_axi_wvalid @[ClHelloWorld.scala 68:41]
    ClHelloWorldCore.s_axi_wdata <= axiRegisterSliceModule.m_axi_wdata @[ClHelloWorld.scala 69:40]
    ClHelloWorldCore.s_axi_wstrb <= axiRegisterSliceModule.m_axi_wstrb @[ClHelloWorld.scala 70:40]
    ClHelloWorldCore.s_axi_bready <= axiRegisterSliceModule.m_axi_bready @[ClHelloWorld.scala 71:41]
    ClHelloWorldCore.s_axi_arvalid <= axiRegisterSliceModule.m_axi_arvalid @[ClHelloWorld.scala 72:42]
    ClHelloWorldCore.s_axi_araddr <= axiRegisterSliceModule.m_axi_araddr @[ClHelloWorld.scala 73:41]
    ClHelloWorldCore.s_axi_rready <= axiRegisterSliceModule.m_axi_rready @[ClHelloWorld.scala 74:41]
    axiRegisterSliceModule.m_axi_awready <= ClHelloWorldCore.s_axi_awready @[ClHelloWorld.scala 75:42]
    axiRegisterSliceModule.m_axi_wready <= ClHelloWorldCore.s_axi_wready @[ClHelloWorld.scala 76:41]
    axiRegisterSliceModule.m_axi_bvalid <= ClHelloWorldCore.s_axi_bvalid @[ClHelloWorld.scala 77:41]
    axiRegisterSliceModule.m_axi_bresp <= ClHelloWorldCore.s_axi_bresp @[ClHelloWorld.scala 78:40]
    axiRegisterSliceModule.m_axi_arready <= ClHelloWorldCore.s_axi_arready @[ClHelloWorld.scala 79:42]
    axiRegisterSliceModule.m_axi_rvalid <= ClHelloWorldCore.s_axi_rvalid @[ClHelloWorld.scala 80:41]
    axiRegisterSliceModule.m_axi_rdata <= ClHelloWorldCore.s_axi_rdata @[ClHelloWorld.scala 81:40]
    axiRegisterSliceModule.m_axi_rresp <= ClHelloWorldCore.s_axi_rresp @[ClHelloWorld.scala 82:40]
    ClHelloWorldCore.sh_cl_status_vdip <= sh_cl_status_vdip @[ClHelloWorld.scala 84:46]
    cl_sh_status_vled <= ClHelloWorldCore.cl_sh_status_vled @[ClHelloWorld.scala 85:23]
    
