From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2] mfd: cros ec: Lock the SPI bus while holding chipselect
Date: Mon,  9 Nov 2015 12:25:50 +0800
Message-ID: <1447043150-4806-1-git-send-email-drinkcat@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Olof Johansson <olof@lixom.net>, dianders@chromium.org,
	rspangler@chromium.org, gwendal@chromium.org,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

v2: Move bus_unlock earlier in the functions.

Applies on top on linux-next/master (20151109)

 drivers/mfd/cros_ec_spi.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 6a0f6ec..d538284 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -97,6 +97,11 @@ static void debug_packet(struct device *dev, const char *name, u8 *ptr,
 #endif
 }
 
+/**
+ * terminate_request - turn off CS
+ *
+ * Requires spi bus to be locked.
+ */
 static int terminate_request(struct cros_ec_device *ec_dev)
 {
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
@@ -113,7 +118,7 @@ static int terminate_request(struct cros_ec_device *ec_dev)
 	trans.delay_usecs = ec_spi->end_of_msg_delay;
 	spi_message_add_tail(&trans, &msg);
 
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Reset end-of-response timer */
 	ec_spi->last_transfer_ns = ktime_get_ns();
@@ -130,6 +135,8 @@ static int terminate_request(struct cros_ec_device *ec_dev)
  * receive_n_bytes - receive n bytes from the EC.
  *
  * Assumes buf is a pointer into the ec_dev->din buffer
+ *
+ * Requires spi bus to be locked.
  */
 static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
 {
@@ -147,7 +154,7 @@ static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 	if (ret < 0)
 		dev_err(ec_dev->dev, "spi transfer failed: %d\n", ret);
 
@@ -163,6 +170,8 @@ static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
  *
  * The received data is placed into ec_dev->din.
  *
+ * Requires spi bus to be locked.
+ *
  * @ec_dev: ChromeOS EC device
  * @need_len: Number of message bytes we need to read
  */
@@ -272,6 +281,8 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
  *
  * The received data is placed into ec_dev->din.
  *
+ * Requires spi bus to be locked.
+ *
  * @ec_dev: ChromeOS EC device
  * @need_len: Number of message bytes we need to read
  */
@@ -391,10 +402,10 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
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
@@ -414,7 +425,7 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	trans.len = len;
 	trans.cs_change = 1;
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Get the response */
 	if (!ret) {
@@ -440,6 +451,9 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	}
 
 	final_ret = terminate_request(ec_dev);
+
+	spi_bus_unlock(ec_spi->spi->master);
+
 	if (!ret)
 		ret = final_ret;
 	if (ret < 0)
@@ -520,10 +534,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
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
@@ -534,7 +548,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	trans.cs_change = 1;
 	spi_message_init(&msg);
 	spi_message_add_tail(&trans, &msg);
-	ret = spi_sync(ec_spi->spi, &msg);
+	ret = spi_sync_locked(ec_spi->spi, &msg);
 
 	/* Get the response */
 	if (!ret) {
@@ -560,6 +574,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
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
