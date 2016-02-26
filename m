From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function" to the spi tree
Date: Fri, 26 Feb 2016 11:47:57 +0900
Message-ID: <E1aZ8Rh-0006YP-8F@finisterre>
References: <1455715739-25161-12-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-12-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function

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

>From b03c3884ca8c5ad3e6d14af6c8df0e3650c67482 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Wed, 24 Feb 2016 09:20:32 +0100
Subject: [PATCH] spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function

Now that the config function knows whether we are doing DMA or not we
can do the necessary register setup in the config function and no longer
have to do this in the trigger function. With this the trigger function
becomes a no-op for DMA, so instead of testing if we are doing DMA or
not in the trigger function we simply no longer call it in the DMA case.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 96e32d409820..91890b2d0978 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -106,7 +106,6 @@ struct spi_imx_data {
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
 	/* DMA */
-	unsigned int dma_finished;
 	bool usedma;
 	u32 wml;
 	struct completion dma_rx_completion;
@@ -324,14 +323,10 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
 
 static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
-	u32 reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	u32 reg;
 
-	if (!spi_imx->usedma)
-		reg |= MX51_ECSPI_CTRL_XCH;
-	else if (!spi_imx->dma_finished)
-		reg |= MX51_ECSPI_CTRL_SMC;
-	else
-		reg &= ~MX51_ECSPI_CTRL_SMC;
+	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	reg |= MX51_ECSPI_CTRL_XCH;
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
@@ -371,6 +366,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
+	if (spi_imx->usedma)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+
 	/* CTRL register always go first to bring out controller from reset */
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -1012,9 +1010,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_rx_completion);
 	reinit_completion(&spi_imx->dma_tx_completion);
 
-	/* Trigger the cspi module. */
-	spi_imx->dma_finished = 0;
-
 	/*
 	 * Set these order to avoid potential RX overflow. The overflow may
 	 * happen if we enable SPI HW before starting RX DMA due to rescheduling
@@ -1025,7 +1020,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	 */
 	dma_async_issue_pending(master->dma_rx);
 	dma_async_issue_pending(master->dma_tx);
-	spi_imx->devtype_data->trigger(spi_imx);
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
@@ -1046,9 +1040,6 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		}
 	}
 
-	spi_imx->dma_finished = 1;
-	spi_imx->devtype_data->trigger(spi_imx);
-
 	if (!timeout)
 		ret = -ETIMEDOUT;
 	else
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
