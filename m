From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Thu, 14 Aug 2008 22:44:21 -0400
Message-ID: <48A4ED85.1030803@gmail.com>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070505000005020106070603"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A44F77.1020908-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------070505000005020106070603
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Again, thanks for the help.

Ned Forrester wrote:
> I can see from your logic analyzer trace, that the clock is running
> before the transfer starts, but it should not be doing this, and such a
> problem has not been reported by others, so far as I know.  You really
> need to find out why this is happening.  Are you sure that you are using
> the correct pins on the chip?  What pins and Alternate Function settings
> are you using?  
In investigating this, I remembered that I was setting the SSPEXTCLK pin 
also. It turns out that disabling the alternate function on that pin 
turned off the outbound clock. I have no idea why but it turns out that 
this was wrong anyway (no external pullups) so it is "fixed" now.
>
> I agree that the Frame pin cannot be used to hold CS across transfers,
> and that is why I said "The driver should honor the per-transfer
> spi_transfer.cs_change flag when used with a cs_control routine.",
> meaning: only with use of a GPIO pin for CS.
>
>   
And now that the clock is off, the cs_control routing is viable and 
works fine.
>> Here are the registers:
>>
>> root@inhand-ft4 [~] # md 0x41000000 0x3f
>> 00000000  87 19 00 00 00 00 00 00  24 f0 00 00 00 00 00 00  |........$.......|
>> 00000010  70 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |p...............|
>> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> *
>> 00000030
>>     
>
> My translation is that you are using SSP1 on the pxa270, and that the
> register values are:
>
> Name	Addr		Value
> SSCR0	0x41000000	0x00001987
> 			clock divisor=1a (19+1)
> 			on-board 13MHz clock source
> 			SSE=1 (enabled)
> 			Motorola SPI format
> 			NOT Network mode
>
> SSCR1	0x41000004	0x00000000
> 			No external clock or ROWT set
> 			No interrupts or service requests enabled
> 			Master mode
> 			TX and RX thresholds = 1
> I'm surprised that bits not set in this register.  It is normal for an
> idle interface to have the timeout interrupt, and either service
> requests or interrupts clear, but then I would expect SSE to be clear in
> SSCR0.  Also I would expect the TX and RX thresholds to be set to the
> mid point = 8; you can set other values, but I wonder if you did.
>   
This is another problem. The thresholds and timeouts are taken from the 
pxa2xx_spi_chip structure where cs_control is specified. So once I tried 
to use cs_control, the timeout and thresholds were wrong. They driver 
does not use defaults if these are zero. If timeout is zero, the kernel 
hangs while trying to read the trailing bytes. Here is a patch to use 
defaults if the timeout or thresholds are zero. (It is also attached due 
to my poor mailer.)

--- linux-2.6.24.4/drivers/spi/pxa2xx_spi.c    2008-03-24 
14:49:18.000000000 -0400
+++ src.cache/drivers/spi/pxa2xx_spi.c    2008-08-14 20:52:15.000000000 
-0400
@@ -1142,11 +1142,12 @@
         if (chip_info->cs_control)
             chip->cs_control = chip_info->cs_control;
 
+        if (chip_info->timeout)
         chip->timeout = chip_info->timeout;
 
-        chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
+        chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold ? : 12) &
                                 SSCR1_RFT) |
