From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/4] spi: support spi without dma channel to use can_dma()
Date: Mon, 29 Jun 2015 21:04:27 +0800
Message-ID: <1435583070-9600-2-git-send-email-leilk.liu@mediatek.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435583070-9600-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For spi without dma channel and use can_dma(), it can
use master->dev for struct device.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d5d7d22..cfd76e9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -539,8 +539,15 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 	if (!master->can_dma)
 		return 0;
 
-	tx_dev = master->dma_tx->device->dev;
-	rx_dev = master->dma_rx->device->dev;
+	if (master->dma_tx)
+		tx_dev = master->dma_tx->device->dev;
+	else
+		tx_dev = &master->dev;
+
+	if (master->dma_rx)
+		rx_dev = master->dma_rx->device->dev;
+	else
+		rx_dev = &master->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
@@ -579,8 +586,15 @@ static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	if (!master->cur_msg_mapped || !master->can_dma)
 		return 0;
 
-	tx_dev = master->dma_tx->device->dev;
-	rx_dev = master->dma_rx->device->dev;
+	if (master->dma_tx)
+		tx_dev = master->dma_tx->device->dev;
+	else
+		tx_dev = &master->dev;
+
+	if (master->dma_rx)
+		rx_dev = master->dma_rx->device->dev;
+	else
+		rx_dev = &master->dev;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!master->can_dma(master, msg->spi, xfer))
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
