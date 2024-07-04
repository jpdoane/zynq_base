`timescale 1ns/1ps

module example_top
(
  input CLK_125MHZ,

  // ps signals
  inout [14:0]DDR_addr,
  inout [2:0]DDR_ba,
  inout DDR_cas_n,
  inout DDR_ck_n,
  inout DDR_ck_p,
  inout DDR_cke,
  inout DDR_cs_n,
  inout [3:0]DDR_dm,
  inout [31:0]DDR_dq,
  inout [3:0]DDR_dqs_n,
  inout [3:0]DDR_dqs_p,
  inout DDR_odt,
  inout DDR_ras_n,
  inout DDR_reset_n,
  inout DDR_we_n,
  inout FIXED_IO_ddr_vrn,
  inout FIXED_IO_ddr_vrp,
  inout [53:0]FIXED_IO_mio,
  inout FIXED_IO_ps_clk,
  inout FIXED_IO_ps_porb,
  inout FIXED_IO_ps_srstb
);

  wire AXI_CLK;
  wire [0:0]AXI_RSTN;
  wire [30:0]USER_AXI_araddr;
  wire [2:0]USER_AXI_arprot;
  wire USER_AXI_arready;
  wire USER_AXI_arvalid;
  wire [30:0]USER_AXI_awaddr;
  wire [2:0]USER_AXI_awprot;
  wire USER_AXI_awready;
  wire USER_AXI_awvalid;
  wire USER_AXI_bready;
  wire [1:0]USER_AXI_bresp;
  wire USER_AXI_bvalid;
  wire [31:0]USER_AXI_rdata;
  wire USER_AXI_rready;
  wire [1:0]USER_AXI_rresp;
  wire USER_AXI_rvalid;
  wire [31:0]USER_AXI_wdata;
  wire USER_AXI_wready;
  wire [3:0]USER_AXI_wstrb;
  wire USER_AXI_wvalid;
  wire [0:0]peripheral_reset_0;

  zynq_ps zynq_ps_i
       (.AXI_CLK(AXI_CLK),
        .AXI_RSTN(AXI_RSTN),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .USER_AXI_araddr(USER_AXI_araddr),
        .USER_AXI_arprot(USER_AXI_arprot),
        .USER_AXI_arready(USER_AXI_arready),
        .USER_AXI_arvalid(USER_AXI_arvalid),
        .USER_AXI_awaddr(USER_AXI_awaddr),
        .USER_AXI_awprot(USER_AXI_awprot),
        .USER_AXI_awready(USER_AXI_awready),
        .USER_AXI_awvalid(USER_AXI_awvalid),
        .USER_AXI_bready(USER_AXI_bready),
        .USER_AXI_bresp(USER_AXI_bresp),
        .USER_AXI_bvalid(USER_AXI_bvalid),
        .USER_AXI_rdata(USER_AXI_rdata),
        .USER_AXI_rready(USER_AXI_rready),
        .USER_AXI_rresp(USER_AXI_rresp),
        .USER_AXI_rvalid(USER_AXI_rvalid),
        .USER_AXI_wdata(USER_AXI_wdata),
        .USER_AXI_wready(USER_AXI_wready),
        .USER_AXI_wstrb(USER_AXI_wstrb),
        .USER_AXI_wvalid(USER_AXI_wvalid),
        .peripheral_reset_0(peripheral_reset_0));




endmodule
