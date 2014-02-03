From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: bfin5xx: Remove duplicate code to check spi->mode
Date: Mon, 03 Feb 2014 10:51:30 +0800
Message-ID: <1391395890.4629.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This checking is already done in the implementation of spi_setup().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bfin5xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index f0f195a..c6902d2 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -1030,10 +1030,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	}
 
 	/* translate common spi framework into our register */
-	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST)) {
-		dev_err(&spi->dev, "unsupported spi modes detected\n");
-		goto error;
-	}
 	if (spi->mode & SPI_CPOL)
 		chip->ctl_reg |= BIT_CTL_CPOL;
 	if (spi->mode & SPI_CPHA)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
