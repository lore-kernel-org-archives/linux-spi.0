From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 36/49] spi: davinci: fix DMA event generation stoppage
Date: Wed, 17 Nov 2010 16:14:08 +0530
Message-ID: <1289990661-30126-37-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-36-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Do not stop SPI DMA event generation in either transmit or
receive DMA event call back because the single setting affects
both transmit and receive event generation.

Depending on the order in which the callbacks happen, transmit
or receive events can get unintentionally stalled.

Instead, disable event generation once after both the transmit
and receive DMA completes.

While at it, remove the largely under-used function to set or
clear DMA event generation.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 67f1e46..9695f98 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -211,16 +211,6 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
 	iowrite32(v, addr);
 }
 
-static void davinci_spi_set_dma_req(const struct spi_device *spi, int enable)
-{
-	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
-
-	if (enable)
-		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
-	else
-		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
-}
-
 /*
  * Interface to control the chip select signal
  */
@@ -414,8 +404,6 @@ static void davinci_spi_dma_rx_callback(unsigned lch, u16 ch_status, void *data)
 		edma_clean_channel(davinci_spi_dma->dma_rx_channel);
 
 	complete(&davinci_spi_dma->dma_rx_completion);
-	/* We must disable the DMA RX request */
-	davinci_spi_set_dma_req(spi, 0);
 }
 
 static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
@@ -433,8 +421,6 @@ static void davinci_spi_dma_tx_callback(unsigned lch, u16 ch_status, void *data)
 		edma_clean_channel(davinci_spi_dma->dma_tx_channel);
 
 	complete(&davinci_spi_dma->dma_tx_completion);
-	/* We must disable the DMA TX request */
-	davinci_spi_set_dma_req(spi, 0);
 }
 
 static int davinci_spi_request_dma(struct spi_device *spi)
@@ -831,7 +817,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 
 	edma_start(davinci_spi_dma->dma_rx_channel);
 	edma_start(davinci_spi_dma->dma_tx_channel);
-	davinci_spi_set_dma_req(spi, 1);
+	set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
 	wait_for_completion_interruptible(&davinci_spi_dma->dma_tx_completion);
 	wait_for_completion_interruptible(&davinci_spi_dma->dma_rx_completion);
@@ -841,6 +827,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 
 	dma_unmap_single(NULL, t->rx_dma, rx_buf_count, DMA_FROM_DEVICE);
 
+	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
-- 
1.7.3.2
