/*
 * (C) Copyright 2018
 * wangwei <wangwei@allwinnertech.com>
 */

#include <config.h>
#include <private_boot0.h>
#include <commit_info.h>

#define BROM_FILE_HEAD_SIZE_OFFSET	(((sizeof(boot0_file_head_t) + sizeof(int) - 1) / sizeof(int) - 2))
#define JUMP_INSTRUCTION		(BROM_FILE_HEAD_SIZE_OFFSET | 0xEA000000)

const boot0_file_head_t  fes1_head = {
	{
		/* jump_instruction */          
		JUMP_INSTRUCTION,
		BOOT0_MAGIC,
		STAMP_VALUE,
		32,
		sizeof(boot_file_head_t),
		BOOT_PUB_HEAD_VERSION,
		(CONFIG_FES1_RUN_ADDR + sizeof(boot0_file_head_t) - sizeof(fes1_head.fes_union_addr)),
		CONFIG_FES1_RUN_ADDR,
		0,
		{
			0, 0, '3','.','0','.','0',0
		},
	},
	{
		//__u32 prvt_head_size;
		0,
		//char prvt_head_vsn[4];      
		0,
		0,	/*power_mode*/
		{0},/* reserver[2] */
		//unsigned int                dram_para[32] ; 
		{
      /*.dram_clk =*/ 936,
      /*.dram_type =*/ 3,
      /*.dram_zq =*/ 0x7b7bfb,
      /*.dram_odt_en =*/ 0x00,
      /*.dram_para1 =*/ 0x000010d2,
      /*.dram_para2 =*/ 0x0000,
      /*.dram_mr0 =*/ 0x1c70,
      /*.dram_mr1 =*/ 0x042,
      /*.dram_mr2 =*/ 0x18,
      /*.dram_mr3 =*/ 0x0,
      /*.dram_tpr0 =*/ 0x004a2195,
      /*.dram_tpr1 =*/ 0x02423190,
      /*.dram_tpr2 =*/ 0x0008B061,
      /*.dram_tpr3 =*/ 0xB4787896,
      /*.dram_tpr4 =*/ 0x0,
      /*.dram_tpr5 =*/ 0x48484848,
      /*.dram_tpr6 =*/ 0x00000048,
      /*.dram_tpr7 =*/ 0x1620121e,
      /*.dram_tpr8 =*/ 0x0,
      /*.dram_tpr9 =*/ 0x0,
      /*.dram_tpr10 =*/ 0x0,
      /*.dram_tpr11 =*/ 0x00340000,
      /*.dram_tpr12 =*/ 0x00000046,
      /*.dram_tpr13 =*/ 0x34000100,
		},
		//__s32			     uart_port;   
		3,
		//normal_gpio_cfg       uart_ctrl[2];  
		{
			{ 5, 9, 5, 1, 1, 0, {0}},//PE9: 5--RX
			{ 5, 8, 5, 1, 1, 0, {0}},//PE8: 5--TX
		},
		//__s32                         enable_jtag;  
		0,
		//normal_gpio_cfg	      jtag_gpio[5];   
		{{0},{0},{0},{0},{0}},
		//normal_gpio_cfg        storage_gpio[32]; 
		{
			{6, 0, 2, 1, 2, 0, {0} },//PF0-5: 2--SDC
			{6, 1, 2, 1, 2, 0, {0} },
			{6, 2, 2, 1, 2, 0, {0} },
			{6, 3, 2, 1, 2, 0, {0} },
			{6, 4, 2, 1, 2, 0, {0} },
			{6, 5, 2, 1, 2, 0, {0} },
		},
		{0}
	 },
	.hash = CI_INFO,
};
