From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Add a timeout when waiting for transfers
Date: Thu, 30 Jan 2014 22:38:56 +0000
Message-ID: <1391121536-10937-1-git-send-email-broonie@kernel.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Don't wait indefinitely for transfers to complete but time out after 10ms
more than we expect the transfer to take on the wire.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7f23cf9afa79..1826a50c2aaf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -710,6 +710,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 	bool cur_cs = true;
 	bool keep_cs = false;
 	int ret = 0;
+	int ms = 1;
 
 	spi_set_cs(msg->spi, true);
 
@@ -727,7 +728,16 @@ static int spi_transfer_one_message(struct spi_master *master,
 
 		if (ret > 0) {
 			ret = 0;
-			wait_for_completion(&master->xfer_completion);
+			ms = xfer->len * 8 * 1000 / xfer->speed_hz;
+			ms += 10; /* some tolerance */
+
+			ms = wait_for_completion_timeout(&master->xfer_completion,
+							 msecs_to_jiffies(ms));
+		}
+
+		if (ms == 0) {
+			dev_err(&msg->spi->dev, "SPI transfer timed out\n");
+			msg->status = -ETIMEDOUT;
 		}
 
 		trace_spi_transfer_stop(msg, xfer);
-- 
1.9.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
