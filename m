From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH v2] spi: spidev: only use up TX/RX bounce buffer space when needed
Date: Mon, 16 Feb 2015 15:00:47 +0000
Message-ID: <1424098847-14390-1-git-send-email-abbotti@mev.co.uk>
References: <1422643413-21796-1-git-send-email-abbotti@mev.co.uk>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422643413-21796-1-git-send-email-abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch changes the way space is reserved in spidev's pre-allocated
TX and RX bounce buffers to avoid wasting space in the buffers for an
SPI message consisting of multiple, half-duplex transfers in different
directions.

Background:

spidev data structures have separate, pre-allocated TX and RX bounce
buffers (`spidev->tx_buffer` and `spidev->rx_buffer`) of fixed size
(`bufsiz`).  The `SPI_IOC_MESSAGE(N)` ioctl processing uses a kernel
copy of the N `struct spi_ioc_transfer` elements copied from the
userspace ioctl arg pointer.  In these elements: `.len` is the length of
transfer in bytes; `.rx_buf` is either a userspace pointer to a buffer
to copy the RX data to or is set to 0 to discard the data; and `.tx_buf`
is either a userspace pointer to TX data supplied by the user or is set
to 0 to transmit zeros for this transfer.

`spidev_message()` uses the array of N `struct spi_ioc_transfer`
elements to construct a kernel SPI message consisting of a `struct
spi_message` containing a linked list (allocated as an array) of N
`struct spi_transfer` elements.  This involves iterating through the
`struct spi_ioc_transfer` and `struct spi_transfer` elements (variables
`u_tmp` and `k_tmp` respectively).  Before the first iteration,
variables `tx_buf` and `rx_buf` point to the start of the TX and RX
bounce buffers `spidev->tx_buffer` and `spidev->rx_buffer` and variable
`total` is set to 0.  These variables keep track of the next available
space in the bounce buffers and the total length of the SPI message.
Each iteration checks that there is enough room left in the buffers for
the transfer.  If `u_tmp->rx_buf` is non-zero, `k_tmp->rx_buf` is set to
`rx_buf`, otherwise it remains set to NULL.  If `u_tmp->tx_buf` is
non-zero, `k_tmp->tx_buf` is set to `tx_buf` and the userspace TX data
copied there, otherwise it remains set to NULL.  The variables `total`,
`rx_buf` and `tx_buf` are advanced by the length of the transfer.

The "problem":

While iterating through the transfers, the local bounce buffer "free
space" pointer variables `tx_buf` and `rx_buf` are always advanced by
the length of the transfer.  If `u_tmp->rx_buf` is 0 (so `k_tmp->rx_buf`
is NULL), then `rx_buf` is advanced unnecessarily and that part of
`spidev->rx_buffer` is wasted.  Similarly, if `u_tmp->tx_buf` is 0 (so
`k_tmp->tx_buf` is NULL), part of `spidev->tx_buffer` is wasted.

What this patch does:

To avoid wasting space unnecessarily in the RX bounce buffer, only
advance `rx_buf` by the transfer length if `u_tmp->rx_buf` is non-zero.
Similarly, to avoid wasting space unnecessarily in the TX bounce buffer,
only advance `tx_buf` if `u_tmp->tx_buf is non-zero.  To avoid pointer
subtraction, use new variables `rx_total` and `tx_total` to keep track
of the amount of space allocated in each of the bounce buffers.  If
these exceed the available space, a `-EMSGSIZE` error will be returned.

Limit the total length of the transfers (tracked by variable `total`) to
`INT_MAX` instead of `bufsiz`, returning an `-EMSGSIZE` error if
exceeded.  The total length is returned by `spidev_message()` on success
and we want that to be non-negative.  The message size limits for the
`SPI_IOC_MESSAGE(N)` ioctl are now as follows:

(a) total length of transfers is <= INTMAX;
(b) total length of transfers with non-NULL rx_buf is <= bufsiz;
(c) total length of transfers with non-NULL tx_buf is <= bufsiz.

Some transfers may have NULL rx_buf and NULL tx_buf.

If the transfer is completed successfully by the SPI core,
`spidev_message()` iterates through the transfers to copy any RX data
from the bounce buffer back to userspace on those transfers where
`u_tmp->rx_buf` is non-zero.  The variable `rx_buf` is again used to
keep track of the corresponding positions in the bounce buffer.  Now it
is only advanced for those transfers that use the RX bounce buffer.

Signed-off-by: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
---
v2: Add some comments.  Redo the commit message.
---
 drivers/spi/spidev.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d1ccbfe..2cb5c57 100644
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
 
@@ -243,33 +243,51 @@ static int spidev_message(struct spidev_data *spidev,
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
+		/* Since the function returns the total length of transfers
+		 * on success, restrict the total to positive int values to
+		 * avoid the return value looking like an error.
+		 */
+		if (total > INT_MAX) {
 			status = -EMSGSIZE;
 			goto done;
 		}
 
 		if (u_tmp->rx_buf) {
+			/* this transfer needs space in RX bounce buffer */
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
+			/* this transfer needs space in TX bounce buffer */
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
@@ -307,8 +325,8 @@ static int spidev_message(struct spidev_data *spidev,
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
