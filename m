From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when needed
Date: Thu, 12 Feb 2015 12:13:08 +0000
Message-ID: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Devices have separate, pre-allocated TX and RX bounce buffers of fixed
size.  Currently, each transfer uses up space in both buffers even if
the user-supplied no TX data or no RX space.  Change it to only use up
space in the TX and RX bounce buffers as required.

Since dummy transfers with no user-supplied TX data and no user-supplied
RX space will no longer use up space in the bounce buffers, limit the
overall SPI message length to INT_MAX instead of the buffer size.

Signed-off-by: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
---
 drivers/spi/spidev.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d1ccbfe..75de351 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -227,7 +227,7 @@ static int spidev_message(struct spidev_data *spidev,
 	struct spi_transfer	*k_xfers;
 	struct spi_transfer	*k_tmp;
 	struct spi_ioc_transfer *u_tmp;
-	unsigned		n, total;
+	unsigned		n, total, tx_total, rx_total;
 	u8			*tx_buf, *rx_buf;
 	int			status = -EFAULT;
 
@@ -243,33 +243,45 @@ static int spidev_message(struct spidev_data *spidev,
 	tx_buf = spidev->tx_buffer;
 	rx_buf = spidev->rx_buffer;
 	total = 0;
+	tx_total = 0;
+	rx_total = 0;
 	for (n = n_xfers, k_tmp = k_xfers, u_tmp = u_xfers;
 			n;
 			n--, k_tmp++, u_tmp++) {
 		k_tmp->len = u_tmp->len;
 
 		total += k_tmp->len;
-		if (total > bufsiz) {
+		if (total > INT_MAX) {
 			status = -EMSGSIZE;
 			goto done;
 		}
 
 		if (u_tmp->rx_buf) {
+			rx_total += k_tmp->len;
+			if (rx_total > bufsiz) {
+				status = -EMSGSIZE;
+				goto done;
+			}
 			k_tmp->rx_buf = rx_buf;
 			if (!access_ok(VERIFY_WRITE, (u8 __user *)
 						(uintptr_t) u_tmp->rx_buf,
 						u_tmp->len))
 				goto done;
+			rx_buf += k_tmp->len;
 		}
 		if (u_tmp->tx_buf) {
+			tx_total += k_tmp->len;
+			if (tx_total > bufsiz) {
+				status = -EMSGSIZE;
+				goto done;
+			}
 			k_tmp->tx_buf = tx_buf;
 			if (copy_from_user(tx_buf, (const u8 __user *)
 						(uintptr_t) u_tmp->tx_buf,
 					u_tmp->len))
 				goto done;
+			tx_buf += k_tmp->len;
 		}
-		tx_buf += k_tmp->len;
-		rx_buf += k_tmp->len;
 
 		k_tmp->cs_change = !!u_tmp->cs_change;
 		k_tmp->tx_nbits = u_tmp->tx_nbits;
@@ -307,8 +319,8 @@ static int spidev_message(struct spidev_data *spidev,
 				status = -EFAULT;
 				goto done;
 			}
+			rx_buf += u_tmp->len;
 		}
-		rx_buf += u_tmp->len;
 	}
 	status = total;
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
