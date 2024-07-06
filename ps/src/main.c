#include "xparameters.h"
#include "xil_printf.h"
#include "xil_types.h"
#include <stdio.h>
#include <sleep.h>

// Get device IDs from xparameters.h
#define SDRAM_AXI_ADDR XPAR_USER_AXI_BASEADDR
#define BRAM_ADDR XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR

int hash_byte(u32 n) { return (u8) ((0xff ^ n) & 0xff); }
int hash_word(u32 n) { return (u32) ((0xffffffff ^ n) & 0xffffffff); }

int memcheck_bytes(u8* base, u32 len) {

	int mm, nn;
	int rv = 0;

	xil_printf("memcheck 0x%x-0x%x (%d bytes)...\r\n",base, base+len-1, len);
	for(mm=0; mm < len; mm++){
		base[mm] = hash_byte(mm);
		if( (mm & 0xfffff) == 0 )
			xil_printf("\tInitializing: 0x%x...\r\n", base+mm);
	}

	for(mm=0; mm < len; mm++){
		if( (mm & 0xfffff) == 0 )
			xil_printf("\tChecking: 0x%x...\r\n", base+mm);
		nn = base[mm];
		if(nn != hash_byte(mm))
		{
			xil_printf("MEMORY ERROR! mem[%d]=0x%x, should be 0x%x. (2nd read: 0x%x)\r\n", mm, nn, hash_byte(mm), base[mm]);
			rv = 1;
		}
	}
	if(rv)
		xil_printf("Failed!\r\n");
	else
		xil_printf("Passed!\r\n");

	return rv;
}

int memcheck_words(u32* base, u32 len) {

	int mm, nn;
	int rv = 0;
	int words = len >> 2;

	xil_printf("memcheck 0x%x-0x%x (%d words)...\r\n",base, base+words-1, words);
	for(mm=0; mm < words; mm++){
		if( (mm & 0xfffff) == 0 )
			xil_printf("\tInitializing: 0x%x...\r\n", base+mm);
		base[mm] = hash_word(mm);
	}

	for(mm=0; mm < words; mm++){
		if( (mm & 0xfffff) == 0 )
			xil_printf("\tChecking: 0x%x...\r\n", base+mm);
		nn = base[mm];
		if(nn != hash_word(mm))
		{
			xil_printf("MEMORY ERROR! mem[%d]=0x%x, should be 0x%x. (2nd read: 0x%x)\r\n", mm, nn, hash_word(mm), base[mm]);
			rv = 1;
		}
	}
	if(rv)
		xil_printf("Failed!\r\n");
	else
		xil_printf("Passed!\r\n");

	return rv;
}


int main() {

	u32 len = 1 << 25;
	memcheck_bytes((u8*) SDRAM_AXI_ADDR, len);
	memcheck_words((u32*) SDRAM_AXI_ADDR, len);

}