-                (SSCR1_TxTresh(chip_info->tx_threshold) &
+                (SSCR1_TxTresh(chip_info->tx_threshold ? : 4) &
                                 SSCR1_TFT);
 
         chip->enable_dma = chip_info->dma_burst_size != 0

I can submit this more formally if you like. Let me know where.

> SSSR	0x41000008	0x0000f024
> 			Rx and Tx fifos empty
> 			no interrupts pending
> SSITR	0x4100000c	0x00000000
> 			off = normal
> SSDR	0x41000010	0x00000070
> 			last data read
> SSTO	0x41000028	0x00000000
> 			timeout of 0 means no timeout
> This is normal for an idle interface, as the driver zeros the timeout
> when activity is complete.
>
> SSPSP	0x4100002c	0x00000000
> 			Not used, 0=normal
> SSTSA	0x41000030	unknown
> SSRSA	0x41000034	unknown
> SSTSS	0x41000038	unknown
> These registers are not listed above, but I think they are not used,
> except in network mode, which is disabled in SSCR0.
>
> SSACD	0x4100003c	unknown
> I'm not sure if this register is used when not in network mode.  It
> affects the clock selection and clock rate, and appears to be mutually
> exclusive with the SCR value in SSCR0.
>
> I don't see anything above that would cause the SSPSCLK to free run.  Be
> sure you are using SSPSCLK and not SSPSYSCLK, though the latter does not
> seem possible, based on your logic analyzer trace.  The only strange
> thing about the register state is that SSE is enabled, while every other
> register implies that the interface should be idle.
>
>   
Here are the new register values:


SSP1 Control Register 0 (0x41000000)
SSP1_SSCR0               0x00002087  00000000 00000000 00100000 10000111
SSP1_SSCR0_MOD                    0  Network Mode
SSP1_SSCR0_ACS                    0  Audio Clock Select
SSP1_SSCR0_FRDC                   0  Frame Rate Divider Control
SSP1_SSCR0_TIM                    0  Tx FIFO Underrun IRQ Mask
SSP1_SSCR0_RIM                    0  Rx FIFO Underrun IRQ Mask
SSP1_SSCR0_NCS                    0  Nework Clock Select
SSP1_SSCR0_EDSS                   0  Extended Data Size Select
SSP1_SSCR0_SCR                   20  Serial Clock Rate
SSP1_SSCR0_SSE                    1  SSP Enable
SSP1_SSCR0_ECS                    0  External Clock Select
SSP1_SSCR0_FRF                    0  Frame Format 0=SPI 1=TI 2=Microwire 
3=PSP
SSP1_SSCR0_DSS                    3  Data Size Select (-1) hi bit is EDSS

** SSE is always set. The driver only clears it if it sees an error. Is 
this a bad thing?

SSP1 Control Register 1 (0x41000004)
SSP1_SSCR1               0x00000ec0  00000000 00000000 00001110 11000000
SSP1_SSCR1_TTELP                  0  TXD Tristate on Last Phase
SSP1_SSCR1_TTE                    0  TXD Tristate Enable
SSP1_SSCR1_EBCEI                  0  Enable Bit Count Error IRQ
SSP1_SSCR1_SCFR                   0  Slave Clock Free Running
SSP1_SSCR1_ECRA                   0  Enable Clock Request A
SSP1_SSCR1_ECRB                   0  Enable Clock Request B
SSP1_SSCR1_SCLKDIR                0  SSPSCLKx Direction
SSP1_SSCR1_SFRMDIR                0  SFRM Direction
SSP1_SSCR1_RWOT                   0  Receive w/o Tx
SSP1_SSCR1_TRAIL                  0  Trailing Byte
SSP1_SSCR1_TSRE                   0  Tx Service Request Enable
SSP1_SSCR1_RSRE                   0  Rx Service Request Enable
SSP1_SSCR1_TINTE                  0  Receiver Time-out IRQ Enable
SSP1_SSCR1_PINTE                  0  Peripheral Trailing Byte IRQ Enable
SSP1_SSCR1_IFS                    0  Invert Frame Signal
SSP1_SSCR1_STRF                   0  Select FIFO for EFWR
SSP1_SSCR1_EFWR                   0  Enable FIFO Write/Read (test mode)
SSP1_SSCR1_RFT                    3  Rx FIFO Threshold
SSP1_SSCR1_TFT                    b  Tx FIFO Threshold
SSP1_SSCR1_MWDS                   0  Microwire Tx Data Size
SSP1_SSCR1_SPH                    0  SPI SSPSCLK Phase
SSP1_SSCR1_SPO                    0  SPI SSPSCLK Polarity
SSP1_SSCR1_LBM                    0  Loop-back test mode
SSP1_SSCR1_TIE                    0  Tx FIFO IRQ Enable
SSP1_SSCR1_RIE                    0  Rx FIFO IRQ Enable

** Thresholds are now as set by defaults. Do you have a good way to 
figure out what they should be?

SSP1 Status Register (0x41000008)
SSP1_SSSR                0x0000f024  00000000 00000000 11110000 00100100
SSP1_SSSR_BCE                     0  Bit Count error
SSP1_SSSR_CSS                     0  Clock Sync Status
SSP1_SSSR_TUR                     0  Tx FIFO Underrun
SSP1_SSSR_EOC                     0  End of Chain
SSP1_SSSR_TINT                    0  Time-out IRQ
SSP1_SSSR_PINT                    0  Peripheral Trailing Byte IRQ
SSP1_SSSR_RFL                     f  Rx FIFO Level
SSP1_SSSR_TFL                     0  Tx FIFO Level
SSP1_SSSR_ROR                     0  Rx FIFO Overrun
SSP1_SSSR_RFS                     0  Rx FIFO Service
SSP1_SSSR_TFS                     1  Tx FIFO Service
SSP1_SSSR_BSY                     0  Busy
SSP1_SSSR_RNE                     0  Rx FIFO Not Empty
SSP1_SSSR_TNF                     1  Tx FIFO Not Full

SSP1 Interrupt Test Register (0x4100000c)
SSP1_SSITR               0x00000000  00000000 00000000 00000000 00000000

SSP1 Data Read/Write Register (0x41000010)
SSP1_SSDR                0x000000ff  00000000 00000000 00000000 11111111

SSP1 Time-Out Register (0x41000028)
SSP1_SSTO                0x00000000  00000000 00000000 00000000 00000000
SSP1_SSTO                         0  SSP1 Time-Out Register

** It is zero after the transfer.

SSP1 Programmable Serial Protocol Register (0x4100002c)
SSP1_SSPSP               0x00000000  00000000 00000000 00000000 00000000

SSP1 Tx Timeslot Active Register (0x41000030)
SSP1_SSTSA               0x00000000  00000000 00000000 00000000 00000000
SSP1_SSTSA                        0  SSP1 Tx Timeslot Active Register

SSP1 Rx Timeslot Active Register (0x41000034)
SSP1_SSRSA               0x00000000  00000000 00000000 00000000 00000000
SSP1_SSRSA                        0  SSP1 Rx Timeslot Active Register

SSP1 Timeslot Status Register (0x41000038)
SSP1_SSTSS               0x00000000  00000000 00000000 00000000 00000000
SSP1_SSTSS                        0  SSP1 Timeslot Status Register

SSP1 Audio Clock Divider Register (0x4100003c)
SSP1_SSACD               0x00000000  00000000 00000000 00000000 00000000
SSP1_SSACD                        0  SSP1 Audio Clock Divider Register


Attached is the platform file I have created for the Fingertip4 SSP.

On a side note, there is an MTD error when using the SPI Flash with the 
pxa2xx_spi driver.

root@inhand-ft4 [~] # flash_erase /dev/mtd_spi
Erase Total 1 Units
Performing Flash Erase of length 65536 at offset 0x0 done # <- why *64K* ??
root@inhand-ft4 [~] # echo -n hithere123 > /dev/mtd_spi
root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
|hithere123......|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
00000200
root@inhand-ft4 [~] # echo -n hithere444xxx > /dev/mtdblock_spi
[  231.370000] pxa2xx-spi pxa2xx-spi.1: pump_transfers: transfer length 
greater than 8191
 # maybe 64K??
[  231.380000] end_request: I/O error, dev mtdblock_spi, sector 0
[  231.380000] Buffer I/O error on device mtdblock_spi, logical block 0
[  231.380000] lost page write due to I/O error on mtdblock_spi
root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
|hithere123......|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
00000200

I have not done a great deal of testing with MTD yet but I can read and 
write a small test file. I was hoping to use the mtdblock interface for 
this application. I will take a little time and see if I can figure out 
what part is wrong here.


Thanks again for your help.
Vern

--------------070505000005020106070603
Content-Type: text/plain;
 name="pxa2xx-spi_timeout_optional.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pxa2xx-spi_timeout_optional.patch"

diff -U3 --exclude-from=/tmp/tmp.WAjUp31037 -rNbw -U3 linux-2.6.24.4/drivers/spi/pxa2xx_spi.c src.cache/drivers/spi/pxa2xx_spi.c
--- linux-2.6.24.4/drivers/spi/pxa2xx_spi.c	2008-03-24 14:49:18.000000000 -0400
+++ src.cache/drivers/spi/pxa2xx_spi.c	2008-08-14 20:52:15.000000000 -0400
@@ -1142,11 +1142,12 @@
 		if (chip_info->cs_control)
 			chip->cs_control = chip_info->cs_control;
 
+		if (chip_info->timeout)
 		chip->timeout = chip_info->timeout;
 
-		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
+		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold ? : 12) &
 								SSCR1_RFT) |
