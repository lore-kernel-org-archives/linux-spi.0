From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: Use spi_sync_transfer() in spi_write()/spi_read()" to the spi tree
Date: Fri, 16 Sep 2016 18:40:53 +0100
Message-ID: <E1bkx89-0004Dz-DC@debutante>
References: <1473773905-15451-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473773905-15451-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: Use spi_sync_transfer() in spi_write()/spi_read()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 323117ab60156d5ef021eeef260c4e7e0a7f520e Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Tue, 13 Sep 2016 15:38:25 +0200
Subject: [PATCH] spi: core: Use spi_sync_transfer() in spi_write()/spi_read()

Simplify spi_write() and spi_read() using the spi_sync_transfer()
helper.

This requires moving spi_sync_transfer() up.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 58 ++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 072cb2aa2413..74278c7d0f52 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -980,6 +980,30 @@ extern int spi_bus_lock(struct spi_master *master);
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
@@ -998,11 +1022,8 @@ spi_write(struct spi_device *spi, const void *buf, size_t len)
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
@@ -1024,35 +1045,8 @@ spi_read(struct spi_device *spi, void *buf, size_t len)
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
