From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: restore rx/tx_buf in case of unset CONFIG_HAS_DMA
Date: Mon, 25 May 2015 10:13:10 +0000
Message-ID: <1432548790-2249-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The case where spi_master sets the flags SPI_MASTER_MUST_RX/TX while
CONFIG_HAS_DMA is unset (which is unlikley) together with a driver
that reuses spi_messages with rx/tx_buff set to NULL, can result in:
* data disclosure over the SPI (for tx_buf == NULL)
* memory corruption (for rx_buf == NULL)

This happenes when dummy_rx/dummy_tx are changing address due to krealloc
or free and an allocation of the memory by a different part of the kernel.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 647a8bb..01e92f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -571,7 +571,7 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
-static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
+static int __spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
 	struct device *tx_dev, *rx_dev;
@@ -583,15 +583,6 @@ static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	rx_dev = master->dma_rx->device->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		/*
-		 * Restore the original value of tx_buf or rx_buf if they are
-		 * NULL.
-		 */
-		if (xfer->tx_buf == master->dummy_tx)
-			xfer->tx_buf = NULL;
-		if (xfer->rx_buf == master->dummy_rx)
-			xfer->rx_buf = NULL;
-
 		if (!master->can_dma(master, msg->spi, xfer))
 			continue;
 
@@ -608,13 +599,32 @@ static inline int __spi_map_msg(struct spi_master *master,
 	return 0;
 }
 
-static inline int spi_unmap_msg(struct spi_master *master,
-				struct spi_message *msg)
+static inline int __spi_unmap_msg(struct spi_master *master,
+				  struct spi_message *msg)
 {
 	return 0;
 }
 #endif /* !CONFIG_HAS_DMA */
 
+static inline int spi_unmap_msg(struct spi_master *master,
+				struct spi_message *msg)
+{
+	struct spi_transfer *xfer;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/*
+		 * Restore the original value of tx_buf or rx_buf if they are
+		 * NULL.
+		 */
+		if (xfer->tx_buf == master->dummy_tx)
+			xfer->tx_buf = NULL;
+		if (xfer->rx_buf == master->dummy_rx)
+			xfer->rx_buf = NULL;
+	}
+
+	return __spi_unmap_msg(master, msg);
+}
+
 static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
