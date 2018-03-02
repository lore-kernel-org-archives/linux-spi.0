From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix scatterlist elements size in spi_map_buf" to the spi tree
Date: Fri, 02 Mar 2018 18:02:03 +0000
Message-ID: <E1erp0N-0005Fv-JL@debutante>
References: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-spi@vger.kernel.org
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix scatterlist elements size in spi_map_buf

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From ce99319a182fe766be67f96338386f3ec73e321c Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 2 Mar 2018 15:55:09 +0100
Subject: [PATCH] spi: Fix scatterlist elements size in spi_map_buf

When SPI transfers can be offloaded using DMA, the SPI core need to
build a scatterlist to make sure that the buffer to be transferred is
dma-able.

This patch fixes the scatterlist entry size computation in the case
where the maximum acceptable scatterlist entry supported by the DMA
controller is less than PAGE_SIZE, when the buffer is vmalloced.

For each entry, the actual size is given by the minimum between the
desc_len (which is the max buffer size supported by the DMA controller)
and the remaining buffer length until we cross a page boundary.

Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..4153f959f28c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -779,8 +779,14 @@ static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
-			min = min_t(size_t,
-				    len, desc_len - offset_in_page(buf));
+			/*
+			 * Next scatterlist entry size is the minimum between
+			 * the desc_len and the remaining buffer length that
+			 * fits in a page.
+			 */
+			min = min_t(size_t, desc_len,
+				    min_t(size_t, len,
+					  PAGE_SIZE - offset_in_page(buf)));
 			if (vmalloced_buf)
 				vm_page = vmalloc_to_page(buf);
 			else
-- 
2.16.2
