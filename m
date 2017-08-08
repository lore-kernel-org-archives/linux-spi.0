From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Add completion timeout" to the spi tree
Date: Tue, 08 Aug 2017 12:18:35 +0100
Message-ID: <E1df2Wx-0006Ox-Nn@finisterre>
References: <1501224781-19519-4-git-send-email-varada@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-4-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Add completion timeout

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

>From 5f13fd60b1e709b9387877b0b65d605df9fff1d6 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:50 +0530
Subject: [PATCH] spi: qup: Add completion timeout

Add i/o completion timeout for DMA and PIO modes.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index abe799bbc67f..fdd34c3ce426 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -331,8 +331,10 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
+	struct spi_qup *qup = spi_master_get_devdata(master);
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
 	int ret;
 
@@ -357,10 +359,14 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 		dma_async_issue_pending(master->dma_tx);
 	}
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -379,6 +385,9 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
 
 	spi_qup_fifo_write(qup, xfer);
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
@@ -632,9 +641,9 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
 	if (spi_qup_is_dma_xfer(controller->mode))
-		ret = spi_qup_do_dma(master, xfer);
+		ret = spi_qup_do_dma(master, xfer, timeout);
 	else
-		ret = spi_qup_do_pio(master, xfer);
+		ret = spi_qup_do_pio(master, xfer, timeout);
 
 	if (ret)
 		goto exit;
-- 
2.13.2
