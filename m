From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 39/49] spi: davinci: handle DMA completion errors correctly
Date: Wed, 17 Nov 2010 16:14:11 +0530
Message-ID: <1289990661-30126-40-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-39-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Do not simply clean the DMA channel on a DMA completion
error. Instead, use wcount and rcount members of davinci_spi
to detecion non-completion of DMA and signal EIO to the
application.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   63 +++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 975c2a2..a47947d 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -388,24 +388,26 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 {
-	struct davinci_spi_dma *davinci_spi_dma = data;
+	struct davinci_spi *davinci_spi = data;
+	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+
+	edma_stop(davinci_spi_dma->dma_rx_channel);
 
 	if (ch_status == DMA_COMPLETE)
-		edma_stop(davinci_spi_dma->dma_rx_channel);
-	else
-		edma_clean_channel(davinci_spi_dma->dma_rx_channel);
+		davinci_spi->rcount = 0;
 
 	complete(&davinci_spi_dma->dma_rx_completion);
 }
 
 static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 {
-	struct davinci_spi_dma *davinci_spi_dma = data;
+	struct davinci_spi *davinci_spi = data;
+	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+
+	edma_stop(davinci_spi_dma->dma_tx_channel);
 
 	if (ch_status == DMA_COMPLETE)
-		edma_stop(davinci_spi_dma->dma_tx_channel);
-	else
-		edma_clean_channel(davinci_spi_dma->dma_tx_channel);
+		davinci_spi->wcount = 0;
 
 	complete(&davinci_spi_dma->dma_tx_completion);
 }
@@ -632,7 +634,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
 	int int_status = 0;
-	int count;
 	unsigned rx_buf_count;
 	struct davinci_spi_dma *davinci_spi_dma;
 	int data_type, ret;
@@ -648,20 +649,20 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 
 	davinci_spi_dma = &davinci_spi->dma_channels;
 
+	/* convert len to words based on bits_per_word */
+	data_type = davinci_spi->bytes_per_word[spi->chip_select];
+
 	tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
 	rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
-
-	/* convert len to words based on bits_per_word */
-	data_type = davinci_spi->bytes_per_word[spi->chip_select];
+	davinci_spi->wcount = t->len / data_type;
+	davinci_spi->rcount = davinci_spi->wcount;
 
 	init_completion(&davinci_spi_dma->dma_rx_completion);
 	init_completion(&davinci_spi_dma->dma_tx_completion);
 
-	count = t->len / data_type;	/* the number of elements */
-
 	/* disable all interrupts for dma transfers */
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
 	/* Enable SPI */
@@ -680,18 +681,18 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	 */
 
 	if (t->tx_buf) {
-		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf, count,
-				DMA_TO_DEVICE);
+		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
+					davinci_spi->wcount, DMA_TO_DEVICE);
 		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			dev_dbg(sdev, "Unable to DMA map a %d bytes"
-				" TX buffer\n", count);
+			dev_dbg(sdev, "Unable to DMA map %d bytes TX buffer\n",
+							davinci_spi->wcount);
 			return -ENOMEM;
 		}
 	}
 
 	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_tx_channel);
 	param.src = t->tx_buf ? t->tx_dma : tx_reg;
-	param.a_b_cnt = count << 16 | data_type;
+	param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
 	param.dst = tx_reg;
 	param.src_dst_bidx = t->tx_buf ? data_type : 0;
 	param.link_bcntrld = 0xffff;
@@ -715,7 +716,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 
 	if (t->rx_buf) {
 		rx_buf = t->rx_buf;
-		rx_buf_count = count;
+		rx_buf_count = davinci_spi->rcount;
 	} else {
 		rx_buf = davinci_spi->rx_tmp_buf;
 		rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
@@ -727,13 +728,14 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 		dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
 								rx_buf_count);
 		if (t->tx_buf)
-			dma_unmap_single(NULL, t->tx_dma, count, DMA_TO_DEVICE);
+			dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
+								DMA_TO_DEVICE);
 		return -ENOMEM;
 	}
 
 	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_rx_channel);
 	param.src = rx_reg;
-	param.a_b_cnt = count << 16 | data_type;
+	param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
 	param.dst = t->rx_dma;
 	param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
 	param.link_bcntrld = 0xffff;
@@ -754,7 +756,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	wait_for_completion_interruptible(&davinci_spi_dma->dma_rx_completion);
 
 	if (t->tx_buf)
-		dma_unmap_single(NULL, t->tx_dma, count, DMA_TO_DEVICE);
+		dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
+								DMA_TO_DEVICE);
 
 	dma_unmap_single(NULL, t->rx_dma, rx_buf_count, DMA_FROM_DEVICE);
 
@@ -770,15 +773,21 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	if (ret != 0)
 		return ret;
 
+	if (davinci_spi->rcount != 0 || davinci_spi->wcount != 0) {
+		dev_err(sdev, "SPI data transfer error\n");
+		return -EIO;
+	}
+
 	return t->len;
 }
 
-static int davinci_spi_request_dma(struct davinci_spi_dma *davinci_spi_dma)
+static int davinci_spi_request_dma(struct davinci_spi *davinci_spi)
 {
 	int r;
+	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_rx_channel,
-				davinci_spi_dma_rx_callback, davinci_spi_dma,
+				davinci_spi_dma_rx_callback, davinci_spi,
 				davinci_spi_dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI RX\n");
@@ -787,7 +796,7 @@ static int davinci_spi_request_dma(struct davinci_spi_dma *davinci_spi_dma)
 	}
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_tx_channel,
-				davinci_spi_dma_tx_callback, davinci_spi_dma,
+				davinci_spi_dma_tx_callback, davinci_spi,
 				davinci_spi_dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI TX\n");
@@ -929,7 +938,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		davinci_spi->dma_channels.dma_tx_channel = dma_tx_chan;
 		davinci_spi->dma_channels.eventq = dma_eventq;
 
-		ret = davinci_spi_request_dma(&davinci_spi->dma_channels);
+		ret = davinci_spi_request_dma(davinci_spi);
 		if (ret)
 			goto free_clk;
 
-- 
1.7.3.2
