From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: davinci: use dma_mapping_error()
Date: Wed, 11 Jan 2017 18:18:40 -0800
Message-ID: <20170112021840.21105-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        =?UTF-8?q?Bartosz=20Go=C5=82aszewski?= <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>,
        Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The correct error checking for dma_map_single() is to use
dma_mapping_error().

Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
Applies to v4.10-rc3

 drivers/spi/spi-davinci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d36c11b73a35..02fb96797ac8 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -646,7 +646,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			buf = t->rx_buf;
 		t->rx_dma = dma_map_single(&spi->dev, buf,
 				t->len, DMA_FROM_DEVICE);
-		if (!t->rx_dma) {
+		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
 			ret = -EFAULT;
 			goto err_rx_map;
 		}
@@ -660,7 +660,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			buf = (void *)t->tx_buf;
 		t->tx_dma = dma_map_single(&spi->dev, buf,
 				t->len, DMA_TO_DEVICE);
-		if (!t->tx_dma) {
+		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
 			ret = -EFAULT;
 			goto err_tx_map;
 		}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
