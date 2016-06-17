From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/5] spi: s3c64xx: group the CS signalling writes in a single
 function
Date: Fri, 17 Jun 2016 16:57:22 +0900
Message-ID: <1466150245-2648-3-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1466150245-2648-1-git-send-email-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To enable/disable the CS line, the driver performs a writel in
the S3C64XX_SPI_SLAVE_SEL registers. Put together all the writes
in that register in a single function.

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a76a50..972367d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -310,6 +310,28 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	dma_async_issue_pending(dma->ch);
 }
 
+static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct s3c64xx_spi_driver_data *sdd =
+					spi_master_get_devdata(spi->master);
+
+	if (enable) {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
+			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		} else {
+			u32 ssel = readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+
+			ssel |= (S3C64XX_SPI_SLAVE_AUTO |
+						S3C64XX_SPI_SLAVE_NSC_CNT_2);
+			writel(ssel, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		}
+	} else {
+		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT,
+		sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	}
+}
+
 static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
@@ -706,12 +728,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	enable_datapath(sdd, spi, xfer, use_dma);
 
 	/* Start the signals */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-	else
-		writel(readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL)
-			| S3C64XX_SPI_SLAVE_AUTO | S3C64XX_SPI_SLAVE_NSC_CNT_2,
-			sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, true);
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
@@ -861,16 +878,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
+
 	return 0;
 
 setup_exit:
 	pm_runtime_mark_last_busy(&sdd->pdev->dev);
 	pm_runtime_put_autosuspend(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	s3c64xx_spi_set_cs(spi, false);
 
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
