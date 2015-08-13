From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: Mediatek: fixup cpu_to_le32 incorrect usage
Date: Thu, 13 Aug 2015 20:06:41 +0800
Message-ID: <1439467601-10209-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

writel() already does a cpu_to_le32 conversion, so
remove cpu_to_le32().

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ae645fa..519f50c 100644
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
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
