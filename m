From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/6] spi: imx: Drop unnecessary check
Date: Fri,  2 Jun 2017 07:38:00 +0200
Message-ID: <20170602053804.3238-3-s.hauer@pengutronix.de>
References: <20170602053804.3238-1-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170602053804.3238-1-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

__spi_validate makes sure that every transfer has a valid bits_per_word
and speed_hz setting. We do not need to fallback to values from the
spi_device.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4b5cd0c84450..e3bc3d51a2d6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -218,8 +218,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	bpw = transfer->bits_per_word;
-	if (!bpw)
-		bpw = spi->bits_per_word;
 
 	bpw = spi_imx_bytes_per_word(bpw);
 
@@ -898,11 +896,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.bpw = t->bits_per_word;
 	config.speed_hz  = t->speed_hz;
 
-	if (!config.speed_hz)
-		config.speed_hz = spi->max_speed_hz;
-	if (!config.bpw)
-		config.bpw = spi->bits_per_word;
-
 	/* Initialize the functions for transfer */
 	if (config.bpw <= 8) {
 		spi_imx->rx = spi_imx_buf_rx_u8;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
