From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/6] spi: imx: Nothing to do in setupxfer when transfer is NULL
Date: Fri,  2 Jun 2017 07:37:59 +0200
Message-ID: <20170602053804.3238-2-s.hauer@pengutronix.de>
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

When the spi_transfer given in spi_imx_setupxfer is NULL then
we have nothing to do. Bail out early in this case so that
we do not have to test for t != NULL multiple times later.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b402530a7a9a..4b5cd0c84450 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -217,9 +217,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (!master->dma_rx)
 		return false;
 
-	if (!transfer)
-		return false;
-
 	bpw = transfer->bits_per_word;
 	if (!bpw)
 		bpw = spi->bits_per_word;
@@ -895,8 +892,11 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	struct spi_imx_config config;
 	int ret;
 
-	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
-	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
+	if (!t)
+		return 0;
+
+	config.bpw = t->bits_per_word;
+	config.speed_hz  = t->speed_hz;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
