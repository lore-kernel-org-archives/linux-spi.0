From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Place the QUP in run mode before DMA" to the spi tree
Date: Tue, 08 Aug 2017 12:18:31 +0100
Message-ID: <E1df2Wt-0006Nu-RE@finisterre>
References: <1500882445-29008-5-git-send-email-varada@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500882445-29008-5-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Place the QUP in run mode before DMA

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

>From ce00bab3187f9fc1afac07914959bff0c52547c2 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:51 +0530
Subject: [PATCH] spi: qup: Place the QUP in run mode before DMA

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index fdd34c3ce426..f1aa5c15d180 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -343,6 +343,14 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	else if (xfer->tx_buf)
 		tx_done = spi_qup_dma_done;
 
+	/* before issuing the descriptors, set the QUP to run */
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
+				__func__, __LINE__);
+		return ret;
+	}
+
 	if (xfer->rx_buf) {
 		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM, rx_done);
 		if (ret)
@@ -385,6 +393,13 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 
 	spi_qup_fifo_write(qup, xfer);
 
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
+				__func__, __LINE__);
+		return ret;
+	}
+
 	if (!wait_for_completion_timeout(&qup->done, timeout))
 		return -ETIMEDOUT;
 
-- 
2.13.2
