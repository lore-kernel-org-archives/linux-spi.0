From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] mtd: m25p80: Revive dual read support
Date: Tue, 22 Apr 2014 14:45:31 +0200
Message-ID: <1398170732-19773-1-git-send-email-geert+renesas@glider.be>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI
nor framework") accidentally removed support for Dual SPI read transfers.
Add it back.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 1557d8f672c1..ed7e0a1bed3c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -221,6 +221,8 @@ static int m25p_probe(struct spi_device *spi)
 
 	if (spi->mode & SPI_RX_QUAD)
 		mode = SPI_NOR_QUAD;
+	else if (spi->mode & SPI_RX_DUAL)
+		mode = SPI_NOR_DUAL;
 	ret = spi_nor_scan(nor, spi_get_device_id(spi), mode);
 	if (ret)
 		return ret;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
