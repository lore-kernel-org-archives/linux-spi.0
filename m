From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC PATCH V2] generic SPI driver for all
	i.MX-platforms
Date: Thu, 26 Feb 2009 17:21:55 +0100
Message-ID: <1235665315-2792-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

So, here is my second version of the generic SPI driver for i.MX. Changes
include:

* bugfix to make it work with i.MX31 (tested)
* supports multiple chip-selects (untested)
* pdata_exit-function now void
* check result of pdata_init-function
* spi_versions for i.MX35 and MX1 added
* fixing comments in a few places

Would be great, if you could give it a try...

Regards,

Wolfram

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 arch/arm/plat-mxc/include/mach/spi_imx.h |   72 +++
 drivers/spi/Kconfig                      |   12 +-
 drivers/spi/spi_imx.c                    |  785 ++++++++++++++++++------------
 3 files changed, 560 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/spi_imx.h

diff --git a/arch/arm/plat-mxc/include/mach/spi_imx.h b/arch/arm/plat-mxc/include/mach/spi_imx.h
new file mode 100644
index 0000000..e734ced
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/spi_imx.h
@@ -0,0 +1,72 @@
+/*
+ * arch/arm/plat-mxc/include/mach/spi_imx.h
+ *
+ * Copyright (C) 2006 SWAPP
+ *	Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
+ * Copyright (C) 2009 Pengutronix
+ *	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+ *
+ * Initial version inspired by:
+ *	linux-2.6.17-rc3-mm1/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef SPI_IMX_H_
+#define SPI_IMX_H_
+
+/*-------------------------------------------------------------------------*/
+/**
+ * struct spi_imx_master - device.platform_data for SPI controller devices.
+ * @num_chipselect: chipselects are used to distinguish individual
+ *	SPI slaves, and are numbered from zero to num_chipselects - 1.
+ *	each slave has a chipselect signal, but it's common that not
+ *	every chipselect is connected to a slave.
+ * @enable_dma: if true enables DMA driven transfers.
+*/
+struct spi_imx_master {
+	u8 num_chipselect;
+	u8 enable_dma:1;
+	int (*init)(struct platform_device *pdev);
+	void (*exit)(struct platform_device *pdev);
+};
+/*-------------------------------------------------------------------------*/
+
+/*-------------------------------------------------------------------------*/
+/**
+ * struct spi_imx_chip - spi_board_info.controller_data for SPI
+ * slave devices, copied to spi_device.controller_data.
+ * @enable_loopback : used for test purpouse to internally connect RX and TX
+ *	sections.
+ * @enable_dma : enables dma transfer (provided that controller driver has
+ *	dma enabled too).
+ * @ins_ss_pulse : enable /SS pulse insertion between SPI burst.
+ * @bclk_wait : number of bclk waits between each bits_per_word SPI burst.
+ * @cs_control : function pointer to board-specific function to assert/deassert
+ *	I/O port to control HW generation of devices chip-select.
+*/
+struct spi_imx_chip {
+	u8	enable_dma:1;
+	u8	ins_ss_pulse:1;
+	u16	bclk_wait:15;
+	void (*cs_control)(u32 control);
+};
+
+/* Chip-select state */
+#define SPI_CS_ASSERT			(1 << 0)
+#define SPI_CS_DEASSERT			(1 << 1)
+/*-------------------------------------------------------------------------*/
+
+#endif /* SPI_IMX_H_*/
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83a185d..4262a94 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -117,12 +117,18 @@ config SPI_GPIO
 	  speed with a custom version of this driver; see the source code.
 
 config SPI_IMX
-	tristate "Freescale iMX SPI controller"
-	depends on ARCH_IMX && EXPERIMENTAL
+	tristate "Freescale iMX SPI controllers"
+	depends on (ARCH_IMX || ARCH_MXC) && EXPERIMENTAL
 	help
-	  This enables using the Freescale iMX SPI controller in master
+	  This enables using the Freescale iMX SPI controllers in master
 	  mode.
 
+config SPI_IMX_DMA
+	bool "use DMA for iMX SPI controllers"
+	depends on SPI_IMX && ARCH_IMX
+	help
+	  This enables DMA usage for the Freescale iMX SPI controllers.
+
 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
 	depends on PARPORT && EXPERIMENTAL
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 269a55e..4eade37 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2006 SWAPP
  *	Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
+ * Copyright (C) 2009 Pengutronix
+ *	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
  *
  * Initial version inspired by:
  *	linux-2.6.17-rc3-mm1/drivers/spi/pxa2xx_spi.c
@@ -30,95 +32,30 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/log2.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
 
 #include <mach/hardware.h>
-#include <mach/imx-dma.h>
 #include <mach/spi_imx.h>
+#ifdef CONFIG_SPI_IMX_DMA
+#  include <mach/imx-dma.h>
+#endif
 
 /*-------------------------------------------------------------------------*/
-/* SPI Registers offsets from peripheral base address */
-#define SPI_RXDATA		(0x00)
-#define SPI_TXDATA		(0x04)
-#define SPI_CONTROL		(0x08)
-#define SPI_INT_STATUS		(0x0C)
-#define SPI_TEST		(0x10)
-#define SPI_PERIOD		(0x14)
-#define SPI_DMA			(0x18)
-#define SPI_RESET		(0x1C)
-
-/* SPI Control Register Bit Fields & Masks */
-#define SPI_CONTROL_BITCOUNT_MASK	(0xF)		/* Bit Count Mask */
-#define SPI_CONTROL_BITCOUNT(n)		(((n) - 1) & SPI_CONTROL_BITCOUNT_MASK)
-#define SPI_CONTROL_POL			(0x1 << 4)      /* Clock Polarity Mask */
-#define SPI_CONTROL_POL_ACT_HIGH	(0x0 << 4)      /* Active high pol. (0=idle) */
-#define SPI_CONTROL_POL_ACT_LOW		(0x1 << 4)      /* Active low pol. (1=idle) */
-#define SPI_CONTROL_PHA			(0x1 << 5)      /* Clock Phase Mask */
-#define SPI_CONTROL_PHA_0		(0x0 << 5)      /* Clock Phase 0 */
-#define SPI_CONTROL_PHA_1		(0x1 << 5)      /* Clock Phase 1 */
-#define SPI_CONTROL_SSCTL		(0x1 << 6)      /* /SS Waveform Select Mask */
-#define SPI_CONTROL_SSCTL_0		(0x0 << 6)      /* Master: /SS stays low between SPI burst
-							   Slave: RXFIFO advanced by BIT_COUNT */
-#define SPI_CONTROL_SSCTL_1		(0x1 << 6)      /* Master: /SS insert pulse between SPI burst
-							   Slave: RXFIFO advanced by /SS rising edge */
-#define SPI_CONTROL_SSPOL		(0x1 << 7)      /* /SS Polarity Select Mask */
-#define SPI_CONTROL_SSPOL_ACT_LOW	(0x0 << 7)      /* /SS Active low */
-#define SPI_CONTROL_SSPOL_ACT_HIGH	(0x1 << 7)      /* /SS Active high */
-#define SPI_CONTROL_XCH			(0x1 << 8)      /* Exchange */
-#define SPI_CONTROL_SPIEN		(0x1 << 9)      /* SPI Module Enable */
-#define SPI_CONTROL_MODE		(0x1 << 10)     /* SPI Mode Select Mask */
-#define SPI_CONTROL_MODE_SLAVE		(0x0 << 10)     /* SPI Mode Slave */
-#define SPI_CONTROL_MODE_MASTER		(0x1 << 10)     /* SPI Mode Master */
-#define SPI_CONTROL_DRCTL		(0x3 << 11)     /* /SPI_RDY Control Mask */
-#define SPI_CONTROL_DRCTL_0		(0x0 << 11)     /* Ignore /SPI_RDY */
-#define SPI_CONTROL_DRCTL_1		(0x1 << 11)     /* /SPI_RDY falling edge triggers input */
-#define SPI_CONTROL_DRCTL_2		(0x2 << 11)     /* /SPI_RDY active low level triggers input */
-#define SPI_CONTROL_DATARATE		(0x7 << 13)     /* Data Rate Mask */
-#define SPI_PERCLK2_DIV_MIN		(0)		/* PERCLK2:4 */
-#define SPI_PERCLK2_DIV_MAX		(7)		/* PERCLK2:512 */
-#define SPI_CONTROL_DATARATE_MIN	(SPI_PERCLK2_DIV_MAX << 13)
-#define SPI_CONTROL_DATARATE_MAX	(SPI_PERCLK2_DIV_MIN << 13)
-#define SPI_CONTROL_DATARATE_BAD	(SPI_CONTROL_DATARATE_MIN + 1)
-
-/* SPI Interrupt/Status Register Bit Fields & Masks */
-#define SPI_STATUS_TE	(0x1 << 0)	/* TXFIFO Empty Status */
-#define SPI_STATUS_TH	(0x1 << 1)      /* TXFIFO Half Status */
-#define SPI_STATUS_TF	(0x1 << 2)      /* TXFIFO Full Status */
-#define SPI_STATUS_RR	(0x1 << 3)      /* RXFIFO Data Ready Status */
-#define SPI_STATUS_RH	(0x1 << 4)      /* RXFIFO Half Status */
-#define SPI_STATUS_RF	(0x1 << 5)      /* RXFIFO Full Status */
-#define SPI_STATUS_RO	(0x1 << 6)      /* RXFIFO Overflow */
-#define SPI_STATUS_BO	(0x1 << 7)      /* Bit Count Overflow */
-#define SPI_STATUS	(0xFF)		/* SPI Status Mask */
-#define SPI_INTEN_TE	(0x1 << 8)      /* TXFIFO Empty Interrupt Enable */
-#define SPI_INTEN_TH	(0x1 << 9)      /* TXFIFO Half Interrupt Enable */
-#define SPI_INTEN_TF	(0x1 << 10)     /* TXFIFO Full Interrupt Enable */
-#define SPI_INTEN_RE	(0x1 << 11)     /* RXFIFO Data Ready Interrupt Enable */
-#define SPI_INTEN_RH	(0x1 << 12)     /* RXFIFO Half Interrupt Enable */
-#define SPI_INTEN_RF	(0x1 << 13)     /* RXFIFO Full Interrupt Enable */
-#define SPI_INTEN_RO	(0x1 << 14)     /* RXFIFO Overflow Interrupt Enable */
-#define SPI_INTEN_BO	(0x1 << 15)     /* Bit Count Overflow Interrupt Enable */
-#define SPI_INTEN	(0xFF << 8)	/* SPI Interrupt Enable Mask */
-
 /* SPI Test Register Bit Fields & Masks */
 #define SPI_TEST_TXCNT		(0xF << 0)	/* TXFIFO Counter */
 #define SPI_TEST_RXCNT_LSB	(4)		/* RXFIFO Counter LSB */
 #define SPI_TEST_RXCNT		(0xF << 4)	/* RXFIFO Counter */
