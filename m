From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: convert spi-bfin-v3.c to a multiplatform driver
Date: Wed, 2 Apr 2014 18:20:21 +0800
Message-ID: <1396434021-13638-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Spi v3 controller is not only used in Blackfin. So rename it
and use ioread/iowrite api to make it work on other platform.

Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/include/asm/bfin_spi3.h |  258 ---------
 drivers/spi/Kconfig                   |    4 +-
 drivers/spi/Makefile                  |    2 +-
 drivers/spi/spi-adi-v3.c              |  989 +++++++++++++++++++++++++++++++++
 drivers/spi/spi-bfin-v3.c             |  964 --------------------------------
 include/linux/spi/adi_spi3.h          |  254 +++++++++
 6 files changed, 1246 insertions(+), 1225 deletions(-)
 delete mode 100644 arch/blackfin/include/asm/bfin_spi3.h
 create mode 100644 drivers/spi/spi-adi-v3.c
 delete mode 100644 drivers/spi/spi-bfin-v3.c
 create mode 100644 include/linux/spi/adi_spi3.h

diff --git a/arch/blackfin/include/asm/bfin_spi3.h b/arch/blackfin/include/asm/bfin_spi3.h
deleted file mode 100644
index 0957e65a..0000000
--- a/arch/blackfin/include/asm/bfin_spi3.h
+++ /dev/null
@@ -1,258 +0,0 @@
-/*
- * Analog Devices SPI3 controller driver
- *
- * Copyright (c) 2011 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef _SPI_CHANNEL_H_
-#define _SPI_CHANNEL_H_
-
-#include <linux/types.h>
-
-/* SPI_CONTROL */
-#define SPI_CTL_EN                  0x00000001    /* Enable */
-#define SPI_CTL_MSTR                0x00000002    /* Master/Slave */
-#define SPI_CTL_PSSE                0x00000004    /* controls modf error in master mode */
-#define SPI_CTL_ODM                 0x00000008    /* Open Drain Mode */
-#define SPI_CTL_CPHA                0x00000010    /* Clock Phase */
-#define SPI_CTL_CPOL                0x00000020    /* Clock Polarity */
-#define SPI_CTL_ASSEL               0x00000040    /* Slave Select Pin Control */
-#define SPI_CTL_SELST               0x00000080    /* Slave Select Polarity in-between transfers */
-#define SPI_CTL_EMISO               0x00000100    /* Enable MISO */
-#define SPI_CTL_SIZE                0x00000600    /* Word Transfer Size */
-#define SPI_CTL_SIZE08              0x00000000    /* SIZE: 8 bits */
-#define SPI_CTL_SIZE16              0x00000200    /* SIZE: 16 bits */
-#define SPI_CTL_SIZE32              0x00000400    /* SIZE: 32 bits */
-#define SPI_CTL_LSBF                0x00001000    /* LSB First */
-#define SPI_CTL_FCEN                0x00002000    /* Flow-Control Enable */
-#define SPI_CTL_FCCH                0x00004000    /* Flow-Control Channel Selection */
-#define SPI_CTL_FCPL                0x00008000    /* Flow-Control Polarity */
-#define SPI_CTL_FCWM                0x00030000    /* Flow-Control Water-Mark */
-#define SPI_CTL_FIFO0               0x00000000    /* FCWM: TFIFO empty or RFIFO Full */
-#define SPI_CTL_FIFO1               0x00010000    /* FCWM: TFIFO 75% or more empty or RFIFO 75% or more full */
-#define SPI_CTL_FIFO2               0x00020000    /* FCWM: TFIFO 50% or more empty or RFIFO 50% or more full */
-#define SPI_CTL_FMODE               0x00040000    /* Fast-mode Enable */
-#define SPI_CTL_MIOM                0x00300000    /* Multiple I/O Mode */
-#define SPI_CTL_MIO_DIS             0x00000000    /* MIOM: Disable */
-#define SPI_CTL_MIO_DUAL            0x00100000    /* MIOM: Enable DIOM (Dual I/O Mode) */
-#define SPI_CTL_MIO_QUAD            0x00200000    /* MIOM: Enable QUAD (Quad SPI Mode) */
-#define SPI_CTL_SOSI                0x00400000    /* Start on MOSI */
-/* SPI_RX_CONTROL */
-#define SPI_RXCTL_REN               0x00000001    /* Receive Channel Enable */
-#define SPI_RXCTL_RTI               0x00000004    /* Receive Transfer Initiate */
-#define SPI_RXCTL_RWCEN             0x00000008    /* Receive Word Counter Enable */
-#define SPI_RXCTL_RDR               0x00000070    /* Receive Data Request */
-#define SPI_RXCTL_RDR_DIS           0x00000000    /* RDR: Disabled */
-#define SPI_RXCTL_RDR_NE            0x00000010    /* RDR: RFIFO not empty */
-#define SPI_RXCTL_RDR_25            0x00000020    /* RDR: RFIFO 25% full */
-#define SPI_RXCTL_RDR_50            0x00000030    /* RDR: RFIFO 50% full */
-#define SPI_RXCTL_RDR_75            0x00000040    /* RDR: RFIFO 75% full */
-#define SPI_RXCTL_RDR_FULL          0x00000050    /* RDR: RFIFO full */
-#define SPI_RXCTL_RDO               0x00000100    /* Receive Data Over-Run */
-#define SPI_RXCTL_RRWM              0x00003000    /* FIFO Regular Water-Mark */
-#define SPI_RXCTL_RWM_0             0x00000000    /* RRWM: RFIFO Empty */
-#define SPI_RXCTL_RWM_25            0x00001000    /* RRWM: RFIFO 25% full */
-#define SPI_RXCTL_RWM_50            0x00002000    /* RRWM: RFIFO 50% full */
-#define SPI_RXCTL_RWM_75            0x00003000    /* RRWM: RFIFO 75% full */
-#define SPI_RXCTL_RUWM              0x00070000    /* FIFO Urgent Water-Mark */
-#define SPI_RXCTL_UWM_DIS           0x00000000    /* RUWM: Disabled */
-#define SPI_RXCTL_UWM_25            0x00010000    /* RUWM: RFIFO 25% full */
-#define SPI_RXCTL_UWM_50            0x00020000    /* RUWM: RFIFO 50% full */
-#define SPI_RXCTL_UWM_75            0x00030000    /* RUWM: RFIFO 75% full */
-#define SPI_RXCTL_UWM_FULL          0x00040000    /* RUWM: RFIFO full */
-/* SPI_TX_CONTROL */
-#define SPI_TXCTL_TEN               0x00000001    /* Transmit Channel Enable */
-#define SPI_TXCTL_TTI               0x00000004    /* Transmit Transfer Initiate */
-#define SPI_TXCTL_TWCEN             0x00000008    /* Transmit Word Counter Enable */
-#define SPI_TXCTL_TDR               0x00000070    /* Transmit Data Request */
-#define SPI_TXCTL_TDR_DIS           0x00000000    /* TDR: Disabled */
-#define SPI_TXCTL_TDR_NF            0x00000010    /* TDR: TFIFO not full */
-#define SPI_TXCTL_TDR_25            0x00000020    /* TDR: TFIFO 25% empty */
-#define SPI_TXCTL_TDR_50            0x00000030    /* TDR: TFIFO 50% empty */
-#define SPI_TXCTL_TDR_75            0x00000040    /* TDR: TFIFO 75% empty */
-#define SPI_TXCTL_TDR_EMPTY         0x00000050    /* TDR: TFIFO empty */
-#define SPI_TXCTL_TDU               0x00000100    /* Transmit Data Under-Run */
-#define SPI_TXCTL_TRWM              0x00003000    /* FIFO Regular Water-Mark */
-#define SPI_TXCTL_RWM_FULL          0x00000000    /* TRWM: TFIFO full */
-#define SPI_TXCTL_RWM_25            0x00001000    /* TRWM: TFIFO 25% empty */
-#define SPI_TXCTL_RWM_50            0x00002000    /* TRWM: TFIFO 50% empty */
-#define SPI_TXCTL_RWM_75            0x00003000    /* TRWM: TFIFO 75% empty */
-#define SPI_TXCTL_TUWM              0x00070000    /* FIFO Urgent Water-Mark */
-#define SPI_TXCTL_UWM_DIS           0x00000000    /* TUWM: Disabled */
-#define SPI_TXCTL_UWM_25            0x00010000    /* TUWM: TFIFO 25% empty */
-#define SPI_TXCTL_UWM_50            0x00020000    /* TUWM: TFIFO 50% empty */
-#define SPI_TXCTL_UWM_75            0x00030000    /* TUWM: TFIFO 75% empty */
-#define SPI_TXCTL_UWM_EMPTY         0x00040000    /* TUWM: TFIFO empty */
-/* SPI_CLOCK */
-#define SPI_CLK_BAUD                0x0000FFFF    /* Baud Rate */
-/* SPI_DELAY */
-#define SPI_DLY_STOP                0x000000FF    /* Transfer delay time in multiples of SCK period */
-#define SPI_DLY_LEADX               0x00000100    /* Extended (1 SCK) LEAD Control */
-#define SPI_DLY_LAGX                0x00000200    /* Extended (1 SCK) LAG control */
-/* SPI_SSEL */
-#define SPI_SLVSEL_SSE1             0x00000002    /* SPISSEL1 Enable */
-#define SPI_SLVSEL_SSE2             0x00000004    /* SPISSEL2 Enable */
-#define SPI_SLVSEL_SSE3             0x00000008    /* SPISSEL3 Enable */
-#define SPI_SLVSEL_SSE4             0x00000010    /* SPISSEL4 Enable */
-#define SPI_SLVSEL_SSE5             0x00000020    /* SPISSEL5 Enable */
-#define SPI_SLVSEL_SSE6             0x00000040    /* SPISSEL6 Enable */
-#define SPI_SLVSEL_SSE7             0x00000080    /* SPISSEL7 Enable */
-#define SPI_SLVSEL_SSEL1            0x00000200    /* SPISSEL1 Value */
-#define SPI_SLVSEL_SSEL2            0x00000400    /* SPISSEL2 Value */
-#define SPI_SLVSEL_SSEL3            0x00000800    /* SPISSEL3 Value */
-#define SPI_SLVSEL_SSEL4            0x00001000    /* SPISSEL4 Value */
-#define SPI_SLVSEL_SSEL5            0x00002000    /* SPISSEL5 Value */
-#define SPI_SLVSEL_SSEL6            0x00004000    /* SPISSEL6 Value */
-#define SPI_SLVSEL_SSEL7            0x00008000    /* SPISSEL7 Value */
-/* SPI_RWC */
-#define SPI_RWC_VALUE               0x0000FFFF    /* Received Word-Count */
-/* SPI_RWCR */
-#define SPI_RWCR_VALUE              0x0000FFFF    /* Received Word-Count Reload */
-/* SPI_TWC */
-#define SPI_TWC_VALUE               0x0000FFFF    /* Transmitted Word-Count */
-/* SPI_TWCR */
-#define SPI_TWCR_VALUE              0x0000FFFF    /* Transmitted Word-Count Reload */
-/* SPI_IMASK */
-#define SPI_IMSK_RUWM               0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_TUWM               0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_ROM                0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_TUM                0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_TCM                0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_MFM                0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_RSM                0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_TSM                0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_RFM                0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_TFM                0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_IMASKCL */
-#define SPI_IMSK_CLR_RUW            0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_CLR_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_CLR_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_CLR_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_CLR_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_CLR_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_CLR_RSM            0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_CLR_TSM            0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_CLR_RFM            0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_CLR_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_IMASKST */
-#define SPI_IMSK_SET_RUWM           0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_SET_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
-#define SPI_IMSK_SET_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
-#define SPI_IMSK_SET_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
-#define SPI_IMSK_SET_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
-#define SPI_IMSK_SET_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
-#define SPI_IMSK_SET_RSM            0x00000100    /* Receive Start Interrupt Mask */
-#define SPI_IMSK_SET_TSM            0x00000200    /* Transmit Start Interrupt Mask */
-#define SPI_IMSK_SET_RFM            0x00000400    /* Receive Finish Interrupt Mask */
-#define SPI_IMSK_SET_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
-/* SPI_STATUS */
-#define SPI_STAT_SPIF               0x00000001    /* SPI Finished */
-#define SPI_STAT_RUWM               0x00000002    /* Receive Urgent Water-Mark Breached */
-#define SPI_STAT_TUWM               0x00000004    /* Transmit Urgent Water-Mark Breached */
-#define SPI_STAT_ROE                0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_STAT_TUE                0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_STAT_TCE                0x00000040    /* Transmit Collision Error Indication */
-#define SPI_STAT_MODF               0x00000080    /* Mode Fault Error Indication */
-#define SPI_STAT_RS                 0x00000100    /* Receive Start Indication */
-#define SPI_STAT_TS                 0x00000200    /* Transmit Start Indication */
-#define SPI_STAT_RF                 0x00000400    /* Receive Finish Indication */
-#define SPI_STAT_TF                 0x00000800    /* Transmit Finish Indication */
-#define SPI_STAT_RFS                0x00007000    /* SPI_RFIFO status */
-#define SPI_STAT_RFIFO_EMPTY        0x00000000    /* RFS: RFIFO Empty */
-#define SPI_STAT_RFIFO_25           0x00001000    /* RFS: RFIFO 25% Full */
-#define SPI_STAT_RFIFO_50           0x00002000    /* RFS: RFIFO 50% Full */
-#define SPI_STAT_RFIFO_75           0x00003000    /* RFS: RFIFO 75% Full */
-#define SPI_STAT_RFIFO_FULL         0x00004000    /* RFS: RFIFO Full */
-#define SPI_STAT_TFS                0x00070000    /* SPI_TFIFO status */
-#define SPI_STAT_TFIFO_FULL         0x00000000    /* TFS: TFIFO full */
-#define SPI_STAT_TFIFO_25           0x00010000    /* TFS: TFIFO 25% empty */
-#define SPI_STAT_TFIFO_50           0x00020000    /* TFS: TFIFO 50% empty */
-#define SPI_STAT_TFIFO_75           0x00030000    /* TFS: TFIFO 75% empty */
-#define SPI_STAT_TFIFO_EMPTY        0x00040000    /* TFS: TFIFO empty */
-#define SPI_STAT_FCS                0x00100000    /* Flow-Control Stall Indication */
-#define SPI_STAT_RFE                0x00400000    /* SPI_RFIFO Empty */
-#define SPI_STAT_TFF                0x00800000    /* SPI_TFIFO Full */
-/* SPI_ILAT */
-#define SPI_ILAT_RUWMI              0x00000002    /* Receive Urgent Water Mark Interrupt */
-#define SPI_ILAT_TUWMI              0x00000004    /* Transmit Urgent Water Mark Interrupt */
-#define SPI_ILAT_ROI                0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_ILAT_TUI                0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_ILAT_TCI                0x00000040    /* Transmit Collision Error Indication */
-#define SPI_ILAT_MFI                0x00000080    /* Mode Fault Error Indication */
-#define SPI_ILAT_RSI                0x00000100    /* Receive Start Indication */
-#define SPI_ILAT_TSI                0x00000200    /* Transmit Start Indication */
-#define SPI_ILAT_RFI                0x00000400    /* Receive Finish Indication */
-#define SPI_ILAT_TFI                0x00000800    /* Transmit Finish Indication */
-/* SPI_ILATCL */
-#define SPI_ILAT_CLR_RUWMI          0x00000002    /* Receive Urgent Water Mark Interrupt */
-#define SPI_ILAT_CLR_TUWMI          0x00000004    /* Transmit Urgent Water Mark Interrupt */
-#define SPI_ILAT_CLR_ROI            0x00000010    /* Receive Over-Run Error Indication */
-#define SPI_ILAT_CLR_TUI            0x00000020    /* Transmit Under-Run Error Indication */
-#define SPI_ILAT_CLR_TCI            0x00000040    /* Transmit Collision Error Indication */
-#define SPI_ILAT_CLR_MFI            0x00000080    /* Mode Fault Error Indication */
-#define SPI_ILAT_CLR_RSI            0x00000100    /* Receive Start Indication */
-#define SPI_ILAT_CLR_TSI            0x00000200    /* Transmit Start Indication */
-#define SPI_ILAT_CLR_RFI            0x00000400    /* Receive Finish Indication */
-#define SPI_ILAT_CLR_TFI            0x00000800    /* Transmit Finish Indication */
-
-/*
- * bfin spi3 registers layout
- */
-struct bfin_spi_regs {
-	u32 revid;
-	u32 control;
-	u32 rx_control;
-	u32 tx_control;
-	u32 clock;
-	u32 delay;
-	u32 ssel;
-	u32 rwc;
-	u32 rwcr;
-	u32 twc;
-	u32 twcr;
-	u32 reserved0;
-	u32 emask;
-	u32 emaskcl;
-	u32 emaskst;
-	u32 reserved1;
-	u32 status;
-	u32 elat;
-	u32 elatcl;
-	u32 reserved2;
-	u32 rfifo;
-	u32 reserved3;
-	u32 tfifo;
-};
-
-#define MAX_CTRL_CS          8  /* cs in spi controller */
-
-/* device.platform_data for SSP controller devices */
-struct bfin_spi3_master {
-	u16 num_chipselect;
-	u16 pin_req[7];
-};
-
-/* spi_board_info.controller_data for SPI slave devices,
- * copied to spi_device.platform_data ... mostly for dma tuning
- */
-struct bfin_spi3_chip {
-	u32 control;
-	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
-	u32 tx_dummy_val; /* tx value for rx only transfer */
-	bool enable_dma;
-};
-
-#endif /* _SPI_CHANNEL_H_ */
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 581ee2a..74879f5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,8 +91,8 @@ config SPI_BFIN5XX
 	help
 	  This is the SPI controller master driver for Blackfin 5xx processor.
 
