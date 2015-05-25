From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 3/4] spi: add flags SPI_MASTER_MUST_*_SG to api
Date: Mon, 25 May 2015 12:44:25 +0000
Message-ID: <1432557867-2427-4-git-send-email-kernel@martin.sperl.org>
References: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
 <1432557867-2427-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432557867-2427-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This avoid unnecessary mapping of null pages in sg_lists for masters
that do not need a sg_list when rx_buf/tx_buff == NULL avoid.

Only spi-masters that require a mapped scatter-gather map need to set
this, but they would not need to set SPI_MASTER_MUST_RX/TX.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |   38 +++++++++++++++++++-------------------
 include/linux/spi/spi.h |    2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

Note that this is an optional patch to avoid the overhead
for spi_masters that do not need the dummy-page functionality.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7e1a12c..9205928 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -570,25 +570,25 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		if (!master->can_dma(master, msg->spi, xfer))
 			continue;
 
-		/* potentially add a flag to spi_master
-		 * (SPI_MASTER_MUST_TX_SG) to avoid unnecessary mapping
-		 */
-		ret = spi_map_buf(master, tx_dev, &xfer->tx_sg,
-				  (void *)xfer->tx_buf, xfer->len,
-				  DMA_TO_DEVICE);
-		if (ret != 0)
-			return ret;
-
-		/* potentially add a flag to spi_master
-		 * (SPI_MASTER_MUST_RX_SG) to avoid unnecessary mapping
-		 */
-		ret = spi_map_buf(master, rx_dev, &xfer->rx_sg,
-				  xfer->rx_buf, xfer->len,
-				  DMA_FROM_DEVICE);
-		if (ret != 0) {
-			spi_unmap_buf(master, tx_dev, &xfer->tx_sg,
-				      DMA_TO_DEVICE);
-			return ret;
+		if (xfer->tx_buf ||
+		    (master->flags & SPI_MASTER_MUST_TX_SG)) {
+			ret = spi_map_buf(master, tx_dev, &xfer->tx_sg,
+					  (void *)xfer->tx_buf, xfer->len,
+					  DMA_TO_DEVICE);
+			if (ret != 0)
+				return ret;
+		}
+
+		if (xfer->rx_buf ||
+		    (master->flags & SPI_MASTER_MUST_RX_SG)) {
+			ret = spi_map_buf(master, rx_dev, &xfer->rx_sg,
+					  xfer->rx_buf, xfer->len,
+					  DMA_FROM_DEVICE);
+			if (ret != 0) {
+				spi_unmap_buf(master, tx_dev, &xfer->tx_sg,
+					      DMA_TO_DEVICE);
+				return ret;
+			}
 		}
 	}
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9ffa506..8b70419 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -357,6 +357,8 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_MASTER_MUST_RX_SG   BIT(5)		/* requires rx sg_list */
+#define SPI_MASTER_MUST_TX_SG   BIT(6)		/* requires tx sg_list */
 
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
