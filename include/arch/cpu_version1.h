/*
 * (C) Copyright 2007-2015
 * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
 * Jerry Wang <wangflord@allwinnertech.com>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 */

#ifndef __PLATFORM_H
#define __PLATFORM_H

#define SUNXI_CE_BASE (0x01c15000L)
#define SUNXI_SS_BASE SUNXI_CE_BASE

//sys ctrl
#define SUNXI_SYSCRL_BASE (0x01c00000L)
#define SUNXI_CCM_BASE (0x01c20000L)
#define SUNXI_DMA_BASE (0x01c02000L)
#define SUNXI_MSGBOX_BASE (0X01C17000L)
#define SUNXI_SPINLOCK_BASE (0X01C18000L)
#define SUNXI_HSTMR_BASE (0x01c60000L)

#define SUNXI_SMC_BASE (0x01c1e000L)

#define SUNXI_TIMER_BASE (0x01c20c00L)

#define SUNXI_PIO_BASE (0x01c20800L)
#define SUNXI_GIC_BASE (0x01c81000L)

//storage
#define SUNXI_DRAMCTL0_BASE (0x01c63000L)
#define SUNXI_NFC_BASE (0x01c03000L)
#define SUNXI_SMHC0_BASE (0x01c0f000L)
#define SUNXI_SMHC1_BASE (0x01c10000L)
#define SUNXI_SMHC2_BASE (0x01c11000L)

//noraml
#define SUNXI_UART0_BASE (0x01c28000L)
#define SUNXI_UART1_BASE (0x01c28400L)
#define SUNXI_UART2_BASE (0x01c28800L)
#define SUNXI_UART3_BASE (0x01c28c00L)
#define SUNXI_UART4_BASE (0x01c29000L)

#define SUNXI_RTWI_BASE (0x01c2ac00L)
#define SUNXI_TWI0_BASE (0x01c2ac00L)
#define SUNXI_TWI1_BASE (0x01c2b000L)
#define SUNXI_TWI2_BASE (0x01c2b400L)
#define SUNXI_TWI3_BASE (0x01c2b800L)


#define SUNXI_GMAC_BASE (0x01c50000L)

#define SUNXI_LRADC_BASE (0X01C21800L)
#define SUNXI_KEYADC_BASE SUNXI_LRADC_BASE

#define SUNXI_RCPUCFG_BASE (SUNXI_CPUS_CFG_BASE)
#define SUNXI_RPRCM_BASE (0x01f01400L)
#define SUNXI_RTWI_BRG_REG           (SUNXI_RPRCM_BASE + 0x019c)
#define SUNXI_R_PIO_BASE (0X01F02C00L)

#define SUNXI_RTC_DATA_BASE (SUNXI_RTC_BASE + 0x100)


#endif
