From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: s3c64xx: fix potential segmentation fault
Date: Tue, 07 Feb 2017 17:10:24 +0900
Message-ID: <20170207081025.9671-1-andi.shyti@samsung.com>
References: <CGME20170207081032epcas5p30d99ec5cfc68b71cd46bd0218101c22b@epcas5p3.samsung.com>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The return value of dmaengine_prep_slave_sg is not checked, but
eventually it can fail and in that case return 'NULL' causing a
segmentation fault.

Check dmaengine_prep_slave_sg return value and exit in case of
failure. For doing this all the 'void' functions involved has
been turned to 'int'.

This patch fixes '1397997 Dereference null return value' from
scan.coverity.com

Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b392cca8fa4f..f6ea9ae047ec 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -276,7 +276,7 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
+static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 			struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
@@ -305,12 +305,16 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EINVAL;
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
 	dmaengine_submit(desc);
 	dma_async_issue_pending(dma->ch);
+
+	return 0;
 }
 
 static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
@@ -360,12 +364,13 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }
 
-static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
+static int enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
+	int ret;
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -391,7 +396,9 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			if (ret)
+				return ret;
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -423,12 +430,16 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			if (ret)
+				return ret;
 		}
 	}
 
 	writel(modecfg, regs + S3C64XX_SPI_MODE_CFG);
 	writel(chcfg, regs + S3C64XX_SPI_CH_CFG);
+
+	return 0;
 }
 
 static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
@@ -677,7 +688,9 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;
 
-	enable_datapath(sdd, spi, xfer, use_dma);
+	status = enable_datapath(sdd, spi, xfer, use_dma);
+	if (status)
+		return status;
 
 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
