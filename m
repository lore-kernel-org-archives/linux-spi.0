From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: call io_config in mode specific function" to the spi tree
Date: Tue, 08 Aug 2017 12:18:13 +0100
Message-ID: <E1df2Wb-0006If-0G@finisterre>
References: <1501224781-19519-10-git-send-email-varada@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Matthew McClintock <mmcclint@codeaurora.org>,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-10-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: call io_config in mode specific function

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

>From 3b5ea2c981dd470882bdc83e548dd15a942dbf4d Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:56 +0530
Subject: [PATCH] spi: qup: call io_config in mode specific function

DMA transactions should only only need to call io_config only once, but
block mode might call it several times to setup several transactions so
it can handle reads/writes larger than the max size per transaction, so
we move the call to the do_ functions.

This is just refactoring, there should be no functional change

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ff5aa08b5725..1aa60785bf98 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -156,6 +156,8 @@ struct spi_qup {
 	struct dma_slave_config	tx_conf;
 };
 
+static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer);
+
 static inline bool spi_qup_is_flag_set(struct spi_qup *controller, u32 flag)
 {
 	u32 opflag = readl_relaxed(controller->base + QUP_OPERATIONAL);
@@ -417,11 +419,12 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
+	struct spi_master *master = spi->master;
+	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
 	if (xfer->rx_buf)
@@ -429,6 +432,10 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	else if (xfer->tx_buf)
 		tx_done = spi_qup_dma_done;
 
+	ret = spi_qup_io_config(spi, xfer);
+	if (ret)
+		return ret;
+
 	/* before issuing the descriptors, set the QUP to run */
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
@@ -459,12 +466,17 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
+	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
+	ret = spi_qup_io_config(spi, xfer);
+	if (ret)
+		return ret;
+
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
 		dev_warn(qup->dev, "cannot set RUN state\n");
@@ -742,10 +754,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (ret)
 		return ret;
 
-	ret = spi_qup_io_config(spi, xfer);
-	if (ret)
-		return ret;
-
 	timeout = DIV_ROUND_UP(xfer->speed_hz, MSEC_PER_SEC);
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
@@ -760,9 +768,9 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
 	if (spi_qup_is_dma_xfer(controller->mode))
-		ret = spi_qup_do_dma(master, xfer, timeout);
+		ret = spi_qup_do_dma(spi, xfer, timeout);
 	else
-		ret = spi_qup_do_pio(master, xfer, timeout);
+		ret = spi_qup_do_pio(spi, xfer, timeout);
 
 	if (ret)
 		goto exit;
-- 
2.13.2
