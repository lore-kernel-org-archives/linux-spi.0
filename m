From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 40/49] spi: davinci: remove usage of additional completion
	variables for DMA
Date: Wed, 17 Nov 2010 16:14:12 +0530
Message-ID: <1289990661-30126-41-git-send-email-nsekhar@ti.com>
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
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1289990661-30126-40-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

The DMA code does not use the existing completion variable 'done'
which is being used for interrupt mode transfers. Instead it uses
two different completion variables specific to DMA mode transfers.

Eliminate the usage of new completion variables for DMA mode and
use the existing completion variable.

[nsekhar-l0cyMroinI0@public.gmane.org: To make this process easy, eliminate the two
different DMA completion callback functions for tx and rx and
use a single callback function instead]

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   58 +++++++++++++++++---------------------------
 1 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index a47947d..6094e3a 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -118,9 +118,6 @@ struct davinci_spi_dma {
 	int			dma_rx_channel;
 	int			dummy_param_slot;
 	enum dma_event_q	eventq;
-
-	struct completion	dma_tx_completion;
-	struct completion	dma_rx_completion;
 };
 
 /* SPI Controller driver's private data. */
@@ -386,32 +383,6 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
-{
-	struct davinci_spi *davinci_spi = data;
-	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
-
-	edma_stop(davinci_spi_dma->dma_rx_channel);
-
-	if (ch_status == DMA_COMPLETE)
-		davinci_spi->rcount = 0;
-
-	complete(&davinci_spi_dma->dma_rx_completion);
-}
-
-static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
-{
-	struct davinci_spi *davinci_spi = data;
-	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
-
-	edma_stop(davinci_spi_dma->dma_tx_channel);
-
-	if (ch_status == DMA_COMPLETE)
-		davinci_spi->wcount = 0;
-
-	complete(&davinci_spi_dma->dma_tx_completion);
-}
-
 /**
  * davinci_spi_setup - This functions will set default transfer method
  * @spi: spi device on which data transfer to be done
@@ -630,6 +601,25 @@ static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
 	return IRQ_HANDLED;
 }
 
+static void davinci_spi_dma_callback(unsigned lch, u16 status, void *data)
+{
+	struct davinci_spi *davinci_spi = data;
+	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+
+	edma_stop(lch);
+
+	if (status == DMA_COMPLETE) {
+		if (lch == davinci_spi_dma->dma_rx_channel)
+			davinci_spi->rcount = 0;
+		if (lch == davinci_spi_dma->dma_tx_channel)
+			davinci_spi->wcount = 0;
+	}
+
+	if ((!davinci_spi->wcount && !davinci_spi->rcount) ||
+	    (status != DMA_COMPLETE))
+		complete(&davinci_spi->done);
+}
+
 static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
@@ -660,8 +650,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	davinci_spi->wcount = t->len / data_type;
 	davinci_spi->rcount = davinci_spi->wcount;
 
-	init_completion(&davinci_spi_dma->dma_rx_completion);
-	init_completion(&davinci_spi_dma->dma_tx_completion);
+	INIT_COMPLETION(davinci_spi->done);
 
 	/* disable all interrupts for dma transfers */
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
@@ -752,8 +741,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	edma_start(davinci_spi_dma->dma_tx_channel);
 	set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
-	wait_for_completion_interruptible(&davinci_spi_dma->dma_tx_completion);
-	wait_for_completion_interruptible(&davinci_spi_dma->dma_rx_completion);
+	wait_for_completion_interruptible(&davinci_spi->done);
 
 	if (t->tx_buf)
 		dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
@@ -787,7 +775,7 @@ static int davinci_spi_request_dma(struct davinci_spi *davinci_spi)
 	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_rx_channel,
-				davinci_spi_dma_rx_callback, davinci_spi,
+				davinci_spi_dma_callback, davinci_spi,
 				davinci_spi_dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI RX\n");
@@ -796,7 +784,7 @@ static int davinci_spi_request_dma(struct davinci_spi *davinci_spi)
 	}
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_tx_channel,
-				davinci_spi_dma_tx_callback, davinci_spi,
+				davinci_spi_dma_callback, davinci_spi,
 				davinci_spi_dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI TX\n");
-- 
1.7.3.2


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
