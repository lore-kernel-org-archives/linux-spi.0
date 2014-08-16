From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Only call transfer_one() if we have buffers to transfer
Date: Sat, 16 Aug 2014 16:30:02 +0100
Message-ID: <1408203002-26403-1-git-send-email-broonie@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-gZy3mtb3KLqsTnJN9+BGXg@public.gmane.org,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Client drivers such as the ChomeOS EC driver sometimes use transfers with
no buffers and only a delay specified in order to allow a delay after the
assertion of /CS. Rather than require controller drivers handle this noop
case gracefully put checks in the core to ensure that we don't call into
the controller for such transfers.

Reported-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Completely untested at this point.

 drivers/spi/spi.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ca935df..95cfe3b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -789,27 +789,35 @@ static int spi_transfer_one_message(struct spi_master *master,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		trace_spi_transfer_start(msg, xfer);
 
-		reinit_completion(&master->xfer_completion);
-
-		ret = master->transfer_one(master, msg->spi, xfer);
-		if (ret < 0) {
-			dev_err(&msg->spi->dev,
-				"SPI transfer failed: %d\n", ret);
-			goto out;
-		}
+		if (xfer->tx_buf || xfer->rx_buf) {
+			reinit_completion(&master->xfer_completion);
+
+			ret = master->transfer_one(master, msg->spi, xfer);
+			if (ret < 0) {
+				dev_err(&msg->spi->dev,
+					"SPI transfer failed: %d\n", ret);
+				goto out;
+			}
 
-		if (ret > 0) {
-			ret = 0;
-			ms = xfer->len * 8 * 1000 / xfer->speed_hz;
-			ms += ms + 100; /* some tolerance */
+			if (ret > 0) {
+				ret = 0;
+				ms = xfer->len * 8 * 1000 / xfer->speed_hz;
+				ms += ms + 100; /* some tolerance */
 
-			ms = wait_for_completion_timeout(&master->xfer_completion,
-							 msecs_to_jiffies(ms));
-		}
+				ms = wait_for_completion_timeout(&master->xfer_completion,
+								 msecs_to_jiffies(ms));
+			}
 
-		if (ms == 0) {
-			dev_err(&msg->spi->dev, "SPI transfer timed out\n");
-			msg->status = -ETIMEDOUT;
+			if (ms == 0) {
+				dev_err(&msg->spi->dev,
+					"SPI transfer timed out\n");
+				msg->status = -ETIMEDOUT;
+			}
+		} else {
+			if (xfer->len)
+				dev_err(&msg->spi->dev,
+					"Bufferless transfer has length %u\n",
+					xfer->len);
 		}
 
 		trace_spi_transfer_stop(msg, xfer);
-- 
2.1.0.rc1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
