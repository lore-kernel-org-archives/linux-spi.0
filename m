From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/9] spi: imx: initialize usedma earlier
Date: Wed, 24 Feb 2016 09:20:26 +0100
Message-ID: <1456302033-25638-3-git-send-email-s.hauer@pengutronix.de>
References: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456302033-25638-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The SoC specific config function does not know if DMA will be used or
not. This information will be useful to configure the SPI controller
correctly for DMA in following patches, so initialize the usedma
variable before calling into the SoC specific config function.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a61b1b1..5792918 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -815,6 +815,11 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->tx = spi_imx_buf_tx_u32;
 	}
 
+	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
+		spi_imx->usedma = 1;
+	else
+		spi_imx->usedma = 0;
+
 	spi_imx->devtype_data->config(spi_imx, &config);
 
 	return 0;
@@ -1040,14 +1045,10 @@ static int spi_imx_transfer(struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
-	if (spi_imx->bitbang.master->can_dma &&
-	    spi_imx_can_dma(spi_imx->bitbang.master, spi, transfer)) {
-		spi_imx->usedma = true;
+	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
-	}
-	spi_imx->usedma = false;
-
-	return spi_imx_pio_transfer(spi, transfer);
+	else
+		return spi_imx_pio_transfer(spi, transfer);
 }
 
 static int spi_imx_setup(struct spi_device *spi)
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
