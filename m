From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v1 1/7] mtd: spi-nor: fix the wrong dummy value
Date: Wed, 23 Apr 2014 18:16:49 +0800
Message-ID: <1398248215-26768-2-git-send-email-b32955@freescale.com>
References: <a>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For the DDR Quad read, the dummy cycles maybe 3 or 6 which is less then 8.
The dummy cycles is actually 8 for SPI fast/dual/quad read.

This patch makes preparations for the DDR quad read, it fixes the wrong dummy
value for both the spi-nor.c and m25p80.c.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c  |    5 ++++-
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 1557d8f..693e25f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -128,9 +128,12 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	struct spi_device *spi = flash->spi;
 	struct spi_transfer t[2];
 	struct spi_message m;
-	int dummy = nor->read_dummy;
+	unsigned int dummy = nor->read_dummy;
 	int ret;
 
+	/* convert the dummy cycles to the number of byte */
+	dummy /= 8;
+
 	/* Wait till previous write/erase is done. */
 	ret = nor->wait_till_ready(nor);
 	if (ret)
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f76f3fc..1a12f81 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -77,7 +77,7 @@ static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
 	case SPI_NOR_FAST:
 	case SPI_NOR_DUAL:
 	case SPI_NOR_QUAD:
-		return 1;
+		return 8;
 	case SPI_NOR_NORMAL:
 		return 0;
 	}
-- 
1.7.2.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
