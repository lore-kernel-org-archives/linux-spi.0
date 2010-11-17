From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 38/49] spi: davinci: fix EDMA CC errors at end of transfers
Date: Wed, 17 Nov 2010 16:14:10 +0530
Message-ID: <1289990661-30126-39-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-38-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Use a dummy param slot linked to itself to take care of the
extra "sync event" that gets sent to EDMA controller after
the last byte has been transferred.

The dummy PaRAM slot that is linked to the actual DMA PaRAM
slot "absorbs" this event and prevents a EDMA CC error to
be asserted.

Without this provision, the EDMA CC error would be asserted
because the channel PaRAM would be empty after the transfer
and EDMA would not know what to make out of the extra sync
event.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 6db4786..975c2a2 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -116,6 +116,7 @@
 struct davinci_spi_dma {
 	int			dma_tx_channel;
 	int			dma_rx_channel;
+	int			dummy_param_slot;
 	enum dma_event_q	eventq;
 
 	struct completion	dma_tx_completion;
@@ -697,6 +698,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	param.src_dst_cidx = 0;
 	param.ccnt = 1;
 	edma_write_slot(davinci_spi_dma->dma_tx_channel, &param);
+	edma_link(davinci_spi_dma->dma_tx_channel,
+			davinci_spi_dma->dummy_param_slot);
 
 	/*
 	 * Receive DMA setup
@@ -779,19 +782,37 @@ static int davinci_spi_request_dma(struct davinci_spi_dma *davinci_spi_dma)
 				davinci_spi_dma->eventq);
 	if (r < 0) {
 		pr_err("Unable to request DMA channel for SPI RX\n");
-		return -EAGAIN;
+		r = -EAGAIN;
+		goto rx_dma_failed;
 	}
 
 	r = edma_alloc_channel(davinci_spi_dma->dma_tx_channel,
 				davinci_spi_dma_tx_callback, davinci_spi_dma,
 				davinci_spi_dma->eventq);
 	if (r < 0) {
-		edma_free_channel(davinci_spi_dma->dma_rx_channel);
 		pr_err("Unable to request DMA channel for SPI TX\n");
-		return -EAGAIN;
+		r = -EAGAIN;
+		goto tx_dma_failed;
 	}
 
+	r = edma_alloc_slot(EDMA_CTLR(davinci_spi_dma->dma_tx_channel),
+		EDMA_SLOT_ANY);
+	if (r < 0) {
+		pr_err("Unable to request SPI TX DMA param slot\n");
+		r = -EAGAIN;
+		goto param_failed;
+	}
+	davinci_spi_dma->dummy_param_slot = r;
+	edma_link(davinci_spi_dma->dummy_param_slot,
+		davinci_spi_dma->dummy_param_slot);
+
 	return 0;
+param_failed:
+	edma_free_channel(davinci_spi_dma->dma_tx_channel);
+tx_dma_failed:
+	edma_free_channel(davinci_spi_dma->dma_rx_channel);
+rx_dma_failed:
+	return r;
 }
 
 /**
@@ -970,6 +991,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 free_dma:
 	edma_free_channel(davinci_spi->dma_channels.dma_tx_channel);
 	edma_free_channel(davinci_spi->dma_channels.dma_rx_channel);
+	edma_free_slot(davinci_spi->dma_channels.dummy_param_slot);
 free_clk:
 	clk_disable(davinci_spi->clk);
 	clk_put(davinci_spi->clk);
-- 
1.7.3.2
