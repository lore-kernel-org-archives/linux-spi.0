From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, V4, 5/5] mtd: m25p80: Let m25p80_read() fallback to spi transfer
Date: Fri, 17 Jun 2016 17:03:53 -0400
Message-ID: <1466197433-11290-5-git-send-email-kdasu.kdev@gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466197433-11290-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
 drivers/mtd/devices/m25p80.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9d68544..3f90542 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -149,8 +149,11 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 		msg.data_nbits = m25p80_rx_nbits(nor);
 
 		ret = spi_flash_read(spi, &msg);
-		*retlen = msg.retlen;
-		return ret;
+		/* some drivers might need to fallback to spi transfer */
+		if (ret != -EAGAIN) {
+			*retlen = msg.retlen;
+			return ret;
+		}
 	}
 
 	spi_message_init(&m);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
