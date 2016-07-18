From: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sh-msiof: request and set cs-gpio direction to output
Date: Mon, 18 Jul 2016 10:57:39 +0200
Message-ID: <1468832259-26476-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
	magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Required for the CS signal to actually be visible to the device.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index a7934ab..d4b5772 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -536,15 +536,35 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 				  !!(spi->mode & SPI_LSB_FIRST),
 				  !!(spi->mode & SPI_CS_HIGH));
 
-	if (spi->cs_gpio >= 0)
-		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	if (spi->cs_gpio >= 0 && !spi_get_ctldata(spi)) {
+		int status = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+
+		if (status)
+			return status;
 
+		status = gpio_direction_output(spi->cs_gpio,
+					       !(spi->mode & SPI_CS_HIGH));
+		if (status) {
+			gpio_free(spi->cs_gpio);
+			return status;
+		}
+
+		spi_set_ctldata(spi, (void *)spi->cs_gpio);
+	}
 
 	pm_runtime_put(&p->pdev->dev);
 
 	return 0;
 }
 
+static void sh_msiof_spi_cleanup(struct spi_device *spi)
+{
+	if (spi->cs_gpio >= 0)
+		gpio_free(spi->cs_gpio);
+
+	spi_set_ctldata(spi, NULL);
+}
+
 static int sh_msiof_prepare_message(struct spi_master *master,
 				    struct spi_message *msg)
 {
@@ -1232,6 +1252,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->num_chipselect = p->info->num_chipselect;
 	master->setup = sh_msiof_spi_setup;
+	master->cleanup = sh_msiof_spi_cleanup;
 	master->prepare_message = sh_msiof_prepare_message;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	master->auto_runtime_pm = true;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
