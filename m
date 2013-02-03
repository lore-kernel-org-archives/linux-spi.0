From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH V2 1/2] spi/bcm63xx: reject transfers unable to transfer
Date: Sun,  3 Feb 2013 15:15:12 +0100
Message-ID: <1359900913-4472-2-git-send-email-jogo@openwrt.org>
References: <1359900913-4472-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359900913-4472-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The hardware does not support keeping CS asserted after sending one
FIFO buffer worth of data, so reject transfers requiring CS being kept
asserted, either between transers or for a certain time after it,
or exceeding the FIFO size.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   91 +++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index f44ab55..27667c1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -49,16 +49,10 @@ struct bcm63xx_spi {
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
 
-	/* Data buffers */
-	const unsigned char	*tx_ptr;
-	unsigned char		*rx_ptr;
-
 	/* data iomem */
 	u8 __iomem		*tx_io;
 	const u8 __iomem	*rx_io;
 
-	int			remaining_bytes;
-
 	struct clk		*clk;
 	struct platform_device	*pdev;
 };
@@ -175,24 +169,13 @@ static int bcm63xx_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-/* Fill the TX FIFO with as many bytes as possible */
-static void bcm63xx_spi_fill_tx_fifo(struct bcm63xx_spi *bs)
-{
-	u8 size;
-
-	/* Fill the Tx FIFO with as many bytes as possible */
-	size = bs->remaining_bytes < bs->fifo_size ? bs->remaining_bytes :
-		bs->fifo_size;
-	memcpy_toio(bs->tx_io, bs->tx_ptr, size);
-	bs->remaining_bytes -= size;
-}
-
-static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
-					struct spi_transfer *t)
+static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 	u16 msg_ctl;
 	u16 cmd;
+	u8 rx_tail;
+	unsigned int timeout = 0;
 
 	/* Disable the CMD_DONE interrupt */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
@@ -200,14 +183,8 @@ static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
 	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
 		t->tx_buf, t->rx_buf, t->len);
 
-	/* Transmitter is inhibited */
-	bs->tx_ptr = t->tx_buf;
-	bs->rx_ptr = t->rx_buf;
-
-	if (t->tx_buf) {
-		bs->remaining_bytes = t->len;
-		bcm63xx_spi_fill_tx_fifo(bs);
-	}
+	if (t->tx_buf)
+		memcpy_toio(bs->tx_io, t->tx_buf, t->len);
 
 	init_completion(&bs->done);
 
@@ -239,7 +216,18 @@ static unsigned int bcm63xx_txrx_bufs(struct spi_device *spi,
 	/* Enable the CMD_DONE interrupt */
 	bcm_spi_writeb(bs, SPI_INTR_CMD_DONE, SPI_INT_MASK);
 
-	return t->len - bs->remaining_bytes;
+	timeout = wait_for_completion_timeout(&bs->done, HZ);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	/* read out all data */
+	rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
+
+	/* Read out all the data */
+	if (rx_tail)
+		memcpy_fromio(t->rx_ptr, bs->rx_io, rx_tail);
+
+	return 0;
 }
 
 static int bcm63xx_spi_prepare_transfer(struct spi_master *master)
@@ -267,36 +255,41 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 	struct spi_transfer *t;
 	struct spi_device *spi = m->spi;
 	int status = 0;
-	unsigned int timeout = 0;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		unsigned int len = t->len;
-		u8 rx_tail;
-
 		status = bcm63xx_spi_check_transfer(spi, t);
 		if (status < 0)
 			goto exit;
 
-		/* configure adapter for a new transfer */
-		bcm63xx_spi_setup_transfer(spi, t);
+		/* we can only transfer one fifo worth of data */
+		if (t->len > bs->fifo_size) {
+			dev_err(&spi->dev, "unable to do transfers larger than FIFO size (%i > %i)\n",
+				t->len, bs->fifo_size);
+			status = -EINVAL;
+			goto exit;
+		}
 
-		while (len) {
-			/* send the data */
-			len -= bcm63xx_txrx_bufs(spi, t);
+		/* CS will be deasserted directly after transfer */
+		if (t->delay_usecs) {
+			dev_err(&spi->dev, "unable to keep CS asserted after transfer\n");
+			status = -EINVAL;
+			goto exit;
+		}
 
-			timeout = wait_for_completion_timeout(&bs->done, HZ);
-			if (!timeout) {
-				status = -ETIMEDOUT;
-				goto exit;
-			}
+		if (!t->cs_change &&
+		    !list_is_last(&t->transfer_list, &m->transfers)) {
+			dev_err(&spi->dev, "unable to keep CS asserted between transfers\n");
+			status = -EINVAL;
+			goto exit;
+		}
 
-			/* read out all data */
-			rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
+		/* configure adapter for a new transfer */
+		bcm63xx_spi_setup_transfer(spi, t);
 
-			/* Read out all the data */
-			if (rx_tail)
-				memcpy_fromio(bs->rx_ptr, bs->rx_io, rx_tail);
-		}
+		/* send the data */
+		status = bcm63xx_txrx_bufs(spi, t);
+		if (status)
+			goto exit;
 
 		m->actual_length += t->len;
 	}
-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
