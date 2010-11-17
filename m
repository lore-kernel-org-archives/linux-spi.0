From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 31/49] spi: davinci: do not store DMA channel information per
	chip select
Date: Wed, 17 Nov 2010 16:14:03 +0530
Message-ID: <1289990661-30126-32-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-31-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Do not store DMA channel related information per chip-select since
that information does not depend on the chip select.

The same DMA channels can be used for transfers on all chip-selects
since the transfer happens one-at-a-time.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   47 +++++++++++++++++---------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 77109dc..4aa5221 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -143,7 +143,7 @@ struct davinci_spi {
 	u8			*tmp_buf;
 	int			rcount;
 	int			wcount;
-	struct davinci_spi_dma	*dma_channels;
+	struct davinci_spi_dma	dma_channels;
 	struct davinci_spi_platform_data *pdata;
 
 	void			(*get_rx)(u32 rx_data, struct davinci_spi *);
@@ -407,7 +407,7 @@ static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 	struct davinci_spi_dma *davinci_spi_dma;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
+	davinci_spi_dma = &davinci_spi->dma_channels;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_rx_channel);
@@ -426,7 +426,7 @@ static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 	struct davinci_spi_dma *davinci_spi_dma;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &(davinci_spi->dma_channels[spi->chip_select]);
+	davinci_spi_dma = &davinci_spi->dma_channels;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_tx_channel);
@@ -446,7 +446,7 @@ static int davinci_spi_request_dma(struct spi_device *spi)
 	int r;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
+	davinci_spi_dma = &davinci_spi->dma_channels;
 	sdev = davinci_spi->bitbang.master->dev.parent;
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
@@ -509,8 +509,8 @@ static int davinci_spi_setup(struct spi_device *spi)
 		clear_io_bits(davinci_spi->base + SPIGCR1,
 				SPIGCR1_LOOPBACK_MASK);
 
-	if (use_dma && davinci_spi->dma_channels) {
-		davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
+	if (use_dma) {
+		davinci_spi_dma = &davinci_spi->dma_channels;
 
 		if ((davinci_spi_dma->dma_rx_channel == -1) ||
 		    (davinci_spi_dma->dma_tx_channel == -1))
@@ -522,13 +522,11 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 static void davinci_spi_cleanup(struct spi_device *spi)
 {
-	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
-	struct davinci_spi_dma *davinci_spi_dma;
-
-	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
-
-	if (use_dma && davinci_spi->dma_channels) {
-		davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
+	if (use_dma) {
+		struct davinci_spi *davinci_spi =
+					spi_master_get_devdata(spi->master);
+		struct davinci_spi_dma *davinci_spi_dma =
+					&davinci_spi->dma_channels;
 
 		if ((davinci_spi_dma->dma_rx_channel != -1)
 				&& (davinci_spi_dma->dma_tx_channel != -1)) {
@@ -730,7 +728,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	davinci_spi = spi_master_get_devdata(spi->master);
 	sdev = davinci_spi->bitbang.master->dev.parent;
 
-	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
+	davinci_spi_dma = &davinci_spi->dma_channels;
 
 	tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
 	rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
@@ -967,22 +965,13 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		use_dma = 0;
 	} else {
 		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_dma;
-		davinci_spi->dma_channels = kzalloc(master->num_chipselect
-				* sizeof(struct davinci_spi_dma), GFP_KERNEL);
-		if (davinci_spi->dma_channels == NULL) {
-			ret = -ENOMEM;
-			goto free_clk;
-		}
 
-		for (i = 0; i < master->num_chipselect; i++) {
-			davinci_spi->dma_channels[i].dma_rx_channel = -1;
-			davinci_spi->dma_channels[i].dma_rx_sync_dev =
-				dma_rx_chan;
-			davinci_spi->dma_channels[i].dma_tx_channel = -1;
-			davinci_spi->dma_channels[i].dma_tx_sync_dev =
-				dma_tx_chan;
-			davinci_spi->dma_channels[i].eventq = dma_eventq;
-		}
+		davinci_spi->dma_channels.dma_rx_channel = -1;
+		davinci_spi->dma_channels.dma_rx_sync_dev = dma_rx_chan;
+		davinci_spi->dma_channels.dma_tx_channel = -1;
+		davinci_spi->dma_channels.dma_tx_sync_dev = dma_tx_chan;
+		davinci_spi->dma_channels.eventq = dma_eventq;
+
 		dev_info(&pdev->dev, "DaVinci SPI driver in EDMA mode\n"
 				"Using RX channel = %d , TX channel = %d and "
 				"event queue = %d", dma_rx_chan, dma_tx_chan,
-- 
1.7.3.2
