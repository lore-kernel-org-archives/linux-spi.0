From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mtd: m25p80: add message if mmap flash read is supported
Date: Wed, 27 Apr 2016 22:36:48 +0200
Message-ID: <9111b023-d1e5-3084-4320-acf727e828f4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: MTD Mailing List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As a follow-up to commit 08922f644878c9 "mtd: devices: m25p80: add support for
mmap read request" add an info to syslog if mmap flash read is supported for a
device.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9d68544..433b100 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -233,6 +233,9 @@ static int m25p_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (spi_flash_read_supported(spi))
+		dev_info(&spi->dev, "memory-mapped flash read supported\n");
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
