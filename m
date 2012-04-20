From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] spi: spi-rspi: add dmaengine supporting
Date: Fri, 20 Apr 2012 16:17:07 +0900
Message-ID: <4F910D73.70809@renesas.com>
References: <4F90F92C.5030001@renesas.com> <20120420064038.GA24697@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <20120420064038.GA24697@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Simon-san,

2012/04/20 15:40, Simon Horman wrote:
> On Fri, Apr 20, 2012 at 02:50:36PM +0900, Shimoda, Yoshihiro wrote:
>> This patch adds dmaengine supporting using sh_dma driver. The module
>> receives data by DMAC, it also needs TX DMAC to generate SPI's clocks.
> 
> Hi Shimoda-san,
> 
> could you let me know if it is possible to exercise this code
> on the sh7757lcr board and if so, how?

If you have an external SPI board for the sh7757lcr board,
you can exercise this code using the two additional patches.

 1) sh: modify the sh_dmae_slave_config for RSPI in setup-sh7757
  http://marc.info/?l=linux-sh&m=133482996807408&w=2
 2) a temporal patch as the following

Best regards,
Yoshihiro Shimoda
---
diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 24b1ee4..bb96070 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -324,6 +324,14 @@ static struct spi_board_info spi_board_info[] = {
 		.chip_select = 1,
 		.platform_data = &spi_flash_data,
 	},
+	{
+		/* for external SPI board */
+		.modalias = "m25p80",
+		.max_speed_hz = 25000000,
+		.bus_num = 2,
+		.chip_select = 0,
+		.platform_data = &spi_flash_data,
+	},
 };

 static int __init sh7757lcr_devices_setup(void)
@@ -558,6 +566,8 @@ static int __init sh7757lcr_devices_setup(void)
 	spi_register_board_info(spi_board_info,
 				ARRAY_SIZE(spi_board_info));

+	__raw_writel(0x40, 0xfe460000);		/* DMAER1: enable RSPI */
+
 	/* General platform */
 	return platform_add_devices(sh7757lcr_devices,
 				    ARRAY_SIZE(sh7757lcr_devices));
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index f807590..1ee3be5 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sh_timer.h>
 #include <linux/sh_dma.h>
+#include <linux/spi/rspi.h>

 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
@@ -694,6 +695,12 @@ static struct platform_device spi1_device = {
 	.resource	= spi1_resources,
 };

+static struct rspi_plat_data rspi_platform_data = {
+	.dma_tx_id = SHDMA_SLAVE_RSPI_TX,
+	.dma_rx_id = SHDMA_SLAVE_RSPI_RX,
+	.dma_width_16bit = 1,
+};
+
 static struct resource rspi_resources[] = {
 	{
 		.start	= 0xfe480000,
@@ -709,6 +716,9 @@ static struct resource rspi_resources[] = {
 static struct platform_device rspi_device = {
 	.name	= "rspi",
 	.id	= 2,
+	.dev	= {
+		.platform_data = &rspi_platform_data,
+	},
 	.num_resources	= ARRAY_SIZE(rspi_resources),
 	.resource	= rspi_resources,
 };

