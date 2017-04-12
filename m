From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/2] spi: atmel: factorize reusable code for SPI controller init
Date: Wed, 12 Apr 2017 09:05:19 +0200
Message-ID: <20170412070520.29621-1-quentin.schulz@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
To: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The SPI controller configuration during the init can be reused, for the
resume function for example.

Let's move this configuration to a separate function.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0e7712b..247d920 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1464,6 +1464,25 @@ static int atmel_spi_gpio_cs(struct platform_device *pdev)
 	return 0;
 }
 
+static void atmel_spi_init(struct atmel_spi *as)
+{
+	spi_writel(as, CR, SPI_BIT(SWRST));
+	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+	if (as->caps.has_wdrbt) {
+		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
+				| SPI_BIT(MSTR));
+	} else {
+		spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
+	}
+
+	if (as->use_pdc)
+		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
+	spi_writel(as, CR, SPI_BIT(SPIEN));
+
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+}
+
 static int atmel_spi_probe(struct platform_device *pdev)
 {
 	struct resource		*regs;
@@ -1572,26 +1591,14 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	as->spi_clk = clk_get_rate(clk);
 
-	spi_writel(as, CR, SPI_BIT(SWRST));
-	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
-	if (as->caps.has_wdrbt) {
-		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
-				| SPI_BIT(MSTR));
-	} else {
-		spi_writel(as, MR, SPI_BIT(MSTR) | SPI_BIT(MODFDIS));
-	}
-
-	if (as->use_pdc)
-		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
-	spi_writel(as, CR, SPI_BIT(SPIEN));
-
 	as->fifo_size = 0;
 	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
 				  &as->fifo_size)) {
 		dev_info(&pdev->dev, "Using FIFO (%u data)\n", as->fifo_size);
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 	}
 
+	atmel_spi_init(as);
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
