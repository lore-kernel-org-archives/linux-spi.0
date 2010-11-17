From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 33/49] spi: davinci: do not use temporary buffer if no
	transmit data provided
Date: Wed, 17 Nov 2010 16:14:05 +0530
Message-ID: <1289990661-30126-34-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-33-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Remove usage of temporary buffer when no transmit data is provided.
Instead, use the transmit register itself as the source of data.

By choosing the transmit register itself as the source of data, this
patch helps remove unnecessary accesses to memory when no real data
is being transmitted.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   52 ++++++++++++++++++--------------------------
 1 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index a5f03dd..f512939 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -38,8 +38,6 @@
 
 #define CS_DEFAULT	0xFF
 
-#define SPI_BUFSIZ	(SMP_CACHE_BYTES + 1)
-
 #define SPIFMT_PHASE_MASK	BIT(16)
 #define SPIFMT_POLARITY_MASK	BIT(17)
 #define SPIFMT_DISTIMER_MASK	BIT(18)
@@ -140,7 +138,6 @@ struct davinci_spi {
 
 	const void		*tx;
 	void			*rx;
-	u8			*tmp_buf;
 	int			rcount;
 	int			wcount;
 	struct davinci_spi_dma	dma_channels;
@@ -718,7 +715,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
 	int int_status = 0;
-	int count, temp_count;
+	int count;
 	struct davinci_spi_dma *davinci_spi_dma;
 	int data_type, ret;
 	unsigned long tx_reg, rx_reg;
@@ -750,6 +747,18 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
+	/*
+	 * Transmit DMA setup
+	 *
+	 * If there is transmit data, map the transmit buffer, set it as the
+	 * source of data and set the source B index to data size.
+	 * If there is no transmit data, set the transmit register as the
+	 * source of data, and set the source B index to zero.
+	 *
+	 * The destination is always the transmit register itself. And the
+	 * destination never increments.
+	 */
+
 	if (t->tx_buf) {
 		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf, count,
 				DMA_TO_DEVICE);
@@ -758,25 +767,15 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 				" TX buffer\n", count);
 			return -ENOMEM;
 		}
-		temp_count = count;
-	} else {
-		/* We need TX clocking for RX transaction */
-		t->tx_dma = dma_map_single(&spi->dev,
-				(void *)davinci_spi->tmp_buf, count + 1,
-				DMA_TO_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			dev_dbg(sdev, "Unable to DMA map a %d bytes"
-				" TX tmp buffer\n", count);
-			return -ENOMEM;
-		}
-		temp_count = count + 1;
 	}
 
 	edma_set_transfer_params(davinci_spi_dma->dma_tx_channel,
-					data_type, temp_count, 1, 0, ASYNC);
+					data_type, count, 1, 0, ASYNC);
 	edma_set_dest(davinci_spi_dma->dma_tx_channel, tx_reg, INCR, W8BIT);
-	edma_set_src(davinci_spi_dma->dma_tx_channel, t->tx_dma, INCR, W8BIT);
-	edma_set_src_index(davinci_spi_dma->dma_tx_channel, data_type, 0);
+	edma_set_src(davinci_spi_dma->dma_tx_channel,
+			t->tx_buf ? t->tx_dma : tx_reg, INCR, W8BIT);
+	edma_set_src_index(davinci_spi_dma->dma_tx_channel,
+			t->tx_buf ? data_type : 0, 0);
 	edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
 
 	if (t->rx_buf) {
@@ -818,7 +817,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 		wait_for_completion_interruptible(
 				&davinci_spi_dma->dma_rx_completion);
 
-	dma_unmap_single(NULL, t->tx_dma, temp_count, DMA_TO_DEVICE);
+	if (t->tx_buf)
+		dma_unmap_single(NULL, t->tx_dma, count, DMA_TO_DEVICE);
 
 	if (t->rx_buf)
 		dma_unmap_single(NULL, t->rx_dma, count, DMA_FROM_DEVICE);
@@ -906,17 +906,10 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto unmap_io;
 
-	/* Allocate tmp_buf for tx_buf */
-	davinci_spi->tmp_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
-	if (davinci_spi->tmp_buf == NULL) {
-		ret = -ENOMEM;
-		goto irq_free;
-	}
-
 	davinci_spi->bitbang.master = spi_master_get(master);
 	if (davinci_spi->bitbang.master == NULL) {
 		ret = -ENODEV;
-		goto free_tmp_buf;
+		goto irq_free;
 	}
 
 	davinci_spi->clk = clk_get(&pdev->dev, NULL);
@@ -1027,8 +1020,6 @@ free_clk:
 	clk_put(davinci_spi->clk);
 put_master:
 	spi_master_put(master);
-free_tmp_buf:
-	kfree(davinci_spi->tmp_buf);
 irq_free:
 	free_irq(davinci_spi->irq, davinci_spi);
 unmap_io:
@@ -1063,7 +1054,6 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
 	clk_disable(davinci_spi->clk);
 	clk_put(davinci_spi->clk);
 	spi_master_put(master);
-	kfree(davinci_spi->tmp_buf);
 	free_irq(davinci_spi->irq, davinci_spi);
 	iounmap(davinci_spi->base);
 	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
-- 
1.7.3.2
