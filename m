From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: use dma_mapping_error()" to the spi tree
Date: Thu, 12 Jan 2017 17:46:23 +0000
Message-ID: <E1cRjSB-0000C9-Ar@debutante>
References: <20170112021840.21105-1-khilman@baylibre.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        =?UTF-8?q?Bartosz=20Go=C5=82aszewski?= <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>,
        Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112021840.21105-1-khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: use dma_mapping_error()

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

>From c5a2a394835f473ae23931eda5066d3771d7b2f8 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Date: Wed, 11 Jan 2017 18:18:40 -0800
Subject: [PATCH] spi: davinci: use dma_mapping_error()

The correct error checking for dma_map_single() is to use
dma_mapping_error().

Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
