From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/17] spi/atmel_spi: correct 16 bits transfer with DMA
Date: Mon, 12 Nov 2012 16:52:30 +0800
Message-ID: <1352710357-3265-11-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 drivers/spi/spi-atmel.c |   53 +++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0007a53..7a3613d 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -249,6 +249,8 @@ struct atmel_spi_device {
 #define BUFFER_SIZE		PAGE_SIZE
 #define INVALID_DMA_ADDRESS	0xffffffff
 
+static struct dma_slave_config slave_config;
+
 /*
  * Version 2 of the SPI controller has
  *  - CR.LASTXFER
@@ -406,17 +408,41 @@ static bool filter(struct dma_chan *chan, void *slave)
 	}
 }
 
+static int atmel_spi_set_dma_xfer_width(struct atmel_spi *as, u8 bits_per_word)
+{
+	int err = 0;
+
+	if (bits_per_word > 8) {
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	slave_config.direction = DMA_TO_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_tx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure tx dma channel\n");
+		err = -EINVAL;
+	}
+
+	slave_config.direction = DMA_FROM_DEVICE;
+	if (dmaengine_slave_config(as->dma.chan_rx, &slave_config)) {
+		dev_err(&as->pdev->dev,
+			"failed to configure rx dma channel\n");
+		err = -EINVAL;
+	}
+	return err;
+}
+
 static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
 {
 	struct at_dma_slave *sdata = (struct at_dma_slave *)&as->data.dma_slave;
-	struct dma_slave_config	slave_config;
 	int err;
 
-	memset(&slave_config, 0, sizeof(slave_config));
 	slave_config.dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
 	slave_config.src_addr = (dma_addr_t)as->phybase + SPI_RDR;
-	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	slave_config.src_maxburst = 1;
 	slave_config.dst_maxburst = 1;
 	slave_config.device_fc = false;
@@ -439,21 +465,9 @@ static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
 		goto error;
 	}
 
-	slave_config.direction = DMA_TO_DEVICE;
-	if (dmaengine_slave_config(as->dma.chan_tx, &slave_config)) {
-		dev_err(&as->pdev->dev,
-			"failed to configure tx dma channel\n");
-		err = -EINVAL;
+	err = atmel_spi_set_dma_xfer_width(as, 8);
+	if (err)
 		goto error;
-	}
-
-	slave_config.direction = DMA_FROM_DEVICE;
-	if (dmaengine_slave_config(as->dma.chan_rx, &slave_config)) {
-		dev_err(&as->pdev->dev,
-			"failed to configure rx dma channel\n");
-		err = -EINVAL;
-		goto error;
-	}
 
 	dev_info(&as->pdev->dev, "Using %s (tx) and " \
 				" %s (rx) for DMA transfers\n",
@@ -575,6 +589,9 @@ static int atmel_spi_next_xfer_dma(struct spi_master *master,
 		memset(as->buffer, 0, xfer->len);
 	}
 
+	if (atmel_spi_set_dma_xfer_width(as, xfer->bits_per_word))
+		goto err_dma;
+
 	/* Send both scatterlists */
 	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
 					&as->dma.sgrx,
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
