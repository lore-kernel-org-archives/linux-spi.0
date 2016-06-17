From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH 2/3] spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
Date: Fri, 17 Jun 2016 17:45:12 -0500
Message-ID: <1466203513-4771-3-git-send-email-fcooper@ti.com>
References: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Franklin S Cooper Jr <fcooper@ti.com>
To: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <david.s.gordon@intel.com>,
	<akpm@linux-foundation.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
	<peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

OMAP35x and OMAP37x mentions in the McSPI End-of-Transfer Sequences section
that if the McSPI is configured as a Master and only DMA RX is being
performed then the DMA transfer size needs to be reduced by 1 or 2.

This was originally implemented by:
commit 57c5c28dbc83 ("spi: omap2_mcspi rxdma bugfix")

This patch adds comments to clarify what is going on in the code since its
not obvious what problem its addressing.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1d237e9..c47f958 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -459,6 +459,11 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	count = xfer->len;
 	dma_count = xfer->len;
 
+	/*
+	 *  In the "End-of-Transfer Procedure" section for DMA RX in OMAP35x TRM
+	 *  it mentions reducing DMA transfer length by one element in master
+	 *  normal mode.
+	 */
 	if (mcspi->fifo_depth == 0)
 		dma_count -= es;
 
@@ -478,6 +483,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
+		/*
+		 *  Reduce DMA transfer length by one more if McSPI is
+		 *  configured in turbo mode.
+		 */
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
 			dma_count -= es;
 
@@ -507,6 +516,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	if (mcspi->fifo_depth > 0)
 		return count;
 
+	/*
+	 *  Due to the DMA transfer length reduction the missing bytes must
+	 *  be read manually to receive all of the expected data.
+	 */
 	omap2_mcspi_set_enable(spi, 0);
 
 	elements = element_count - 1;
-- 
1.9.1
