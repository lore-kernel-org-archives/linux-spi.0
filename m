From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: atmel: factorize reusable code for SPI controller init" to the spi tree
Date: Wed, 12 Apr 2017 10:48:22 +0100
Message-ID: <E1cyEsw-0004Wq-DF@debutante>
References: <20170412070520.29621-1-quentin.schulz@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170412070520.29621-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: atmel: factorize reusable code for SPI controller init

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 05514c86965f98f9b0e57f73700771fa267050a7 Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Date: Wed, 12 Apr 2017 09:05:19 +0200
Subject: [PATCH] spi: atmel: factorize reusable code for SPI controller init

The SPI controller configuration during the init can be reused, for the
resume function for example.

Let's move this configuration to a separate function.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0e7712bac3b6..247d920a512f 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