-config SPI_BFIN_V3
-	tristate "SPI controller v3 for Blackfin"
+config SPI_ADI_V3
+	tristate "SPI controller v3 for ADI"
 	depends on BF60x
 	help
 	  This is the SPI controller v3 master driver
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 95af48d..587d453 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SPI_BCM2835)		+= spi-bcm2835.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
-obj-$(CONFIG_SPI_BFIN_V3)               += spi-bfin-v3.o
+obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
new file mode 100644
index 0000000..cec90b7
--- /dev/null
+++ b/drivers/spi/spi-adi-v3.c
@@ -0,0 +1,989 @@
+/*
+ * Analog Devices SPI3 controller driver
+ *
+ * Copyright (c) 2014 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/adi_spi3.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_HEADER_IN_MACH
+#include <mach/dma.h>
+#include <mach/portmux.h>
+#else
+#include <asm/dma.h>
+#include <asm/portmux.h>
+#endif
+
+enum adi_spi_state {
+	START_STATE,
+	RUNNING_STATE,
+	DONE_STATE,
+	ERROR_STATE
+};
+
+struct adi_spi_master;
+
+struct adi_spi_transfer_ops {
+	void (*write) (struct adi_spi_master *);
+	void (*read) (struct adi_spi_master *);
+	void (*duplex) (struct adi_spi_master *);
+};
+
+/* runtime info for spi master */
+struct adi_spi_master {
+	/* SPI framework hookup */
+	struct spi_master *master;
+
+	/* Regs base of SPI controller */
+	struct adi_spi_regs __iomem *regs;
+
+	/* Pin request list */
+	u16 *pin_req;
+
+	/* Message Transfer pump */
+	struct tasklet_struct pump_transfers;
+
+	/* Current message transfer state info */
+	struct spi_message *cur_msg;
+	struct spi_transfer *cur_transfer;
+	struct adi_spi_device *cur_chip;
+	unsigned transfer_len;
+
+	/* transfer buffer */
+	void *tx;
+	void *tx_end;
+	void *rx;
+	void *rx_end;
+
+	/* dma info */
+	unsigned int tx_dma;
+	unsigned int rx_dma;
+	dma_addr_t tx_dma_addr;
+	dma_addr_t rx_dma_addr;
+	unsigned long dummy_buffer; /* used in unidirectional transfer */
+	unsigned long tx_dma_size;
+	unsigned long rx_dma_size;
+	int tx_num;
+	int rx_num;
+
+	/* store register value for suspend/resume */
+	u32 control;
+	u32 ssel;
+
+	unsigned long sclk;
+	enum adi_spi_state state;
+
+	const struct adi_spi_transfer_ops *ops;
+};
+
+struct adi_spi_device {
+	u32 control;
+	u32 clock;
+	u32 ssel;
+
+	u8 cs;
+	u16 cs_chg_udelay; /* Some devices require > 255usec delay */
+	u32 cs_gpio;
+	u32 tx_dummy_val; /* tx value for rx only transfer */
+	bool enable_dma;
+	const struct adi_spi_transfer_ops *ops;
+};
+
+static void adi_spi_enable(struct adi_spi_master *drv_data)
+{
+	u32 ctl;
+
+	ctl = ioread32(&drv_data->regs->control);
+	ctl |= SPI_CTL_EN;
+	iowrite32(ctl, &drv_data->regs->control);
+}
+
+static void adi_spi_disable(struct adi_spi_master *drv_data)
+{
+	u32 ctl;
+
+	ctl = ioread32(&drv_data->regs->control);
+	ctl &= ~SPI_CTL_EN;
+	iowrite32(ctl, &drv_data->regs->control);
+}
+
+/* Caculate the SPI_CLOCK register value based on input HZ */
+static u32 hz_to_spi_clock(u32 sclk, u32 speed_hz)
+{
+	u32 spi_clock = sclk / speed_hz;
+
+	if (spi_clock)
+		spi_clock--;
+	return spi_clock;
+}
+
+static int adi_spi_flush(struct adi_spi_master *drv_data)
+{
+	unsigned long limit = loops_per_jiffy << 1;
+
+	/* wait for stop and clear stat */
+	while (!(ioread32(&drv_data->regs->status) & SPI_STAT_SPIF) && --limit)
+		cpu_relax();
+
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
+
+	return limit;
+}
+
+/* Chip select operation functions for cs_change flag */
+static void adi_spi_cs_active(struct adi_spi_master *drv_data, struct adi_spi_device *chip)
+{
+	if (likely(chip->cs < MAX_CTRL_CS)) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg &= ~chip->ssel;
+		iowrite32(reg, &drv_data->regs->ssel);
+	} else {
+		gpio_set_value(chip->cs_gpio, 0);
+	}
+}
+
+static void adi_spi_cs_deactive(struct adi_spi_master *drv_data,
+				struct adi_spi_device *chip)
+{
+	if (likely(chip->cs < MAX_CTRL_CS)) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg |= chip->ssel;
+		iowrite32(reg, &drv_data->regs->ssel);
+	} else {
+		gpio_set_value(chip->cs_gpio, 1);
+	}
+
+	/* Move delay here for consistency */
+	if (chip->cs_chg_udelay)
+		udelay(chip->cs_chg_udelay);
+}
+
+/* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
+static inline void adi_spi_cs_enable(struct adi_spi_master *drv_data,
+					struct adi_spi_device *chip)
+{
+	if (chip->cs < MAX_CTRL_CS) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg |= chip->ssel >> 8;
+		iowrite32(reg, &drv_data->regs->ssel);
+	}
+}
+
+static inline void adi_spi_cs_disable(struct adi_spi_master *drv_data,
+					struct adi_spi_device *chip)
+{
+	if (chip->cs < MAX_CTRL_CS) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg &= ~(chip->ssel >> 8);
+		iowrite32(reg, &drv_data->regs->ssel);
+	}
+}
+
+/* stop controller and re-config current chip*/
+static void adi_spi_restore_state(struct adi_spi_master *drv_data)
+{
+	struct adi_spi_device *chip = drv_data->cur_chip;
+
+	/* Clear status and disable clock */
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
+	iowrite32(0x0, &drv_data->regs->rx_control);
+	iowrite32(0x0, &drv_data->regs->tx_control);
+	adi_spi_disable(drv_data);
+
+	/* Load the registers */
+	iowrite32(chip->control, &drv_data->regs->control);
+	iowrite32(chip->clock, &drv_data->regs->clock);
+
+	adi_spi_enable(drv_data);
+	drv_data->tx_num = drv_data->rx_num = 0;
+	/* we always choose tx transfer initiate */
+	iowrite32(SPI_RXCTL_REN, &drv_data->regs->rx_control);
+	iowrite32(SPI_TXCTL_TEN | SPI_TXCTL_TTI, &drv_data->regs->tx_control);
+	adi_spi_cs_active(drv_data, chip);
+}
+
+/* discard invalid rx data and empty rfifo */
+static inline void dummy_read(struct adi_spi_master *drv_data)
+{
+	while (!(ioread32(&drv_data->regs->status) & SPI_STAT_RFE))
+		ioread32(&drv_data->regs->rfifo);
+}
+
+static void adi_spi_u8_write(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->tx < drv_data->tx_end) {
+		iowrite32(*(u8 *)(drv_data->tx++), &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		ioread32(&drv_data->regs->rfifo);
+	}
+}
+
+static void adi_spi_u8_read(struct adi_spi_master *drv_data)
+{
+	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
+
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u8 *)(drv_data->rx++) = ioread32(&drv_data->regs->rfifo);
+	}
+}
+
+static void adi_spi_u8_duplex(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(*(u8 *)(drv_data->tx++), &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u8 *)(drv_data->rx++) = ioread32(&drv_data->regs->rfifo);
+	}
+}
+
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u8 = {
+	.write  = adi_spi_u8_write,
+	.read   = adi_spi_u8_read,
+	.duplex = adi_spi_u8_duplex,
+};
+
+static void adi_spi_u16_write(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->tx < drv_data->tx_end) {
+		iowrite32(*(u16 *)drv_data->tx, &drv_data->regs->tfifo);
+		drv_data->tx += 2;
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		ioread32(&drv_data->regs->rfifo);
+	}
+}
+
+static void adi_spi_u16_read(struct adi_spi_master *drv_data)
+{
+	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
+
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u16 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
+		drv_data->rx += 2;
+	}
+}
+
+static void adi_spi_u16_duplex(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(*(u16 *)drv_data->tx, &drv_data->regs->tfifo);
+		drv_data->tx += 2;
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u16 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
+		drv_data->rx += 2;
+	}
+}
+
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u16 = {
+	.write  = adi_spi_u16_write,
+	.read   = adi_spi_u16_read,
+	.duplex = adi_spi_u16_duplex,
+};
+
+static void adi_spi_u32_write(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->tx < drv_data->tx_end) {
+		iowrite32(*(u32 *)drv_data->tx, &drv_data->regs->tfifo);
+		drv_data->tx += 4;
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		ioread32(&drv_data->regs->rfifo);
+	}
+}
+
+static void adi_spi_u32_read(struct adi_spi_master *drv_data)
+{
+	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
+
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u32 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
+		drv_data->rx += 4;
+	}
+}
+
+static void adi_spi_u32_duplex(struct adi_spi_master *drv_data)
+{
+	dummy_read(drv_data);
+	while (drv_data->rx < drv_data->rx_end) {
+		iowrite32(*(u32 *)drv_data->tx, &drv_data->regs->tfifo);
+		drv_data->tx += 4;
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
+			cpu_relax();
+		*(u32 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
+		drv_data->rx += 4;
+	}
+}
+
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u32 = {
+	.write  = adi_spi_u32_write,
+	.read   = adi_spi_u32_read,
+	.duplex = adi_spi_u32_duplex,
+};
+
+
+/* test if there is more transfer to be done */
+static void adi_spi_next_transfer(struct adi_spi_master *drv)
+{
+	struct spi_message *msg = drv->cur_msg;
+	struct spi_transfer *t = drv->cur_transfer;
+
+	/* Move to next transfer */
+	if (t->transfer_list.next != &msg->transfers) {
+		drv->cur_transfer = list_entry(t->transfer_list.next,
+			       struct spi_transfer, transfer_list);
+		drv->state = RUNNING_STATE;
+	} else {
+		drv->state = DONE_STATE;
+		drv->cur_transfer = NULL;
+	}
+}
+
+static void adi_spi_giveback(struct adi_spi_master *drv_data)
+{
+	struct adi_spi_device *chip = drv_data->cur_chip;
+
+	adi_spi_cs_deactive(drv_data, chip);
+	spi_finalize_current_message(drv_data->master);
+}
+
+static int adi_spi_setup_transfer(struct adi_spi_master *drv)
+{
+	struct spi_transfer *t = drv->cur_transfer;
+	u32 cr, cr_width;
+
+	if (t->tx_buf) {
+		drv->tx = (void *)t->tx_buf;
+		drv->tx_end = drv->tx + t->len;
+	} else {
+		drv->tx = NULL;
+	}
+
+	if (t->rx_buf) {
+		drv->rx = t->rx_buf;
+		drv->rx_end = drv->rx + t->len;
+	} else {
+		drv->rx = NULL;
+	}
+
+	drv->transfer_len = t->len;
+
+	/* bits per word setup */
+	switch (t->bits_per_word) {
+	case 8:
+		cr_width = SPI_CTL_SIZE08;
+		drv->ops = &adi_spi_transfer_ops_u8;
+		break;
+	case 16:
+		cr_width = SPI_CTL_SIZE16;
+		drv->ops = &adi_spi_transfer_ops_u16;
+		break;
+	case 32:
+		cr_width = SPI_CTL_SIZE32;
+		drv->ops = &adi_spi_transfer_ops_u32;
+		break;
+	default:
+		return -EINVAL;
+	}
+	cr = ioread32(&drv->regs->control) & ~SPI_CTL_SIZE;
+	cr |= cr_width;
+	iowrite32(cr, &drv->regs->control);
+
+	/* speed setup */
+	iowrite32(hz_to_spi_clock(drv->sclk, t->speed_hz), &drv->regs->clock);
+	return 0;
+}
+
+static int adi_spi_dma_xfer(struct adi_spi_master *drv_data)
+{
+	struct spi_transfer *t = drv_data->cur_transfer;
+	struct spi_message *msg = drv_data->cur_msg;
+	struct adi_spi_device *chip = drv_data->cur_chip;
+	u32 dma_config;
+	unsigned long word_count, word_size;
+	void *tx_buf, *rx_buf;
+
+	switch (t->bits_per_word) {
+	case 8:
+		dma_config = WDSIZE_8 | PSIZE_8;
+		word_count = drv_data->transfer_len;
+		word_size = 1;
+		break;
+	case 16:
+		dma_config = WDSIZE_16 | PSIZE_16;
+		word_count = drv_data->transfer_len / 2;
+		word_size = 2;
+		break;
+	default:
+		dma_config = WDSIZE_32 | PSIZE_32;
+		word_count = drv_data->transfer_len / 4;
+		word_size = 4;
+		break;
+	}
+
+	if (!drv_data->rx) {
+		tx_buf = drv_data->tx;
+		rx_buf = &drv_data->dummy_buffer;
+		drv_data->tx_dma_size = drv_data->transfer_len;
+		drv_data->rx_dma_size = sizeof(drv_data->dummy_buffer);
+		set_dma_x_modify(drv_data->tx_dma, word_size);
+		set_dma_x_modify(drv_data->rx_dma, 0);
+	} else if (!drv_data->tx) {
+		drv_data->dummy_buffer = chip->tx_dummy_val;
+		tx_buf = &drv_data->dummy_buffer;
+		rx_buf = drv_data->rx;
+		drv_data->tx_dma_size = sizeof(drv_data->dummy_buffer);
+		drv_data->rx_dma_size = drv_data->transfer_len;
+		set_dma_x_modify(drv_data->tx_dma, 0);
+		set_dma_x_modify(drv_data->rx_dma, word_size);
+	} else {
+		tx_buf = drv_data->tx;
+		rx_buf = drv_data->rx;
+		drv_data->tx_dma_size = drv_data->rx_dma_size
+					= drv_data->transfer_len;
+		set_dma_x_modify(drv_data->tx_dma, word_size);
+		set_dma_x_modify(drv_data->rx_dma, word_size);
+	}
+
+	drv_data->tx_dma_addr = dma_map_single(&msg->spi->dev,
+				(void *)tx_buf,
+				drv_data->tx_dma_size,
+				DMA_TO_DEVICE);
+	if (dma_mapping_error(&msg->spi->dev,
+				drv_data->tx_dma_addr))
+		return -ENOMEM;
+
+	drv_data->rx_dma_addr = dma_map_single(&msg->spi->dev,
+				(void *)rx_buf,
+				drv_data->rx_dma_size,
+				DMA_FROM_DEVICE);
+	if (dma_mapping_error(&msg->spi->dev,
+				drv_data->rx_dma_addr)) {
+		dma_unmap_single(&msg->spi->dev,
+				drv_data->tx_dma_addr,
+				drv_data->tx_dma_size,
+				DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	dummy_read(drv_data);
+	set_dma_x_count(drv_data->tx_dma, word_count);
+	set_dma_x_count(drv_data->rx_dma, word_count);
+	set_dma_start_addr(drv_data->tx_dma, drv_data->tx_dma_addr);
+	set_dma_start_addr(drv_data->rx_dma, drv_data->rx_dma_addr);
+	dma_config |= DMAFLOW_STOP | RESTART | DI_EN;
+	set_dma_config(drv_data->tx_dma, dma_config);
+	set_dma_config(drv_data->rx_dma, dma_config | WNR);
+	enable_dma(drv_data->tx_dma);
+	enable_dma(drv_data->rx_dma);
+
+	iowrite32(SPI_RXCTL_REN | SPI_RXCTL_RDR_NE,
+			&drv_data->regs->rx_control);
+	iowrite32(SPI_TXCTL_TEN | SPI_TXCTL_TTI | SPI_TXCTL_TDR_NF,
+			&drv_data->regs->tx_control);
+
+	return 0;
+}
+
+static int adi_spi_pio_xfer(struct adi_spi_master *drv_data)
+{
+	struct spi_message *msg = drv_data->cur_msg;
+
+	if (!drv_data->rx) {
+		/* write only half duplex */
+		drv_data->ops->write(drv_data);
+		if (drv_data->tx != drv_data->tx_end)
+			return -EIO;
+	} else if (!drv_data->tx) {
+		/* read only half duplex */
+		drv_data->ops->read(drv_data);
+		if (drv_data->rx != drv_data->rx_end)
+			return -EIO;
+	} else {
+		/* full duplex mode */
+		drv_data->ops->duplex(drv_data);
+		if (drv_data->tx != drv_data->tx_end)
+			return -EIO;
+	}
+
+	if (!adi_spi_flush(drv_data))
+		return -EIO;
+	msg->actual_length += drv_data->transfer_len;
+	tasklet_schedule(&drv_data->pump_transfers);
+	return 0;
+}
+
+static void adi_spi_pump_transfers(unsigned long data)
+{
+	struct adi_spi_master *drv_data = (struct adi_spi_master *)data;
+	struct spi_message *msg = NULL;
+	struct spi_transfer *t = NULL;
+	struct adi_spi_device *chip = NULL;
+	int ret;
+
+	/* Get current state information */
+	msg = drv_data->cur_msg;
+	t = drv_data->cur_transfer;
+	chip = drv_data->cur_chip;
+
+	/* Handle for abort */
+	if (drv_data->state == ERROR_STATE) {
+		msg->status = -EIO;
+		adi_spi_giveback(drv_data);
+		return;
+	}
+
+	if (drv_data->state == RUNNING_STATE) {
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
+		if (t->cs_change)
+			adi_spi_cs_deactive(drv_data, chip);
+		adi_spi_next_transfer(drv_data);
+		t = drv_data->cur_transfer;
+	}
+	/* Handle end of message */
+	if (drv_data->state == DONE_STATE) {
+		msg->status = 0;
+		adi_spi_giveback(drv_data);
+		return;
+	}
+
+	if ((t->len == 0) || (t->tx_buf == NULL && t->rx_buf == NULL)) {
+		/* Schedule next transfer tasklet */
+		tasklet_schedule(&drv_data->pump_transfers);
+		return;
+	}
+
+	ret = adi_spi_setup_transfer(drv_data);
+	if (ret) {
+		msg->status = ret;
+		adi_spi_giveback(drv_data);
+	}
+
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
+	adi_spi_cs_active(drv_data, chip);
+	drv_data->state = RUNNING_STATE;
+
+	if (chip->enable_dma)
+		ret = adi_spi_dma_xfer(drv_data);
+	else
+		ret = adi_spi_pio_xfer(drv_data);
+	if (ret) {
+		msg->status = ret;
+		adi_spi_giveback(drv_data);
+	}
+}
+
+static int adi_spi_transfer_one_message(struct spi_master *master,
+					struct spi_message *m)
+{
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
+
+	drv_data->cur_msg = m;
+	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
+	adi_spi_restore_state(drv_data);
+
+	drv_data->state = START_STATE;
+	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
+					    struct spi_transfer, transfer_list);
+
+	tasklet_schedule(&drv_data->pump_transfers);
+	return 0;
+}
+
+#define MAX_SPI_SSEL	7
+
+static const u16 ssel[][MAX_SPI_SSEL] = {
+	{P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
+	P_SPI0_SSEL4, P_SPI0_SSEL5,
+	P_SPI0_SSEL6, P_SPI0_SSEL7},
+
+	{P_SPI1_SSEL1, P_SPI1_SSEL2, P_SPI1_SSEL3,
+	P_SPI1_SSEL4, P_SPI1_SSEL5,
+	P_SPI1_SSEL6, P_SPI1_SSEL7},
+
+	{P_SPI2_SSEL1, P_SPI2_SSEL2, P_SPI2_SSEL3,
+	P_SPI2_SSEL4, P_SPI2_SSEL5,
+	P_SPI2_SSEL6, P_SPI2_SSEL7},
+};
+
+static int adi_spi_setup(struct spi_device *spi)
+{
+	struct adi_spi_master *drv_data = spi_master_get_devdata(spi->master);
+	struct adi_spi_device *chip = spi_get_ctldata(spi);
+	u32 ctl_reg = SPI_CTL_ODM | SPI_CTL_PSSE;
+	int ret = -EINVAL;
+
+	if (!chip) {
+		struct adi_spi3_chip *chip_info = spi->controller_data;
+
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+		if (!chip) {
+			dev_err(&spi->dev, "can not allocate chip data\n");
+			return -ENOMEM;
+		}
+		if (chip_info) {
+			if (chip_info->control & ~ctl_reg) {
+				dev_err(&spi->dev,
+					"do not set bits that the SPI framework manages\n");
+				goto error;
+			}
+			chip->control = chip_info->control;
+			chip->cs_chg_udelay = chip_info->cs_chg_udelay;
+			chip->tx_dummy_val = chip_info->tx_dummy_val;
+			chip->enable_dma = chip_info->enable_dma;
+		}
+		chip->cs = spi->chip_select;
+
+		if (chip->cs < MAX_CTRL_CS) {
+			chip->ssel = (1 << chip->cs) << 8;
+			ret = peripheral_request(ssel[spi->master->bus_num]
+					[chip->cs-1], dev_name(&spi->dev));
+			if (ret) {
+				dev_err(&spi->dev, "peripheral_request() error\n");
+				goto error;
+			}
+		} else {
+			chip->cs_gpio = chip->cs - MAX_CTRL_CS;
+			ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
+						dev_name(&spi->dev));
+			if (ret) {
+				dev_err(&spi->dev, "gpio_request_one() error\n");
+				goto error;
+			}
+		}
+		spi_set_ctldata(spi, chip);
+	}
+
+	/* force a default base state */
+	chip->control &= ctl_reg;
+
+	if (spi->mode & SPI_CPOL)
+		chip->control |= SPI_CTL_CPOL;
+	if (spi->mode & SPI_CPHA)
+		chip->control |= SPI_CTL_CPHA;
+	if (spi->mode & SPI_LSB_FIRST)
+		chip->control |= SPI_CTL_LSBF;
+	chip->control |= SPI_CTL_MSTR;
+	/* we choose software to controll cs */
+	chip->control &= ~SPI_CTL_ASSEL;
+
+	chip->clock = hz_to_spi_clock(drv_data->sclk, spi->max_speed_hz);
+
+	adi_spi_cs_enable(drv_data, chip);
+	adi_spi_cs_deactive(drv_data, chip);
+
+	return 0;
+error:
+	if (chip) {
+		kfree(chip);
+		spi_set_ctldata(spi, NULL);
+	}
+
+	return ret;
+}
+
+static void adi_spi_cleanup(struct spi_device *spi)
+{
+	struct adi_spi_device *chip = spi_get_ctldata(spi);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(spi->master);
+
+	if (!chip)
+		return;
+
+	if (chip->cs < MAX_CTRL_CS) {
+		peripheral_free(ssel[spi->master->bus_num]
+					[chip->cs-1]);
+		adi_spi_cs_disable(drv_data, chip);
+	} else {
+		gpio_free(chip->cs_gpio);
+	}
+
+	kfree(chip);
+	spi_set_ctldata(spi, NULL);
+}
+
+static irqreturn_t adi_spi_tx_dma_isr(int irq, void *dev_id)
+{
+	struct adi_spi_master *drv_data = dev_id;
+	u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
+	u32 tx_ctl;
+
+	clear_dma_irqstat(drv_data->tx_dma);
+	if (dma_stat & DMA_DONE) {
+		drv_data->tx_num++;
+	} else {
+		dev_err(&drv_data->master->dev,
+				"spi tx dma error: %d\n", dma_stat);
+		if (drv_data->tx)
+			drv_data->state = ERROR_STATE;
+	}
+	tx_ctl = ioread32(&drv_data->regs->tx_control);
+	tx_ctl &= ~SPI_TXCTL_TDR_NF;
+	iowrite32(tx_ctl, &drv_data->regs->tx_control);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t adi_spi_rx_dma_isr(int irq, void *dev_id)
+{
+	struct adi_spi_master *drv_data = dev_id;
+	struct spi_message *msg = drv_data->cur_msg;
+	u32 dma_stat = get_dma_curr_irqstat(drv_data->rx_dma);
+
+	clear_dma_irqstat(drv_data->rx_dma);
+	if (dma_stat & DMA_DONE) {
+		drv_data->rx_num++;
+		/* we may fail on tx dma */
+		if (drv_data->state != ERROR_STATE)
+			msg->actual_length += drv_data->transfer_len;
+	} else {
+		drv_data->state = ERROR_STATE;
+		dev_err(&drv_data->master->dev,
+				"spi rx dma error: %d\n", dma_stat);
+	}
+	iowrite32(0, &drv_data->regs->tx_control);
+	iowrite32(0, &drv_data->regs->rx_control);
+	if (drv_data->rx_num != drv_data->tx_num)
+		dev_dbg(&drv_data->master->dev,
+				"dma interrupt missing: tx=%d,rx=%d\n",
+				drv_data->tx_num, drv_data->rx_num);
+	tasklet_schedule(&drv_data->pump_transfers);
+	return IRQ_HANDLED;
+}
+
+static int adi_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adi_spi3_master *info = dev_get_platdata(dev);
+	struct spi_master *master;
+	struct adi_spi_master *drv_data;
+	struct resource *mem, *res;
+	unsigned int tx_dma, rx_dma;
+	unsigned long sclk;
+	int ret;
+
+	if (!info) {
+		dev_err(dev, "platform data missing!\n");
+		return -ENODEV;
+	}
+
+	sclk = get_sclk1();
+	if (!sclk) {
+		dev_err(dev, "can not get sclk1\n");
+		return -ENXIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dev, "can not get tx dma resource\n");
+		return -ENXIO;
+	}
+	tx_dma = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!res) {
+		dev_err(dev, "can not get rx dma resource\n");
+		return -ENXIO;
+	}
+	rx_dma = res->start;
+
+	/* allocate master with space for drv_data */
+	master = spi_alloc_master(dev, sizeof(*drv_data));
+	if (!master) {
+		dev_err(dev, "can not alloc spi_master\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, master);
+
+	/* the mode bits supported by this driver */
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+
+	master->bus_num = pdev->id;
+	master->num_chipselect = info->num_chipselect;
+	master->cleanup = adi_spi_cleanup;
+	master->setup = adi_spi_setup;
+	master->transfer_one_message = adi_spi_transfer_one_message;
+	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
+
+	drv_data = spi_master_get_devdata(master);
+	drv_data->master = master;
+	drv_data->tx_dma = tx_dma;
+	drv_data->rx_dma = rx_dma;
+	drv_data->pin_req = info->pin_req;
+	drv_data->sclk = sclk;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drv_data->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(drv_data->regs)) {
+		ret = PTR_ERR(drv_data->regs);
+		goto err_put_master;
+	}
+
+	/* request tx and rx dma */
+	ret = request_dma(tx_dma, "SPI_TX_DMA");
+	if (ret) {
+		dev_err(dev, "can not request SPI TX DMA channel\n");
+		goto err_put_master;
+	}
+	set_dma_callback(tx_dma, adi_spi_tx_dma_isr, drv_data);
+
+	ret = request_dma(rx_dma, "SPI_RX_DMA");
+	if (ret) {
+		dev_err(dev, "can not request SPI RX DMA channel\n");
+		goto err_free_tx_dma;
+	}
+	set_dma_callback(drv_data->rx_dma, adi_spi_rx_dma_isr, drv_data);
+
+	/* request CLK, MOSI and MISO */
+	ret = peripheral_request_list(drv_data->pin_req, "adi-spi3");
+	if (ret < 0) {
+		dev_err(dev, "can not request spi pins\n");
+		goto err_free_rx_dma;
+	}
+
+	iowrite32(SPI_CTL_MSTR | SPI_CTL_CPHA, &drv_data->regs->control);
+	iowrite32(0x0000FE00, &drv_data->regs->ssel);
+	iowrite32(0x0, &drv_data->regs->delay);
+
+	tasklet_init(&drv_data->pump_transfers,
+			adi_spi_pump_transfers, (unsigned long)drv_data);
+	/* register with the SPI framework */
+	ret = devm_spi_register_master(dev, master);
+	if (ret) {
+		dev_err(dev, "can not  register spi master\n");
+		goto err_free_peripheral;
+	}
+
+	return ret;
+
+err_free_peripheral:
+	peripheral_free_list(drv_data->pin_req);
+err_free_rx_dma:
+	free_dma(rx_dma);
+err_free_tx_dma:
+	free_dma(tx_dma);
+err_put_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int adi_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
+
+	adi_spi_disable(drv_data);
+	peripheral_free_list(drv_data->pin_req);
+	free_dma(drv_data->rx_dma);
+	free_dma(drv_data->tx_dma);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int adi_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
+
+	spi_master_suspend(master);
+
+	drv_data->control = ioread32(&drv_data->regs->control);
+	drv_data->ssel = ioread32(&drv_data->regs->ssel);
+
+	iowrite32(SPI_CTL_MSTR | SPI_CTL_CPHA, &drv_data->regs->control);
+	iowrite32(0x0000FE00, &drv_data->regs->ssel);
+	dma_disable_irq(drv_data->rx_dma);
+	dma_disable_irq(drv_data->tx_dma);
+
+	return 0;
+}
+
+static int adi_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
+	int ret = 0;
+
+	/* bootrom may modify spi and dma status when resume in spi boot mode */
+	disable_dma(drv_data->rx_dma);
+
+	dma_enable_irq(drv_data->rx_dma);
+	dma_enable_irq(drv_data->tx_dma);
+	iowrite32(drv_data->control, &drv_data->regs->control);
+	iowrite32(drv_data->ssel, &drv_data->regs->ssel);
+
+	ret = spi_master_resume(master);
+	if (ret) {
+		free_dma(drv_data->rx_dma);
+		free_dma(drv_data->tx_dma);
+	}
+
+	return ret;
+}
+#endif
+static const struct dev_pm_ops adi_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(adi_spi_suspend, adi_spi_resume)
+};
+
+MODULE_ALIAS("platform:adi-spi3");
+static struct platform_driver adi_spi_driver = {
+	.driver	= {
+		.name	= "adi-spi3",
+		.owner	= THIS_MODULE,
+		.pm     = &adi_spi_pm_ops,
+	},
+	.remove		= adi_spi_remove,
+};
+
+module_platform_driver_probe(adi_spi_driver, adi_spi_probe);
+
+MODULE_DESCRIPTION("Analog Devices SPI3 controller driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-bfin-v3.c b/drivers/spi/spi-bfin-v3.c
deleted file mode 100644
index 8f85988..0000000
--- a/drivers/spi/spi-bfin-v3.c
+++ /dev/null
@@ -1,964 +0,0 @@
-/*
- * Analog Devices SPI3 controller driver
- *
- * Copyright (c) 2013 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/errno.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/types.h>
-
-#include <asm/bfin_spi3.h>
-#include <asm/cacheflush.h>
-#include <asm/dma.h>
-#include <asm/portmux.h>
-
-enum bfin_spi_state {
-	START_STATE,
-	RUNNING_STATE,
-	DONE_STATE,
-	ERROR_STATE
-};
-
-struct bfin_spi_master;
-
-struct bfin_spi_transfer_ops {
-	void (*write) (struct bfin_spi_master *);
-	void (*read) (struct bfin_spi_master *);
-	void (*duplex) (struct bfin_spi_master *);
-};
-
-/* runtime info for spi master */
-struct bfin_spi_master {
-	/* SPI framework hookup */
-	struct spi_master *master;
-
-	/* Regs base of SPI controller */
-	struct bfin_spi_regs __iomem *regs;
-
-	/* Pin request list */
-	u16 *pin_req;
-
-	/* Message Transfer pump */
-	struct tasklet_struct pump_transfers;
-
-	/* Current message transfer state info */
-	struct spi_message *cur_msg;
-	struct spi_transfer *cur_transfer;
-	struct bfin_spi_device *cur_chip;
-	unsigned transfer_len;
-
-	/* transfer buffer */
-	void *tx;
-	void *tx_end;
-	void *rx;
-	void *rx_end;
-
-	/* dma info */
-	unsigned int tx_dma;
-	unsigned int rx_dma;
-	dma_addr_t tx_dma_addr;
-	dma_addr_t rx_dma_addr;
-	unsigned long dummy_buffer; /* used in unidirectional transfer */
-	unsigned long tx_dma_size;
-	unsigned long rx_dma_size;
-	int tx_num;
-	int rx_num;
-
-	/* store register value for suspend/resume */
-	u32 control;
-	u32 ssel;
-
-	unsigned long sclk;
-	enum bfin_spi_state state;
-
-	const struct bfin_spi_transfer_ops *ops;
-};
-
-struct bfin_spi_device {
-	u32 control;
-	u32 clock;
-	u32 ssel;
-
-	u8 cs;
-	u16 cs_chg_udelay; /* Some devices require > 255usec delay */
-	u32 cs_gpio;
-	u32 tx_dummy_val; /* tx value for rx only transfer */
-	bool enable_dma;
-	const struct bfin_spi_transfer_ops *ops;
-};
-
-static void bfin_spi_enable(struct bfin_spi_master *drv_data)
-{
-	bfin_write_or(&drv_data->regs->control, SPI_CTL_EN);
-}
-
-static void bfin_spi_disable(struct bfin_spi_master *drv_data)
-{
-	bfin_write_and(&drv_data->regs->control, ~SPI_CTL_EN);
-}
-
-/* Caculate the SPI_CLOCK register value based on input HZ */
-static u32 hz_to_spi_clock(u32 sclk, u32 speed_hz)
-{
-	u32 spi_clock = sclk / speed_hz;
-
-	if (spi_clock)
-		spi_clock--;
-	return spi_clock;
-}
-
-static int bfin_spi_flush(struct bfin_spi_master *drv_data)
-{
-	unsigned long limit = loops_per_jiffy << 1;
-
-	/* wait for stop and clear stat */
-	while (!(bfin_read(&drv_data->regs->status) & SPI_STAT_SPIF) && --limit)
-		cpu_relax();
-
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
-
-	return limit;
-}
-
-/* Chip select operation functions for cs_change flag */
-static void bfin_spi_cs_active(struct bfin_spi_master *drv_data, struct bfin_spi_device *chip)
-{
-	if (likely(chip->cs < MAX_CTRL_CS))
-		bfin_write_and(&drv_data->regs->ssel, ~chip->ssel);
-	else
-		gpio_set_value(chip->cs_gpio, 0);
-}
-
-static void bfin_spi_cs_deactive(struct bfin_spi_master *drv_data,
-				struct bfin_spi_device *chip)
-{
-	if (likely(chip->cs < MAX_CTRL_CS))
-		bfin_write_or(&drv_data->regs->ssel, chip->ssel);
-	else
-		gpio_set_value(chip->cs_gpio, 1);
-
-	/* Move delay here for consistency */
-	if (chip->cs_chg_udelay)
-		udelay(chip->cs_chg_udelay);
-}
-
-/* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
-static inline void bfin_spi_cs_enable(struct bfin_spi_master *drv_data,
-					struct bfin_spi_device *chip)
-{
-	if (chip->cs < MAX_CTRL_CS)
-		bfin_write_or(&drv_data->regs->ssel, chip->ssel >> 8);
-}
-
-static inline void bfin_spi_cs_disable(struct bfin_spi_master *drv_data,
-					struct bfin_spi_device *chip)
-{
-	if (chip->cs < MAX_CTRL_CS)
-		bfin_write_and(&drv_data->regs->ssel, ~(chip->ssel >> 8));
-}
-
-/* stop controller and re-config current chip*/
-static void bfin_spi_restore_state(struct bfin_spi_master *drv_data)
-{
-	struct bfin_spi_device *chip = drv_data->cur_chip;
-
-	/* Clear status and disable clock */
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
-	bfin_write(&drv_data->regs->rx_control, 0x0);
-	bfin_write(&drv_data->regs->tx_control, 0x0);
-	bfin_spi_disable(drv_data);
-
-	SSYNC();
-
-	/* Load the registers */
-	bfin_write(&drv_data->regs->control, chip->control);
-	bfin_write(&drv_data->regs->clock, chip->clock);
-
-	bfin_spi_enable(drv_data);
-	drv_data->tx_num = drv_data->rx_num = 0;
-	/* we always choose tx transfer initiate */
-	bfin_write(&drv_data->regs->rx_control, SPI_RXCTL_REN);
-	bfin_write(&drv_data->regs->tx_control,
-			SPI_TXCTL_TEN | SPI_TXCTL_TTI);
-	bfin_spi_cs_active(drv_data, chip);
-}
-
-/* discard invalid rx data and empty rfifo */
-static inline void dummy_read(struct bfin_spi_master *drv_data)
-{
-	while (!(bfin_read(&drv_data->regs->status) & SPI_STAT_RFE))
-		bfin_read(&drv_data->regs->rfifo);
-}
-
-static void bfin_spi_u8_write(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u8 *)(drv_data->tx++)));
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
-	}
-}
-
-static void bfin_spi_u8_read(struct bfin_spi_master *drv_data)
-{
-	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
-
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u8 *)(drv_data->rx++) = bfin_read(&drv_data->regs->rfifo);
-	}
-}
-
-static void bfin_spi_u8_duplex(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u8 *)(drv_data->tx++)));
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u8 *)(drv_data->rx++) = bfin_read(&drv_data->regs->rfifo);
-	}
-}
-
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u8 = {
-	.write  = bfin_spi_u8_write,
-	.read   = bfin_spi_u8_read,
-	.duplex = bfin_spi_u8_duplex,
-};
-
-static void bfin_spi_u16_write(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u16 *)drv_data->tx));
-		drv_data->tx += 2;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
-	}
-}
-
-static void bfin_spi_u16_read(struct bfin_spi_master *drv_data)
-{
-	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
-
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u16 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
-		drv_data->rx += 2;
-	}
-}
-
-static void bfin_spi_u16_duplex(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u16 *)drv_data->tx));
-		drv_data->tx += 2;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u16 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
-		drv_data->rx += 2;
-	}
-}
-
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u16 = {
-	.write  = bfin_spi_u16_write,
-	.read   = bfin_spi_u16_read,
-	.duplex = bfin_spi_u16_duplex,
-};
-
-static void bfin_spi_u32_write(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u32 *)drv_data->tx));
-		drv_data->tx += 4;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
-	}
-}
-
-static void bfin_spi_u32_read(struct bfin_spi_master *drv_data)
-{
-	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
-
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u32 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
-		drv_data->rx += 4;
-	}
-}
-
-static void bfin_spi_u32_duplex(struct bfin_spi_master *drv_data)
-{
-	dummy_read(drv_data);
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u32 *)drv_data->tx));
-		drv_data->tx += 4;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
-			cpu_relax();
-		*(u32 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
-		drv_data->rx += 4;
-	}
-}
-
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u32 = {
-	.write  = bfin_spi_u32_write,
-	.read   = bfin_spi_u32_read,
-	.duplex = bfin_spi_u32_duplex,
-};
-
-
-/* test if there is more transfer to be done */
-static void bfin_spi_next_transfer(struct bfin_spi_master *drv)
-{
-	struct spi_message *msg = drv->cur_msg;
-	struct spi_transfer *t = drv->cur_transfer;
-
-	/* Move to next transfer */
-	if (t->transfer_list.next != &msg->transfers) {
-		drv->cur_transfer = list_entry(t->transfer_list.next,
-			       struct spi_transfer, transfer_list);
-		drv->state = RUNNING_STATE;
-	} else {
-		drv->state = DONE_STATE;
-		drv->cur_transfer = NULL;
-	}
-}
-
-static void bfin_spi_giveback(struct bfin_spi_master *drv_data)
-{
-	struct bfin_spi_device *chip = drv_data->cur_chip;
-
-	bfin_spi_cs_deactive(drv_data, chip);
-	spi_finalize_current_message(drv_data->master);
-}
-
-static int bfin_spi_setup_transfer(struct bfin_spi_master *drv)
-{
-	struct spi_transfer *t = drv->cur_transfer;
-	u32 cr, cr_width;
-
-	if (t->tx_buf) {
-		drv->tx = (void *)t->tx_buf;
-		drv->tx_end = drv->tx + t->len;
-	} else {
-		drv->tx = NULL;
-	}
-
-	if (t->rx_buf) {
-		drv->rx = t->rx_buf;
-		drv->rx_end = drv->rx + t->len;
-	} else {
-		drv->rx = NULL;
-	}
-
-	drv->transfer_len = t->len;
-
-	/* bits per word setup */
-	switch (t->bits_per_word) {
-	case 8:
-		cr_width = SPI_CTL_SIZE08;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u8;
-		break;
-	case 16:
-		cr_width = SPI_CTL_SIZE16;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u16;
-		break;
-	case 32:
-		cr_width = SPI_CTL_SIZE32;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u32;
-		break;
-	default:
-		return -EINVAL;
-	}
-	cr = bfin_read(&drv->regs->control) & ~SPI_CTL_SIZE;
-	cr |= cr_width;
-	bfin_write(&drv->regs->control, cr);
-
-	/* speed setup */
-	bfin_write(&drv->regs->clock,
-			hz_to_spi_clock(drv->sclk, t->speed_hz));
-	return 0;
-}
-
-static int bfin_spi_dma_xfer(struct bfin_spi_master *drv_data)
-{
-	struct spi_transfer *t = drv_data->cur_transfer;
-	struct spi_message *msg = drv_data->cur_msg;
-	struct bfin_spi_device *chip = drv_data->cur_chip;
-	u32 dma_config;
-	unsigned long word_count, word_size;
-	void *tx_buf, *rx_buf;
-
-	switch (t->bits_per_word) {
-	case 8:
-		dma_config = WDSIZE_8 | PSIZE_8;
-		word_count = drv_data->transfer_len;
-		word_size = 1;
-		break;
-	case 16:
-		dma_config = WDSIZE_16 | PSIZE_16;
-		word_count = drv_data->transfer_len / 2;
-		word_size = 2;
-		break;
-	default:
-		dma_config = WDSIZE_32 | PSIZE_32;
-		word_count = drv_data->transfer_len / 4;
-		word_size = 4;
-		break;
-	}
-
-	if (!drv_data->rx) {
-		tx_buf = drv_data->tx;
-		rx_buf = &drv_data->dummy_buffer;
-		drv_data->tx_dma_size = drv_data->transfer_len;
-		drv_data->rx_dma_size = sizeof(drv_data->dummy_buffer);
-		set_dma_x_modify(drv_data->tx_dma, word_size);
-		set_dma_x_modify(drv_data->rx_dma, 0);
-	} else if (!drv_data->tx) {
-		drv_data->dummy_buffer = chip->tx_dummy_val;
-		tx_buf = &drv_data->dummy_buffer;
-		rx_buf = drv_data->rx;
-		drv_data->tx_dma_size = sizeof(drv_data->dummy_buffer);
-		drv_data->rx_dma_size = drv_data->transfer_len;
-		set_dma_x_modify(drv_data->tx_dma, 0);
-		set_dma_x_modify(drv_data->rx_dma, word_size);
-	} else {
-		tx_buf = drv_data->tx;
-		rx_buf = drv_data->rx;
-		drv_data->tx_dma_size = drv_data->rx_dma_size
-					= drv_data->transfer_len;
-		set_dma_x_modify(drv_data->tx_dma, word_size);
-		set_dma_x_modify(drv_data->rx_dma, word_size);
-	}
-
-	drv_data->tx_dma_addr = dma_map_single(&msg->spi->dev,
-				(void *)tx_buf,
-				drv_data->tx_dma_size,
-				DMA_TO_DEVICE);
-	if (dma_mapping_error(&msg->spi->dev,
-				drv_data->tx_dma_addr))
-		return -ENOMEM;
-
-	drv_data->rx_dma_addr = dma_map_single(&msg->spi->dev,
-				(void *)rx_buf,
-				drv_data->rx_dma_size,
-				DMA_FROM_DEVICE);
-	if (dma_mapping_error(&msg->spi->dev,
-				drv_data->rx_dma_addr)) {
-		dma_unmap_single(&msg->spi->dev,
-				drv_data->tx_dma_addr,
-				drv_data->tx_dma_size,
-				DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	dummy_read(drv_data);
-	set_dma_x_count(drv_data->tx_dma, word_count);
-	set_dma_x_count(drv_data->rx_dma, word_count);
-	set_dma_start_addr(drv_data->tx_dma, drv_data->tx_dma_addr);
-	set_dma_start_addr(drv_data->rx_dma, drv_data->rx_dma_addr);
-	dma_config |= DMAFLOW_STOP | RESTART | DI_EN;
-	set_dma_config(drv_data->tx_dma, dma_config);
-	set_dma_config(drv_data->rx_dma, dma_config | WNR);
-	enable_dma(drv_data->tx_dma);
-	enable_dma(drv_data->rx_dma);
-	SSYNC();
-
-	bfin_write(&drv_data->regs->rx_control, SPI_RXCTL_REN | SPI_RXCTL_RDR_NE);
-	SSYNC();
-	bfin_write(&drv_data->regs->tx_control,
-			SPI_TXCTL_TEN | SPI_TXCTL_TTI | SPI_TXCTL_TDR_NF);
-
-	return 0;
-}
-
-static int bfin_spi_pio_xfer(struct bfin_spi_master *drv_data)
-{
-	struct spi_message *msg = drv_data->cur_msg;
-
-	if (!drv_data->rx) {
-		/* write only half duplex */
-		drv_data->ops->write(drv_data);
-		if (drv_data->tx != drv_data->tx_end)
-			return -EIO;
-	} else if (!drv_data->tx) {
-		/* read only half duplex */
-		drv_data->ops->read(drv_data);
-		if (drv_data->rx != drv_data->rx_end)
-			return -EIO;
-	} else {
-		/* full duplex mode */
-		drv_data->ops->duplex(drv_data);
-		if (drv_data->tx != drv_data->tx_end)
-			return -EIO;
-	}
-
-	if (!bfin_spi_flush(drv_data))
-		return -EIO;
-	msg->actual_length += drv_data->transfer_len;
-	tasklet_schedule(&drv_data->pump_transfers);
-	return 0;
-}
-
-static void bfin_spi_pump_transfers(unsigned long data)
-{
-	struct bfin_spi_master *drv_data = (struct bfin_spi_master *)data;
-	struct spi_message *msg = NULL;
-	struct spi_transfer *t = NULL;
-	struct bfin_spi_device *chip = NULL;
-	int ret;
-
-	/* Get current state information */
-	msg = drv_data->cur_msg;
-	t = drv_data->cur_transfer;
-	chip = drv_data->cur_chip;
-
-	/* Handle for abort */
-	if (drv_data->state == ERROR_STATE) {
-		msg->status = -EIO;
-		bfin_spi_giveback(drv_data);
-		return;
-	}
-
-	if (drv_data->state == RUNNING_STATE) {
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-		if (t->cs_change)
-			bfin_spi_cs_deactive(drv_data, chip);
-		bfin_spi_next_transfer(drv_data);
-		t = drv_data->cur_transfer;
-	}
-	/* Handle end of message */
-	if (drv_data->state == DONE_STATE) {
-		msg->status = 0;
-		bfin_spi_giveback(drv_data);
-		return;
-	}
-
-	if ((t->len == 0) || (t->tx_buf == NULL && t->rx_buf == NULL)) {
-		/* Schedule next transfer tasklet */
-		tasklet_schedule(&drv_data->pump_transfers);
-		return;
-	}
-
-	ret = bfin_spi_setup_transfer(drv_data);
-	if (ret) {
-		msg->status = ret;
-		bfin_spi_giveback(drv_data);
-	}
-
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
-	bfin_spi_cs_active(drv_data, chip);
-	drv_data->state = RUNNING_STATE;
-
-	if (chip->enable_dma)
-		ret = bfin_spi_dma_xfer(drv_data);
-	else
-		ret = bfin_spi_pio_xfer(drv_data);
-	if (ret) {
-		msg->status = ret;
-		bfin_spi_giveback(drv_data);
-	}
-}
-
-static int bfin_spi_transfer_one_message(struct spi_master *master,
-					struct spi_message *m)
-{
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
-
-	drv_data->cur_msg = m;
-	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
-	bfin_spi_restore_state(drv_data);
-
-	drv_data->state = START_STATE;
-	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
-					    struct spi_transfer, transfer_list);
-
-	tasklet_schedule(&drv_data->pump_transfers);
-	return 0;
-}
-
-#define MAX_SPI_SSEL	7
-
-static const u16 ssel[][MAX_SPI_SSEL] = {
-	{P_SPI0_SSEL1, P_SPI0_SSEL2, P_SPI0_SSEL3,
-	P_SPI0_SSEL4, P_SPI0_SSEL5,
-	P_SPI0_SSEL6, P_SPI0_SSEL7},
-
-	{P_SPI1_SSEL1, P_SPI1_SSEL2, P_SPI1_SSEL3,
-	P_SPI1_SSEL4, P_SPI1_SSEL5,
-	P_SPI1_SSEL6, P_SPI1_SSEL7},
-
-	{P_SPI2_SSEL1, P_SPI2_SSEL2, P_SPI2_SSEL3,
-	P_SPI2_SSEL4, P_SPI2_SSEL5,
-	P_SPI2_SSEL6, P_SPI2_SSEL7},
-};
-
-static int bfin_spi_setup(struct spi_device *spi)
-{
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(spi->master);
-	struct bfin_spi_device *chip = spi_get_ctldata(spi);
-	u32 bfin_ctl_reg = SPI_CTL_ODM | SPI_CTL_PSSE;
-	int ret = -EINVAL;
-
-	if (!chip) {
-		struct bfin_spi3_chip *chip_info = spi->controller_data;
-
-		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-		if (!chip) {
-			dev_err(&spi->dev, "can not allocate chip data\n");
-			return -ENOMEM;
-		}
-		if (chip_info) {
-			if (chip_info->control & ~bfin_ctl_reg) {
-				dev_err(&spi->dev,
-					"do not set bits that the SPI framework manages\n");
-				goto error;
-			}
-			chip->control = chip_info->control;
-			chip->cs_chg_udelay = chip_info->cs_chg_udelay;
-			chip->tx_dummy_val = chip_info->tx_dummy_val;
-			chip->enable_dma = chip_info->enable_dma;
-		}
-		chip->cs = spi->chip_select;
-		if (chip->cs < MAX_CTRL_CS) {
-			chip->ssel = (1 << chip->cs) << 8;
-			ret = peripheral_request(ssel[spi->master->bus_num]
-					[chip->cs-1], dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "peripheral_request() error\n");
-				goto error;
-			}
-		} else {
-			chip->cs_gpio = chip->cs - MAX_CTRL_CS;
-			ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
-						dev_name(&spi->dev));
-			if (ret) {
-				dev_err(&spi->dev, "gpio_request_one() error\n");
-				goto error;
-			}
-		}
-		spi_set_ctldata(spi, chip);
-	}
-
-	/* force a default base state */
-	chip->control &= bfin_ctl_reg;
-
-	if (spi->mode & SPI_CPOL)
-		chip->control |= SPI_CTL_CPOL;
-	if (spi->mode & SPI_CPHA)
-		chip->control |= SPI_CTL_CPHA;
-	if (spi->mode & SPI_LSB_FIRST)
-		chip->control |= SPI_CTL_LSBF;
-	chip->control |= SPI_CTL_MSTR;
-	/* we choose software to controll cs */
-	chip->control &= ~SPI_CTL_ASSEL;
-
-	chip->clock = hz_to_spi_clock(drv_data->sclk, spi->max_speed_hz);
-
-	bfin_spi_cs_enable(drv_data, chip);
-	bfin_spi_cs_deactive(drv_data, chip);
-
-	return 0;
-error:
-	if (chip) {
-		kfree(chip);
-		spi_set_ctldata(spi, NULL);
-	}
-
-	return ret;
-}
-
-static void bfin_spi_cleanup(struct spi_device *spi)
-{
-	struct bfin_spi_device *chip = spi_get_ctldata(spi);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(spi->master);
-
-	if (!chip)
-		return;
-
-	if (chip->cs < MAX_CTRL_CS) {
-		peripheral_free(ssel[spi->master->bus_num]
-					[chip->cs-1]);
-		bfin_spi_cs_disable(drv_data, chip);
-	} else {
-		gpio_free(chip->cs_gpio);
-	}
-
-	kfree(chip);
-	spi_set_ctldata(spi, NULL);
-}
-
-static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
-{
-	struct bfin_spi_master *drv_data = dev_id;
-	u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
-
-	clear_dma_irqstat(drv_data->tx_dma);
-	if (dma_stat & DMA_DONE) {
-		drv_data->tx_num++;
-	} else {
-		dev_err(&drv_data->master->dev,
-				"spi tx dma error: %d\n", dma_stat);
-		if (drv_data->tx)
-			drv_data->state = ERROR_STATE;
-	}
-	bfin_write_and(&drv_data->regs->tx_control, ~SPI_TXCTL_TDR_NF);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t bfin_spi_rx_dma_isr(int irq, void *dev_id)
-{
-	struct bfin_spi_master *drv_data = dev_id;
-	struct spi_message *msg = drv_data->cur_msg;
-	u32 dma_stat = get_dma_curr_irqstat(drv_data->rx_dma);
-
-	clear_dma_irqstat(drv_data->rx_dma);
-	if (dma_stat & DMA_DONE) {
-		drv_data->rx_num++;
-		/* we may fail on tx dma */
-		if (drv_data->state != ERROR_STATE)
-			msg->actual_length += drv_data->transfer_len;
-	} else {
-		drv_data->state = ERROR_STATE;
-		dev_err(&drv_data->master->dev,
-				"spi rx dma error: %d\n", dma_stat);
-	}
-	bfin_write(&drv_data->regs->tx_control, 0);
-	bfin_write(&drv_data->regs->rx_control, 0);
-	if (drv_data->rx_num != drv_data->tx_num)
-		dev_dbg(&drv_data->master->dev,
-				"dma interrupt missing: tx=%d,rx=%d\n",
-				drv_data->tx_num, drv_data->rx_num);
-	tasklet_schedule(&drv_data->pump_transfers);
-	return IRQ_HANDLED;
-}
-
-static int bfin_spi_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct bfin_spi3_master *info = dev_get_platdata(dev);
-	struct spi_master *master;
-	struct bfin_spi_master *drv_data;
-	struct resource *mem, *res;
-	unsigned int tx_dma, rx_dma;
-	unsigned long sclk;
-	int ret;
-
-	if (!info) {
-		dev_err(dev, "platform data missing!\n");
-		return -ENODEV;
-	}
-
-	sclk = get_sclk1();
-	if (!sclk) {
-		dev_err(dev, "can not get sclk1\n");
-		return -ENXIO;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(dev, "can not get tx dma resource\n");
-		return -ENXIO;
-	}
-	tx_dma = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(dev, "can not get rx dma resource\n");
-		return -ENXIO;
-	}
-	rx_dma = res->start;
-
-	/* allocate master with space for drv_data */
-	master = spi_alloc_master(dev, sizeof(*drv_data));
-	if (!master) {
-		dev_err(dev, "can not alloc spi_master\n");
-		return -ENOMEM;
-	}
-	platform_set_drvdata(pdev, master);
-
-	/* the mode bits supported by this driver */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-
-	master->bus_num = pdev->id;
-	master->num_chipselect = info->num_chipselect;
-	master->cleanup = bfin_spi_cleanup;
-	master->setup = bfin_spi_setup;
-	master->transfer_one_message = bfin_spi_transfer_one_message;
-	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
-
-	drv_data = spi_master_get_devdata(master);
-	drv_data->master = master;
-	drv_data->tx_dma = tx_dma;
-	drv_data->rx_dma = rx_dma;
-	drv_data->pin_req = info->pin_req;
-	drv_data->sclk = sclk;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drv_data->regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(drv_data->regs)) {
-		ret = PTR_ERR(drv_data->regs);
-		goto err_put_master;
-	}
-
-	/* request tx and rx dma */
-	ret = request_dma(tx_dma, "SPI_TX_DMA");
-	if (ret) {
-		dev_err(dev, "can not request SPI TX DMA channel\n");
-		goto err_put_master;
-	}
-	set_dma_callback(tx_dma, bfin_spi_tx_dma_isr, drv_data);
-
-	ret = request_dma(rx_dma, "SPI_RX_DMA");
-	if (ret) {
-		dev_err(dev, "can not request SPI RX DMA channel\n");
-		goto err_free_tx_dma;
-	}
-	set_dma_callback(drv_data->rx_dma, bfin_spi_rx_dma_isr, drv_data);
-
-	/* request CLK, MOSI and MISO */
-	ret = peripheral_request_list(drv_data->pin_req, "bfin-spi3");
-	if (ret < 0) {
-		dev_err(dev, "can not request spi pins\n");
-		goto err_free_rx_dma;
-	}
-
-	bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
-	bfin_write(&drv_data->regs->ssel, 0x0000FE00);
-	bfin_write(&drv_data->regs->delay, 0x0);
-
-	tasklet_init(&drv_data->pump_transfers,
-			bfin_spi_pump_transfers, (unsigned long)drv_data);
-	/* register with the SPI framework */
-	ret = devm_spi_register_master(dev, master);
-	if (ret) {
-		dev_err(dev, "can not  register spi master\n");
-		goto err_free_peripheral;
-	}
-
-	return ret;
-
-err_free_peripheral:
-	peripheral_free_list(drv_data->pin_req);
-err_free_rx_dma:
-	free_dma(rx_dma);
-err_free_tx_dma:
-	free_dma(tx_dma);
-err_put_master:
-	spi_master_put(master);
-
-	return ret;
-}
-
-static int bfin_spi_remove(struct platform_device *pdev)
-{
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
-
-	bfin_spi_disable(drv_data);
-
-	peripheral_free_list(drv_data->pin_req);
-	free_dma(drv_data->rx_dma);
-	free_dma(drv_data->tx_dma);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int bfin_spi_suspend(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
-
-	spi_master_suspend(master);
-
-	drv_data->control = bfin_read(&drv_data->regs->control);
-	drv_data->ssel = bfin_read(&drv_data->regs->ssel);
-
-	bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
-	bfin_write(&drv_data->regs->ssel, 0x0000FE00);
-	dma_disable_irq(drv_data->rx_dma);
-	dma_disable_irq(drv_data->tx_dma);
-
-	return 0;
-}
-
-static int bfin_spi_resume(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
-	int ret = 0;
-
-	/* bootrom may modify spi and dma status when resume in spi boot mode */
-	disable_dma(drv_data->rx_dma);
-
-	dma_enable_irq(drv_data->rx_dma);
-	dma_enable_irq(drv_data->tx_dma);
-	bfin_write(&drv_data->regs->control, drv_data->control);
-	bfin_write(&drv_data->regs->ssel, drv_data->ssel);
-
-	ret = spi_master_resume(master);
-	if (ret) {
-		free_dma(drv_data->rx_dma);
-		free_dma(drv_data->tx_dma);
-	}
-
-	return ret;
-}
-#endif
-static const struct dev_pm_ops bfin_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(bfin_spi_suspend, bfin_spi_resume)
-};
-
-MODULE_ALIAS("platform:bfin-spi3");
-static struct platform_driver bfin_spi_driver = {
-	.driver	= {
-		.name	= "bfin-spi3",
-		.owner	= THIS_MODULE,
-		.pm     = &bfin_spi_pm_ops,
-	},
-	.remove		= bfin_spi_remove,
-};
-
-module_platform_driver_probe(bfin_spi_driver, bfin_spi_probe);
-
-MODULE_DESCRIPTION("Analog Devices SPI3 controller driver");
-MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/adi_spi3.h b/include/linux/spi/adi_spi3.h
new file mode 100644
index 0000000..c84123a
--- /dev/null
+++ b/include/linux/spi/adi_spi3.h
@@ -0,0 +1,254 @@
+/*
+ * Analog Devices SPI3 controller driver
+ *
+ * Copyright (c) 2014 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ADI_SPI3_H_
+#define _ADI_SPI3_H_
+
+#include <linux/types.h>
+
+/* SPI_CONTROL */
+#define SPI_CTL_EN                  0x00000001    /* Enable */
+#define SPI_CTL_MSTR                0x00000002    /* Master/Slave */
+#define SPI_CTL_PSSE                0x00000004    /* controls modf error in master mode */
+#define SPI_CTL_ODM                 0x00000008    /* Open Drain Mode */
+#define SPI_CTL_CPHA                0x00000010    /* Clock Phase */
+#define SPI_CTL_CPOL                0x00000020    /* Clock Polarity */
+#define SPI_CTL_ASSEL               0x00000040    /* Slave Select Pin Control */
+#define SPI_CTL_SELST               0x00000080    /* Slave Select Polarity in-between transfers */
+#define SPI_CTL_EMISO               0x00000100    /* Enable MISO */
+#define SPI_CTL_SIZE                0x00000600    /* Word Transfer Size */
+#define SPI_CTL_SIZE08              0x00000000    /* SIZE: 8 bits */
+#define SPI_CTL_SIZE16              0x00000200    /* SIZE: 16 bits */
+#define SPI_CTL_SIZE32              0x00000400    /* SIZE: 32 bits */
+#define SPI_CTL_LSBF                0x00001000    /* LSB First */
+#define SPI_CTL_FCEN                0x00002000    /* Flow-Control Enable */
+#define SPI_CTL_FCCH                0x00004000    /* Flow-Control Channel Selection */
+#define SPI_CTL_FCPL                0x00008000    /* Flow-Control Polarity */
+#define SPI_CTL_FCWM                0x00030000    /* Flow-Control Water-Mark */
+#define SPI_CTL_FIFO0               0x00000000    /* FCWM: TFIFO empty or RFIFO Full */
+#define SPI_CTL_FIFO1               0x00010000    /* FCWM: TFIFO 75% or more empty or RFIFO 75% or more full */
+#define SPI_CTL_FIFO2               0x00020000    /* FCWM: TFIFO 50% or more empty or RFIFO 50% or more full */
+#define SPI_CTL_FMODE               0x00040000    /* Fast-mode Enable */
+#define SPI_CTL_MIOM                0x00300000    /* Multiple I/O Mode */
+#define SPI_CTL_MIO_DIS             0x00000000    /* MIOM: Disable */
+#define SPI_CTL_MIO_DUAL            0x00100000    /* MIOM: Enable DIOM (Dual I/O Mode) */
+#define SPI_CTL_MIO_QUAD            0x00200000    /* MIOM: Enable QUAD (Quad SPI Mode) */
+#define SPI_CTL_SOSI                0x00400000    /* Start on MOSI */
+/* SPI_RX_CONTROL */
+#define SPI_RXCTL_REN               0x00000001    /* Receive Channel Enable */
+#define SPI_RXCTL_RTI               0x00000004    /* Receive Transfer Initiate */
+#define SPI_RXCTL_RWCEN             0x00000008    /* Receive Word Counter Enable */
+#define SPI_RXCTL_RDR               0x00000070    /* Receive Data Request */
+#define SPI_RXCTL_RDR_DIS           0x00000000    /* RDR: Disabled */
+#define SPI_RXCTL_RDR_NE            0x00000010    /* RDR: RFIFO not empty */
+#define SPI_RXCTL_RDR_25            0x00000020    /* RDR: RFIFO 25% full */
+#define SPI_RXCTL_RDR_50            0x00000030    /* RDR: RFIFO 50% full */
+#define SPI_RXCTL_RDR_75            0x00000040    /* RDR: RFIFO 75% full */
+#define SPI_RXCTL_RDR_FULL          0x00000050    /* RDR: RFIFO full */
+#define SPI_RXCTL_RDO               0x00000100    /* Receive Data Over-Run */
+#define SPI_RXCTL_RRWM              0x00003000    /* FIFO Regular Water-Mark */
+#define SPI_RXCTL_RWM_0             0x00000000    /* RRWM: RFIFO Empty */
+#define SPI_RXCTL_RWM_25            0x00001000    /* RRWM: RFIFO 25% full */
+#define SPI_RXCTL_RWM_50            0x00002000    /* RRWM: RFIFO 50% full */
+#define SPI_RXCTL_RWM_75            0x00003000    /* RRWM: RFIFO 75% full */
+#define SPI_RXCTL_RUWM              0x00070000    /* FIFO Urgent Water-Mark */
+#define SPI_RXCTL_UWM_DIS           0x00000000    /* RUWM: Disabled */
+#define SPI_RXCTL_UWM_25            0x00010000    /* RUWM: RFIFO 25% full */
+#define SPI_RXCTL_UWM_50            0x00020000    /* RUWM: RFIFO 50% full */
+#define SPI_RXCTL_UWM_75            0x00030000    /* RUWM: RFIFO 75% full */
+#define SPI_RXCTL_UWM_FULL          0x00040000    /* RUWM: RFIFO full */
+/* SPI_TX_CONTROL */
+#define SPI_TXCTL_TEN               0x00000001    /* Transmit Channel Enable */
+#define SPI_TXCTL_TTI               0x00000004    /* Transmit Transfer Initiate */
+#define SPI_TXCTL_TWCEN             0x00000008    /* Transmit Word Counter Enable */
+#define SPI_TXCTL_TDR               0x00000070    /* Transmit Data Request */
+#define SPI_TXCTL_TDR_DIS           0x00000000    /* TDR: Disabled */
+#define SPI_TXCTL_TDR_NF            0x00000010    /* TDR: TFIFO not full */
+#define SPI_TXCTL_TDR_25            0x00000020    /* TDR: TFIFO 25% empty */
+#define SPI_TXCTL_TDR_50            0x00000030    /* TDR: TFIFO 50% empty */
+#define SPI_TXCTL_TDR_75            0x00000040    /* TDR: TFIFO 75% empty */
+#define SPI_TXCTL_TDR_EMPTY         0x00000050    /* TDR: TFIFO empty */
+#define SPI_TXCTL_TDU               0x00000100    /* Transmit Data Under-Run */
+#define SPI_TXCTL_TRWM              0x00003000    /* FIFO Regular Water-Mark */
+#define SPI_TXCTL_RWM_FULL          0x00000000    /* TRWM: TFIFO full */
+#define SPI_TXCTL_RWM_25            0x00001000    /* TRWM: TFIFO 25% empty */
+#define SPI_TXCTL_RWM_50            0x00002000    /* TRWM: TFIFO 50% empty */
+#define SPI_TXCTL_RWM_75            0x00003000    /* TRWM: TFIFO 75% empty */
+#define SPI_TXCTL_TUWM              0x00070000    /* FIFO Urgent Water-Mark */
+#define SPI_TXCTL_UWM_DIS           0x00000000    /* TUWM: Disabled */
+#define SPI_TXCTL_UWM_25            0x00010000    /* TUWM: TFIFO 25% empty */
+#define SPI_TXCTL_UWM_50            0x00020000    /* TUWM: TFIFO 50% empty */
+#define SPI_TXCTL_UWM_75            0x00030000    /* TUWM: TFIFO 75% empty */
+#define SPI_TXCTL_UWM_EMPTY         0x00040000    /* TUWM: TFIFO empty */
+/* SPI_CLOCK */
+#define SPI_CLK_BAUD                0x0000FFFF    /* Baud Rate */
+/* SPI_DELAY */
+#define SPI_DLY_STOP                0x000000FF    /* Transfer delay time in multiples of SCK period */
+#define SPI_DLY_LEADX               0x00000100    /* Extended (1 SCK) LEAD Control */
+#define SPI_DLY_LAGX                0x00000200    /* Extended (1 SCK) LAG control */
+/* SPI_SSEL */
+#define SPI_SLVSEL_SSE1             0x00000002    /* SPISSEL1 Enable */
+#define SPI_SLVSEL_SSE2             0x00000004    /* SPISSEL2 Enable */
+#define SPI_SLVSEL_SSE3             0x00000008    /* SPISSEL3 Enable */
+#define SPI_SLVSEL_SSE4             0x00000010    /* SPISSEL4 Enable */
+#define SPI_SLVSEL_SSE5             0x00000020    /* SPISSEL5 Enable */
+#define SPI_SLVSEL_SSE6             0x00000040    /* SPISSEL6 Enable */
+#define SPI_SLVSEL_SSE7             0x00000080    /* SPISSEL7 Enable */
+#define SPI_SLVSEL_SSEL1            0x00000200    /* SPISSEL1 Value */
+#define SPI_SLVSEL_SSEL2            0x00000400    /* SPISSEL2 Value */
+#define SPI_SLVSEL_SSEL3            0x00000800    /* SPISSEL3 Value */
+#define SPI_SLVSEL_SSEL4            0x00001000    /* SPISSEL4 Value */
+#define SPI_SLVSEL_SSEL5            0x00002000    /* SPISSEL5 Value */
+#define SPI_SLVSEL_SSEL6            0x00004000    /* SPISSEL6 Value */
+#define SPI_SLVSEL_SSEL7            0x00008000    /* SPISSEL7 Value */
+/* SPI_RWC */
+#define SPI_RWC_VALUE               0x0000FFFF    /* Received Word-Count */
+/* SPI_RWCR */
+#define SPI_RWCR_VALUE              0x0000FFFF    /* Received Word-Count Reload */
+/* SPI_TWC */
+#define SPI_TWC_VALUE               0x0000FFFF    /* Transmitted Word-Count */
+/* SPI_TWCR */
+#define SPI_TWCR_VALUE              0x0000FFFF    /* Transmitted Word-Count Reload */
+/* SPI_IMASK */
+#define SPI_IMSK_RUWM               0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_TUWM               0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_ROM                0x00000010    /* Receive Over-Run Error Interrupt Mask */
+#define SPI_IMSK_TUM                0x00000020    /* Transmit Under-Run Error Interrupt Mask */
+#define SPI_IMSK_TCM                0x00000040    /* Transmit Collision Error Interrupt Mask */
+#define SPI_IMSK_MFM                0x00000080    /* Mode Fault Error Interrupt Mask */
+#define SPI_IMSK_RSM                0x00000100    /* Receive Start Interrupt Mask */
+#define SPI_IMSK_TSM                0x00000200    /* Transmit Start Interrupt Mask */
+#define SPI_IMSK_RFM                0x00000400    /* Receive Finish Interrupt Mask */
+#define SPI_IMSK_TFM                0x00000800    /* Transmit Finish Interrupt Mask */
+/* SPI_IMASKCL */
+#define SPI_IMSK_CLR_RUW            0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_CLR_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_CLR_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
+#define SPI_IMSK_CLR_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
+#define SPI_IMSK_CLR_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
+#define SPI_IMSK_CLR_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
+#define SPI_IMSK_CLR_RSM            0x00000100    /* Receive Start Interrupt Mask */
+#define SPI_IMSK_CLR_TSM            0x00000200    /* Transmit Start Interrupt Mask */
+#define SPI_IMSK_CLR_RFM            0x00000400    /* Receive Finish Interrupt Mask */
+#define SPI_IMSK_CLR_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
+/* SPI_IMASKST */
+#define SPI_IMSK_SET_RUWM           0x00000002    /* Receive Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_SET_TUWM           0x00000004    /* Transmit Urgent Water-Mark Interrupt Mask */
+#define SPI_IMSK_SET_ROM            0x00000010    /* Receive Over-Run Error Interrupt Mask */
+#define SPI_IMSK_SET_TUM            0x00000020    /* Transmit Under-Run Error Interrupt Mask */
+#define SPI_IMSK_SET_TCM            0x00000040    /* Transmit Collision Error Interrupt Mask */
+#define SPI_IMSK_SET_MFM            0x00000080    /* Mode Fault Error Interrupt Mask */
+#define SPI_IMSK_SET_RSM            0x00000100    /* Receive Start Interrupt Mask */
+#define SPI_IMSK_SET_TSM            0x00000200    /* Transmit Start Interrupt Mask */
+#define SPI_IMSK_SET_RFM            0x00000400    /* Receive Finish Interrupt Mask */
+#define SPI_IMSK_SET_TFM            0x00000800    /* Transmit Finish Interrupt Mask */
+/* SPI_STATUS */
+#define SPI_STAT_SPIF               0x00000001    /* SPI Finished */
+#define SPI_STAT_RUWM               0x00000002    /* Receive Urgent Water-Mark Breached */
+#define SPI_STAT_TUWM               0x00000004    /* Transmit Urgent Water-Mark Breached */
+#define SPI_STAT_ROE                0x00000010    /* Receive Over-Run Error Indication */
+#define SPI_STAT_TUE                0x00000020    /* Transmit Under-Run Error Indication */
+#define SPI_STAT_TCE                0x00000040    /* Transmit Collision Error Indication */
+#define SPI_STAT_MODF               0x00000080    /* Mode Fault Error Indication */
+#define SPI_STAT_RS                 0x00000100    /* Receive Start Indication */
+#define SPI_STAT_TS                 0x00000200    /* Transmit Start Indication */
+#define SPI_STAT_RF                 0x00000400    /* Receive Finish Indication */
+#define SPI_STAT_TF                 0x00000800    /* Transmit Finish Indication */
+#define SPI_STAT_RFS                0x00007000    /* SPI_RFIFO status */
+#define SPI_STAT_RFIFO_EMPTY        0x00000000    /* RFS: RFIFO Empty */
+#define SPI_STAT_RFIFO_25           0x00001000    /* RFS: RFIFO 25% Full */
+#define SPI_STAT_RFIFO_50           0x00002000    /* RFS: RFIFO 50% Full */
+#define SPI_STAT_RFIFO_75           0x00003000    /* RFS: RFIFO 75% Full */
+#define SPI_STAT_RFIFO_FULL         0x00004000    /* RFS: RFIFO Full */
+#define SPI_STAT_TFS                0x00070000    /* SPI_TFIFO status */
+#define SPI_STAT_TFIFO_FULL         0x00000000    /* TFS: TFIFO full */
+#define SPI_STAT_TFIFO_25           0x00010000    /* TFS: TFIFO 25% empty */
+#define SPI_STAT_TFIFO_50           0x00020000    /* TFS: TFIFO 50% empty */
+#define SPI_STAT_TFIFO_75           0x00030000    /* TFS: TFIFO 75% empty */
+#define SPI_STAT_TFIFO_EMPTY        0x00040000    /* TFS: TFIFO empty */
+#define SPI_STAT_FCS                0x00100000    /* Flow-Control Stall Indication */
+#define SPI_STAT_RFE                0x00400000    /* SPI_RFIFO Empty */
+#define SPI_STAT_TFF                0x00800000    /* SPI_TFIFO Full */
+/* SPI_ILAT */
+#define SPI_ILAT_RUWMI              0x00000002    /* Receive Urgent Water Mark Interrupt */
+#define SPI_ILAT_TUWMI              0x00000004    /* Transmit Urgent Water Mark Interrupt */
+#define SPI_ILAT_ROI                0x00000010    /* Receive Over-Run Error Indication */
+#define SPI_ILAT_TUI                0x00000020    /* Transmit Under-Run Error Indication */
+#define SPI_ILAT_TCI                0x00000040    /* Transmit Collision Error Indication */
+#define SPI_ILAT_MFI                0x00000080    /* Mode Fault Error Indication */
+#define SPI_ILAT_RSI                0x00000100    /* Receive Start Indication */
+#define SPI_ILAT_TSI                0x00000200    /* Transmit Start Indication */
+#define SPI_ILAT_RFI                0x00000400    /* Receive Finish Indication */
+#define SPI_ILAT_TFI                0x00000800    /* Transmit Finish Indication */
+/* SPI_ILATCL */
+#define SPI_ILAT_CLR_RUWMI          0x00000002    /* Receive Urgent Water Mark Interrupt */
+#define SPI_ILAT_CLR_TUWMI          0x00000004    /* Transmit Urgent Water Mark Interrupt */
+#define SPI_ILAT_CLR_ROI            0x00000010    /* Receive Over-Run Error Indication */
+#define SPI_ILAT_CLR_TUI            0x00000020    /* Transmit Under-Run Error Indication */
+#define SPI_ILAT_CLR_TCI            0x00000040    /* Transmit Collision Error Indication */
+#define SPI_ILAT_CLR_MFI            0x00000080    /* Mode Fault Error Indication */
+#define SPI_ILAT_CLR_RSI            0x00000100    /* Receive Start Indication */
+#define SPI_ILAT_CLR_TSI            0x00000200    /* Transmit Start Indication */
+#define SPI_ILAT_CLR_RFI            0x00000400    /* Receive Finish Indication */
+#define SPI_ILAT_CLR_TFI            0x00000800    /* Transmit Finish Indication */
+
+/*
+ * adi spi3 registers layout
+ */
+struct adi_spi_regs {
+	u32 revid;
+	u32 control;
+	u32 rx_control;
+	u32 tx_control;
+	u32 clock;
+	u32 delay;
+	u32 ssel;
+	u32 rwc;
+	u32 rwcr;
+	u32 twc;
+	u32 twcr;
+	u32 reserved0;
+	u32 emask;
+	u32 emaskcl;
+	u32 emaskst;
+	u32 reserved1;
+	u32 status;
+	u32 elat;
+	u32 elatcl;
+	u32 reserved2;
+	u32 rfifo;
+	u32 reserved3;
+	u32 tfifo;
+};
+
+#define MAX_CTRL_CS          8  /* cs in spi controller */
+
+/* device.platform_data for SSP controller devices */
+struct adi_spi3_master {
+	u16 num_chipselect;
+	u16 pin_req[7];
+};
+
+/* spi_board_info.controller_data for SPI slave devices,
+ * copied to spi_device.platform_data ... mostly for dma tuning
+ */
+struct adi_spi3_chip {
+	u32 control;
+	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
+	u32 tx_dummy_val; /* tx value for rx only transfer */
+	bool enable_dma;
+};
+
+#endif /* _ADI_SPI3_H_ */
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
