From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 37/49] spi: davinci: do not allocate DMA channels during SPI
	device setup
Date: Wed, 17 Nov 2010 16:14:09 +0530
Message-ID: <1289990661-30126-38-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-37-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Do not allocate (and de-allocate) SPI DMA channels during setup
(and cleanup) for each SPI device. Instead, allocate the DMA
channels once duing probe and use them for the life time of
the driver.

This makes sense since there are dedicated DMA channels meant
for SPI use.

This also helps remove the unnecessary DMA "sync_dev" variables
being used to store DMA channel information.

Also, the "use_dma" platform variable is now eliminated since
it is possible to check if the platform supports DMA or not
based upon whether DMA resources can be found or not.

Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Tested-By: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    1 -
 drivers/spi/davinci_spi.c                |  153 ++++++++++--------------------
 2 files changed, 51 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 68db6d5..f7586a0 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -31,7 +31,6 @@ struct davinci_spi_platform_data {
 	u8	num_chipselect;
 	u8	clk_internal;
 	u8	intr_line;
-	u8	use_dma;
 	u8	*chip_sel;
 	bool	cshold_bug;
 };
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 9695f98..6db4786 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -116,8 +116,6 @@
 struct davinci_spi_dma {
 	int			dma_tx_channel;
 	int			dma_rx_channel;
-	int			dma_tx_sync_dev;
-	int			dma_rx_sync_dev;
 	enum dma_event_q	eventq;
 
 	struct completion	dma_tx_completion;
@@ -153,8 +151,6 @@ struct davinci_spi {
 
 static struct davinci_spi_config davinci_spi_default_cfg;
 
-static unsigned use_dma;
-
 static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
 {
 	if (davinci_spi->rx) {
@@ -391,12 +387,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 {
-	struct spi_device *spi = (struct spi_device *)data;
-	struct davinci_spi *davinci_spi;
-	struct davinci_spi_dma *davinci_spi_dma;
-
-	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &davinci_spi->dma_channels;
+	struct davinci_spi_dma *davinci_spi_dma = data;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_rx_channel);
@@ -408,12 +399,7 @@ static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 
 static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 {
-	struct spi_device *spi = (struct spi_device *)data;
-	struct davinci_spi *davinci_spi;
-	struct davinci_spi_dma *davinci_spi_dma;
-
-	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &davinci_spi->dma_channels;
+	struct davinci_spi_dma *davinci_spi_dma = data;
 
 	if (ch_status == DMA_COMPLETE)
 		edma_stop(davinci_spi_dma->dma_tx_channel);
@@ -423,39 +409,6 @@ static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 	complete(&davinci_spi_dma->dma_tx_completion);
 }
 
-static int davinci_spi_request_dma(struct spi_device *spi)
-{
-	struct davinci_spi *davinci_spi;
-	struct davinci_spi_dma *davinci_spi_dma;
-	struct device *sdev;
-	int r;
-
-	davinci_spi = spi_master_get_devdata(spi->master);
-	davinci_spi_dma = &davinci_spi->dma_channels;
-	sdev = davinci_spi->bitbang.master->dev.parent;
-
-	r = edma_alloc_channel(davinci_spi_dma->dma_rx_sync_dev,
-				davinci_spi_dma_rx_callback, spi,
-				davinci_spi_dma->eventq);
-	if (r < 0) {
-		dev_dbg(sdev, "Unable to request DMA channel for SPI RX\n");
-		return -EAGAIN;
-	}
-	davinci_spi_dma->dma_rx_channel = r;
-	r = edma_alloc_channel(davinci_spi_dma->dma_tx_sync_dev,
-				davinci_spi_dma_tx_callback, spi,
-				davinci_spi_dma->eventq);
-	if (r < 0) {
-		edma_free_channel(davinci_spi_dma->dma_rx_channel);
-		davinci_spi_dma->dma_rx_channel = -1;
-		dev_dbg(sdev, "Unable to request DMA channel for SPI TX\n");
-		return -EAGAIN;
-	}
-	davinci_spi_dma->dma_tx_channel = r;
-
-	return 0;
-}
-
 /**
  * davinci_spi_setup - This functions will set default transfer method
  * @spi: spi device on which data transfer to be done
@@ -466,7 +419,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 {
 	int retval = 0;
 	struct davinci_spi *davinci_spi;
-	struct davinci_spi_dma *davinci_spi_dma;
 	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
@@ -494,33 +446,9 @@ static int davinci_spi_setup(struct spi_device *spi)
 		clear_io_bits(davinci_spi->base + SPIGCR1,
 				SPIGCR1_LOOPBACK_MASK);
 
-	if (use_dma) {
-		davinci_spi_dma = &davinci_spi->dma_channels;
-
-		if ((davinci_spi_dma->dma_rx_channel == -1) ||
-		    (davinci_spi_dma->dma_tx_channel == -1))
-			retval = davinci_spi_request_dma(spi);
-	}
-
 	return retval;
 }
 
-static void davinci_spi_cleanup(struct spi_device *spi)
-{
-	if (use_dma) {
-		struct davinci_spi *davinci_spi =
-					spi_master_get_devdata(spi->master);
-		struct davinci_spi_dma *davinci_spi_dma =
-					&davinci_spi->dma_channels;
-
-		if ((davinci_spi_dma->dma_rx_channel != -1)
-				&& (davinci_spi_dma->dma_tx_channel != -1)) {
-			edma_free_channel(davinci_spi_dma->dma_tx_channel);
-			edma_free_channel(davinci_spi_dma->dma_rx_channel);
-		}
-	}
-}
-
 static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 				   int int_status)
 {
@@ -842,6 +770,30 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 }
 
+static int davinci_spi_request_dma(struct davinci_spi_dma *davinci_spi_dma)
+{
+	int r;
+
+	r = edma_alloc_channel(davinci_spi_dma->dma_rx_channel,
+				davinci_spi_dma_rx_callback, davinci_spi_dma,
+				davinci_spi_dma->eventq);
+	if (r < 0) {
+		pr_err("Unable to request DMA channel for SPI RX\n");
+		return -EAGAIN;
+	}
+
+	r = edma_alloc_channel(davinci_spi_dma->dma_tx_channel,
+				davinci_spi_dma_tx_callback, davinci_spi_dma,
+				davinci_spi_dma->eventq);
+	if (r < 0) {
+		edma_free_channel(davinci_spi_dma->dma_rx_channel);
+		pr_err("Unable to request DMA channel for SPI TX\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
 /**
  * davinci_spi_probe - probe function for SPI Master Controller
  * @pdev: platform_device structure which contains plateform specific data
@@ -928,45 +880,39 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = davinci_spi_setup;
-	master->cleanup = davinci_spi_cleanup;
 
 	davinci_spi->bitbang.chipselect = davinci_spi_chipselect;
 	davinci_spi->bitbang.setup_transfer = davinci_spi_setup_transfer;
 
 	davinci_spi->version = pdata->version;
-	use_dma = pdata->use_dma;
 
 	davinci_spi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
 	if (davinci_spi->version == SPI_VERSION_2)
 		davinci_spi->bitbang.flags |= SPI_READY;
 
-	if (use_dma) {
-		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-		if (r)
-			dma_rx_chan = r->start;
-		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-		if (r)
-			dma_tx_chan = r->start;
-		r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
-		if (r)
-			dma_eventq = r->start;
-	}
-
-	if (!use_dma ||
-	    dma_rx_chan == SPI_NO_RESOURCE ||
-	    dma_tx_chan == SPI_NO_RESOURCE ||
-	    dma_eventq	== SPI_NO_RESOURCE) {
-		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_pio;
-		use_dma = 0;
-	} else {
-		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_dma;
-
-		davinci_spi->dma_channels.dma_rx_channel = -1;
-		davinci_spi->dma_channels.dma_rx_sync_dev = dma_rx_chan;
-		davinci_spi->dma_channels.dma_tx_channel = -1;
-		davinci_spi->dma_channels.dma_tx_sync_dev = dma_tx_chan;
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (r)
+		dma_rx_chan = r->start;
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (r)
+		dma_tx_chan = r->start;
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
+	if (r)
+		dma_eventq = r->start;
+
+	davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_pio;
+	if (dma_rx_chan != SPI_NO_RESOURCE &&
+	    dma_tx_chan != SPI_NO_RESOURCE &&
+	    dma_eventq != SPI_NO_RESOURCE) {
+		davinci_spi->dma_channels.dma_rx_channel = dma_rx_chan;
+		davinci_spi->dma_channels.dma_tx_channel = dma_tx_chan;
 		davinci_spi->dma_channels.eventq = dma_eventq;
 
+		ret = davinci_spi_request_dma(&davinci_spi->dma_channels);
+		if (ret)
+			goto free_clk;
+
+		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_dma;
 		dev_info(&pdev->dev, "DaVinci SPI driver in EDMA mode\n"
 				"Using RX channel = %d , TX channel = %d and "
 				"event queue = %d", dma_rx_chan, dma_tx_chan,
@@ -1015,12 +961,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	ret = spi_bitbang_start(&davinci_spi->bitbang);
 	if (ret)
-		goto free_clk;
+		goto free_dma;
 
 	dev_info(&pdev->dev, "Controller at 0x%p\n", davinci_spi->base);
 
 	return ret;
 
+free_dma:
+	edma_free_channel(davinci_spi->dma_channels.dma_tx_channel);
+	edma_free_channel(davinci_spi->dma_channels.dma_rx_channel);
 free_clk:
 	clk_disable(davinci_spi->clk);
 	clk_put(davinci_spi->clk);
-- 
1.7.3.2
