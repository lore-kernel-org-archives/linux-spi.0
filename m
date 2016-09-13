From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: core: Use spi_sync_transfer() in spi_write()/spi_read()
Date: Tue, 13 Sep 2016 15:38:25 +0200
Message-ID: <1473773905-15451-1-git-send-email-geert+renesas@glider.be>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify spi_write() and spi_read() using the spi_sync_transfer()
helper.

This requires moving spi_sync_transfer() up.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 include/linux/spi/spi.h | 58 ++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index de8ae3d92e94c440..3d498110d3e68f5e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1010,6 +1010,30 @@ extern int spi_bus_lock(struct spi_master *master);
 extern int spi_bus_unlock(struct spi_master *master);
 
 /**
+ * spi_sync_transfer - synchronous SPI data transfer
+ * @spi: device with which data will be exchanged
+ * @xfers: An array of spi_transfers
+ * @num_xfers: Number of items in the xfer array
+ * Context: can sleep
+ *
+ * Does a synchronous SPI data transfer of the given spi_transfer array.
+ *
+ * For more specific semantics see spi_sync().
+ *
+ * Return: Return: zero on success, else a negative error code.
+ */
+static inline int
+spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
+	unsigned int num_xfers)
+{
+	struct spi_message msg;
+
+	spi_message_init_with_transfers(&msg, xfers, num_xfers);
+
+	return spi_sync(spi, &msg);
+}
+
+/**
  * spi_write - SPI synchronous write
  * @spi: device to which data will be written
  * @buf: data buffer
@@ -1028,11 +1052,8 @@ spi_write(struct spi_device *spi, const void *buf, size_t len)
 			.tx_buf		= buf,
 			.len		= len,
 		};
-	struct spi_message	m;
 
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-	return spi_sync(spi, &m);
+	return spi_sync_transfer(spi, &t, 1);
 }
 
 /**
@@ -1054,35 +1075,8 @@ spi_read(struct spi_device *spi, void *buf, size_t len)
 			.rx_buf		= buf,
 			.len		= len,
 		};
-	struct spi_message	m;
 
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-	return spi_sync(spi, &m);
-}
-
-/**
- * spi_sync_transfer - synchronous SPI data transfer
- * @spi: device with which data will be exchanged
- * @xfers: An array of spi_transfers
- * @num_xfers: Number of items in the xfer array
- * Context: can sleep
- *
- * Does a synchronous SPI data transfer of the given spi_transfer array.
- *
- * For more specific semantics see spi_sync().
- *
- * Return: Return: zero on success, else a negative error code.
- */
-static inline int
-spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
-	unsigned int num_xfers)
-{
-	struct spi_message msg;
-
-	spi_message_init_with_transfers(&msg, xfers, num_xfers);
-
-	return spi_sync(spi, &msg);
+	return spi_sync_transfer(spi, &t, 1);
 }
 
 /* this copies txbuf and rxbuf data; for small transfers only! */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
