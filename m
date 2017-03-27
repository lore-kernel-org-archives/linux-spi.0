From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ti-qspi: Remove unused dma_dev variable" to the spi tree
Date: Mon, 27 Mar 2017 12:32:26 +0100
Message-ID: <E1csSss-0000vl-I3@debutante>
References: <20170327052928.21236-1-vigneshr@ti.com>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327052928.21236-1-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ti-qspi: Remove unused dma_dev variable

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

>From cb3c8e5ade3f01839ce0a9388ddc9729de4e2d6d Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Date: Mon, 27 Mar 2017 10:59:28 +0530
Subject: [PATCH] spi: spi-ti-qspi: Remove unused dma_dev variable

commit 1351aaeb50b2 ("spi: spi-ti-qspi: Use dma_engine wrapper for dma
memcpy call") introduced this warning:

drivers/spi/spi-ti-qspi.c: In function 'ti_qspi_dma_xfer':
drivers/spi/spi-ti-qspi.c:398:21: warning: unused variable 'dma_dev' [-Wunused-variable]
  struct dma_device *dma_dev = chan->device;

Fix it by removing the unused variable.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index bd19a20a122e..804914ebfd9d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -395,7 +395,6 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 			    dma_addr_t dma_src, size_t len)
 {
 	struct dma_chan *chan = qspi->rx_chan;
-	struct dma_device *dma_dev = chan->device;
 	dma_cookie_t cookie;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct dma_async_tx_descriptor *tx;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
