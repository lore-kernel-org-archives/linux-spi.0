From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3] mfd: cros ec: Lock the SPI bus while holding chipselect
Date: Wed, 25 Nov 2015 13:51:07 +0800
Message-ID: <1448430667-4213-1-git-send-email-drinkcat@chromium.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

cros_ec_cmd_xfer_spi and cros_ec_pkt_xfer_spi generally work like
this:
 - Pull CS down (active), wait a bit, then send a command
 - Wait for response (multiple requests)
 - Wait a while, pull CS up (inactive)

These operations, individually, lock the SPI bus, but there is
nothing preventing the SPI framework from interleaving messages
intended for other devices as the bus is unlocked in between.

This is a problem as the EC expects CS to be held low for the
whole duration.

Solution: Lock the SPI bus during the whole transaction, to make
sure that no other messages can be interleaved.

Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

v2: Move bus_unlock earlier in the functions.
v3: Remove comments.

Applies on top on linux-next/master (20151124)

 drivers/mfd/cros_ec_spi.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 6a0f6ec..d6af52d 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -113,7 +113,7 @@ static int terminate_request(struct cros_ec_device *ec_dev)
 	trans.delay_usecs = ec_spi->end_of_msg_delay;
 	spi_message_add_tail(&trans, &msg);
 
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Reset end-of-response timer */
 	ec_spi->last_transfer_ns = ktime_get_ns();
@@ -147,7 +147,7 @@ static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 	if (ret < 0)
 		dev_err(ec_dev->dev, "spi transfer failed: %d\n", ret);
 
@@ -391,10 +391,10 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	}
 
 	rx_buf = kzalloc(len, GFP_KERNEL);
-	if (!rx_buf) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!rx_buf)
+		return -ENOMEM;
+
+	spi_bus_lock(ec_spi->spi->master);
 
 	/*
 	 * Leave a gap between CS assertion and clocking of data to allow the
@@ -414,7 +414,7 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	trans.len = len;
 	trans.cs_change = 1;
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Get the response */
 	if (!ret) {
@@ -440,6 +440,9 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	}
 
 	final_ret = terminate_request(ec_dev);
+
+	spi_bus_unlock(ec_spi->spi->master);
+
 	if (!ret)
 		ret = final_ret;
 	if (ret < 0)
@@ -520,10 +523,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	}
 
 	rx_buf = kzalloc(len, GFP_KERNEL);
-	if (!rx_buf) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!rx_buf)
+		return -ENOMEM;
+
+	spi_bus_lock(ec_spi->spi->master);
 
 	/* Transmit phase - send our message */
 	debug_packet(ec_dev->dev, "out", ec_dev->dout, len);
@@ -534,7 +537,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	trans.cs_change = 1;
 	spi_message_init(&msg);
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Get the response */
 	if (!ret) {
@@ -560,6 +563,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	}
 
 	final_ret = terminate_request(ec_dev);
+
+	spi_bus_unlock(ec_spi->spi->master);
+
 	if (!ret)
 		ret = final_ret;
 	if (ret < 0)
-- 
2.6.0.rc2.230.g3dd15c0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
