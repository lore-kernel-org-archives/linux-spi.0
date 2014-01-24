From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/s3c64xx: Remove unused /CS GPIO management
Date: Fri, 24 Jan 2014 19:01:32 +0000
Message-ID: <1390590092-20452-1-git-send-email-broonie@kernel.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The GPIO enable and disable is done in the core so does not need to be
replicated in the driver, delete the unneeded code. enable_cs() was not
referenced at all.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e7620f299777..19113538f5c6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -656,23 +656,6 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	writel(chcfg, regs + S3C64XX_SPI_CH_CFG);
 }
 
-static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_device *spi)
-{
-	if (sdd->tgl_spi != NULL) { /* If last device toggled after mssg */
-		if (sdd->tgl_spi != spi) { /* if last mssg on diff device */
-			/* Deselect the last toggled device */
-			if (spi->cs_gpio >= 0)
-				gpio_set_value(spi->cs_gpio,
-					spi->mode & SPI_CS_HIGH ? 0 : 1);
-		}
-		sdd->tgl_spi = NULL;
-	}
-
-	if (spi->cs_gpio >= 0)
-		gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH ? 1 : 0);
-}
-
 static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 					int timeout_ms)
 {
@@ -792,16 +775,6 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 	return 0;
 }
 
-static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_device *spi)
-{
-	if (sdd->tgl_spi == spi)
-		sdd->tgl_spi = NULL;
-
-	if (spi->cs_gpio >= 0)
-		gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
-}
-
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
 	void __iomem *regs = sdd->regs;
@@ -1118,14 +1091,12 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_put(&sdd->pdev->dev);
 	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-	disable_cs(sdd, spi);
 	return 0;
 
 setup_exit:
 	pm_runtime_put(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
 	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-	disable_cs(sdd, spi);
 
 	gpio_free(cs->line);
 	spi_set_ctldata(spi, NULL);
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
