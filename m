From: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v1] spi: check tx_buf and rx_buf in spi_unmap_msg
Date: Thu, 16 Apr 2015 10:54:18 +0800
Message-ID: <1429152858-1141-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some spi device drivers use the same tx_buf and rx_buf repeatly for better
performance such as driver/input/touchsreen/ads7846.c, but spi core grab tx_buf
/rx_buf of transfer and set them as dummy_tx/dummy_rx once they are NULL. Thus,
in the second time the tx_buf/rx_buf will be replaced by dummy_tx/dummy_rx and
the data which produced by the last tx or rx may be wrongly sent to the device
or handled by the upper level protocol. This patch just keep the orignal value
of tx_buf/rx_buf if they are NULL after this transfer processed.

Signed-off-by: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d5d7d22..50910d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -583,6 +583,15 @@ static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	rx_dev = master->dma_rx->device->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/*
+		 * Restore the original value of tx_buf or rx_buf if they are
+		 * NULL.
+		 */
+		if (xfer->tx_buf == master->dummy_tx)
+			xfer->tx_buf = NULL;
+		if (xfer->rx_buf == master->dummy_rx)
+			xfer->rx_buf = NULL;
+
 		if (!master->can_dma(master, msg->spi, xfer))
 			continue;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
