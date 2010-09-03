From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/6] SPI: S3C64XX: Correction for 16,32 bits bus width
Date: Fri,  3 Sep 2010 10:36:54 +0900
Message-ID: <1283477814-31228-1-git-send-email-jassi.brar@samsung.com>
References: <1OrKX4-0007cO-1K>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1OrKX4-0007cO-1K>
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
same size.
Inorder to do that, define a new callback to be used
to do read/write of appropriate widths.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_s3c64xx.c |   78 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 39816bb..8aa9f85 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -174,12 +174,59 @@ struct s3c64xx_spi_driver_data {
 	unsigned                        state;
 	unsigned                        cur_mode, cur_bpw;
 	unsigned                        cur_speed;
+	void (*do_xfer)(void *ptr, void *fifo, unsigned sz, bool rd);
 };
 
 static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
 	.name = "samsung-spi-dma",
 };
 
+static void s3c64xx_spi_xfer8(void *ptr, void __iomem *fifo,
+		unsigned len, bool read)
+{
+	u8 *buf = (u8 *)ptr;
+	int i = 0;
+
+	if (read)
+		while (i < len)
+			buf[i++] = readb(fifo);
+	else
+		while (i < len)
+			writeb(buf[i++], fifo);
+}
+
+static void s3c64xx_spi_xfer16(void *ptr, void __iomem *fifo,
+		unsigned len, bool read)
+{
+	u16 *buf = (u16 *)ptr;
+	int i = 0;
+
+	len /= 2;
+
+	if (read)
+		while (i < len)
+			buf[i++] = readw(fifo);
+	else
+		while (i < len)
+			writew(buf[i++], fifo);
+}
+
+static void s3c64xx_spi_xfer32(void *ptr, void __iomem *fifo,
+		unsigned len, bool read)
+{
+	u32 *buf = (u32 *)ptr;
+	int i = 0;
+
+	len /= 4;
+
+	if (read)
+		while (i < len)
+			buf[i++] = readl(fifo);
+	else
+		while (i < len)
+			writel(buf[i++], fifo);
+}
+
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
@@ -260,10 +307,8 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 						xfer->tx_dma, xfer->len);
 			s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
 		} else {
-			unsigned char *buf = (unsigned char *) xfer->tx_buf;
-			int i = 0;
-			while (i < xfer->len)
-				writeb(buf[i++], regs + S3C64XX_SPI_TX_DATA);
+			sdd->do_xfer((void *)xfer->tx_buf,
+				regs + S3C64XX_SPI_TX_DATA, xfer->len, false);
 		}
 	}
 
@@ -360,20 +405,14 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
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
+		sdd->do_xfer(xfer->rx_buf,
+			regs + S3C64XX_SPI_RX_DATA, xfer->len, true);
 		sdd->state &= ~RXBUSY;
 	}
 
@@ -423,15 +462,20 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	switch (sdd->cur_bpw) {
 	case 32:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_WORD;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_WORD;
+		sdd->do_xfer = s3c64xx_spi_xfer32;
 		break;
 	case 16:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
+		sdd->do_xfer = s3c64xx_spi_xfer16;
 		break;
 	default:
 		val |= S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
+		val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE;
+		sdd->do_xfer = s3c64xx_spi_xfer8;
 		break;
 	}
-	val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE; /* Always 8bits wide */
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
@@ -610,6 +654,14 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
 		bpw = xfer->bits_per_word ? : spi->bits_per_word;
 		speed = xfer->speed_hz ? : spi->max_speed_hz;
 
+		if (bpw != 8 && xfer->len % (bpw / 8)) {
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
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
