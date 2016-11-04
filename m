From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: fsl-espi: remove unneeded call to
 fsl_espi_setup_transfer
Date: Fri, 4 Nov 2016 21:00:40 +0100
Message-ID: <0c0f1c29-c9b3-2b79-4982-bb07efe747e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Resetting the chip to a default transfer mode after each transfer
doesn't provide any benefit. Therefore remove this call.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8b3a287..1029bd2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -331,8 +331,6 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
 
-	fsl_espi_setup_transfer(spi, NULL);
-
 	if (!ret)
 		fsl_espi_copy_from_buf(m, mspi);
 
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
