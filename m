From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/23] spi: fsl-espi: improve return value handling in
 fsl_espi_bufs
Date: Thu, 25 Aug 2016 06:49:10 +0200
Message-ID: <d8aa466c-1366-8aa0-5cf6-d0be7dbafa3a@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Return a proper status code from fsl_espi_bufs instead of returning
the number of remaining words and let the caller evaluate it.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 4c64012..821ec3e 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -259,7 +259,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	/* disable rx ints */
 	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
 
-	return mpc8xxx_spi->count;
+	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
 }
 
 static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
@@ -289,9 +289,6 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 	if (trans->len)
 		ret = fsl_espi_bufs(spi, trans);
 
-	if (ret)
-		ret = -EMSGSIZE;
-
 	if (trans->delay_usecs)
 		udelay(trans->delay_usecs);
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