-#define SPI_TEST_SSTATUS	(0xF << 8)	/* State Machine Status */
 #define SPI_TEST_LBC		(0x1 << 14)	/* Loop Back Control */
 
 /* SPI Period Register Bit Fields & Masks */
-#define SPI_PERIOD_WAIT		(0x7FFF << 0)	/* Wait Between Transactions */
 #define SPI_PERIOD_MAX_WAIT	(0x7FFF)	/* Max Wait Between
 							Transactions */
-#define SPI_PERIOD_CSRC		(0x1 << 15)	/* Period Clock Source Mask */
 #define SPI_PERIOD_CSRC_BCLK	(0x0 << 15)	/* Period Clock Source is
 							Bit Clock */
-#define SPI_PERIOD_CSRC_32768	(0x1 << 15)	/* Period Clock Source is
-							32.768 KHz Clock */
 
 /* SPI DMA Register Bit Fields & Masks */
 #define SPI_DMA_RHDMA	(0x1 << 4)	/* RXFIFO Half Status */
@@ -130,22 +67,6 @@
 #define SPI_DMA_TEDEN	(0x1 << 14)     /* TXFIFO Empty DMA Request Enable */
 #define SPI_DMA_THDEN	(0x1 << 15)     /* TXFIFO Half DMA Request Enable */
 
-/* SPI Soft Reset Register Bit Fields & Masks */
-#define SPI_RESET_START	(0x1)		/* Start */
-
-/* Default SPI configuration values */
-#define SPI_DEFAULT_CONTROL		\
-(					\
-	SPI_CONTROL_BITCOUNT(16) | 	\
-	SPI_CONTROL_POL_ACT_HIGH |	\
-	SPI_CONTROL_PHA_0 |		\
-	SPI_CONTROL_SPIEN |		\
-	SPI_CONTROL_SSCTL_1 |		\
-	SPI_CONTROL_MODE_MASTER |	\
-	SPI_CONTROL_DRCTL_0 |		\
-	SPI_CONTROL_DATARATE_MIN	\
-)
-#define SPI_DEFAULT_ENABLE_LOOPBACK	(0)
 #define SPI_DEFAULT_ENABLE_DMA		(0)
 #define SPI_DEFAULT_PERIOD_WAIT		(8)
 /*-------------------------------------------------------------------------*/
@@ -154,11 +75,10 @@
 /*-------------------------------------------------------------------------*/
 /* TX/RX SPI FIFO size */
 #define SPI_FIFO_DEPTH			(8)
-#define SPI_FIFO_BYTE_WIDTH		(2)
 #define SPI_FIFO_OVERFLOW_MARGIN	(2)
 
 /* DMA burst length for half full/empty request trigger */
-#define SPI_DMA_BLR			(SPI_FIFO_DEPTH * SPI_FIFO_BYTE_WIDTH / 2)
+#define SPI_DMA_BLR			(SPI_FIFO_DEPTH * (drv_data->version->max_bitcount / 8) / 2)
 
 /* Dummy char output to achieve reads.
    Choosing something different from all zeroes may help pattern recogition
@@ -168,12 +88,21 @@
 #define SPI_DUMMY_u32			((SPI_DUMMY_u16 << 16) | SPI_DUMMY_u16)
 
 /**
- * Macro to change a u32 field:
+ * U32_EDIT_WITH_SHIFT: Macro to change a u32 field:
  * @r : register to edit
  * @m : bit mask
- * @v : new value for the field correctly bit-alligned
+ * @v : new value
+ * @s : amount to shift for mask and value
+*/
+#define u32_EDIT_WITH_SHIFT(r, m, v, s)		r = (r & ~((m) << (s))) | ((v) << (s))
+
+/**
+ * U32_EDIT_BIT_COND: Macro to change a bit in a u32 field conditionally:
+ * @r : register to edit
+ * @c : condition according to which the bit will be set
+ * @s : amount to shift for the desired bit
 */
-#define u32_EDIT(r, m, v)		r = (r & ~(m)) | (v)
+#define u32_EDIT_BIT_COND(r, c, s)		r = (r & ~(1 << (s))) | (!!(c) << (s))
 
 /* Message state */
 #define START_STATE			((void*)0)
@@ -192,6 +121,184 @@
 /*-------------------------------------------------------------------------*/
 /* Driver data structs */
 
