From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap2-mcspi: Add comments for RX only DMA buffer workaround" to the spi tree
Date: Tue, 05 Jul 2016 16:50:31 +0200
Message-ID: <E1bKRgF-000673-R0@finisterre>
References: <1466203513-4771-3-git-send-email-fcooper@ti.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	david.s.gordon@intel.com, akpm@linux-foundation.org,
	nsekhar@ti.com, vigneshr@ti.com, peter.ujfalusi@ti.com,
	linux-spi@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466203513-4771-3-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: omap2-mcspi: Add comments for RX only DMA buffer workaround

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4bd00413cde851d84b297c1b0dae15109025e84b Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper@ti.com>
Date: Mon, 27 Jun 2016 09:54:08 -0500
Subject: [PATCH] spi: omap2-mcspi: Add comments for RX only DMA buffer
 workaround

OMAP35x and OMAP37x mentions in the McSPI End-of-Transfer Sequences section
that if the McSPI is configured as a Master and only DMA RX is being
performed then the DMA transfer size needs to be reduced by 1 or 2.

This was originally implemented by:
commit 57c5c28dbc83 ("spi: omap2_mcspi rxdma bugfix")

This patch adds comments to clarify what is going on in the code since its
not obvious what problem its addressing.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1d237e93a289..c47f95879833 100644
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
2.8.1
