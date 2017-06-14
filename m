From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 01/18] spi: qup: Enable chip select support
Date: Wed, 14 Jun 2017 11:22:14 +0530
Message-ID: <1497419551-21834-2-git-send-email-varada@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Enable chip select support for QUP versions later than v1

Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1bfa889..c0d4def 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -750,6 +750,24 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	return ret;
 }
 
+static void spi_qup_set_cs(struct spi_device *spi, bool val)
+{
+	struct spi_qup *controller;
+	u32 spi_ioc;
+	u32 spi_ioc_orig;
+
+	controller = spi_master_get_devdata(spi->master);
+	spi_ioc = readl_relaxed(controller->base + SPI_IO_CONTROL);
+	spi_ioc_orig = spi_ioc;
+	if (!val)
+		spi_ioc |= SPI_IO_C_FORCE_CS;
+	else
+		spi_ioc &= ~SPI_IO_C_FORCE_CS;
+
+	if (spi_ioc != spi_ioc_orig)
+		writel_relaxed(spi_ioc, controller->base + SPI_IO_CONTROL);
+}
+
 static int spi_qup_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -846,6 +864,9 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
 		controller->qup_v1 = 1;
 
+	if (!controller->qup_v1)
+		master->set_cs = spi_qup_set_cs;
+
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
