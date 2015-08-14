From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Mediatek: fixup cpu_to_le32 incorrect usage" to the spi tree
Date: Fri, 14 Aug 2015 01:01:03 +0100
Message-ID: <E1ZQ2Qh-0003OT-S4@finisterre>
References: <1439467601-10209-1-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439467601-10209-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Mediatek: fixup cpu_to_le32 incorrect usage

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

>From 39ba928f8b34720b60c68d4c1bb274ae219ab39e Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 13 Aug 2015 20:06:41 +0800
Subject: [PATCH] spi: Mediatek: fixup cpu_to_le32 incorrect usage

writel() already does a cpu_to_le32 conversion, so
remove cpu_to_le32().

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 2c41dcf..62baaad 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -359,11 +359,9 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	if (mdata->tx_sgl)
-		writel((__force u32)cpu_to_le32(xfer->tx_dma),
-		       mdata->base + SPI_TX_SRC_REG);
+		writel(xfer->tx_dma, mdata->base + SPI_TX_SRC_REG);
 	if (mdata->rx_sgl)
-		writel((__force u32)cpu_to_le32(xfer->rx_dma),
-		       mdata->base + SPI_RX_DST_REG);
+		writel(xfer->rx_dma, mdata->base + SPI_RX_DST_REG);
 }
 
 static int mtk_spi_fifo_transfer(struct spi_master *master,
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
