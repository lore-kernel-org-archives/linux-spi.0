From: Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev: remove unused completion
Date: Fri,  5 May 2017 14:30:49 +0200
Message-ID: <20170505123049.7500-1-kirkseraph@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This removes an unused completion from spidev_sync.

It was introduced in

	commit 25d5cb4b0375e ("spi: remove some spidev oops-on-rmmod paths")

and it was no longer used after:

	commit 98d6f47958001 ("spi: spidev: use spi_sync instead of spi_async")

Signed-off-by: Seraphime Kirkovski (Haapie) <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099baf8c..b2abf89e61db 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -99,7 +99,6 @@ MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
 static ssize_t
 spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
 	struct spi_device *spi;
 
-- 
2.13.0.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
