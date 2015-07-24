From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: support spi without dma channel to use can_dma()" to the spi tree
Date: Fri, 24 Jul 2015 18:49:44 +0100
Message-ID: <E1ZIh6O-0002zu-1C@debutante>
References: <1435583070-9600-2-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435583070-9600-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: support spi without dma channel to use can_dma()

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

>From c37f45b5f1cdfcdc351d88950b32658c970582ca Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 23 Jul 2015 17:10:40 +0800
Subject: [PATCH] spi: support spi without dma channel to use can_dma()

For spi without dma channel and use can_dma(), it can
use master->dev for struct device.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b23a76..f725085a5f07 100644
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
@@ -579,8 +586,15 @@ static int __spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
