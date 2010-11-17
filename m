From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 35/49] spi: davinci: use edma_write_slot() to setup EDMA PaRAM
	slot
Date: Wed, 17 Nov 2010 16:14:07 +0530
Message-ID: <1289990661-30126-36-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-35-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Currently a series of EDMA API calls are being made to setup
various aspects of EDMA PaRAM slots for receive and transmit.

Instead setup the PaRAM using a local structure and write once
to the hardware using edma_write_slot()

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 705d006..67f1e46 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -725,6 +725,7 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi_platform_data *pdata;
 	void *rx_buf;
 	struct device *sdev;
+	struct edmacc_param param;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
@@ -773,14 +774,15 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 		}
 	}
 
-	edma_set_transfer_params(davinci_spi_dma->dma_tx_channel,
-					data_type, count, 1, 0, ASYNC);
-	edma_set_dest(davinci_spi_dma->dma_tx_channel, tx_reg, INCR, W8BIT);
-	edma_set_src(davinci_spi_dma->dma_tx_channel,
-			t->tx_buf ? t->tx_dma : tx_reg, INCR, W8BIT);
-	edma_set_src_index(davinci_spi_dma->dma_tx_channel,
-			t->tx_buf ? data_type : 0, 0);
-	edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
+	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_tx_channel);
+	param.src = t->tx_buf ? t->tx_dma : tx_reg;
+	param.a_b_cnt = count << 16 | data_type;
+	param.dst = tx_reg;
+	param.src_dst_bidx = t->tx_buf ? data_type : 0;
+	param.link_bcntrld = 0xffff;
+	param.src_dst_cidx = 0;
+	param.ccnt = 1;
+	edma_write_slot(davinci_spi_dma->dma_tx_channel, &param);
 
 	/*
 	 * Receive DMA setup
@@ -812,13 +814,15 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 		return -ENOMEM;
 	}
 
-	edma_set_transfer_params(davinci_spi_dma->dma_rx_channel, data_type,
-							count, 1, 0, ASYNC);
-	edma_set_src(davinci_spi_dma->dma_rx_channel, rx_reg, INCR, W8BIT);
-	edma_set_dest(davinci_spi_dma->dma_rx_channel, t->rx_dma, INCR, W8BIT);
-	edma_set_src_index(davinci_spi_dma->dma_rx_channel, 0, 0);
-	edma_set_dest_index(davinci_spi_dma->dma_rx_channel,
-						t->rx_buf ? data_type : 0, 0);
+	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_rx_channel);
+	param.src = rx_reg;
+	param.a_b_cnt = count << 16 | data_type;
+	param.dst = t->rx_dma;
+	param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
+	param.link_bcntrld = 0xffff;
+	param.src_dst_cidx = 0;
+	param.ccnt = 1;
+	edma_write_slot(davinci_spi_dma->dma_rx_channel, &param);
 
 	if (pdata->cshold_bug) {
 		u16 spidat1 = ioread16(davinci_spi->base + SPIDAT1 + 2);
-- 
1.7.3.2
