;buildInfoPackage: chisel3, version: 3.4.0, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit cl_hello_world : 
  extmodule ResetSyncNeg : 
    input clock : UInt<1>
    input reset_n : UInt<1>
    output reset_sync_n : UInt<1>
    
    defname = ResetSyncNeg
    
    
  extmodule TieOffDdrABDBlackBox : 
    input clk_main_a0 : UInt<1>
    input rst_main_n_sync : UInt<1>
    input CLK_300M_DIMM0_DP : UInt<1>
    input CLK_300M_DIMM0_DN : UInt<1>
    output M_A_ACT_N : UInt<1>
    output M_A_MA : UInt<17>
    output M_A_BA : UInt<2>
    output M_A_BG : UInt<2>
    output M_A_CKE : UInt<1>
    output M_A_ODT : UInt<1>
    output M_A_CS_N : UInt<1>
    output M_A_CLK_DN : UInt<1>
    output M_A_CLK_DP : UInt<1>
    output M_A_PAR : UInt<1>
    output M_A_DQ : Analog<64>
    output M_A_ECC : Analog<8>
    output M_A_DQS_DP : Analog<18>
    output M_A_DQS_DN : Analog<18>
    output cl_RST_DIMM_A_N : UInt<1>
    input CLK_300M_DIMM1_DP : UInt<1>
    input CLK_300M_DIMM1_DN : UInt<1>
    output M_B_ACT_N : UInt<1>
    output M_B_MA : UInt<17>
    output M_B_BA : UInt<2>
    output M_B_BG : UInt<2>
    output M_B_CKE : UInt<1>
    output M_B_ODT : UInt<1>
    output M_B_CS_N : UInt<1>
    output M_B_CLK_DN : UInt<1>
    output M_B_CLK_DP : UInt<1>
    output M_B_PAR : UInt<1>
    output M_B_DQ : Analog<64>
    output M_B_ECC : Analog<8>
    output M_B_DQS_DP : Analog<18>
    output M_B_DQS_DN : Analog<18>
    output cl_RST_DIMM_B_N : UInt<1>
    input CLK_300M_DIMM3_DP : UInt<1>
    input CLK_300M_DIMM3_DN : UInt<1>
    output M_D_ACT_N : UInt<1>
    output M_D_MA : UInt<17>
    output M_D_BA : UInt<2>
    output M_D_BG : UInt<2>
    output M_D_CKE : UInt<1>
    output M_D_ODT : UInt<1>
    output M_D_CS_N : UInt<1>
    output M_D_CLK_DN : UInt<1>
    output M_D_CLK_DP : UInt<1>
    output M_D_PAR : UInt<1>
    output M_D_DQ : Analog<64>
    output M_D_ECC : Analog<8>
    output M_D_DQS_DP : Analog<18>
    output M_D_DQS_DN : Analog<18>
    output cl_RST_DIMM_D_N : UInt<1>
    
    defname = TieOffDdrABDBlackBox
    
    
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
    
    reg readStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorld.scala 136:29]
    reg readAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 139:28]
    node _T = eq(readStateReg, UInt<2>("h00")) @[ClHelloWorld.scala 140:22]
    node _T_1 = and(_T, s_axi_arvalid) @[ClHelloWorld.scala 140:36]
    when _T_1 : @[ClHelloWorld.scala 140:54]
      readStateReg <= UInt<2>("h01") @[ClHelloWorld.scala 141:18]
      readAddrReg <= s_axi_araddr @[ClHelloWorld.scala 142:17]
      skip @[ClHelloWorld.scala 140:54]
    else : @[ClHelloWorld.scala 143:49]
      node _T_2 = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 143:29]
      when _T_2 : @[ClHelloWorld.scala 143:49]
        readStateReg <= UInt<2>("h02") @[ClHelloWorld.scala 144:18]
        skip @[ClHelloWorld.scala 143:49]
      else : @[ClHelloWorld.scala 145:65]
        node _T_3 = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 145:29]
        node _T_4 = and(_T_3, s_axi_rready) @[ClHelloWorld.scala 145:48]
        when _T_4 : @[ClHelloWorld.scala 145:65]
          readStateReg <= UInt<2>("h00") @[ClHelloWorld.scala 146:18]
          skip @[ClHelloWorld.scala 145:65]
    reg writeStateReg : UInt<2>, clock with : (reset => (reset, UInt<2>("h00"))) @[ClHelloWorld.scala 155:30]
    reg writeAddrReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 158:29]
    reg helloWorldReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[ClHelloWorld.scala 159:30]
    node _T_5 = eq(writeStateReg, UInt<2>("h00")) @[ClHelloWorld.scala 160:23]
    node _T_6 = and(_T_5, s_axi_awvalid) @[ClHelloWorld.scala 160:38]
    node _T_7 = and(_T_6, s_axi_wvalid) @[ClHelloWorld.scala 160:55]
    when _T_7 : @[ClHelloWorld.scala 160:72]
      writeStateReg <= UInt<2>("h01") @[ClHelloWorld.scala 161:19]
      writeAddrReg <= s_axi_awaddr @[ClHelloWorld.scala 162:18]
      skip @[ClHelloWorld.scala 160:72]
    else : @[ClHelloWorld.scala 163:47]
      node _T_8 = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 163:30]
      when _T_8 : @[ClHelloWorld.scala 163:47]
        writeStateReg <= UInt<2>("h02") @[ClHelloWorld.scala 164:19]
        node _T_9 = eq(writeAddrReg, UInt<32>("h0500")) @[ClHelloWorld.scala 165:24]
        when _T_9 : @[ClHelloWorld.scala 165:50]
          helloWorldReg <= s_axi_wdata @[ClHelloWorld.scala 166:21]
          skip @[ClHelloWorld.scala 165:50]
        skip @[ClHelloWorld.scala 163:47]
      else : @[ClHelloWorld.scala 168:62]
        node _T_10 = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 168:30]
        node _T_11 = and(_T_10, s_axi_bready) @[ClHelloWorld.scala 168:45]
        when _T_11 : @[ClHelloWorld.scala 168:62]
          writeStateReg <= UInt<2>("h00") @[ClHelloWorld.scala 169:19]
          skip @[ClHelloWorld.scala 168:62]
    reg shClStatusVDipQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 176:32]
    shClStatusVDipQ <= sh_cl_status_vdip @[ClHelloWorld.scala 176:32]
    reg shClStatusVDipQ2 : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 177:33]
    shClStatusVDipQ2 <= shClStatusVDipQ @[ClHelloWorld.scala 177:33]
    node _T_12 = bits(helloWorldReg, 15, 0) @[ClHelloWorld.scala 178:36]
    reg vLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 178:22]
    vLedQ <= _T_12 @[ClHelloWorld.scala 178:22]
    node _T_13 = and(vLedQ, shClStatusVDipQ2) @[ClHelloWorld.scala 179:39]
    reg clSHStatusVLedQ : UInt, clock with : (reset => (reset, UInt<16>("h00"))) @[ClHelloWorld.scala 179:32]
    clSHStatusVLedQ <= _T_13 @[ClHelloWorld.scala 179:32]
    cl_sh_status_vled <= clSHStatusVLedQ @[ClHelloWorld.scala 180:21]
    node _s_axi_arready_T = eq(readStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 183:33]
    s_axi_arready <= _s_axi_arready_T @[ClHelloWorld.scala 183:17]
    node _s_axi_rvalid_T = eq(readStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 184:32]
    s_axi_rvalid <= _s_axi_rvalid_T @[ClHelloWorld.scala 184:16]
    node _s_axi_rdata_T = eq(readAddrReg, UInt<32>("h0500")) @[ClHelloWorld.scala 185:34]
    node s_axi_rdata_right = bits(helloWorldReg, 15, 0) @[ClHelloWorld.scala 186:22]
    node s_axi_rdata_left = bits(helloWorldReg, 31, 16) @[ClHelloWorld.scala 186:44]
    node _s_axi_rdata_T_1 = cat(s_axi_rdata_right, s_axi_rdata_left) @[Cat.scala 29:58]
    node _s_axi_rdata_T_2 = cat(UInt<16>("h00"), vLedQ) @[Cat.scala 29:58]
    node _s_axi_rdata_T_3 = mux(_s_axi_rdata_T, _s_axi_rdata_T_1, _s_axi_rdata_T_2) @[ClHelloWorld.scala 185:21]
    s_axi_rdata <= _s_axi_rdata_T_3 @[ClHelloWorld.scala 185:15]
    s_axi_rresp <= UInt<2>("h00") @[ClHelloWorld.scala 188:15]
    node _s_axi_awready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 190:34]
    s_axi_awready <= _s_axi_awready_T @[ClHelloWorld.scala 190:17]
    node _s_axi_wready_T = eq(writeStateReg, UInt<2>("h01")) @[ClHelloWorld.scala 191:33]
    s_axi_wready <= _s_axi_wready_T @[ClHelloWorld.scala 191:16]
    s_axi_bresp <= UInt<2>("h00") @[ClHelloWorld.scala 192:15]
    node _s_axi_bvalid_T = eq(writeStateReg, UInt<2>("h02")) @[ClHelloWorld.scala 193:33]
    s_axi_bvalid <= _s_axi_bvalid_T @[ClHelloWorld.scala 193:16]
    
  module cl_hello_world : 
    input clk_main_a0 : UInt<1>
    input clk_extra_a1 : UInt<1>
    input clk_extra_a2 : UInt<1>
    input clk_extra_a3 : UInt<1>
    input clk_extra_b0 : UInt<1>
    input clk_extra_b1 : UInt<1>
    input clk_extra_c0 : UInt<1>
    input clk_extra_c1 : UInt<1>
    input kernel_rst_n : UInt<1>
    input rst_main_n : UInt<1>
    input sh_cl_flr_assert : UInt<1>
    output cl_sh_flr_done : UInt<1>
    output cl_sh_status0 : UInt<32>
    output cl_sh_status1 : UInt<32>
    output cl_sh_id0 : UInt<32>
    output cl_sh_id1 : UInt<32>
    input sh_cl_ctl0 : UInt<32>
    input sh_cl_ctl1 : UInt<32>
    input sh_cl_status_vdip : UInt<16>
    output cl_sh_status_vled : UInt<16>
    input sh_cl_pwr_state : UInt<2>
    output cl_sh_dma_wr_full : UInt<1>
    output cl_sh_dma_rd_full : UInt<1>
    output cl_sh_pcim_awid : UInt<16>
    output cl_sh_pcim_awaddr : UInt<64>
    output cl_sh_pcim_awlen : UInt<8>
    output cl_sh_pcim_awsize : UInt<3>
    output cl_sh_pcim_awuser : UInt<18>
    output cl_sh_pcim_awvalid : UInt<1>
    input sh_cl_pcim_awready : UInt<1>
    output cl_sh_pcim_wdata : UInt<512>
    output cl_sh_pcim_wstrb : UInt<64>
    output cl_sh_pcim_wlast : UInt<1>
    output cl_sh_pcim_wvalid : UInt<1>
    input sh_cl_pcim_wready : UInt<1>
    input sh_cl_pcim_bid : UInt<16>
    input sh_cl_pcim_bresp : UInt<2>
    input sh_cl_pcim_bvalid : UInt<1>
    output cl_sh_pcim_bready : UInt<1>
    output cl_sh_pcim_arid : UInt<16>
    output cl_sh_pcim_araddr : UInt<64>
    output cl_sh_pcim_arlen : UInt<8>
    output cl_sh_pcim_arsize : UInt<3>
    output cl_sh_pcim_aruser : UInt<19>
    output cl_sh_pcim_arvalid : UInt<1>
    input sh_cl_pcim_arready : UInt<1>
    input sh_cl_pcim_rid : UInt<16>
    input sh_cl_pcim_rdata : UInt<512>
    input sh_cl_pcim_rresp : UInt<2>
    input sh_cl_pcim_rlast : UInt<1>
    input sh_cl_pcim_rvalid : UInt<1>
    output cl_sh_pcim_rready : UInt<1>
    input cfg_max_payload : UInt<2>
    input cfg_max_read_req : UInt<3>
    input CLK_300M_DIMM0_DP : UInt<1>
    input CLK_300M_DIMM0_DN : UInt<1>
    output M_A_ACT_N : UInt<1>
    output M_A_MA : UInt<16>
    output M_A_BA : UInt<2>
    output M_A_BG : UInt<2>
    output M_A_CKE : UInt<1>
    output M_A_ODT : UInt<1>
    output M_A_CS_N : UInt<1>
    output M_A_CLK_DN : UInt<1>
    output M_A_CLK_DP : UInt<1>
    output M_A_PAR : UInt<1>
    output M_A_DQ : Analog<64>
    output M_A_ECC : Analog<8>
    output M_A_DQS_DP : Analog<18>
    output M_A_DQS_DN : Analog<18>
    output cl_RST_DIMM_A_N : UInt<1>
    input CLK_300M_DIMM1_DP : UInt<1>
    input CLK_300M_DIMM1_DN : UInt<1>
    output M_B_ACT_N : UInt<1>
    output M_B_MA : UInt<16>
    output M_B_BA : UInt<2>
    output M_B_BG : UInt<2>
    output M_B_CKE : UInt<1>
    output M_B_ODT : UInt<1>
    output M_B_CS_N : UInt<1>
    output M_B_CLK_DN : UInt<1>
    output M_B_CLK_DP : UInt<1>
    output M_B_PAR : UInt<1>
    output M_B_DQ : Analog<64>
    output M_B_ECC : Analog<8>
    output M_B_DQS_DP : Analog<18>
    output M_B_DQS_DN : Analog<18>
    output cl_RST_DIMM_B_N : UInt<1>
    input CLK_300M_DIMM3_DP : UInt<1>
    input CLK_300M_DIMM3_DN : UInt<1>
    output M_D_ACT_N : UInt<1>
    output M_D_MA : UInt<16>
    output M_D_BA : UInt<2>
    output M_D_BG : UInt<2>
    output M_D_CKE : UInt<1>
    output M_D_ODT : UInt<1>
    output M_D_CS_N : UInt<1>
    output M_D_CLK_DN : UInt<1>
    output M_D_CLK_DP : UInt<1>
    output M_D_PAR : UInt<1>
    output M_D_DQ : Analog<64>
    output M_D_ECC : Analog<8>
    output M_D_DQS_DP : Analog<18>
    output M_D_DQS_DN : Analog<18>
    output cl_RST_DIMM_D_N : UInt<1>
    input sh_ddr_stat_addr0 : UInt<8>
    input sh_ddr_stat_wr0 : UInt<1>
    input sh_ddr_stat_rd0 : UInt<1>
    input sh_ddr_stat_wdata0 : UInt<32>
    output ddr_sh_stat_ack0 : UInt<1>
    output ddr_sh_stat_rdata0 : UInt<32>
    output ddr_sh_stat_int0 : UInt<8>
    input sh_ddr_stat_addr1 : UInt<8>
    input sh_ddr_stat_wr1 : UInt<1>
    input sh_ddr_stat_rd1 : UInt<1>
    input sh_ddr_stat_wdata1 : UInt<32>
    output ddr_sh_stat_ack1 : UInt<1>
    output ddr_sh_stat_rdata1 : UInt<32>
    output ddr_sh_stat_int1 : UInt<8>
    input sh_ddr_stat_addr2 : UInt<8>
    input sh_ddr_stat_wr2 : UInt<1>
    input sh_ddr_stat_rd2 : UInt<1>
    input sh_ddr_stat_wdata2 : UInt<32>
    output ddr_sh_stat_ack2 : UInt<1>
    output ddr_sh_stat_rdata2 : UInt<32>
    output ddr_sh_stat_int2 : UInt<8>
    output cl_sh_ddr_awid : UInt<16>
    output cl_sh_ddr_awaddr : UInt<64>
    output cl_sh_ddr_awlen : UInt<8>
    output cl_sh_ddr_awsize : UInt<3>
    output cl_sh_ddr_awburst : UInt<2>
    output cl_sh_ddr_awvalid : UInt<1>
    input sh_cl_ddr_awready : UInt<1>
    output cl_sh_ddr_wid : UInt<16>
    output cl_sh_ddr_wdata : UInt<512>
    output cl_sh_ddr_wstrb : UInt<64>
    output cl_sh_ddr_wlast : UInt<1>
    output cl_sh_ddr_wvalid : UInt<1>
    input sh_cl_ddr_wready : UInt<1>
    input sh_cl_ddr_bid : UInt<16>
    input sh_cl_ddr_bresp : UInt<2>
    input sh_cl_ddr_bvalid : UInt<1>
    output cl_sh_ddr_bready : UInt<1>
    output cl_sh_ddr_arid : UInt<16>
    output cl_sh_ddr_araddr : UInt<64>
    output cl_sh_ddr_arlen : UInt<8>
    output cl_sh_ddr_arsize : UInt<3>
    output cl_sh_ddr_arburst : UInt<2>
    output cl_sh_ddr_arvalid : UInt<1>
    input sh_cl_ddr_arready : UInt<1>
    input sh_cl_ddr_rid : UInt<16>
    input sh_cl_ddr_rdata : UInt<512>
    input sh_cl_ddr_rresp : UInt<2>
    input sh_cl_ddr_rlast : UInt<1>
    input sh_cl_ddr_rvalid : UInt<1>
    output cl_sh_ddr_rready : UInt<1>
    input sh_cl_ddr_is_ready : UInt<1>
    output cl_sh_apppf_irq_req : UInt<16>
    input sh_cl_apppf_irq_ack : UInt<16>
    input sh_cl_dma_pcis_awid : UInt<6>
    input sh_cl_dma_pcis_awaddr : UInt<64>
    input sh_cl_dma_pcis_awlen : UInt<8>
    input sh_cl_dma_pcis_awsize : UInt<3>
    input sh_cl_dma_pcis_awvalid : UInt<1>
    output cl_sh_dma_pcis_awready : UInt<1>
    input sh_cl_dma_pcis_wdata : UInt<512>
    input sh_cl_dma_pcis_wstrb : UInt<64>
    input sh_cl_dma_pcis_wlast : UInt<1>
    input sh_cl_dma_pcis_wvalid : UInt<1>
    output cl_sh_dma_pcis_wready : UInt<1>
    output cl_sh_dma_pcis_bid : UInt<6>
    output cl_sh_dma_pcis_bresp : UInt<2>
    output cl_sh_dma_pcis_bvalid : UInt<1>
    input sh_cl_dma_pcis_bready : UInt<1>
    input sh_cl_dma_pcis_arid : UInt<6>
    input sh_cl_dma_pcis_araddr : UInt<64>
    input sh_cl_dma_pcis_arlen : UInt<8>
    input sh_cl_dma_pcis_arsize : UInt<3>
    input sh_cl_dma_pcis_arvalid : UInt<1>
    output cl_sh_dma_pcis_arready : UInt<1>
    output cl_sh_dma_pcis_rid : UInt<6>
    output cl_sh_dma_pcis_rdata : UInt<511>
    output cl_sh_dma_pcis_rresp : UInt<2>
    output cl_sh_dma_pcis_rlast : UInt<1>
    output cl_sh_dma_pcis_rvalid : UInt<1>
    input sh_cl_dma_pcis_rready : UInt<1>
    input sda_cl_awvalid : UInt<1>
    input sda_cl_awaddr : UInt<32>
    output cl_sda_awready : UInt<1>
    input sda_cl_wvalid : UInt<1>
    input sda_cl_wdata : UInt<32>
    input sda_cl_wstrb : UInt<4>
    output cl_sda_wready : UInt<1>
    output cl_sda_bvalid : UInt<1>
    output cl_sda_bresp : UInt<2>
    input sda_cl_bready : UInt<1>
    input sda_cl_arvalid : UInt<1>
    input sda_cl_araddr : UInt<32>
    output cl_sda_arready : UInt<1>
    output cl_sda_rvalid : UInt<1>
    output cl_sda_rdata : UInt<32>
    output cl_sda_rresp : UInt<2>
    input sda_cl_rready : UInt<1>
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
    input sh_bar1_awvalid : UInt<1>
    input sh_bar1_awaddr : UInt<32>
    output bar1_sh_awready : UInt<1>
    input sh_bar1_wvalid : UInt<1>
    input sh_bar1_wdata : UInt<32>
    input sh_bar1_wstrb : UInt<3>
    output bar1_sh_wready : UInt<1>
    output bar1_sh_bvalid : UInt<1>
    output bar1_sh_bresp : UInt<2>
    input sh_bar1_bready : UInt<1>
    input sh_bar1_arvalid : UInt<1>
    input sh_bar1_araddr : UInt<32>
    output bar1_sh_arready : UInt<1>
    output bar1_sh_rvalid : UInt<1>
    output bar1_sh_rdata : UInt<32>
    output bar1_sh_rresp : UInt<2>
    input sh_bar1_rready : UInt<1>
    input drck : UInt<1>
    input shift : UInt<1>
    input tdi : UInt<1>
    input update : UInt<1>
    input sel : UInt<1>
    output tdo : UInt<1>
    input tms : UInt<1>
    input tck : UInt<1>
    input runtest : UInt<1>
    input reset : UInt<1>
    input capture : UInt<1>
    input bscanid_en : UInt<1>
    input sh_cl_glcount0 : UInt<64>
    input sh_cl_glcount1 : UInt<64>
    
    inst resetSyncNegModule of ResetSyncNeg @[AwsEc2F1Cl.scala 264:34]
    resetSyncNegModule.reset_sync_n is invalid
    resetSyncNegModule.reset_n is invalid
    resetSyncNegModule.clock is invalid
    resetSyncNegModule.clock <= clk_main_a0 @[AwsEc2F1Cl.scala 266:24]
    resetSyncNegModule.reset_n <= rst_main_n @[AwsEc2F1Cl.scala 267:26]
    cl_sh_flr_done <= UInt<1>("h00") @[AwsEc2F1Cl.scala 704:20]
    inst TieOffDdrABDBlackBox of TieOffDdrABDBlackBox @[AwsEc2F1Cl.scala 580:38]
    TieOffDdrABDBlackBox.cl_RST_DIMM_D_N is invalid
    TieOffDdrABDBlackBox.M_D_DQS_DN is invalid
    TieOffDdrABDBlackBox.M_D_DQS_DP is invalid
    TieOffDdrABDBlackBox.M_D_ECC is invalid
    TieOffDdrABDBlackBox.M_D_DQ is invalid
    TieOffDdrABDBlackBox.M_D_PAR is invalid
    TieOffDdrABDBlackBox.M_D_CLK_DP is invalid
    TieOffDdrABDBlackBox.M_D_CLK_DN is invalid
    TieOffDdrABDBlackBox.M_D_CS_N is invalid
    TieOffDdrABDBlackBox.M_D_ODT is invalid
    TieOffDdrABDBlackBox.M_D_CKE is invalid
    TieOffDdrABDBlackBox.M_D_BG is invalid
    TieOffDdrABDBlackBox.M_D_BA is invalid
    TieOffDdrABDBlackBox.M_D_MA is invalid
    TieOffDdrABDBlackBox.M_D_ACT_N is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM3_DN is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM3_DP is invalid
    TieOffDdrABDBlackBox.cl_RST_DIMM_B_N is invalid
    TieOffDdrABDBlackBox.M_B_DQS_DN is invalid
    TieOffDdrABDBlackBox.M_B_DQS_DP is invalid
    TieOffDdrABDBlackBox.M_B_ECC is invalid
    TieOffDdrABDBlackBox.M_B_DQ is invalid
    TieOffDdrABDBlackBox.M_B_PAR is invalid
    TieOffDdrABDBlackBox.M_B_CLK_DP is invalid
    TieOffDdrABDBlackBox.M_B_CLK_DN is invalid
    TieOffDdrABDBlackBox.M_B_CS_N is invalid
    TieOffDdrABDBlackBox.M_B_ODT is invalid
    TieOffDdrABDBlackBox.M_B_CKE is invalid
    TieOffDdrABDBlackBox.M_B_BG is invalid
    TieOffDdrABDBlackBox.M_B_BA is invalid
    TieOffDdrABDBlackBox.M_B_MA is invalid
    TieOffDdrABDBlackBox.M_B_ACT_N is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM1_DN is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM1_DP is invalid
    TieOffDdrABDBlackBox.cl_RST_DIMM_A_N is invalid
    TieOffDdrABDBlackBox.M_A_DQS_DN is invalid
    TieOffDdrABDBlackBox.M_A_DQS_DP is invalid
    TieOffDdrABDBlackBox.M_A_ECC is invalid
    TieOffDdrABDBlackBox.M_A_DQ is invalid
    TieOffDdrABDBlackBox.M_A_PAR is invalid
    TieOffDdrABDBlackBox.M_A_CLK_DP is invalid
    TieOffDdrABDBlackBox.M_A_CLK_DN is invalid
    TieOffDdrABDBlackBox.M_A_CS_N is invalid
    TieOffDdrABDBlackBox.M_A_ODT is invalid
    TieOffDdrABDBlackBox.M_A_CKE is invalid
    TieOffDdrABDBlackBox.M_A_BG is invalid
    TieOffDdrABDBlackBox.M_A_BA is invalid
    TieOffDdrABDBlackBox.M_A_MA is invalid
    TieOffDdrABDBlackBox.M_A_ACT_N is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM0_DN is invalid
    TieOffDdrABDBlackBox.CLK_300M_DIMM0_DP is invalid
    TieOffDdrABDBlackBox.rst_main_n_sync is invalid
    TieOffDdrABDBlackBox.clk_main_a0 is invalid
    TieOffDdrABDBlackBox.clk_main_a0 <= clk_main_a0 @[AwsEc2F1Cl.scala 582:26]
    TieOffDdrABDBlackBox.rst_main_n_sync <= resetSyncNegModule.reset_sync_n @[AwsEc2F1Cl.scala 583:30]
    TieOffDdrABDBlackBox.CLK_300M_DIMM0_DP <= CLK_300M_DIMM0_DP @[AwsEc2F1Cl.scala 584:32]
    TieOffDdrABDBlackBox.CLK_300M_DIMM0_DN <= CLK_300M_DIMM0_DN @[AwsEc2F1Cl.scala 585:32]
    M_A_ACT_N <= TieOffDdrABDBlackBox.M_A_ACT_N @[AwsEc2F1Cl.scala 586:24]
    M_A_MA <= TieOffDdrABDBlackBox.M_A_MA @[AwsEc2F1Cl.scala 587:21]
    M_A_BA <= TieOffDdrABDBlackBox.M_A_BA @[AwsEc2F1Cl.scala 588:21]
    M_A_BG <= TieOffDdrABDBlackBox.M_A_BG @[AwsEc2F1Cl.scala 589:21]
    M_A_CKE <= TieOffDdrABDBlackBox.M_A_CKE @[AwsEc2F1Cl.scala 590:22]
    M_A_ODT <= TieOffDdrABDBlackBox.M_A_ODT @[AwsEc2F1Cl.scala 591:22]
    M_A_CS_N <= TieOffDdrABDBlackBox.M_A_CS_N @[AwsEc2F1Cl.scala 592:23]
    M_A_CLK_DN <= TieOffDdrABDBlackBox.M_A_CLK_DN @[AwsEc2F1Cl.scala 593:25]
    M_A_CLK_DP <= TieOffDdrABDBlackBox.M_A_CLK_DP @[AwsEc2F1Cl.scala 594:25]
    M_A_PAR <= TieOffDdrABDBlackBox.M_A_PAR @[AwsEc2F1Cl.scala 595:22]
    attach (TieOffDdrABDBlackBox.M_A_DQ, M_A_DQ) @[AwsEc2F1Cl.scala 596:21]
    attach (TieOffDdrABDBlackBox.M_A_ECC, M_A_ECC) @[AwsEc2F1Cl.scala 597:22]
    attach (TieOffDdrABDBlackBox.M_A_DQS_DP, M_A_DQS_DP) @[AwsEc2F1Cl.scala 598:25]
    attach (TieOffDdrABDBlackBox.M_A_DQS_DN, M_A_DQS_DN) @[AwsEc2F1Cl.scala 599:25]
    cl_RST_DIMM_A_N <= TieOffDdrABDBlackBox.cl_RST_DIMM_A_N @[AwsEc2F1Cl.scala 600:30]
    TieOffDdrABDBlackBox.CLK_300M_DIMM1_DP <= CLK_300M_DIMM1_DP @[AwsEc2F1Cl.scala 601:32]
    TieOffDdrABDBlackBox.CLK_300M_DIMM1_DN <= CLK_300M_DIMM1_DN @[AwsEc2F1Cl.scala 602:32]
    M_B_ACT_N <= TieOffDdrABDBlackBox.M_B_ACT_N @[AwsEc2F1Cl.scala 603:24]
    M_B_MA <= TieOffDdrABDBlackBox.M_B_MA @[AwsEc2F1Cl.scala 604:21]
    M_B_BA <= TieOffDdrABDBlackBox.M_B_BA @[AwsEc2F1Cl.scala 605:21]
    M_B_BG <= TieOffDdrABDBlackBox.M_B_BG @[AwsEc2F1Cl.scala 606:21]
    M_B_CKE <= TieOffDdrABDBlackBox.M_B_CKE @[AwsEc2F1Cl.scala 607:22]
    M_B_ODT <= TieOffDdrABDBlackBox.M_B_ODT @[AwsEc2F1Cl.scala 608:22]
    M_B_CS_N <= TieOffDdrABDBlackBox.M_B_CS_N @[AwsEc2F1Cl.scala 609:23]
    M_B_CLK_DN <= TieOffDdrABDBlackBox.M_B_CLK_DN @[AwsEc2F1Cl.scala 610:25]
    M_B_CLK_DP <= TieOffDdrABDBlackBox.M_B_CLK_DP @[AwsEc2F1Cl.scala 611:25]
    M_B_PAR <= TieOffDdrABDBlackBox.M_B_PAR @[AwsEc2F1Cl.scala 612:22]
    attach (TieOffDdrABDBlackBox.M_B_DQ, M_B_DQ) @[AwsEc2F1Cl.scala 613:21]
    attach (TieOffDdrABDBlackBox.M_B_ECC, M_B_ECC) @[AwsEc2F1Cl.scala 614:22]
    attach (TieOffDdrABDBlackBox.M_B_DQS_DP, M_B_DQS_DP) @[AwsEc2F1Cl.scala 615:25]
    attach (TieOffDdrABDBlackBox.M_B_DQS_DN, M_B_DQS_DN) @[AwsEc2F1Cl.scala 616:25]
    cl_RST_DIMM_B_N <= TieOffDdrABDBlackBox.cl_RST_DIMM_B_N @[AwsEc2F1Cl.scala 617:30]
    TieOffDdrABDBlackBox.CLK_300M_DIMM3_DP <= CLK_300M_DIMM3_DP @[AwsEc2F1Cl.scala 618:32]
    TieOffDdrABDBlackBox.CLK_300M_DIMM3_DN <= CLK_300M_DIMM3_DN @[AwsEc2F1Cl.scala 619:32]
    M_D_ACT_N <= TieOffDdrABDBlackBox.M_D_ACT_N @[AwsEc2F1Cl.scala 620:24]
    M_D_MA <= TieOffDdrABDBlackBox.M_D_MA @[AwsEc2F1Cl.scala 621:21]
    M_D_BA <= TieOffDdrABDBlackBox.M_D_BA @[AwsEc2F1Cl.scala 622:21]
    M_D_BG <= TieOffDdrABDBlackBox.M_D_BG @[AwsEc2F1Cl.scala 623:21]
    M_D_CKE <= TieOffDdrABDBlackBox.M_D_CKE @[AwsEc2F1Cl.scala 624:22]
    M_D_ODT <= TieOffDdrABDBlackBox.M_D_ODT @[AwsEc2F1Cl.scala 625:22]
    M_D_CS_N <= TieOffDdrABDBlackBox.M_D_CS_N @[AwsEc2F1Cl.scala 626:23]
    M_D_CLK_DN <= TieOffDdrABDBlackBox.M_D_CLK_DN @[AwsEc2F1Cl.scala 627:25]
    M_D_CLK_DP <= TieOffDdrABDBlackBox.M_D_CLK_DP @[AwsEc2F1Cl.scala 628:25]
    M_D_PAR <= TieOffDdrABDBlackBox.M_D_PAR @[AwsEc2F1Cl.scala 629:22]
    attach (TieOffDdrABDBlackBox.M_D_DQ, M_D_DQ) @[AwsEc2F1Cl.scala 630:21]
    attach (TieOffDdrABDBlackBox.M_D_ECC, M_D_ECC) @[AwsEc2F1Cl.scala 631:22]
    attach (TieOffDdrABDBlackBox.M_D_DQS_DP, M_D_DQS_DP) @[AwsEc2F1Cl.scala 632:25]
    attach (TieOffDdrABDBlackBox.M_D_DQS_DN, M_D_DQS_DN) @[AwsEc2F1Cl.scala 633:25]
    cl_RST_DIMM_D_N <= TieOffDdrABDBlackBox.cl_RST_DIMM_D_N @[AwsEc2F1Cl.scala 634:30]
    ddr_sh_stat_ack0 <= UInt<1>("h01") @[AwsEc2F1Cl.scala 636:22]
    ddr_sh_stat_rdata0 <= UInt<32>("h00") @[AwsEc2F1Cl.scala 637:24]
    ddr_sh_stat_int0 <= UInt<8>("h00") @[AwsEc2F1Cl.scala 638:22]
    ddr_sh_stat_ack1 <= UInt<1>("h01") @[AwsEc2F1Cl.scala 639:22]
    ddr_sh_stat_rdata1 <= UInt<32>("h00") @[AwsEc2F1Cl.scala 640:24]
    ddr_sh_stat_int1 <= UInt<8>("h00") @[AwsEc2F1Cl.scala 641:22]
    ddr_sh_stat_ack2 <= UInt<1>("h01") @[AwsEc2F1Cl.scala 642:22]
    ddr_sh_stat_rdata2 <= UInt<32>("h00") @[AwsEc2F1Cl.scala 643:24]
    ddr_sh_stat_int2 <= UInt<8>("h00") @[AwsEc2F1Cl.scala 644:22]
    cl_sh_ddr_awid <= UInt<16>("h00") @[AwsEc2F1Cl.scala 655:20]
    cl_sh_ddr_awaddr <= UInt<64>("h00") @[AwsEc2F1Cl.scala 656:22]
    cl_sh_ddr_awlen <= UInt<8>("h00") @[AwsEc2F1Cl.scala 657:21]
    cl_sh_ddr_awsize <= UInt<3>("h00") @[AwsEc2F1Cl.scala 658:22]
    cl_sh_ddr_awvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 659:23]
    cl_sh_ddr_awburst <= UInt<2>("h00") @[AwsEc2F1Cl.scala 660:23]
    cl_sh_ddr_wid <= UInt<16>("h00") @[AwsEc2F1Cl.scala 661:19]
    cl_sh_ddr_wdata <= UInt<512>("h00") @[AwsEc2F1Cl.scala 662:21]
    cl_sh_ddr_wstrb <= UInt<64>("h00") @[AwsEc2F1Cl.scala 663:21]
    cl_sh_ddr_wlast <= UInt<1>("h00") @[AwsEc2F1Cl.scala 664:21]
    cl_sh_ddr_wvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 665:22]
    cl_sh_ddr_bready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 666:22]
    cl_sh_ddr_arid <= UInt<16>("h00") @[AwsEc2F1Cl.scala 667:20]
    cl_sh_ddr_araddr <= UInt<64>("h00") @[AwsEc2F1Cl.scala 668:22]
    cl_sh_ddr_arlen <= UInt<8>("h00") @[AwsEc2F1Cl.scala 669:21]
    cl_sh_ddr_arsize <= UInt<3>("h00") @[AwsEc2F1Cl.scala 670:22]
    cl_sh_ddr_arvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 671:23]
    cl_sh_ddr_arburst <= UInt<2>("h00") @[AwsEc2F1Cl.scala 672:23]
    cl_sh_ddr_rready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 673:22]
    cl_sh_pcim_awid <= UInt<16>("h00") @[AwsEc2F1Cl.scala 715:21]
    cl_sh_pcim_awaddr <= UInt<64>("h00") @[AwsEc2F1Cl.scala 716:23]
    cl_sh_pcim_awlen <= UInt<8>("h00") @[AwsEc2F1Cl.scala 717:22]
    cl_sh_pcim_awsize <= UInt<3>("h00") @[AwsEc2F1Cl.scala 718:23]
    cl_sh_pcim_awuser <= UInt<19>("h00") @[AwsEc2F1Cl.scala 719:23]
    cl_sh_pcim_awvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 720:24]
    cl_sh_pcim_wdata <= UInt<512>("h00") @[AwsEc2F1Cl.scala 721:22]
    cl_sh_pcim_wstrb <= UInt<64>("h00") @[AwsEc2F1Cl.scala 722:22]
    cl_sh_pcim_wlast <= UInt<1>("h00") @[AwsEc2F1Cl.scala 723:22]
    cl_sh_pcim_wvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 724:23]
    cl_sh_pcim_bready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 725:23]
    cl_sh_pcim_arid <= UInt<16>("h00") @[AwsEc2F1Cl.scala 726:21]
    cl_sh_pcim_araddr <= UInt<64>("h00") @[AwsEc2F1Cl.scala 727:23]
    cl_sh_pcim_arlen <= UInt<8>("h00") @[AwsEc2F1Cl.scala 728:22]
    cl_sh_pcim_arsize <= UInt<3>("h00") @[AwsEc2F1Cl.scala 729:23]
    cl_sh_pcim_aruser <= UInt<19>("h00") @[AwsEc2F1Cl.scala 730:23]
    cl_sh_pcim_arvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 731:24]
    cl_sh_pcim_rready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 732:23]
    cl_sh_dma_pcis_awready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 684:28]
    cl_sh_dma_pcis_wready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 685:27]
    cl_sh_dma_pcis_bid <= UInt<6>("h00") @[AwsEc2F1Cl.scala 686:24]
    cl_sh_dma_pcis_bresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 687:26]
    cl_sh_dma_pcis_bvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 688:27]
    cl_sh_dma_pcis_arready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 689:28]
    cl_sh_dma_pcis_rid <= UInt<6>("h00") @[AwsEc2F1Cl.scala 690:24]
    cl_sh_dma_pcis_rdata <= UInt<512>("h00") @[AwsEc2F1Cl.scala 691:26]
    cl_sh_dma_pcis_rresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 692:26]
    cl_sh_dma_pcis_rlast <= UInt<1>("h00") @[AwsEc2F1Cl.scala 693:26]
    cl_sh_dma_pcis_rvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 694:27]
    cl_sh_dma_wr_full <= UInt<1>("h00") @[AwsEc2F1Cl.scala 695:23]
    cl_sh_dma_rd_full <= UInt<1>("h00") @[AwsEc2F1Cl.scala 696:23]
    cl_sda_awready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 301:20]
    cl_sda_wready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 302:19]
    cl_sda_bvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 303:19]
    cl_sda_bresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 304:18]
    cl_sda_arready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 305:20]
    cl_sda_rvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 306:19]
    cl_sda_rdata <= UInt<32>("h00") @[AwsEc2F1Cl.scala 307:18]
    cl_sda_rresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 308:18]
    bar1_sh_awready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 743:21]
    bar1_sh_wready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 744:20]
    bar1_sh_bvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 745:20]
    bar1_sh_bresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 746:19]
    bar1_sh_arready <= UInt<1>("h00") @[AwsEc2F1Cl.scala 747:21]
    bar1_sh_rvalid <= UInt<1>("h00") @[AwsEc2F1Cl.scala 748:20]
    bar1_sh_rdata <= UInt<32>("h00") @[AwsEc2F1Cl.scala 749:19]
    bar1_sh_rresp <= UInt<2>("h00") @[AwsEc2F1Cl.scala 750:19]
    cl_sh_apppf_irq_req <= UInt<16>("h00") @[AwsEc2F1Cl.scala 290:25]
    inst axiRegisterSliceModule of axi_register_slice_light @[ClHelloWorld.scala 31:38]
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
    node _axiRegisterSliceModule_aclk_T = bits(clk_main_a0, 0, 0) @[ClHelloWorld.scala 32:52]
    axiRegisterSliceModule.aclk <= _axiRegisterSliceModule_aclk_T @[ClHelloWorld.scala 32:31]
    axiRegisterSliceModule.aresetn <= resetSyncNegModule.reset_sync_n @[ClHelloWorld.scala 33:34]
    axiRegisterSliceModule.s_axi_awaddr <= sh_ocl_awaddr @[ClHelloWorld.scala 34:39]
    axiRegisterSliceModule.s_axi_awprot <= UInt<2>("h00") @[ClHelloWorld.scala 35:39]
    axiRegisterSliceModule.s_axi_awvalid <= sh_ocl_awvalid @[ClHelloWorld.scala 36:40]
    ocl_sh_awready <= axiRegisterSliceModule.s_axi_awready @[ClHelloWorld.scala 37:40]
    axiRegisterSliceModule.s_axi_wdata <= sh_ocl_wdata @[ClHelloWorld.scala 38:38]
    axiRegisterSliceModule.s_axi_wstrb <= sh_ocl_wstrb @[ClHelloWorld.scala 39:38]
    axiRegisterSliceModule.s_axi_wvalid <= sh_ocl_wvalid @[ClHelloWorld.scala 40:39]
    ocl_sh_wready <= axiRegisterSliceModule.s_axi_wready @[ClHelloWorld.scala 41:39]
    ocl_sh_bresp <= axiRegisterSliceModule.s_axi_bresp @[ClHelloWorld.scala 42:38]
    ocl_sh_bvalid <= axiRegisterSliceModule.s_axi_bvalid @[ClHelloWorld.scala 43:39]
    axiRegisterSliceModule.s_axi_bready <= sh_ocl_bready @[ClHelloWorld.scala 44:39]
    axiRegisterSliceModule.s_axi_araddr <= sh_ocl_araddr @[ClHelloWorld.scala 45:39]
    axiRegisterSliceModule.s_axi_arvalid <= sh_ocl_arvalid @[ClHelloWorld.scala 46:40]
    ocl_sh_arready <= axiRegisterSliceModule.s_axi_arready @[ClHelloWorld.scala 47:40]
    ocl_sh_rdata <= axiRegisterSliceModule.s_axi_rdata @[ClHelloWorld.scala 48:38]
    ocl_sh_rresp <= axiRegisterSliceModule.s_axi_rresp @[ClHelloWorld.scala 49:38]
    ocl_sh_rvalid <= axiRegisterSliceModule.s_axi_rvalid @[ClHelloWorld.scala 50:39]
    axiRegisterSliceModule.s_axi_rready <= sh_ocl_rready @[ClHelloWorld.scala 51:39]
    cl_sh_id0 <= UInt<32>("h0f0001d0f") @[ClHelloWorld.scala 54:13]
    cl_sh_id1 <= UInt<32>("h01d51fedd") @[ClHelloWorld.scala 55:13]
    node _T = asClock(clk_main_a0) @[ClHelloWorld.scala 57:40]
    node _T_1 = eq(resetSyncNegModule.reset_sync_n, UInt<1>("h00")) @[ClHelloWorld.scala 57:44]
    inst ClHelloWorldCore of ClHelloWorldCore @[ClHelloWorld.scala 58:40]
    ClHelloWorldCore.clock <= _T
    ClHelloWorldCore.reset <= _T_1
    ClHelloWorldCore.s_axi_awvalid <= axiRegisterSliceModule.m_axi_awvalid @[ClHelloWorld.scala 59:42]
    ClHelloWorldCore.s_axi_awaddr <= axiRegisterSliceModule.m_axi_awaddr @[ClHelloWorld.scala 60:41]
    ClHelloWorldCore.s_axi_wvalid <= axiRegisterSliceModule.m_axi_wvalid @[ClHelloWorld.scala 61:41]
    ClHelloWorldCore.s_axi_wdata <= axiRegisterSliceModule.m_axi_wdata @[ClHelloWorld.scala 62:40]
    ClHelloWorldCore.s_axi_wstrb <= axiRegisterSliceModule.m_axi_wstrb @[ClHelloWorld.scala 63:40]
    ClHelloWorldCore.s_axi_bready <= axiRegisterSliceModule.m_axi_bready @[ClHelloWorld.scala 64:41]
    ClHelloWorldCore.s_axi_arvalid <= axiRegisterSliceModule.m_axi_arvalid @[ClHelloWorld.scala 65:42]
    ClHelloWorldCore.s_axi_araddr <= axiRegisterSliceModule.m_axi_araddr @[ClHelloWorld.scala 66:41]
    ClHelloWorldCore.s_axi_rready <= axiRegisterSliceModule.m_axi_rready @[ClHelloWorld.scala 67:41]
    axiRegisterSliceModule.m_axi_awready <= ClHelloWorldCore.s_axi_awready @[ClHelloWorld.scala 68:42]
    axiRegisterSliceModule.m_axi_wready <= ClHelloWorldCore.s_axi_wready @[ClHelloWorld.scala 69:41]
    axiRegisterSliceModule.m_axi_bvalid <= ClHelloWorldCore.s_axi_bvalid @[ClHelloWorld.scala 70:41]
    axiRegisterSliceModule.m_axi_bresp <= ClHelloWorldCore.s_axi_bresp @[ClHelloWorld.scala 71:40]
    axiRegisterSliceModule.m_axi_arready <= ClHelloWorldCore.s_axi_arready @[ClHelloWorld.scala 72:42]
    axiRegisterSliceModule.m_axi_rvalid <= ClHelloWorldCore.s_axi_rvalid @[ClHelloWorld.scala 73:41]
    axiRegisterSliceModule.m_axi_rdata <= ClHelloWorldCore.s_axi_rdata @[ClHelloWorld.scala 74:40]
    axiRegisterSliceModule.m_axi_rresp <= ClHelloWorldCore.s_axi_rresp @[ClHelloWorld.scala 75:40]
    ClHelloWorldCore.sh_cl_status_vdip <= sh_cl_status_vdip @[ClHelloWorld.scala 77:46]
    cl_sh_status_vled <= ClHelloWorldCore.cl_sh_status_vled @[ClHelloWorld.scala 78:46]
    cl_sh_status0 <= UInt<32>("h00") @[ClHelloWorld.scala 82:17]
    cl_sh_status1 <= UInt<32>("h00") @[ClHelloWorld.scala 83:17]
    tdo <= UInt<1>("h00") @[ClHelloWorld.scala 85:7]
    
