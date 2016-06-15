From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: add spi_sync_single_transfer wrapper for single
 spi_transfer
Date: Thu, 16 Jun 2016 08:40:46 +0900
Message-ID: <1466034046-718-1-git-send-email-andi.shyti@samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi_sync_single_transfer function calls spi_sync_transfer
with a single spi_transfer element, instead of an array.

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/spi/spi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1f03483..660f6a1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1051,6 +1051,24 @@ spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
 	return spi_sync(spi, &msg);
 }
 
+/**
+ * spi_sync_single_transfer - synchronous SPI data transfer of one spi_transfer
+ * @spi: device with which data will be exchanged
+ * @xfers: One spi_transfer struct
+ * Context: can sleep
+ *
+ * Does a synchronous SPI data transfer of a given spi_transfer.
+ *
+ * For more specific semantics see spi_sync_transfer().
+ *
+ * It returns zero on success, else a negative error code.
+ */
+static inline int
+spi_sync_single_transfer(struct spi_device *spi, struct spi_transfer *xfers)
+{
+	return spi_sync_transfer(spi, xfers, 1);
+}
+
 /* this copies txbuf and rxbuf data; for small transfers only! */
 extern int spi_write_then_read(struct spi_device *spi,
 		const void *txbuf, unsigned n_tx,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