+struct driver_data;
+static u32 calc_datarate_linear(struct driver_data *drv_data, u32 speed_hz, u32 *val);
+static u32 calc_datarate_nonlinear(struct driver_data *drv_data, u32 speed_hz, u32 *val);
+
+struct spi_core_version {
+	u32 rxdata;
+	u32 txdata;
+	u32 ctrl;
+	u32 int_en;
+	u32 status;
+	u32 test;
+	u32 period;
+	u32 dma;
+	u32 reset;
+
+	u32 int_te;
+	u32 int_th;
+	u32 int_ro;
+	u32 int_te_en;
+	u32 int_th_en;
+	u32 int_ro_en;
+	u32 xch;
+
+	u8 bitcount_shift;
+	u8 sspol_shift;
+	u8 ssctl_shift;
+	u8 pha_shift;
+	u8 pol_shift;
+	u8 datarate_shift;
+	u8 cs_shift;
+	u8 reset_val;
+
+	u32 max_divider;
+	u32 max_bitcount;
+	u32 default_ctrl;
+	u32 (*calc_datarate)(struct driver_data *drv_data, u32 speed_hz, u32 *val);
+};
+
+static struct spi_core_version spi_core_ver_mx35 = {
+	.rxdata = 0x00,
+	.txdata = 0x04,
+	.ctrl = 0x08,
+	.int_en = 0x0c,
+	.dma = 0x10,
+	.status = 0x14,
+	.period = 0x18,
+	.test = 0x1c,
+	.reset = 0x08,
+
+	.int_te = 1 << 0,
+	.int_th = 1 << 1,
+	.int_ro = 1 << 6,
+	.int_te_en = 1 << 0,
+	.int_th_en = 1 << 1,
+	.int_ro_en = 1 << 6,
+	.xch = 1 << 2,
+
+	.bitcount_shift = 20,
+	.sspol_shift = 7,
+	.ssctl_shift = 6,
+	.pha_shift = 5,
+	.pol_shift = 4,
+	.datarate_shift = 16,
+	.cs_shift = 12,
+	.reset_val = 0,
+
+	.max_divider = 512,
+	/* for now we artificially limit max_bitcount */
+	.max_bitcount = 32,
+	.default_ctrl = 0x01f70043,
+	.calc_datarate = calc_datarate_linear,
+};
+
+/* used in: MX31 */
+static struct spi_core_version spi_core_ver_0_4 = {
+	.rxdata = 0x00,
+	.txdata = 0x04,
+	.ctrl = 0x08,
+	.int_en = 0x0c,
+	.dma = 0x10,
+	.status = 0x14,
+	.period = 0x18,
+	.test = 0x1c,
+	.reset = 0x08,
+
+	.int_te = 1 << 0,
+	.int_th = 1 << 1,
+	.int_ro = 1 << 6,
+	.int_te_en = 1 << 0,
+	.int_th_en = 1 << 1,
+	.int_ro_en = 1 << 6,
+	.xch = 1 << 2,
+
+	.bitcount_shift = 8,
+	.sspol_shift = 7,
+	.ssctl_shift = 6,
+	.pha_shift = 5,
+	.pol_shift = 4,
+	.datarate_shift = 16,
+	.cs_shift = 24,
+	.reset_val = 0,
+
+	.max_divider = 512,
+	.max_bitcount = 32,
+	.default_ctrl = 0x00071f43,
+	.calc_datarate = calc_datarate_linear,
+};
+
+/* used in: MX27 */
+static struct spi_core_version spi_core_ver_0_0 = {
+	.rxdata = 0x00,
+	.txdata = 0x04,
+	.ctrl = 0x08,
+	.int_en = 0x0c,
+	.dma = 0x18,
+	.status = 0x0c,
+	.period = 0x14,
+	.test = 0x10,
+	.reset = 0x1c,
+
+	.int_te = 1 << 0,
+	.int_th = 1 << 1,
+	.int_ro = 1 << 7,
+	.int_te_en = 1 << 9,
+	.int_th_en = 1 << 10,
+	.int_ro_en = 1 << 16,
+	.xch = 1 << 9,
+
+	.bitcount_shift = 0,
+	.sspol_shift = 8,
+	.ssctl_shift = 7,
+	.pha_shift = 6,
+	.pol_shift = 5,
+	.datarate_shift = 14,
+	.cs_shift = 19,
+	.reset_val = 1,
+
+	.max_divider = 512,
+	.max_bitcount = 32,
+	.default_ctrl = 0x00040c9f,
+	.calc_datarate = calc_datarate_nonlinear,
+};
+
+static struct spi_core_version spi_core_ver_mx1 = {
+	.rxdata = 0x00,
+	.txdata = 0x04,
+	.ctrl = 0x08,
+	.int_en = 0x0c,
+	.dma = 0x18,
+	.status = 0x0c,
+	.period = 0x14,
+	.test = 0x10,
+	.reset = 0x1c,
+
+	.int_te = 1 << 0,
+	.int_th = 1 << 1,
+	.int_ro = 1 << 6,
+	.int_te_en = 1 << 8,
+	.int_th_en = 1 << 9,
+	.int_ro_en = 1 << 14,
+	.xch = 1 << 8,
+
+	.bitcount_shift = 0,
+	.sspol_shift = 7,
+	.ssctl_shift = 6,
+	.pha_shift = 5,
+	.pol_shift = 4,
+	.datarate_shift = 13,
+	/* dummy value outside 16-bit range as MX1 has just one CS */
+	.cs_shift = 16,
+	.reset_val = 1,
+
+	.max_divider = 512,
+	.max_bitcount = 16,
+	.default_ctrl = 0x0000e64f,
+	.calc_datarate = calc_datarate_linear,
+};
+
 /* Context */
 struct driver_data {
 	/* Driver model hookup */
@@ -207,6 +314,8 @@ struct driver_data {
 	struct resource *ioarea;
 	void __iomem *regs;
 
+	struct spi_core_version *version;
+
 	/* SPI RX_DATA physical address */
 	dma_addr_t rd_data_phys;
 
@@ -269,7 +378,6 @@ struct chip_data {
 };
 /*-------------------------------------------------------------------------*/
 
-
 static void pump_messages(struct work_struct *work);
 
 static void flush(struct driver_data *drv_data)
@@ -281,17 +389,18 @@ static void flush(struct driver_data *drv_data)
 
 	/* Wait for end of transaction */
 	do {
-		control = readl(regs + SPI_CONTROL);
-	} while (control & SPI_CONTROL_XCH);
+		control = readl(regs + drv_data->version->ctrl);
+	} while (control & drv_data->version->xch);
 
 	/* Release chip select if requested, transfer delays are
 	   handled in pump_transfers */
 	if (drv_data->cs_change)
 		drv_data->cs_control(SPI_CS_DEASSERT);
 
-	/* Disable SPI to flush FIFOs */
-	writel(control & ~SPI_CONTROL_SPIEN, regs + SPI_CONTROL);
-	writel(control, regs + SPI_CONTROL);
+	/* Flush RXFIFO (not all spi-cores support hardware flushing) */
+	while (readl(regs + drv_data->version->test) & SPI_TEST_RXCNT)
+		readl(regs + drv_data->version->rxdata);
+
 }
 
 static void restore_state(struct driver_data *drv_data)
@@ -306,26 +415,16 @@ static void restore_state(struct driver_data *drv_data)
 		"    control = 0x%08X\n",
 		chip->test,
 		chip->control);
-	writel(chip->test, regs + SPI_TEST);
-	writel(chip->period, regs + SPI_PERIOD);
-	writel(0, regs + SPI_INT_STATUS);
-	writel(chip->control, regs + SPI_CONTROL);
+	writel(chip->test, regs + drv_data->version->test);
+	writel(chip->period, regs + drv_data->version->period);
+	writel(0, regs + drv_data->version->int_en);
+	writel(chip->control, regs + drv_data->version->ctrl);
 }
 
 static void null_cs_control(u32 command)
 {
 }
 
