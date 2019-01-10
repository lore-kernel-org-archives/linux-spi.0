From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 2/2] spi: spi-geni-qcom: Get rid of forward declaration
Date: Thu, 10 Jan 2019 13:02:53 -0800
Message-ID: <20190110210253.23219-2-swboyd@chromium.org>
References: <20190110210253.23219-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110210253.23219-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We don't need this forward declaration. Move the function to where it
needed so we can drop it and shave some lines of code.

CC: Girish Mahadevan <girishm@codeaurora.org>
CC: Dilip Kota <dkota@codeaurora.org>
CC: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
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
Sent by a computer through tubes
