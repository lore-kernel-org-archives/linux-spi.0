From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6, 5/8] mtd: m25p80: Let m25p80_read() fallback to spi transfer
Date: Wed, 24 Aug 2016 18:04:26 -0400
Message-ID: <1472076269-4731-6-git-send-email-kdasu.kdev@gmail.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472076269-4731-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In m25p80_read() even though spi_flash_read() is supported
by some drivers, under certain circumstances like unaligned
buffer, address or address range limitations on certain SoCs
let it fallback to core spi reads. Such drivers are expected
to return -EAGAIN so that the m25p80_read() uses standard
spi transfer.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9cf7fcd..77c2d2c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -155,9 +155,16 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 		msg.data_nbits = m25p80_rx_nbits(nor);
 
 		ret = spi_flash_read(spi, &msg);
-		if (ret < 0)
+
+		if (ret >= 0)
+			return msg.retlen;
+
+		/*
+		 * some spi master drivers might need to fallback to
+		 * normal spi transfer
+		 */
+		if (ret != -EAGAIN)
 			return ret;
-		return msg.retlen;
 	}
 
 	spi_message_init(&m);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