-static inline u32 data_to_write(struct driver_data *drv_data)
-{
-	return ((u32)(drv_data->tx_end - drv_data->tx)) / drv_data->n_bytes;
-}
-
-static inline u32 data_to_read(struct driver_data *drv_data)
-{
-	return ((u32)(drv_data->rx_end - drv_data->rx)) / drv_data->n_bytes;
-}
-
 static int write(struct driver_data *drv_data)
 {
 	void __iomem *regs = drv_data->regs;
@@ -334,24 +433,23 @@ static int write(struct driver_data *drv_data)
 	u8 n_bytes = drv_data->n_bytes;
 	u32 remaining_writes;
 	u32 fifo_avail_space;
-	u32 n;
-	u16 d;
+	u32 n,d;
 
 	/* Compute how many fifo writes to do */
-	remaining_writes = (u32)(tx_end - tx) / n_bytes;
+	remaining_writes = (u32)DIV_ROUND_UP(tx_end - tx, n_bytes);
 	fifo_avail_space = SPI_FIFO_DEPTH -
-				(readl(regs + SPI_TEST) & SPI_TEST_TXCNT);
+				(readl(regs + drv_data->version->test) & SPI_TEST_TXCNT);
 	if (drv_data->rx && (fifo_avail_space > SPI_FIFO_OVERFLOW_MARGIN))
 		/* Fix misunderstood receive overflow */
 		fifo_avail_space -= SPI_FIFO_OVERFLOW_MARGIN;
 	n = min(remaining_writes, fifo_avail_space);
 
 	dev_dbg(&drv_data->pdev->dev,
-		"write type %s\n"
+		"write type u%d\n"
 		"    remaining writes = %d\n"
 		"    fifo avail space = %d\n"
 		"    fifo writes      = %d\n",
-		(n_bytes == 1) ? "u8" : "u16",
+		n_bytes << 3,
 		remaining_writes,
 		fifo_avail_space,
 		n);
@@ -361,26 +459,36 @@ static int write(struct driver_data *drv_data)
 		if (drv_data->rd_only) {
 			tx += n * n_bytes;
 			while (n--)
-				writel(SPI_DUMMY_u16, regs + SPI_TXDATA);
+				writel(SPI_DUMMY_u32, regs + drv_data->version->txdata);
 		} else {
-			if (n_bytes == 1) {
+			switch (n_bytes) {
+			case 4:
 				while (n--) {
-					d = *(u8*)tx;
-					writel(d, regs + SPI_TXDATA);
-					tx += 1;
+					d = *(u32*)tx;
+					writel(d, regs + drv_data->version->txdata);
+					tx += 4;
 				}
-			} else {
+				break;
+			case 2:
 				while (n--) {
 					d = *(u16*)tx;
-					writel(d, regs + SPI_TXDATA);
+					writel(d, regs + drv_data->version->txdata);
 					tx += 2;
 				}
+				break;
+			case 1:
+				while (n--) {
+					d = *(u8*)tx;
+					writel(d, regs + drv_data->version->txdata);
+					tx += 1;
+				}
+				break;
 			}
 		}
 
 		/* Trigger transfer */
-		writel(readl(regs + SPI_CONTROL) | SPI_CONTROL_XCH,
-			regs + SPI_CONTROL);
+		writel(readl(regs + drv_data->version->ctrl) | drv_data->version->xch,
+			regs + drv_data->version->ctrl);
 
 		/* Update tx pointer */
 		drv_data->tx = tx;
@@ -397,39 +505,49 @@ static int read(struct driver_data *drv_data)
 	u8 n_bytes = drv_data->n_bytes;
 	u32 remaining_reads;
 	u32 fifo_rxcnt;
-	u32 n;
-	u16 d;
+	u32 n,d;
 
 	/* Compute how many fifo reads to do */
-	remaining_reads = (u32)(rx_end - rx) / n_bytes;
-	fifo_rxcnt = (readl(regs + SPI_TEST) & SPI_TEST_RXCNT) >>
+	remaining_reads = (u32)DIV_ROUND_UP(rx_end - rx, n_bytes);
+
+	fifo_rxcnt = (readl(regs + drv_data->version->test) & SPI_TEST_RXCNT) >>
 			SPI_TEST_RXCNT_LSB;
 	n = min(remaining_reads, fifo_rxcnt);
 
 	dev_dbg(&drv_data->pdev->dev,
-		"read type %s\n"
+		"read type u%d\n"
 		"    remaining reads = %d\n"
 		"    fifo rx count   = %d\n"
 		"    fifo reads      = %d\n",
-		(n_bytes == 1) ? "u8" : "u16",
+		n_bytes << 3,
 		remaining_reads,
 		fifo_rxcnt,
 		n);
 
 	if (n > 0) {
 		/* Read SPI RXFIFO */
-		if (n_bytes == 1) {
+		switch (n_bytes) {
+		case 4:
 			while (n--) {
-				d = readl(regs + SPI_RXDATA);
-				*((u8*)rx) = d;
-				rx += 1;
+				d = readl(regs + drv_data->version->rxdata);
+				*((u32*)rx) = d;
+				rx += 4;
 			}
-		} else {
+			break;
+		case 2:
 			while (n--) {
-				d = readl(regs + SPI_RXDATA);
+				d = readl(regs + drv_data->version->rxdata);
 				*((u16*)rx) = d;
 				rx += 2;
 			}
+			break;
+		case 1:
+			while (n--) {
+				d = readl(regs + drv_data->version->rxdata);
+				*((u8*)rx) = d;
+				rx += 1;
+			}
+			break;
 		}
 
 		/* Update rx pointer */
@@ -456,6 +574,30 @@ static void *next_transfer(struct driver_data *drv_data)
 	return DONE_STATE;
 }
 
+/* Caller already set message->status (dma is already blocked) */
+static void giveback(struct spi_message *message, struct driver_data *drv_data)
+{
+	void __iomem *regs = drv_data->regs;
+
+	/* Bring SPI to sleep; restore_state() and pump_transfer()
+	   will do new setup */
+	writel(0, regs + drv_data->version->int_en);
+	writel(0, regs + drv_data->version->dma);
+
+	/* Unconditioned deselct */
+	drv_data->cs_control(SPI_CS_DEASSERT);
+
+	message->state = NULL;
+	if (message->complete)
+		message->complete(message->context);
+
+	drv_data->cur_msg = NULL;
+	drv_data->cur_transfer = NULL;
+	drv_data->cur_chip = NULL;
+	queue_work(drv_data->workqueue, &drv_data->work);
+}
+
+#ifdef CONFIG_SPI_IMX_DMA
 static int map_dma_buffers(struct driver_data *drv_data)
 {
 	struct spi_message *msg;
@@ -568,29 +710,6 @@ static void unmap_dma_buffers(struct driver_data *drv_data)
 	}
 }
 
-/* Caller already set message->status (dma is already blocked) */
-static void giveback(struct spi_message *message, struct driver_data *drv_data)
-{
-	void __iomem *regs = drv_data->regs;
-
-	/* Bring SPI to sleep; restore_state() and pump_transfer()
-	   will do new setup */
-	writel(0, regs + SPI_INT_STATUS);
-	writel(0, regs + SPI_DMA);
-
-	/* Unconditioned deselct */
-	drv_data->cs_control(SPI_CS_DEASSERT);
-
-	message->state = NULL;
-	if (message->complete)
-		message->complete(message->context);
-
-	drv_data->cur_msg = NULL;
-	drv_data->cur_transfer = NULL;
-	drv_data->cur_chip = NULL;
-	queue_work(drv_data->workqueue, &drv_data->work);
-}
-
 static void dma_err_handler(int channel, void *data, int errcode)
 {
 	struct driver_data *drv_data = data;
@@ -618,20 +737,20 @@ static void dma_tx_handler(int channel, void *data)
 	imx_dma_disable(channel);
 
 	/* Now waits for TX FIFO empty */
-	writel(SPI_INTEN_TE, drv_data->regs + SPI_INT_STATUS);
+	writel(drv_data->version->int_te_en, drv_data->regs + drv_data->version->int_en);
 }
 
 static irqreturn_t dma_transfer(struct driver_data *drv_data)
 {
-	u32 status;
+	u32 status, int_en;
 	struct spi_message *msg = drv_data->cur_msg;
 	void __iomem *regs = drv_data->regs;
 
-	status = readl(regs + SPI_INT_STATUS);
+	status = readl(regs + drv_data->version->status);
+	int_en = readl(regs + drv_data->version->status);
 
-	if ((status & (SPI_INTEN_RO | SPI_STATUS_RO))
-			== (SPI_INTEN_RO | SPI_STATUS_RO)) {
-		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
+	if ((status & drv_data->version->int_ro) && (int_en & drv_data->version->int_ro_en)) {
+		writel(0, regs + drv_data->version->int_en);
 
 		imx_dma_disable(drv_data->tx_channel);
 		imx_dma_disable(drv_data->rx_channel);
@@ -648,12 +767,12 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
 		return IRQ_HANDLED;
 	}
 
-	if (status & SPI_STATUS_TE) {
-		writel(status & ~SPI_INTEN_TE, regs + SPI_INT_STATUS);
+	if (status & drv_data->version->int_te) {
+		writel(status & ~drv_data->version->int_te_en, regs + drv_data->version->int_en);
 
 		if (drv_data->rx) {
 			/* Wait end of transfer before read trailing data */
-			while (readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH)
+			while (readl(regs + drv_data->version->ctrl) & drv_data->version->xch)
 				cpu_relax();
 
 			imx_dma_disable(drv_data->rx_channel);
@@ -667,9 +786,9 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
 			/* Calculate number of trailing data and read them */
 			dev_dbg(&drv_data->pdev->dev,
 				"dma_transfer - test = 0x%08X\n",
-				readl(regs + SPI_TEST));
+				readl(regs + drv_data->version->test));
 			drv_data->rx = drv_data->rx_end -
-					((readl(regs + SPI_TEST) &
+					((readl(regs + drv_data->version->test) &
 					SPI_TEST_RXCNT) >>
 					SPI_TEST_RXCNT_LSB)*drv_data->n_bytes;
 			read(drv_data);
@@ -696,18 +815,21 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
 	return IRQ_NONE;
 }
 
+#endif /* DMA */
+
 static irqreturn_t interrupt_wronly_transfer(struct driver_data *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
 	void __iomem *regs = drv_data->regs;
-	u32 status;
+	u32 status, int_en;
 	irqreturn_t handled = IRQ_NONE;
 
-	status = readl(regs + SPI_INT_STATUS);
+	status = readl(regs + drv_data->version->status);
+	int_en = readl(regs + drv_data->version->int_en);
 
-	if (status & SPI_INTEN_TE) {
+	if (int_en & drv_data->version->int_te_en) {
 		/* TXFIFO Empty Interrupt on the last transfered word */
-		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
+		writel(0, regs + drv_data->version->int_en);
 		dev_dbg(&drv_data->pdev->dev,
 			"interrupt_wronly_transfer - end of tx\n");
 
@@ -724,7 +846,7 @@ static irqreturn_t interrupt_wronly_transfer(struct driver_data *drv_data)
 
 		return IRQ_HANDLED;
 	} else {
-		while (status & SPI_STATUS_TH) {
+		while (status & drv_data->version->int_th) {
 			dev_dbg(&drv_data->pdev->dev,
 				"interrupt_wronly_transfer - status = 0x%08X\n",
 				status);
@@ -733,11 +855,11 @@ static irqreturn_t interrupt_wronly_transfer(struct driver_data *drv_data)
 			if (write(drv_data)) {
 				/* End of TXFIFO writes,
 				   now wait until TXFIFO is empty */
-				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
+				writel(drv_data->version->int_te_en, regs + drv_data->version->int_en);
 				return IRQ_HANDLED;
 			}
 
-			status = readl(regs + SPI_INT_STATUS);
+			status = readl(regs + drv_data->version->status);
 
 			/* We did something */
 			handled = IRQ_HANDLED;
@@ -751,15 +873,16 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
 	void __iomem *regs = drv_data->regs;
-	u32 status, control;
+	u32 status, int_en, control;
 	irqreturn_t handled = IRQ_NONE;
 	unsigned long limit;
 
-	status = readl(regs + SPI_INT_STATUS);
+	status = readl(regs + drv_data->version->status);
+	int_en = readl(regs + drv_data->version->int_en);
 
-	if (status & SPI_INTEN_TE) {
+	if (int_en & drv_data->version->int_te_en) {
 		/* TXFIFO Empty Interrupt on the last transfered word */
-		writel(status & ~SPI_INTEN, regs + SPI_INT_STATUS);
+		writel(0, regs + drv_data->version->int_en);
 		dev_dbg(&drv_data->pdev->dev,
 			"interrupt_transfer - end of tx\n");
 
@@ -769,8 +892,8 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		} else {
 			/* Wait for end of transaction */
 			do {
-				control = readl(regs + SPI_CONTROL);
-			} while (control & SPI_CONTROL_XCH);
+				control = readl(regs + drv_data->version->ctrl);
+			} while (control & drv_data->version->xch);
 
 			/* Release chip select if requested, transfer delays are
 			   handled in pump_transfers */
@@ -801,22 +924,22 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 		return IRQ_HANDLED;
 	} else {
-		while (status & (SPI_STATUS_TH | SPI_STATUS_RO)) {
+		while (status & (drv_data->version->int_th | drv_data->version->int_ro)) {
 			dev_dbg(&drv_data->pdev->dev,
 				"interrupt_transfer - status = 0x%08X\n",
 				status);
 
-			if (status & SPI_STATUS_RO) {
+			if (status & drv_data->version->int_ro) {
 				/* RXFIFO overrun, abort message end wait
 				   until TXFIFO is empty */
-				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
+				writel(drv_data->version->int_te_en, regs + drv_data->version->int_en);
 
 				dev_warn(&drv_data->pdev->dev,
 					"interrupt_transfer - fifo overun\n"
 					"    data not yet written = %d\n"
 					"    data not yet read    = %d\n",
-					data_to_write(drv_data),
-					data_to_read(drv_data));
+					DIV_ROUND_UP(drv_data->tx_end - drv_data->tx, drv_data->n_bytes),
+					DIV_ROUND_UP(drv_data->rx_end - drv_data->rx, drv_data->n_bytes));
 
 				msg->state = ERROR_STATE;
 
@@ -828,11 +951,11 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 			if (write(drv_data)) {
 				/* End of TXFIFO writes,
 				   now wait until TXFIFO is empty */
-				writel(SPI_INTEN_TE, regs + SPI_INT_STATUS);
+				writel(drv_data->version->int_te_en, regs + drv_data->version->int_en);
 				return IRQ_HANDLED;
 			}
 
-			status = readl(regs + SPI_INT_STATUS);
+			status = readl(regs + drv_data->version->status);
 
 			/* We did something */
 			handled = IRQ_HANDLED;
@@ -856,24 +979,44 @@ static irqreturn_t spi_int(int irq, void *dev_id)
 	return drv_data->transfer_handler(drv_data);
 }
 
-static inline u32 spi_speed_hz(struct driver_data *drv_data, u32 data_rate)
+static u32 calc_datarate_nonlinear(struct driver_data *drv_data, u32 speed_hz, u32 *val)
 {
-	return clk_get_rate(drv_data->clk) / (4 << ((data_rate) >> 13));
+	u32 div, max_div;
+	u32 quantized_hz = clk_get_rate(drv_data->clk);
+
+	*val &= ~(0x1f << drv_data->version->datarate_shift);
+
+	max_div = (ilog2(drv_data->version->max_divider) - 1) << 1;
+	/* we start at 2 as 0 is reserved and 1 needs speical care, see refman */
+	for (div = 2; div <= max_div; div += 2, quantized_hz >>= 1) {
+			if (quantized_hz / 4 <= speed_hz) {
+				*val |= div << drv_data->version->datarate_shift;
+				return quantized_hz / 4;
+			}
+			if (quantized_hz / 6 <= speed_hz) {
+				*val |= (div + 1) << drv_data->version->datarate_shift;
+				return quantized_hz / 6;
+			}
+	}
+	/* Nothing found, use slowest speed */
+	*val |= div << drv_data->version->datarate_shift;
+	return 0;
 }
 
-static u32 spi_data_rate(struct driver_data *drv_data, u32 speed_hz)
+static u32 calc_datarate_linear(struct driver_data *drv_data, u32 speed_hz, u32 *val)
 {
 	u32 div;
-	u32 quantized_hz = clk_get_rate(drv_data->clk) >> 2;
-
-	for (div = SPI_PERCLK2_DIV_MIN;
-		div <= SPI_PERCLK2_DIV_MAX;
-		div++, quantized_hz >>= 1) {
-			if (quantized_hz <= speed_hz)
-				/* Max available speed LEQ required speed */
-				return div << 13;
+	u32 quantized_hz = clk_get_rate(drv_data->clk) / 4;
+
+	*val &= ~(7 << drv_data->version->datarate_shift);
+	for (div = 0; div <= 7; div++, quantized_hz >>= 1) {
+			if (quantized_hz <= speed_hz) {
+				*val |= div << drv_data->version->datarate_shift;
+				return quantized_hz;
+			}
 	}
-	return SPI_CONTROL_DATARATE_BAD;
+	*val |= div << drv_data->version->datarate_shift;
+	return 0;
 }
 
 static void pump_transfers(unsigned long data)
@@ -931,7 +1074,7 @@ static void pump_transfers(unsigned long data)
 	drv_data->rd_only = (drv_data->tx == NULL);
 
 	regs = drv_data->regs;
-	control = readl(regs + SPI_CONTROL);
+	control = readl(regs + drv_data->version->ctrl);
 
 	/* Bits per word setup */
 	tmp = transfer->bits_per_word;
@@ -941,27 +1084,24 @@ static void pump_transfers(unsigned long data)
 		drv_data->n_bytes = chip->n_bytes;
 	} else
 		/* Use per-transfer setup */
-		drv_data->n_bytes = (tmp <= 8) ? 1 : 2;
-	u32_EDIT(control, SPI_CONTROL_BITCOUNT_MASK, tmp - 1);
+		drv_data->n_bytes = roundup_pow_of_two(tmp) >> 3;
+	u32_EDIT_WITH_SHIFT(control, drv_data->version->max_bitcount - 1,
+				tmp - 1, drv_data->version->bitcount_shift);
 
 	/* Speed setup (surely valid because already checked) */
-	tmp = transfer->speed_hz;
-	if (tmp == 0)
-		tmp = chip->max_speed_hz;
-	tmp = spi_data_rate(drv_data, tmp);
-	u32_EDIT(control, SPI_CONTROL_DATARATE, tmp);
-
-	writel(control, regs + SPI_CONTROL);
+	drv_data->version->calc_datarate(drv_data, transfer->speed_hz ?: chip->max_speed_hz, &control);
+	writel(control, regs + drv_data->version->ctrl);
 
 	/* Assert device chip-select */
 	drv_data->cs_control(SPI_CS_ASSERT);
 
+#ifdef CONFIG_SPI_IMX_DMA
 	/* DMA cannot read/write SPI FIFOs other than 16 bits at a time; hence
 	   if bits_per_word is less or equal 8 PIO transfers are performed.
 	   Moreover DMA is convinient for transfer length bigger than FIFOs
 	   byte size. */
 	if ((drv_data->n_bytes == 2) &&
-		(drv_data->len > SPI_FIFO_DEPTH*SPI_FIFO_BYTE_WIDTH) &&
+		(drv_data->len > SPI_FIFO_DEPTH * (drv_data->version->max_bitcount / 8)) &&
 		(map_dma_buffers(drv_data) == 0)) {
 		dev_dbg(&drv_data->pdev->dev,
 			"pump dma transfer\n"
@@ -980,8 +1120,8 @@ static void pump_transfers(unsigned long data)
 		drv_data->transfer_handler = dma_transfer;
 
 		/* Trigger transfer */
-		writel(readl(regs + SPI_CONTROL) | SPI_CONTROL_XCH,
-			regs + SPI_CONTROL);
+		writel(readl(regs + drv_data->version->ctrl) | drv_data->version->xch,
+			regs + drv_data->version->ctrl);
 
 		/* Setup tx DMA */
 		if (drv_data->tx)
@@ -1023,18 +1163,20 @@ static void pump_transfers(unsigned long data)
 			imx_dma_enable(drv_data->rx_channel);
 
 			/* Enable SPI interrupt */
-			writel(SPI_INTEN_RO, regs + SPI_INT_STATUS);
+			writel(drv_data->version->int_ro_en, regs + drv_data->version->int_en);
 
 			/* Set SPI to request DMA service on both
 			   Rx and Tx half fifo watermark */
-			writel(SPI_DMA_RHDEN | SPI_DMA_THDEN, regs + SPI_DMA);
+			writel(SPI_DMA_RHDEN | SPI_DMA_THDEN, regs + drv_data->version->dma);
 		} else
 			/* Write only access -> set SPI to request DMA
 			   service on Tx half fifo watermark */
-			writel(SPI_DMA_THDEN, regs + SPI_DMA);
+			writel(SPI_DMA_THDEN, regs + drv_data->version->dma);
 
 		imx_dma_enable(drv_data->tx_channel);
-	} else {
+	} else
+#endif /* DMA */
+	{
 		dev_dbg(&drv_data->pdev->dev,
 			"pump pio transfer\n"
 			"    tx      = %p\n"
@@ -1052,10 +1194,10 @@ static void pump_transfers(unsigned long data)
 
 		/* Enable SPI interrupt */
 		if (drv_data->rx)
-			writel(SPI_INTEN_TH | SPI_INTEN_RO,
-				regs + SPI_INT_STATUS);
+			writel(drv_data->version->int_th_en | drv_data->version->int_ro_en,
+				regs + drv_data->version->int_en);
 		else
-			writel(SPI_INTEN_TH, regs + SPI_INT_STATUS);
+			writel(drv_data->version->int_th_en, regs + drv_data->version->int_en);
 	}
 }
 
@@ -1110,11 +1252,11 @@ static int transfer(struct spi_device *spi, struct spi_message *msg)
 	msg->actual_length = 0;
 
 	/* Per transfer setup check */
-	min_speed_hz = spi_speed_hz(drv_data, SPI_CONTROL_DATARATE_MIN);
+	min_speed_hz = clk_get_rate(drv_data->clk) / drv_data->version->max_divider;
 	max_speed_hz = spi->max_speed_hz;
 	list_for_each_entry(trans, &msg->transfers, transfer_list) {
 		tmp = trans->bits_per_word;
-		if (tmp > 16) {
+		if (tmp > drv_data->version->max_bitcount) {
 			dev_err(&drv_data->pdev->dev,
 				"message rejected : "
 				"invalid transfer bits_per_word (%d bits)\n",
@@ -1170,7 +1312,7 @@ msg_rejected:
 }
 
 /* the spi->mode bits understood by this driver: */
-#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP)
 
 /* On first setup bad values must free chip_data memory since will cause
    spi_new_device to fail. Bad value setup from protocol driver are simply not
@@ -1181,15 +1323,20 @@ static int setup(struct spi_device *spi)
 	struct spi_imx_chip *chip_info;
 	struct chip_data *chip;
 	int first_setup = 0;
-	u32 tmp;
+	u32 bitcount, tmp, calc_hz;
 	int status = 0;
 
 	if (spi->mode & ~MODEBITS) {
-		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+		dev_dbg(&spi->dev, "setup - unsupported mode bits %x\n",
 			spi->mode & ~MODEBITS);
 		return -EINVAL;
 	}
 
+	if (spi->chip_select >= spi->master->num_chipselect) {
+		dev_dbg(&spi->dev, "setup - invalid chipselect #%d\n", spi->chip_select);
+		return -EINVAL;
+	}
+
 	/* Get controller data */
 	chip_info = spi->controller_data;
 
@@ -1204,7 +1351,7 @@ static int setup(struct spi_device *spi)
 				"setup - cannot allocate controller state\n");
 			return -ENOMEM;
 		}
-		chip->control = SPI_DEFAULT_CONTROL;
+		chip->control = drv_data->version->default_ctrl;
 
 		if (chip_info == NULL) {
 			/* spi_board_info.controller_data not is supplied */
@@ -1218,12 +1365,12 @@ static int setup(struct spi_device *spi)
 				goto err_first_setup;
 			}
 			/* Set controller data default value */
-			chip_info->enable_loopback =
-						SPI_DEFAULT_ENABLE_LOOPBACK;
 			chip_info->enable_dma = SPI_DEFAULT_ENABLE_DMA;
 			chip_info->ins_ss_pulse = 1;
 			chip_info->bclk_wait = SPI_DEFAULT_PERIOD_WAIT;
 			chip_info->cs_control = null_cs_control;
+			//XXX: This was missing in the original driver. Bug or my misunderstanding?
+			spi->controller_data = chip_info;
 		}
 	}
 
@@ -1231,21 +1378,12 @@ static int setup(struct spi_device *spi)
 
 	if (first_setup) {
 		/* SPI loopback */
-		if (chip_info->enable_loopback)
-			chip->test = SPI_TEST_LBC;
-		else
-			chip->test = 0;
+		chip->test = (spi->mode & SPI_LOOP) ? SPI_TEST_LBC : 0;
 
 		/* SPI dma driven */
 		chip->enable_dma = chip_info->enable_dma;
 
-		/* SPI /SS pulse between spi burst */
-		if (chip_info->ins_ss_pulse)
-			u32_EDIT(chip->control,
-				SPI_CONTROL_SSCTL, SPI_CONTROL_SSCTL_1);
-		else
-			u32_EDIT(chip->control,
-				SPI_CONTROL_SSCTL, SPI_CONTROL_SSCTL_0);
+		u32_EDIT_BIT_COND(chip->control, chip_info->ins_ss_pulse, drv_data->version->ssctl_shift);
 
 		/* SPI bclk waits between each bits_per_word spi burst */
 		if (chip_info->bclk_wait > SPI_PERIOD_MAX_WAIT) {
@@ -1256,64 +1394,50 @@ static int setup(struct spi_device *spi)
 			goto err_first_setup;
 		}
 		chip->period = SPI_PERIOD_CSRC_BCLK |
-				(chip_info->bclk_wait & SPI_PERIOD_WAIT);
+				(chip_info->bclk_wait & SPI_PERIOD_MAX_WAIT);
 	}
 
-	/* SPI mode */
-	tmp = spi->mode;
-	if (tmp & SPI_CS_HIGH) {
-		u32_EDIT(chip->control,
-				SPI_CONTROL_SSPOL, SPI_CONTROL_SSPOL_ACT_HIGH);
-	}
-	switch (tmp & SPI_MODE_3) {
-	case SPI_MODE_0:
-		tmp = 0;
-		break;
-	case SPI_MODE_1:
-		tmp = SPI_CONTROL_PHA_1;
-		break;
-	case SPI_MODE_2:
-		tmp = SPI_CONTROL_POL_ACT_LOW;
-		break;
-	default:
-		/* SPI_MODE_3 */
-		tmp = SPI_CONTROL_PHA_1 | SPI_CONTROL_POL_ACT_LOW;
-		break;
-	}
-	u32_EDIT(chip->control, SPI_CONTROL_POL | SPI_CONTROL_PHA, tmp);
-
 	/* SPI word width */
-	tmp = spi->bits_per_word;
-	if (tmp == 0) {
-		tmp = 8;
+	bitcount = spi->bits_per_word;
+	if (bitcount == 0) {
+		bitcount = 8;
 		spi->bits_per_word = 8;
-	} else if (tmp > 16) {
+	} else if (bitcount > drv_data->version->max_bitcount) {
 		status = -EINVAL;
 		dev_err(&spi->dev,
 			"setup - "
 			"invalid bits_per_word (%d)\n",
-			tmp);
+			bitcount);
 		if (first_setup)
 			goto err_first_setup;
 		else {
 			/* Undo setup using chip as backup copy */
-			tmp = chip->bits_per_word;
-			spi->bits_per_word = tmp;
+			bitcount = chip->bits_per_word;
+			spi->bits_per_word = bitcount;
 		}
 	}
-	chip->bits_per_word = tmp;
-	u32_EDIT(chip->control, SPI_CONTROL_BITCOUNT_MASK, tmp - 1);
-	chip->n_bytes = (tmp <= 8) ? 1 : 2;
+	chip->bits_per_word = bitcount;
+	chip->n_bytes = roundup_pow_of_two(bitcount) >> 3;
+
+	tmp = chip->control;
+	u32_EDIT_WITH_SHIFT(tmp, 3, spi->chip_select, drv_data->version->cs_shift);
+	u32_EDIT_WITH_SHIFT(tmp, drv_data->version->max_bitcount - 1,
+				bitcount - 1, drv_data->version->bitcount_shift);
+
+	u32_EDIT_BIT_COND(tmp, spi->mode & SPI_CS_HIGH, drv_data->version->sspol_shift);
+	u32_EDIT_BIT_COND(tmp, spi->mode & SPI_CPHA, drv_data->version->pha_shift);
+	u32_EDIT_BIT_COND(tmp, spi->mode & SPI_CPOL, drv_data->version->pol_shift);
+	chip->control = tmp;
 
 	/* SPI datarate */
-	tmp = spi_data_rate(drv_data, spi->max_speed_hz);
-	if (tmp == SPI_CONTROL_DATARATE_BAD) {
+	calc_hz = drv_data->version->calc_datarate(drv_data, spi->max_speed_hz, &tmp);
+	if (calc_hz == 0) {
 		status = -EINVAL;
 		dev_err(&spi->dev,
 			"setup - "
-			"HW min speed (%d Hz) exceeds required "
+			"HW min speed (%lu Hz) exceeds required "
 			"max speed (%d Hz)\n",
-			spi_speed_hz(drv_data, SPI_CONTROL_DATARATE_MIN),
+			clk_get_rate(drv_data->clk) / drv_data->version->max_divider,
 			spi->max_speed_hz);
 		if (first_setup)
 			goto err_first_setup;
@@ -1321,11 +1445,10 @@ static int setup(struct spi_device *spi)
 			/* Undo setup using chip as backup copy */
 			spi->max_speed_hz = chip->max_speed_hz;
 	} else {
-		u32_EDIT(chip->control, SPI_CONTROL_DATARATE, tmp);
 		/* Actual rounded max_speed_hz */
-		tmp = spi_speed_hz(drv_data, tmp);
-		spi->max_speed_hz = tmp;
-		chip->max_speed_hz = tmp;
+		spi->max_speed_hz = calc_hz;
+		chip->max_speed_hz = calc_hz;
+		chip->control = tmp;
 	}
 
 	/* SPI chip-select management */
@@ -1346,15 +1469,15 @@ static int setup(struct spi_device *spi)
 		"    period wait       = %d\n"
 		"    mode              = %d\n"
 		"    bits per word     = %d\n"
-		"    min speed         = %d Hz\n"
+		"    min speed         = %lu Hz\n"
 		"    rounded max speed = %d Hz\n",
 		chip->test & SPI_TEST_LBC ? "Yes" : "No",
 		chip->enable_dma ? "Yes" : "No",
-		chip->control & SPI_CONTROL_SSCTL ? "Yes" : "No",
-		chip->period & SPI_PERIOD_WAIT,
-		spi->mode,
+		chip_info->ins_ss_pulse ? "Yes" : "No",
+		chip->period & SPI_PERIOD_MAX_WAIT,
+		spi->mode & SPI_MODE_3,
 		spi->bits_per_word,
-		spi_speed_hz(drv_data, SPI_CONTROL_DATARATE_MIN),
+		clk_get_rate(drv_data->clk) / drv_data->version->max_divider,
 		spi->max_speed_hz);
 	return status;
 
@@ -1479,6 +1602,16 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	drv_data->master_info = platform_info;
 	drv_data->pdev = pdev;
 
+	if (cpu_is_mx27())
+		drv_data->version = &spi_core_ver_0_0;
+	else if (cpu_is_mx31())
+		drv_data->version = &spi_core_ver_0_4;
+	else {
+		dev_err(&pdev->dev, "Could not determine spi-core-version\n");
+		status = -ENODEV;
+		goto err_no_cpu_type;
+	}
+
 	master->bus_num = pdev->id;
 	master->num_chipselect = platform_info->num_chipselect;
 	master->cleanup = cleanup;
@@ -1487,7 +1620,8 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 
 	drv_data->dummy_dma_buf = SPI_DUMMY_u32;
 
-	drv_data->clk = clk_get(&pdev->dev, "perclk2");
+	//FIXME: names will be obsoleted
+	drv_data->clk = clk_get(&pdev->dev, "cspi_clk");
 	if (IS_ERR(drv_data->clk)) {
 		dev_err(&pdev->dev, "probe - cannot get clock\n");
 		status = PTR_ERR(drv_data->clk);
@@ -1495,6 +1629,12 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	}
 	clk_enable(drv_data->clk);
 
+	/* Setup any GPIO active */
+	if (platform_info->init)
+		status = platform_info->init(pdev);
+		if (status)
+			goto err_no_init;
+
 	/* Find and map resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1503,20 +1643,19 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 		goto err_no_iores;
 	}
 	drv_data->ioarea = request_mem_region(res->start,
-						res->end - res->start + 1,
+						resource_size(res),
 						pdev->name);
 	if (drv_data->ioarea == NULL) {
 		dev_err(&pdev->dev, "probe - cannot reserve region\n");
 		status = -ENXIO;
 		goto err_no_iores;
 	}
-	drv_data->regs = ioremap(res->start, res->end - res->start + 1);
+	drv_data->regs = ioremap(res->start, resource_size(res));
 	if (drv_data->regs == NULL) {
 		dev_err(&pdev->dev, "probe - cannot map IO\n");
 		status = -ENXIO;
 		goto err_no_iomap;
 	}
-	drv_data->rd_data_phys = (dma_addr_t)res->start;
 
 	/* Attach to IRQ */
 	irq = platform_get_irq(pdev, 0);
@@ -1531,11 +1670,14 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 		goto err_no_irqres;
 	}
 
+#ifdef CONFIG_SPI_IMX_DMA
+	drv_data->rd_data_phys = (dma_addr_t)res->start;
 	/* Setup DMA if requested */
 	drv_data->tx_channel = -1;
 	drv_data->rx_channel = -1;
 	if (platform_info->enable_dma) {
 		/* Get rx DMA channel */
+		status = -ENODEV;
 		drv_data->rx_channel = imx_dma_request_by_prio("spi_imx_rx",
 							       DMA_PRIO_HIGH);
 		if (drv_data->rx_channel < 0) {
@@ -1554,7 +1696,6 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 			dev_err(dev,
 				"probe - problem (%d) requesting tx channel\n",
 				drv_data->tx_channel);
-			imx_dma_free(drv_data->rx_channel);
 			goto err_no_txdma;
 		} else
 			imx_dma_setup_handlers(drv_data->tx_channel,
@@ -1575,19 +1716,16 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 			break;
 		default:
 			dev_err(dev, "probe - bad SPI Id\n");
-			imx_dma_free(drv_data->rx_channel);
-			imx_dma_free(drv_data->tx_channel);
-			status = -ENODEV;
 			goto err_no_devid;
 		}
 		BLR(drv_data->rx_channel) = SPI_DMA_BLR;
 		BLR(drv_data->tx_channel) = SPI_DMA_BLR;
 	}
+#endif /* DMA */
 
 	/* Load default SPI configuration */
-	writel(SPI_RESET_START, drv_data->regs + SPI_RESET);
-	writel(0, drv_data->regs + SPI_RESET);
-	writel(SPI_DEFAULT_CONTROL, drv_data->regs + SPI_CONTROL);
+	writel(drv_data->version->reset_val, drv_data->regs + drv_data->version->reset);
+	writel(drv_data->version->default_ctrl, drv_data->regs + drv_data->version->ctrl);
 
 	/* Initial and start queue */
 	status = init_queue(drv_data);
@@ -1617,9 +1755,13 @@ err_start_queue:
 err_spi_register:
 	destroy_queue(drv_data);
 
-err_no_rxdma:
-err_no_txdma:
+#ifdef CONFIG_SPI_IMX_DMA
 err_no_devid:
+	imx_dma_free(drv_data->tx_channel);
+err_no_txdma:
+	imx_dma_free(drv_data->rx_channel);
+err_no_rxdma:
+#endif /* DMA */
 	free_irq(irq, drv_data);
 
 err_no_irqres:
@@ -1630,9 +1772,14 @@ err_no_iomap:
 	kfree(drv_data->ioarea);
 
 err_no_iores:
+	if (platform_info->exit)
+		platform_info->exit(pdev);
+
+err_no_init:
 	clk_disable(drv_data->clk);
 	clk_put(drv_data->clk);
 
+err_no_cpu_type:
 err_no_clk:
 	spi_master_put(master);
 
@@ -1646,6 +1793,8 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
 	int irq;
 	int status = 0;
+	struct spi_imx_master *platform_info =
+			(struct spi_imx_master *)pdev->dev.platform_data;
 
 	if (!drv_data)
 		return 0;
@@ -1659,10 +1808,13 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
 		return status;
 	}
 
+	if (platform_info->exit)
+		platform_info->exit(pdev);
+
 	/* Reset SPI */
-	writel(SPI_RESET_START, drv_data->regs + SPI_RESET);
-	writel(0, drv_data->regs + SPI_RESET);
+	writel(drv_data->version->reset_val, drv_data->regs + drv_data->version->reset);
 
+#ifdef CONFIG_SPI_IMX_DMA
 	/* Release DMA */
 	if (drv_data->master_info->enable_dma) {
 		RSSR(drv_data->rx_channel) = 0;
@@ -1670,6 +1822,7 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
 		imx_dma_free(drv_data->tx_channel);
 		imx_dma_free(drv_data->rx_channel);
 	}
+#endif /* DMA */
 
 	/* Release IRQ */
 	irq = platform_get_irq(pdev, 0);
@@ -1701,8 +1854,7 @@ static void spi_imx_shutdown(struct platform_device *pdev)
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
 
 	/* Reset SPI */
-	writel(SPI_RESET_START, drv_data->regs + SPI_RESET);
-	writel(0, drv_data->regs + SPI_RESET);
+	writel(drv_data->version->reset_val, drv_data->regs + drv_data->version->reset);
 
 	dev_dbg(&pdev->dev, "shutdown succeded\n");
 }
@@ -1714,12 +1866,20 @@ static int spi_imx_suspend(struct platform_device *pdev, pm_message_t state)
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
+	struct spi_imx_master *platform_info =
+			(struct spi_imx_master *)pdev->dev.platform_data;
+
 	status = stop_queue(drv_data);
 	if (status != 0) {
 		dev_warn(&pdev->dev, "suspend cannot stop queue\n");
 		return status;
 	}
 
+	if (platform_info->exit)
+		platform_info->exit(pdev);
+
+	clk_disable(drv_data->clk);
+
 	dev_dbg(&pdev->dev, "suspended\n");
 
 	return 0;
@@ -1730,6 +1890,19 @@ static int spi_imx_resume(struct platform_device *pdev)
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
+	struct spi_imx_master *platform_info =
+			(struct spi_imx_master *)pdev->dev.platform_data;
+
+	clk_enable(drv_data->clk);
+
+	if (platform_info->init) {
+		status = platform_info->init(pdev);
+		if (status) {
+			clk_disable(drv_data->clk);
+			return status;
+		}
+	}
+
 	/* Start the queue running */
 	status = start_queue(drv_data);
 	if (status != 0)
-- 
1.5.6.5


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
