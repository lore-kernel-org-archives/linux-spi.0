From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] ARM: mxs: Provide a common header file for SSP controller
Date: Wed, 18 Apr 2012 21:30:33 -0300
Message-ID: <1334795434-8780-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	snijsure-4jo+YWezP1RWk0Htik3J/w@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
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

On mxs SoCs the SSP controller can act as MMC or SPI controller.

Remove the SSP related definitions from the mxs-mmc driver and put it on a 
common header file.

This will facilitate the introduction of the spi-mxs driver.

Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/mach-mxs/include/mach/ssp-regs.h |  114 +++++++++++++++++++++++++++++
 drivers/mmc/host/mxs-mmc.c                |   93 +-----------------------
 2 files changed, 116 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/ssp-regs.h

diff --git a/arch/arm/mach-mxs/include/mach/ssp-regs.h b/arch/arm/mach-mxs/include/mach/ssp-regs.h
new file mode 100644
index 0000000..4bb0b27
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/ssp-regs.h
@@ -0,0 +1,114 @@
+/*
+ * Freescale MXS SSP Registers
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
+ */
+
+#ifndef __SSP_REGS_H
+#define __SSP_REGS_H
+
+
+/* card detect polling timeout */
+#define MXS_MMC_DETECT_TIMEOUT			(HZ/2)
+
+#define SSP_VERSION_LATEST	4
+#define ssp_is_old()		(rev_struct < SSP_VERSION_LATEST)
+
+/* SSP registers */
+#define HW_SSP_CTRL0				0x000
+#define BM_SSP_CTRL0_RUN			(1 << 29)
+#define BM_SSP_CTRL0_SDIO_IRQ_CHECK		(1 << 28)
+#define BM_SSP_CTRL0_IGNORE_CRC			(1 << 26)
+#define BM_SSP_CTRL0_READ			(1 << 25)
+#define BM_SSP_CTRL0_DATA_XFER			(1 << 24)
+#define BP_SSP_CTRL0_BUS_WIDTH			22
+#define BM_SSP_CTRL0_BUS_WIDTH			(0x3 << 22)
+#define BM_SSP_CTRL0_WAIT_FOR_IRQ		(1 << 21)
+#define BM_SSP_CTRL0_LONG_RESP			(1 << 19)
+#define BM_SSP_CTRL0_GET_RESP			(1 << 17)
+#define BM_SSP_CTRL0_ENABLE			(1 << 16)
+#define BP_SSP_CTRL0_XFER_COUNT			0
+#define BM_SSP_CTRL0_XFER_COUNT			0xffff
+#define HW_SSP_CMD0				0x010
+#define BM_SSP_CMD0_DBL_DATA_RATE_EN		(1 << 25)
+#define BM_SSP_CMD0_SLOW_CLKING_EN		(1 << 22)
+#define BM_SSP_CMD0_CONT_CLKING_EN		(1 << 21)
+#define BM_SSP_CMD0_APPEND_8CYC			(1 << 20)
+#define BP_SSP_CMD0_BLOCK_SIZE			16
+#define BM_SSP_CMD0_BLOCK_SIZE			(0xf << 16)
+#define BP_SSP_CMD0_BLOCK_COUNT			8
+#define BM_SSP_CMD0_BLOCK_COUNT			(0xff << 8)
+#define BP_SSP_CMD0_CMD				0
+#define BM_SSP_CMD0_CMD				0xff
+#define HW_SSP_CMD1				0x020
+#define HW_SSP_XFER_SIZE			0x030
+#define HW_SSP_BLOCK_SIZE			0x040
+#define BP_SSP_BLOCK_SIZE_BLOCK_COUNT		4
+#define BM_SSP_BLOCK_SIZE_BLOCK_COUNT		(0xffffff << 4)
+#define BP_SSP_BLOCK_SIZE_BLOCK_SIZE		0
+#define BM_SSP_BLOCK_SIZE_BLOCK_SIZE		0xf
+#define HW_SSP_TIMING				(ssp_is_old() ? 0x050 : 0x070)
+#define BP_SSP_TIMING_TIMEOUT			16
+#define BM_SSP_TIMING_TIMEOUT			(0xffff << 16)
+#define BP_SSP_TIMING_CLOCK_DIVIDE		8
+#define BM_SSP_TIMING_CLOCK_DIVIDE		(0xff << 8)
+#define BP_SSP_TIMING_CLOCK_RATE		0
+#define BM_SSP_TIMING_CLOCK_RATE		0xff
+#define HW_SSP_CTRL1				(ssp_is_old() ? 0x060 : 0x080)
+#define BM_SSP_CTRL1_SDIO_IRQ			(1 << 31)
+#define BM_SSP_CTRL1_SDIO_IRQ_EN		(1 << 30)
+#define BM_SSP_CTRL1_RESP_ERR_IRQ		(1 << 29)
+#define BM_SSP_CTRL1_RESP_ERR_IRQ_EN		(1 << 28)
+#define BM_SSP_CTRL1_RESP_TIMEOUT_IRQ		(1 << 27)
+#define BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN	(1 << 26)
+#define BM_SSP_CTRL1_DATA_TIMEOUT_IRQ		(1 << 25)
+#define BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN	(1 << 24)
+#define BM_SSP_CTRL1_DATA_CRC_IRQ		(1 << 23)
+#define BM_SSP_CTRL1_DATA_CRC_IRQ_EN		(1 << 22)
+#define BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ		(1 << 21)
+#define BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ_EN	(1 << 20)
+#define BM_SSP_CTRL1_RECV_TIMEOUT_IRQ		(1 << 17)
+#define BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN	(1 << 16)
+#define BM_SSP_CTRL1_FIFO_OVERRUN_IRQ		(1 << 15)
+#define BM_SSP_CTRL1_FIFO_OVERRUN_IRQ_EN	(1 << 14)
+#define BM_SSP_CTRL1_DMA_ENABLE			(1 << 13)
+#define BM_SSP_CTRL1_POLARITY			(1 << 9)
+#define BP_SSP_CTRL1_WORD_LENGTH		4
+#define BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
+#define BP_SSP_CTRL1_SSP_MODE			0
+#define BM_SSP_CTRL1_SSP_MODE			0xf
+#define HW_SSP_SDRESP0				(ssp_is_old() ? 0x080 : 0x0a0)
+#define HW_SSP_SDRESP1				(ssp_is_old() ? 0x090 : 0x0b0)
+#define HW_SSP_SDRESP2				(ssp_is_old() ? 0x0a0 : 0x0c0)
+#define HW_SSP_SDRESP3				(ssp_is_old() ? 0x0b0 : 0x0d0)
+#define HW_SSP_STATUS				(ssp_is_old() ? 0x0c0 : 0x100)
+#define BM_SSP_STATUS_CARD_DETECT		(1 << 28)
+#define BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
+#define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)
+#define BP_SSP_VERSION_MAJOR			24
+
+#define BF_SSP(value, field)	(((value) << BP_SSP_##field) & BM_SSP_##field)
+
+#define MXS_MMC_IRQ_BITS	(BM_SSP_CTRL1_SDIO_IRQ		| \
+				 BM_SSP_CTRL1_RESP_ERR_IRQ	| \
+				 BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
+				 BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
+				 BM_SSP_CTRL1_DATA_CRC_IRQ	| \
+				 BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	| \
+				 BM_SSP_CTRL1_RECV_TIMEOUT_IRQ  | \
+				 BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
+
+#define SSP_PIO_NUM	3
+
+#endif /* __SSP_REGS_H */
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index b0f2ef9..44d19ef 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -43,100 +43,11 @@
 #include <mach/mxs.h>
 #include <mach/common.h>
 #include <mach/mmc.h>
