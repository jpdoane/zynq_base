include ../inc/make.inc

TOP=sdram_top
SDRAM_SRC = $(wildcard ../sdram/*.v)
BD_SOURCE = zynq_ps_bd.tcl
HDL_SOURCE = $(TOP).sv $(SDRAM_SRC)
CONSTRAINTS =  ../inc/ArtyZ720_sdram.xdc
DEVICE=xc7z020clg400-1
DEVICE_SHORT=xc7z020_1

DEBUG_NETS = debug_nets.tcl

include ../inc/make.hw
