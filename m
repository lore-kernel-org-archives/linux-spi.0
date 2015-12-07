From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: reorder HW operations enable order to avoid possible RX data loss" to the spi tree
Date: Mon, 07 Dec 2015 19:54:16 +0000
Message-ID: <E1a61rU-0003cM-Jc@debutante>
References: <1449334629-4715-3-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449334629-4715-3-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: reorder HW operations enable order to avoid possible RX data loss

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

>From fab44ef1adcc585440c07c90539e2b9e2cded4bf Mon Sep 17 00:00:00 2001
From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 5 Dec 2015 17:57:00 +0100
Subject: [PATCH] spi: imx: reorder HW operations enable order to avoid
 possible RX data loss

The overflow may happen due to rescheduling for another task and/or interrupt
if we enable SPI HW before starting RX DMA. So RX DMA enabled first to make
sure data would be read out from FIFO ASAP. TX DMA enabled next to start
filling TX FIFO with new data. And finaly SPI HW enabled to start actual
data transfer.

The risk rise in case of heavy system load and high SPI clock.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d6dc66542811..e6b1c74ade6b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -956,10 +956,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	if (left)
 		writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
 				spi_imx->base + MX51_ECSPI_DMA);
+	/*
+	 * Set these order to avoid potential RX overflow. The overflow may
+	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
+	 * for another task and/or interrupt.
+	 * So RX DMA enabled first to make sure data would be read out from FIFO
+	 * ASAP. TX DMA enabled next to start filling TX FIFO with new data.
+	 * And finaly SPI HW enabled to start actual data transfer.
+	 */
+	dma_async_issue_pending(master->dma_rx);
+	dma_async_issue_pending(master->dma_tx);
 	spi_imx->devtype_data->trigger(spi_imx);
 
-	dma_async_issue_pending(master->dma_tx);
-	dma_async_issue_pending(master->dma_rx);
 	/* Wait SDMA to finish the data transfer.*/
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
 						IMX_DMA_TIMEOUT);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