+#include <mach/ssp-regs.h>
 
 #define DRIVER_NAME	"mxs-mmc"
 
-/* card detect polling timeout */
-#define MXS_MMC_DETECT_TIMEOUT			(HZ/2)
-
-#define SSP_VERSION_LATEST	4
-#define ssp_is_old()		(host->version < SSP_VERSION_LATEST)
-
-/* SSP registers */
-#define HW_SSP_CTRL0				0x000
-#define  BM_SSP_CTRL0_RUN			(1 << 29)
-#define  BM_SSP_CTRL0_SDIO_IRQ_CHECK		(1 << 28)
-#define  BM_SSP_CTRL0_IGNORE_CRC		(1 << 26)
-#define  BM_SSP_CTRL0_READ			(1 << 25)
-#define  BM_SSP_CTRL0_DATA_XFER			(1 << 24)
-#define  BP_SSP_CTRL0_BUS_WIDTH			(22)
-#define  BM_SSP_CTRL0_BUS_WIDTH			(0x3 << 22)
-#define  BM_SSP_CTRL0_WAIT_FOR_IRQ		(1 << 21)
-#define  BM_SSP_CTRL0_LONG_RESP			(1 << 19)
-#define  BM_SSP_CTRL0_GET_RESP			(1 << 17)
-#define  BM_SSP_CTRL0_ENABLE			(1 << 16)
-#define  BP_SSP_CTRL0_XFER_COUNT		(0)
-#define  BM_SSP_CTRL0_XFER_COUNT		(0xffff)
-#define HW_SSP_CMD0				0x010
-#define  BM_SSP_CMD0_DBL_DATA_RATE_EN		(1 << 25)
-#define  BM_SSP_CMD0_SLOW_CLKING_EN		(1 << 22)
-#define  BM_SSP_CMD0_CONT_CLKING_EN		(1 << 21)
-#define  BM_SSP_CMD0_APPEND_8CYC		(1 << 20)
-#define  BP_SSP_CMD0_BLOCK_SIZE			(16)
-#define  BM_SSP_CMD0_BLOCK_SIZE			(0xf << 16)
-#define  BP_SSP_CMD0_BLOCK_COUNT		(8)
-#define  BM_SSP_CMD0_BLOCK_COUNT		(0xff << 8)
-#define  BP_SSP_CMD0_CMD			(0)
-#define  BM_SSP_CMD0_CMD			(0xff)
-#define HW_SSP_CMD1				0x020
-#define HW_SSP_XFER_SIZE			0x030
-#define HW_SSP_BLOCK_SIZE			0x040
-#define  BP_SSP_BLOCK_SIZE_BLOCK_COUNT		(4)
-#define  BM_SSP_BLOCK_SIZE_BLOCK_COUNT		(0xffffff << 4)
-#define  BP_SSP_BLOCK_SIZE_BLOCK_SIZE		(0)
-#define  BM_SSP_BLOCK_SIZE_BLOCK_SIZE		(0xf)
-#define HW_SSP_TIMING				(ssp_is_old() ? 0x050 : 0x070)
-#define  BP_SSP_TIMING_TIMEOUT			(16)
-#define  BM_SSP_TIMING_TIMEOUT			(0xffff << 16)
-#define  BP_SSP_TIMING_CLOCK_DIVIDE		(8)
-#define  BM_SSP_TIMING_CLOCK_DIVIDE		(0xff << 8)
-#define  BP_SSP_TIMING_CLOCK_RATE		(0)
-#define  BM_SSP_TIMING_CLOCK_RATE		(0xff)
-#define HW_SSP_CTRL1				(ssp_is_old() ? 0x060 : 0x080)
-#define  BM_SSP_CTRL1_SDIO_IRQ			(1 << 31)
-#define  BM_SSP_CTRL1_SDIO_IRQ_EN		(1 << 30)
-#define  BM_SSP_CTRL1_RESP_ERR_IRQ		(1 << 29)
-#define  BM_SSP_CTRL1_RESP_ERR_IRQ_EN		(1 << 28)
-#define  BM_SSP_CTRL1_RESP_TIMEOUT_IRQ		(1 << 27)
-#define  BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN	(1 << 26)
-#define  BM_SSP_CTRL1_DATA_TIMEOUT_IRQ		(1 << 25)
-#define  BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN	(1 << 24)
-#define  BM_SSP_CTRL1_DATA_CRC_IRQ		(1 << 23)
-#define  BM_SSP_CTRL1_DATA_CRC_IRQ_EN		(1 << 22)
-#define  BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ		(1 << 21)
-#define  BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ_EN	(1 << 20)
-#define  BM_SSP_CTRL1_RECV_TIMEOUT_IRQ		(1 << 17)
-#define  BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN	(1 << 16)
-#define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ		(1 << 15)
-#define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ_EN	(1 << 14)
-#define  BM_SSP_CTRL1_DMA_ENABLE		(1 << 13)
-#define  BM_SSP_CTRL1_POLARITY			(1 << 9)
-#define  BP_SSP_CTRL1_WORD_LENGTH		(4)
-#define  BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
-#define  BP_SSP_CTRL1_SSP_MODE			(0)
-#define  BM_SSP_CTRL1_SSP_MODE			(0xf)
-#define HW_SSP_SDRESP0				(ssp_is_old() ? 0x080 : 0x0a0)
-#define HW_SSP_SDRESP1				(ssp_is_old() ? 0x090 : 0x0b0)
-#define HW_SSP_SDRESP2				(ssp_is_old() ? 0x0a0 : 0x0c0)
-#define HW_SSP_SDRESP3				(ssp_is_old() ? 0x0b0 : 0x0d0)
-#define HW_SSP_STATUS				(ssp_is_old() ? 0x0c0 : 0x100)
-#define  BM_SSP_STATUS_CARD_DETECT		(1 << 28)
-#define  BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
-#define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)
-#define  BP_SSP_VERSION_MAJOR			(24)
-
-#define BF_SSP(value, field)	(((value) << BP_SSP_##field) & BM_SSP_##field)
-
-#define MXS_MMC_IRQ_BITS	(BM_SSP_CTRL1_SDIO_IRQ		| \
-				 BM_SSP_CTRL1_RESP_ERR_IRQ	| \
-				 BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
-				 BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
-				 BM_SSP_CTRL1_DATA_CRC_IRQ	| \
-				 BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	| \
-				 BM_SSP_CTRL1_RECV_TIMEOUT_IRQ  | \
-				 BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
-
-#define SSP_PIO_NUM	3
+#define rev_struct	(host->version)
 
 struct mxs_mmc_host {
 	struct mmc_host			*mmc;
-- 
1.7.1


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
