#include "xparameters.h"
#include "xil_printf.h"
#include "xil_types.h"
#include <stdio.h>
#include <sleep.h>

// Get device IDs from xparameters.h
#define USER_AXI_ADDR XPAR_USER_AXI_BASEADDR
#define BRAM_ADDR XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR

int main() {

	int nn = 0;
	int mm = 0;
	char* c = (char*) BRAM_ADDR;
	while(1){
		for(mm=0;mm<5;mm++){
			c[mm] = nn++;
			xil_printf("Writing BRAM[%d] = %d\r\n",mm, c[mm]);
		}
		for(mm=0;mm<5;mm++){
			xil_printf("Reading BRAM[%d]: %d\r\n",mm, c[mm]);
		}

		usleep(1000000);
	}

}
