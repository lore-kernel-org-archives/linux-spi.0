From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 34/49] spi: davinci: always start receive DMA
Date: Wed, 17 Nov 2010 16:14:06 +0530
Message-ID: <1289990661-30126-35-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-34-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

In keeping with the full duplex nature of the SPI bus. Always
start receive DMA along with transmit DMA.

If there is no receive buffer provided with the transfer, use
a temporary buffer to receive the data to be thrown away.

[michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org: receive DMA size should
be same as transfer length to avoid hang-up when transfer length
is smaller than temporary rx buffer size (rx buffer not provided)]

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   70 +++++++++++++++++++++++++++------------------
 1 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index f512939..705d006 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -138,6 +138,8 @@ struct davinci_spi {
 
 	const void		*tx;
 	void			*rx;
+#define SPI_TMP_BUFSZ	(SMP_CACHE_BYTES + 1)
+	u8			rx_tmp_buf[SPI_TMP_BUFSZ];
 	int			rcount;
 	int			wcount;
 	struct davinci_spi_dma	dma_channels;
@@ -716,10 +718,12 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi *davinci_spi;
 	int int_status = 0;
 	int count;
+	unsigned rx_buf_count;
 	struct davinci_spi_dma *davinci_spi_dma;
 	int data_type, ret;
 	unsigned long tx_reg, rx_reg;
 	struct davinci_spi_platform_data *pdata;
+	void *rx_buf;
 	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
@@ -778,50 +782,60 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 			t->tx_buf ? data_type : 0, 0);
 	edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
 
+	/*
+	 * Receive DMA setup
+	 *
+	 * If there is receive buffer, use it to receive data. If there
+	 * is none provided, use a temporary receive buffer. Set the
+	 * destination B index to 0 so effectively only one byte is used
+	 * in the temporary buffer (address does not increment).
+	 *
+	 * The source of receive data is the receive data register. The
+	 * source address never increments.
+	 */
+
 	if (t->rx_buf) {
-		t->rx_dma = dma_map_single(&spi->dev, (void *)t->rx_buf, count,
-				DMA_FROM_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
-			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
-					count);
-			if (t->tx_buf != NULL)
-				dma_unmap_single(NULL, t->tx_dma,
-						 count, DMA_TO_DEVICE);
-			return -ENOMEM;
-		}
-		edma_set_transfer_params(davinci_spi_dma->dma_rx_channel,
-				data_type, count, 1, 0, ASYNC);
-		edma_set_src(davinci_spi_dma->dma_rx_channel,
-				rx_reg, INCR, W8BIT);
-		edma_set_dest(davinci_spi_dma->dma_rx_channel,
-				t->rx_dma, INCR, W8BIT);
-		edma_set_src_index(davinci_spi_dma->dma_rx_channel, 0, 0);
-		edma_set_dest_index(davinci_spi_dma->dma_rx_channel,
-				data_type, 0);
+		rx_buf = t->rx_buf;
+		rx_buf_count = count;
+	} else {
+		rx_buf = davinci_spi->rx_tmp_buf;
+		rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
+	}
+
+	t->rx_dma = dma_map_single(&spi->dev, rx_buf, rx_buf_count,
+							DMA_FROM_DEVICE);
+	if (dma_mapping_error(&spi->dev, t->rx_dma)) {
+		dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
+								rx_buf_count);
+		if (t->tx_buf)
+			dma_unmap_single(NULL, t->tx_dma, count, DMA_TO_DEVICE);
+		return -ENOMEM;
 	}
 
+	edma_set_transfer_params(davinci_spi_dma->dma_rx_channel, data_type,
+							count, 1, 0, ASYNC);
+	edma_set_src(davinci_spi_dma->dma_rx_channel, rx_reg, INCR, W8BIT);
+	edma_set_dest(davinci_spi_dma->dma_rx_channel, t->rx_dma, INCR, W8BIT);
+	edma_set_src_index(davinci_spi_dma->dma_rx_channel, 0, 0);
+	edma_set_dest_index(davinci_spi_dma->dma_rx_channel,
+						t->rx_buf ? data_type : 0, 0);
+
 	if (pdata->cshold_bug) {
 		u16 spidat1 = ioread16(davinci_spi->base + SPIDAT1 + 2);
 		iowrite16(spidat1, davinci_spi->base + SPIDAT1 + 2);
 	}
 
-	if (t->rx_buf)
-		edma_start(davinci_spi_dma->dma_rx_channel);
-
+	edma_start(davinci_spi_dma->dma_rx_channel);
 	edma_start(davinci_spi_dma->dma_tx_channel);
 	davinci_spi_set_dma_req(spi, 1);
 
 	wait_for_completion_interruptible(&davinci_spi_dma->dma_tx_completion);
-
-	if (t->rx_buf)
-		wait_for_completion_interruptible(
-				&davinci_spi_dma->dma_rx_completion);
+	wait_for_completion_interruptible(&davinci_spi_dma->dma_rx_completion);
 
 	if (t->tx_buf)
 		dma_unmap_single(NULL, t->tx_dma, count, DMA_TO_DEVICE);
 
-	if (t->rx_buf)
-		dma_unmap_single(NULL, t->rx_dma, count, DMA_FROM_DEVICE);
+	dma_unmap_single(NULL, t->rx_dma, rx_buf_count, DMA_FROM_DEVICE);
 
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
-- 
1.7.3.2
