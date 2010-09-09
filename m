From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/6] SPI: S3C64XX: Correction for 16,32 bits bus width
Date: Fri, 10 Sep 2010 08:55:49 +0900
Message-ID: <1284076549-17715-1-git-send-email-jassi.brar@samsung.com>
References: <20100909160051.GA6273@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100909160051.GA6273-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We can't do without setting channel and bus width to
same size. Inorder to do that, use loop read/writes in
polling mode and appropriate burst size in DMA mode.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |   56 +++++++++++++++++++++++++++++++++------------
 1 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 39816bb..cf45e01 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -255,15 +255,25 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			s3c2410_dma_config(sdd->tx_dmach, 1);
+			s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
 			s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
 						xfer->tx_dma, xfer->len);
 			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
 		} else {
-			unsigned char *buf = (unsigned char *) xfer->tx_buf;
-			int i = 0;
-			while (i < xfer->len)
-				writeb(buf[i++], regs + S3C64XX_SPI_TX_DATA);
+			switch (sdd->cur_bpw) {
+			case 32:
+				iowrite32_rep(regs + S3C64XX_SPI_TX_DATA,
+					xfer->tx_buf, xfer->len / 4);
+				break;
+			case 16:
+				iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
+					xfer->tx_buf, xfer->len / 2);
+				break;
+			default:
+				iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
+					xfer->tx_buf, xfer->len);
+				break;
+			}
 		}
 	}
 
@@ -280,7 +290,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			s3c2410_dma_config(sdd->rx_dmach, 1);
+			s3c2410_dma_config(sdd->rx_dmach, sdd->cur_bpw / 8);
 			s3c2410_dma_enqueue(sdd->rx_dmach, (void *)sdd,
 						xfer->rx_dma, xfer->len);
 			s3c2410_dma_ctrl(sdd->rx_dmach, S3C2410_DMAOP_START);
@@ -360,20 +370,26 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 				return -EIO;
 		}
 	} else {
-		unsigned char *buf;
-		int i;
-
 		/* If it was only Tx */
 		if (xfer->rx_buf == NULL) {
 			sdd->state &= ~TXBUSY;
 			return 0;
 		}
 
-		i = 0;
-		buf = xfer->rx_buf;
-		while (i < xfer->len)
-			buf[i++] = readb(regs + S3C64XX_SPI_RX_DATA);
-
+		switch (sdd->cur_bpw) {
+		case 32:
+			ioread32_rep(regs + S3C64XX_SPI_RX_DATA,
+				xfer->rx_buf, xfer->len / 4);
+			break;
+		case 16:
+			ioread16_rep(regs + S3C64XX_SPI_RX_DATA,
+				xfer->rx_buf, xfer->len / 2);
+			break;
+		default:
+			ioread8_rep(regs + S3C64XX_SPI_RX_DATA,
+				xfer->rx_buf, xfer->len);
+			break;
+		}
 		sdd->state &= ~RXBUSY;
 	}
 
@@ -423,15 +439,17 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	switch (sdd->cur_bpw) {
 	case 32:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_WORD;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_WORD;
 		break;
 	case 16:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
 		break;
 	default:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE;
 		break;
 	}
-	val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE; /* Always 8bits wide */
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
@@ -610,6 +628,14 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 		bpw = xfer->bits_per_word ? : spi->bits_per_word;
 		speed = xfer->speed_hz ? : spi->max_speed_hz;
 
+		if (xfer->len % (bpw / 8)) {
+			dev_err(&spi->dev,
+				"Xfer length(%u) not a multiple of word size(%u)\n",
+				xfer->len, bpw / 8);
+			status = -EIO;
+			goto out;
+		}
+
 		if (bpw != sdd->cur_bpw || speed != sdd->cur_speed) {
 			sdd->cur_bpw = bpw;
 			sdd->cur_speed = speed;
-- 
1.6.2.5


------------------------------------------------------------------------------
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, 
automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. 
http://p.sf.net/sfu/dell-sfdev2dev