-				(SSCR1_TxTresh(chip_info->tx_threshold) &
+				(SSCR1_TxTresh(chip_info->tx_threshold ? : 4) &
 								SSCR1_TFT);
 
 		chip->enable_dma = chip_info->dma_burst_size != 0

--------------070505000005020106070603
Content-Type: text/x-csrc;
 name="ft4-ssp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ft4-ssp.c"

/*
 * InHand SSP platform driver
 *
 * Copyright: 2007-2008 Inhand Electronics, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/irq.h>
#include <linux/delay.h>
#include <linux/spi/spi.h>
#include <linux/spi/flash.h>

#include <asm/hardware.h>
#include <asm/arch/pxa-regs.h>
#include <asm/arch/ssp.h>
#include <asm/arch/pxa2xx_spi.h>

#include <linux/inhand-types.h>
#include <linux/pxa_gpio.h>

MODULE_AUTHOR("Vernon Sauder <vsauder-xB3BArjMkznQT0dZR+AlfA@public.gmane.org>");
MODULE_DESCRIPTION("InHand SSP platform driver");
MODULE_LICENSE("GPL");

#define MHZ *1000*1000
#define KHZ *1000

#define SSP_REG_LEN 0x40

// GPIO pins to initialize for SSP ports 1 & 2
// FT4 does not have port 3
static u32 ssp_gpio_init_list[] __initdata = {
#ifdef CONFIG_SSP1_EN
	// pins needed for SSP1
	(23 | GPIO_ALT_FN_2_OUT), 	// CLK
	//(24 | GPIO_ALT_FN_2_OUT), 	// Frame
	(25 | GPIO_ALT_FN_2_OUT), 	// TX
	(26 | GPIO_ALT_FN_1_IN), 	// RX
	// don't enable EXTCLK unless you actually are using it. Otherwise,
	// the SSPCLK will always run (for some strange reason)
	//(27 | GPIO_ALT_FN_2_IN), 	// EXTCLK
#endif
#ifdef CONFIG_SSP2_EN
	// pins needed for SSP2
	(36 | GPIO_ALT_FN_2_OUT), 	// CLK
	(37 | GPIO_ALT_FN_2_OUT), 	// Frame
	(13 | GPIO_ALT_FN_1_OUT), 	// TX
	(29 | GPIO_ALT_FN_1_OUT), 	// RX (yes, out)
	// don't enable EXTCLK unless you actually are using it. Otherwise,
	// the SSPCLK will always run (for some strange reason)
	//(22 | GPIO_ALT_FN_1_IN), 	// EXTCLK
#endif
};


// SPI Chips

#ifdef CONFIG_SSP1_EN

// enable as needed
//#define M25P16		// SPI FLash
#define SD		// driver for SD card in SPI mode

// use FRM as CS0
static gpreg ssp1_cs0_gpio = {
	.name = "SSP1 CS0",
	.offset = 24,
	.output = 1,
	.act_low = 1,
	.drv = &pxa_gpreg_drv,
};

// use EXTCLK as CS1
static gpreg ssp1_cs1_gpio = {
	.name = "SSP1 CS1",
	.offset = 27,
	.output = 1,
	.act_low = 1,
	.drv = &pxa_gpreg_drv,

};

// SPI driver callback to manipulate CS0
static void ssp_cs0_cb(u32 command)
{
	if (command == PXA2XX_CS_ASSERT)
		gpreg_activate(&ssp1_cs0_gpio);
	else
		gpreg_deactivate(&ssp1_cs0_gpio);
}

// SPI driver callback to manipulate CS1
static void ssp_cs1_cb(u32 command)
{
	if (command == PXA2XX_CS_ASSERT)
		gpreg_activate(&ssp1_cs1_gpio);
	else
		gpreg_deactivate(&ssp1_cs1_gpio);
}

/* SPI chip data */
static struct pxa2xx_spi_chip ssp1_cs0_settings = {
	.tx_threshold	= 12,
	.rx_threshold	= 4,
	.cs_control		= ssp_cs0_cb,
};
static struct pxa2xx_spi_chip ssp1_cs1_settings = {
	.cs_control		= ssp_cs1_cb,
};

#ifdef M25P16
// declare the type of SPI flash and MTD config info
static struct flash_platform_data pdata_m25p16 = {
	.name = "spi",
	.type = "m25p16",
};
#endif

// The set of devices that are on the SPI (1) bus.
static struct spi_board_info spi1_chips[] __initdata = {
	// This setup is invalid because they all use CS0. If this were a real
	// setup, they would all use different controller_data's. For this example,
	// it allows each device to be used by physically connecting and
	// disconnecting (and insmod/rmmod) as needed for testing.
	// 'spidev' is a user-mode interface. It can theoritically be used alongside
	// a kernel-mode driver as long as they are not used at the same time. The
	// spidev interface allows user-mode debugging of the kernel-mode driver.
	// If a real user-mode driver was used, the kernel driver would need to be disabled.
	// The .chip_select field is better called device-index.
	{
		.modalias		= "spidev",
		//.platform_data	= 0,
		.controller_data = &ssp1_cs0_settings,
		//.irq			= DEV_IRQ,
		//.mode 		= SPI_CPOL | SPI_CPHA,
		.max_speed_hz	= 10 MHZ,		// max - PXA only does 13MHz
		.bus_num		= 1,			// SSP1
		.chip_select	= 0,			// device number on bus (0-based)
	},
	{
		.modalias		= "spidev",
		.controller_data = &ssp1_cs1_settings,
		.max_speed_hz	= 10 MHZ,		// max - PXA only does 13MHz
		.bus_num		= 1,			// SSP1
		.chip_select	= 1,			// device number on bus (0-based)
	},
#ifdef M25P16
	{	// SPI FLash
		.modalias		= "m25p80",
		.platform_data	= &pdata_m25p16,
		.controller_data = &ssp1_cs0_settings,
		.max_speed_hz	= 20 MHZ,
		.bus_num		= 1,
		.chip_select	= 2,	// device number on bus (0-based)
	},
#endif
#ifdef SD
	{
		.modalias		= "mmc_spi",
		.controller_data = &ssp1_cs0_settings,
		.max_speed_hz	= 20 MHZ,
		.bus_num		= 1,
		#ifdef M25P16
			.chip_select	= 3,	// device number on bus (0-based)
		#else
			.chip_select	= 2,	// device number on bus (0-based)
		#endif
	},
#endif
};

static struct resource pxa_ssp1_resources[] = {
	{
		.start	= __PREG(SSCR0_P(1)),	/* Start address of SSP1 registers */
		.end	= __PREG(SSCR0_P(1)) + SSP_REG_LEN - 1,
		.flags	= IORESOURCE_MEM,
	},
	{
		.start	= IRQ_SSP,
		.end	= IRQ_SSP,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct pxa2xx_spi_master pxa_ssp1_master_info = {
	.ssp_type		= PXA27x_SSP,
	.clock_enable	= CKEN_SSP1,
	.num_chipselect	= ARRAY_SIZE(spi1_chips),	/* number of chips attached to SSP */
	.enable_dma		= 1,
};

static struct platform_device pxa_ssp1 = {
	.name		= "pxa2xx-spi",			/* driver to use */
	.id			= 1,					/* Bus number, MUST MATCH SSP number 1..n */
	.resource	= pxa_ssp1_resources,
	.num_resources = ARRAY_SIZE(pxa_ssp1_resources),
	.dev = {
		.platform_data	= &pxa_ssp1_master_info,
	},
};
#else
#define spi1_chips 0
#endif

#ifdef CONFIG_SSP2_EN
// The set of devices that are on the SPI (2) bus.
static struct spi_board_info spi2_chips[] __initdata = {
	// Enable an spidev "chip" for debugging
	{
		.modalias		= "spidev",
		.max_speed_hz	= 20 MHZ,		// max - PXA only does 13MHz
		.bus_num		= 2,			// SSP1
		.chip_select	= 0,			// device number on bus (0-based)
	},
};

static struct resource pxa_ssp2_resources[] = {
	{
		.start  = __PREG(SSCR0_P(2)),	/* Start address of SSP2 registers */
		.end    = __PREG(SSCR0_P(2)) + SSP_REG_LEN - 1,
		.flags  = IORESOURCE_MEM,
	},
	{
		.start  = IRQ_SSP2,
		.end    = IRQ_SSP2,
		.flags  = IORESOURCE_IRQ,
	},
};

static struct pxa2xx_spi_master pxa_ssp2_master_info = {
	.ssp_type = PXA27x_SSP,
	.clock_enable = CKEN_SSP2,
	.num_chipselect	= ARRAY_SIZE(spi2_chips),	/* number of chips attached to SSP */
	.enable_dma = 0,
};

static struct platform_device pxa_ssp2 = {
	.name 		= "pxa2xx-spi",			/* driver to use */
	.id 		= 2,					/* Bus number, MUST MATCH SSP number 1..n */
	.resource 	= pxa_ssp2_resources,
	.num_resources = ARRAY_SIZE(pxa_ssp2_resources),
	.dev = {
		.platform_data = &pxa_ssp2_master_info, /* Passed to driver */
	},
};
#else
#define spi2_chips 0
#endif

static struct platform_device *ssp_devices[] __initdata = {
#ifdef CONFIG_SSP1_EN
    &pxa_ssp1,
#endif
#ifdef CONFIG_SSP2_EN
    &pxa_ssp2,
#endif
};

// the set of gpregs that need to be initialized
static gpreg* sspregs[] __initdata = {
#ifdef CONFIG_SSP1_EN
	&ssp1_cs0_gpio,
	&ssp1_cs1_gpio,
#endif
#ifdef CONFIG_SSP2_EN
#endif
};


// Module initialization
// called from platform
extern int __init ft4_ssp_init(void)
{
	pr_info("Installing SSP drivers/devices\n");
	/* SSP GPIO setup */
	pxa_gpio_init(ssp_gpio_init_list, ARRAY_SIZE(ssp_gpio_init_list));
	// initialize our GPIO pins
	gpreg **reg = sspregs;
	for (int i = 0; i < ARRAY_SIZE(sspregs); i++, reg++) {
		if (gpreg_init(*reg)) {
			return -ENODEV;
		}
	}
	// register ssp controllers
	int err = platform_add_devices(ssp_devices, ARRAY_SIZE(ssp_devices));
	// register spi chips
	if (spi1_chips)
		spi_register_board_info(spi1_chips, ARRAY_SIZE(spi1_chips));
	if (spi2_chips)
		spi_register_board_info(spi2_chips, ARRAY_SIZE(spi2_chips));
	return err;
}

--------------070505000005020106070603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------070505000005020106070603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------070505000005020106070603--
