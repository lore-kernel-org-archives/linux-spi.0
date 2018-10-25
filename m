From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 1/2] spi: spi-geni-qcom: fix nitpicks
Date: Thu, 25 Oct 2018 22:10:28 +0530
Message-ID: <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

fixed the nitpicks.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6432ecc..d1830fb 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -64,15 +64,13 @@
 #define TIMESTAMP_AFTER		BIT(3)
 #define POST_CMD_DELAY		BIT(4)
 
-/* SPI M_COMMAND OPCODE */
-enum spi_mcmd_code {
+enum spi_m_cmd_opcode {
 	CMD_NONE,
 	CMD_XFER,
 	CMD_CS,
 	CMD_CANCEL,
 };
 
-
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -87,7 +85,7 @@ struct spi_geni_master {
 	struct completion xfer_done;
 	unsigned int oversampling;
 	spinlock_t lock;
-	unsigned int cur_mcmd;
+	enum spi_m_cmd_opcode cur_mcmd;
 	int irq;
 };
 
@@ -129,7 +127,7 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
 	struct spi_master *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
-	unsigned long timeout;
+	unsigned long time_left;
 
 	reinit_completion(&mas->xfer_done);
 	pm_runtime_get_sync(mas->dev);
@@ -142,8 +140,8 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
 
-	timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (!timeout)
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!time_left)
 		handle_fifo_timeout(spi, NULL);
 
 	pm_runtime_put(mas->dev);
@@ -485,7 +483,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
 	unsigned long flags;
-	irqreturn_t ret = IRQ_HANDLED;
 
 	if (mas->cur_mcmd == CMD_NONE)
 		return IRQ_NONE;
@@ -533,7 +530,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
 	spin_unlock_irqrestore(&mas->lock, flags);
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static int spi_geni_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
