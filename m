From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: fix endian warnings" to the spi tree
Date: Tue, 11 Aug 2015 17:28:08 +0100
Message-ID: <E1ZPCPI-0005IW-Dk@finisterre>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439289789-29026-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: fix endian warnings

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

>From 7abc01b346e67534cc0307544e563e5497280296 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Tue, 11 Aug 2015 18:43:09 +0800
Subject: [PATCH] spi: mediatek: fix endian warnings

This patch fixes endian warnings detected by sparse:
- sparse: incorrect type in argument 1 (different base types)
	  expected unsigned int [unsigned] val
	  got restricted __le32 [usertype] <noident>
- sparse: incorrect type in argument 1 (different base types)
	  expected unsigned int [unsigned] val
	  got restricted __le32 [usertype] <noident>

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 08da77e..2c41dcf 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	if (mdata->tx_sgl)
-		writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
+		writel((__force u32)cpu_to_le32(xfer->tx_dma),
+		       mdata->base + SPI_TX_SRC_REG);
 	if (mdata->rx_sgl)
-		writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
+		writel((__force u32)cpu_to_le32(xfer->rx_dma),
+		       mdata->base + SPI_RX_DST_REG);
 }
 
 static int mtk_spi_fifo_transfer(struct spi_master *master,
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
