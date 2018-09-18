From: Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 4/4] spi: spi-geni-qcom: Plugin API to assert and de-assert Chipselect
Date: Tue, 18 Sep 2018 23:37:26 +0530
Message-ID: <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Plugin set cs API to the SPI framework so that
framework can do chipselect assert de-assert
during  SPI transfers.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 949b853..5cfb4f2 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -66,6 +66,13 @@
 
 static irqreturn_t geni_spi_isr(int irq, void *data);
 
+/* SPI M_COMMAND OPCODE */
+enum spi_mcmd_code {
+	CMD_NONE,
+	CMD_XFER,
+	CMD_CS,
+};
+
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -81,8 +88,12 @@ struct spi_geni_master {
 	struct completion xfer_done;
 	unsigned int oversampling;
 	spinlock_t lock;
+	unsigned int cur_mcmd;
 };
 
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg);
+
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -113,6 +124,31 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
+	struct spi_master *spi = dev_get_drvdata(mas->dev);
+	struct geni_se *se = &mas->se;
+	unsigned long timeout;
+
+	reinit_completion(&mas->xfer_done);
+	pm_runtime_get_sync(mas->dev);
+	if (!(slv->mode & SPI_CS_HIGH))
+		set_flag = !set_flag;
+
+	mas->cur_mcmd = CMD_CS;
+	if (set_flag)
+		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
+	else
+		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
+
+	timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!timeout)
+		handle_fifo_timeout(spi, NULL);
+
+	pm_runtime_put(mas->dev);
+}
+
 static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 					unsigned int bits_per_word)
 {
@@ -249,7 +285,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 				struct spi_geni_master *mas,
 				u16 mode, struct spi_master *spi)
 {
-	u32 m_cmd = 0, m_param = 0;
+	u32 m_cmd = 0;
 	u32 spi_tx_cfg, trans_len;
 	struct geni_se *se = &mas->se;
 
@@ -305,21 +341,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		trans_len = (xfer->len / bytes_per_word) & TRANS_LEN_MSK;
 	}
 
-	/*
-	 * If CS change flag is set, then toggle the CS line in between
-	 * transfers and keep CS asserted after the last transfer.
-	 * Else if keep CS flag asserted in between transfers and de-assert
-	 * CS after the last message.
-	 */
-	if (xfer->cs_change) {
-		if (list_is_last(&xfer->transfer_list,
-				&spi->cur_msg->transfers))
-			m_param = FRAGMENTATION;
-	} else {
-		if (!list_is_last(&xfer->transfer_list,
-				&spi->cur_msg->transfers))
-			m_param = FRAGMENTATION;
-	}
+
 
 	mas->cur_xfer = xfer;
 	if (m_cmd & SPI_TX_ONLY) {
@@ -332,8 +354,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		mas->rx_rem_bytes = xfer->len;
 	}
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
-	geni_se_setup_m_cmd(se, m_cmd, m_param);
-
+	mas->cur_mcmd = CMD_XFER;
+	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
 	/*
 	 * TX_WATERMARK_REG should be set after SPI configuration and
 	 * setting up GENI SE engine, as driver starts data transfer
@@ -489,7 +511,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		ret = geni_spi_handle_tx(mas);
 
 	if (m_irq & M_CMD_DONE_EN) {
-		spi_finalize_current_transfer(spi);
+		if (mas->cur_mcmd == CMD_XFER)
+			spi_finalize_current_transfer(spi);
+		else if (mas->cur_mcmd == CMD_CS)
+			complete(&mas->xfer_done);
+		mas->cur_mcmd = CMD_NONE;
 		/*
 		 * If this happens, then a CMD_DONE came before all the Tx
 		 * buffer bytes were sent out. This is unusual, log this
@@ -572,6 +598,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->transfer_one = spi_geni_transfer_one;
 	spi->auto_runtime_pm = true;
 	spi->handle_err = handle_fifo_timeout;
+	spi->set_cs = spi_geni_set_cs;
 
 	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
