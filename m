From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-geni-qcom: Get rid of forward declaration" to the spi tree
Date: Mon, 14 Jan 2019 22:09:56 +0000 (GMT)
Message-ID: <20190114220956.D5D971127AD0@debutante.sirena.org.uk>
References: <20190110210253.23219-2-swboyd@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110210253.23219-2-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-geni-qcom: Get rid of forward declaration

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

>From de43affed77b1bd9f246235dbd94eb23b07ab657 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 10 Jan 2019 13:02:53 -0800
Subject: [PATCH] spi: spi-geni-qcom: Get rid of forward declaration

We don't need this forward declaration. Move the function to where it
needed so we can drop it and shave some lines of code.

CC: Girish Mahadevan <girishm@codeaurora.org>
CC: Dilip Kota <dkota@codeaurora.org>
CC: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 55 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3e9464027d4..5f0b0d5bfef4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -89,9 +89,6 @@ struct spi_geni_master {
 	int irq;
 };
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg);
-
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -122,6 +119,32 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	unsigned long time_left, flags;
+	struct geni_se *se = &mas->se;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	mas->cur_mcmd = CMD_CANCEL;
+	geni_se_cancel_m_cmd(se);
+	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (time_left)
+		return;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	geni_se_abort_m_cmd(se);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!time_left)
+		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+}
+
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
@@ -356,32 +379,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
 }
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg)
-{
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
-	unsigned long time_left, flags;
-	struct geni_se *se = &mas->se;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd = CMD_CANCEL;
-	geni_se_cancel_m_cmd(se);
-	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (time_left)
-		return;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	geni_se_abort_m_cmd(se);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (!time_left)
-		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
-}
-
 static int spi_geni_transfer_one(struct spi_master *spi,
 				struct spi_device *slv,
 				struct spi_transfer *xfer)
-- 
2.20.1
