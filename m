From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi/mxs: Make the SPI block clock speed configurable via DT
Date: Wed, 22 Aug 2012 22:38:35 +0200
Message-ID: <1345667915-26189-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

Add "clock-frequency" property, which allows configuring the SPI block's
base speed.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/mxs-spi.txt |    4 ++++
 drivers/spi/spi-mxs.c                             |   21 +++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
index c36296f..e2e1395 100644
--- a/Documentation/devicetree/bindings/spi/mxs-spi.txt
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts: Should contain SSP interrupts (error irq first, dma irq second)
 - fsl,ssp-dma-channel: APBX DMA channel for the SSP
 
+Optional properties:
+- clock-frequency : Input clock frequency to the SPI block in Hz.
+		    Default is 160000000 Hz.
+
 Example:
 
 ssp0: ssp@80010000 {
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 130a436..331f600 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -485,10 +485,17 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	struct clk *clk;
 	void __iomem *base;
-	int devid, dma_channel;
+	int devid, dma_channel, clk_freq;
 	int ret = 0, irq_err, irq_dma;
 	dma_cap_mask_t mask;
 
+	/*
+	 * Default clock speed for the SPI core. 160MHz seems to
+	 * work reasonably well with most SPI flashes, so use this
+	 * as a default. Override with "clock-frequency" DT prop.
+	 */
+	const int clk_freq_default = 160000000;
+
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_err = platform_get_irq(pdev, 0);
 	irq_dma = platform_get_irq(pdev, 1);
@@ -520,12 +527,18 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 				"Failed to get DMA channel\n");
 			return -EINVAL;
 		}
+
+		ret = of_property_read_u32(np, "clock-frequency",
+					   &clk_freq);
+		if (ret)
+			clk_freq = clk_freq_default;
 	} else {
 		dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 		if (!dmares)
 			return -EINVAL;
 		devid = pdev->id_entry->driver_data;
 		dma_channel = dmares->start;
+		clk_freq = clk_freq_default;
 	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
@@ -561,12 +574,8 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 		goto out_master_free;
 	}
 
-	/*
-	 * Crank up the clock to 120MHz, this will be further divided onto a
-	 * proper speed.
-	 */
 	clk_prepare_enable(ssp->clk);
-	clk_set_rate(ssp->clk, 120 * 1000 * 1000);
+	clk_set_rate(ssp->clk, clk_freq);
 	ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
 
 	stmp_reset_block(ssp->base);
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
