`timescale 1ns/1ps

module sdram_top
(
  input CLK_125MHZ,
  output [3:0] led,
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
  inout FIXED_IO_ps_srstb,

  output          clk_sdram,
  output          sdram_cke,
  output [1:0]    sdram_dqm,
  output          sdram_cas_n,
  output          sdram_ras_n,
  output          sdram_we_n,
  output          sdram_cs_n,
  output [1:0]    sdram_bs,
  output [12:0]   sdram_a,
  inout  [15:0]   sdram_dq
);

(* mark_debug = "true" *)    wire clk;
(* mark_debug = "true" *)    wire rstn;
(* mark_debug = "true" *)    wire rst = ~rstn;
  
(* mark_debug = "true" *)    wire           USER_AXI_awvalid;
(* mark_debug = "true" *)    wire  [ 31:0]  USER_AXI_awaddr;
(* mark_debug = "true" *)    wire  [  3:0]  USER_AXI_awid;
(* mark_debug = "true" *)    wire  [  7:0]  USER_AXI_awlen;
(* mark_debug = "true" *)    wire  [  1:0]  USER_AXI_awburst;
(* mark_debug = "true" *)    wire           USER_AXI_wvalid;
(* mark_debug = "true" *)    wire  [ 31:0]  USER_AXI_wdata;
(* mark_debug = "true" *)    wire  [  3:0]  USER_AXI_wstrb;
(* mark_debug = "true" *)    wire           USER_AXI_wlast;
(* mark_debug = "true" *)    wire           USER_AXI_bready;
(* mark_debug = "true" *)    wire           USER_AXI_arvalid;
(* mark_debug = "true" *)    wire  [ 31:0]  USER_AXI_araddr;
(* mark_debug = "true" *)    wire  [  3:0]  USER_AXI_arid;
(* mark_debug = "true" *)    wire  [  7:0]  USER_AXI_arlen;
(* mark_debug = "true" *)    wire  [  1:0]  USER_AXI_arburst;
(* mark_debug = "true" *)    wire           USER_AXI_rready;
(* mark_debug = "true" *)    wire          USER_AXI_awready;
(* mark_debug = "true" *)    wire          USER_AXI_wready;
(* mark_debug = "true" *)    wire          USER_AXI_bvalid;
(* mark_debug = "true" *)    wire [  1:0]  USER_AXI_bresp;
(* mark_debug = "true" *)    wire [  3:0]  USER_AXI_bid;
(* mark_debug = "true" *)    wire          USER_AXI_arready;
(* mark_debug = "true" *)    wire          USER_AXI_rvalid;
(* mark_debug = "true" *)    wire [ 31:0]  USER_AXI_rdata;
(* mark_debug = "true" *)    wire [  1:0]  USER_AXI_rresp;
(* mark_debug = "true" *)    wire [  3:0]  USER_AXI_rid;
(* mark_debug = "true" *)    wire          USER_AXI_rlast;

(* mark_debug = "true" *)    wire [0:0]peripheral_reset_0;


  zynq_ps zynq_ps_i
       (.AXI_CLK(clk),
        .AXI_RSTN(rstn),
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
        .USER_AXI_awvalid       (USER_AXI_awvalid),
        .USER_AXI_awaddr        (USER_AXI_awaddr),
        .USER_AXI_awid          (USER_AXI_awid),
        .USER_AXI_awlen         (USER_AXI_awlen),
        .USER_AXI_awburst       (USER_AXI_awburst),
        .USER_AXI_wvalid        (USER_AXI_wvalid),
        .USER_AXI_wdata         (USER_AXI_wdata),
        .USER_AXI_wstrb         (USER_AXI_wstrb),
        .USER_AXI_wlast         (USER_AXI_wlast),
        .USER_AXI_bready        (USER_AXI_bready),
        .USER_AXI_arvalid       (USER_AXI_arvalid),
        .USER_AXI_araddr        (USER_AXI_araddr),
        .USER_AXI_arid          (USER_AXI_arid),
        .USER_AXI_arlen         (USER_AXI_arlen),
        .USER_AXI_arburst       (USER_AXI_arburst),
        .USER_AXI_rready        (USER_AXI_rready),
        .USER_AXI_awready       (USER_AXI_awready),
        .USER_AXI_wready        (USER_AXI_wready),
        .USER_AXI_bvalid        (USER_AXI_bvalid),
        .USER_AXI_bresp         (USER_AXI_bresp),
        .USER_AXI_bid           (USER_AXI_bid),
        .USER_AXI_arready       (USER_AXI_arready),
        .USER_AXI_rvalid        (USER_AXI_rvalid),
        .USER_AXI_rdata         (USER_AXI_rdata),
        .USER_AXI_rresp         (USER_AXI_rresp),
        .USER_AXI_rid           (USER_AXI_rid),
        .USER_AXI_rlast         (USER_AXI_rlast),
//        .USER_AXI_araddr(USER_AXI_araddr),
//        .USER_AXI_arprot(USER_AXI_arprot),
//        .USER_AXI_arready(USER_AXI_arready),
//        .USER_AXI_arvalid(USER_AXI_arvalid),
//        .USER_AXI_awaddr(USER_AXI_awaddr),
//        .USER_AXI_awprot(USER_AXI_awprot),
//        .USER_AXI_awready(USER_AXI_awready),
//        .USER_AXI_awvalid(USER_AXI_awvalid),
//        .USER_AXI_bready(USER_AXI_bready),
//        .USER_AXI_bresp(USER_AXI_bresp),
//        .USER_AXI_bvalid(USER_AXI_bvalid),
//        .USER_AXI_rdata(USER_AXI_rdata),
//        .USER_AXI_rready(USER_AXI_rready),
//        .USER_AXI_rresp(USER_AXI_rresp),
//        .USER_AXI_rvalid(USER_AXI_rvalid),
//        .USER_AXI_wdata(USER_AXI_wdata),
//        .USER_AXI_wready(USER_AXI_wready),
//        .USER_AXI_wstrb(USER_AXI_wstrb),
//        .USER_AXI_wvalid(USER_AXI_wvalid),
        .peripheral_reset_0(peripheral_reset_0));


(* mark_debug = "true" *)    wire [ 15:0]        sdram_data_in;
(* mark_debug = "true" *)    wire [ 15:0]        sdram_data_out;
(* mark_debug = "true" *)    wire                sdram_data_out_en;

    wire    sdram_cas;
    wire    sdram_ras;
    wire    sdram_we;
    wire    sdram_cs;
    assign  sdram_cas_n = sdram_cas;
    assign  sdram_ras_n = sdram_ras;
    assign  sdram_we_n = sdram_we;
    assign  sdram_cs_n = sdram_cs;


    sdram_axi u_sdram_axi (
        // Inputs
        .clk_i                  (clk),
        .rst_i                  (rst),
        .inport_awvalid_i       (USER_AXI_awvalid),
        .inport_awaddr_i        (USER_AXI_awaddr),
        .inport_awid_i          (USER_AXI_awid),
        .inport_awlen_i         (USER_AXI_awlen),
        .inport_awburst_i       (USER_AXI_awburst),
        .inport_wvalid_i        (USER_AXI_wvalid),
        .inport_wdata_i         (USER_AXI_wdata),
        .inport_wstrb_i         (USER_AXI_wstrb),
        .inport_wlast_i         (USER_AXI_wlast),
        .inport_bready_i        (USER_AXI_bready),
        .inport_arvalid_i       (USER_AXI_arvalid),
        .inport_araddr_i        (USER_AXI_araddr),
        .inport_arid_i          (USER_AXI_arid),
        .inport_arlen_i         (USER_AXI_arlen),
        .inport_arburst_i       (USER_AXI_arburst),
        .inport_rready_i        (USER_AXI_rready),
        .sdram_data_input_i     (sdram_data_in),
        
        // Outputs
        .inport_awready_o       (USER_AXI_awready),
        .inport_wready_o        (USER_AXI_wready),
        .inport_bvalid_o        (USER_AXI_bvalid),
        .inport_bresp_o         (USER_AXI_bresp),
        .inport_bid_o           (USER_AXI_bid),
        .inport_arready_o       (USER_AXI_arready),
        .inport_rvalid_o        (USER_AXI_rvalid),
        .inport_rdata_o         (USER_AXI_rdata),
        .inport_rresp_o         (USER_AXI_rresp),
        .inport_rid_o           (USER_AXI_rid),
        .inport_rlast_o         (USER_AXI_rlast),
        .sdram_clk_o            (),
        .sdram_cke_o            (sdram_cke),
        .sdram_cs_o             (sdram_cs),
        .sdram_ras_o            (sdram_ras),
        .sdram_cas_o            (sdram_cas),
        .sdram_we_o             (sdram_we),
        .sdram_dqm_o            (sdram_dqm),
        .sdram_addr_o           (sdram_a),
        .sdram_ba_o             (sdram_bs),
        .sdram_data_output_o    (sdram_data_out),
        .sdram_data_out_en_o    (sdram_data_out_en)
    );

    ODDR2 
    #(
        .DDR_ALIGNMENT("NONE"),
        .INIT(1'b0),
        .SRTYPE("SYNC")
    )
    u_clock_delay
    (
        .Q(clk_sdram),
        .C0(clk),
        .C1(~clk),
        .CE(1'b1),
        .R(1'b0),
        .S(1'b0),
        .D0(1'b0),
        .D1(1'b1)
    );

    genvar i;
    for (i=0; i < 16; i = i + 1) 
    begin
      IOBUF 
      #(
        .DRIVE(12),
        .IOSTANDARD("LVTTL"),
        .SLEW("FAST")
      )
      u_data_buf
      (
        .O(sdram_data_in[i]),
        .IO(sdram_dq[i]),
        .I(sdram_data_out[i]),
        .T(~sdram_data_out_en)
      );
    end
    
    logic ram_rreq_latch;
    logic ram_wreq_latch;
    logic ram_accept_latch;
    logic ram_ack_latch;
    logic ram_error_latch;
    always @ (posedge clk)
        if (rst) begin
            ram_rreq_latch <= 0;
            ram_wreq_latch <= 0;
            ram_accept_latch <= 0;
            ram_ack_latch <= 0;
            ram_error_latch <= 0;
        end else begin
            if(u_sdram_axi.ram_wr_w) ram_wreq_latch <= 1;
            if(u_sdram_axi.ram_rd_w) ram_rreq_latch <= 1;
            if(u_sdram_axi.ram_accept_w) ram_accept_latch <= 1;
            if(u_sdram_axi.ram_ack_w) ram_ack_latch <= 1;
            if(u_sdram_axi.ram_error_w) ram_error_latch <= 1;
        end

    // assign led[0]=ram_rreq_latch;
    // assign led[1]=ram_wreq_latch;
    // assign led[2]=ram_ack_latch;
    // assign led[3]=ram_error_latch;

    assign led=u_sdram_axi.u_core.state_q;

endmodule
