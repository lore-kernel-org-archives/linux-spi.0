From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 4/4] spi: qup: Add support for v1.1.1
Date: Tue, 13 May 2014 16:34:44 -0500
Message-ID: <1400016884-9568-5-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400016884-9568-1-git-send-email-agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds support for v1.1.1 of the SPI QUP controller.

Signed-off-by: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index b518b51..abad630 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -144,6 +144,7 @@ struct spi_qup {
 	int			w_size;	/* bytes per SPI word */
 	int			tx_bytes;
 	int			rx_bytes;
+	int			qup_v1;
 };
 
 
@@ -422,7 +423,9 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	config |= QUP_CONFIG_SPI_MODE;
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 
-	writel_relaxed(0, controller->base + QUP_OPERATIONAL_MASK);
+	/* only write to OPERATIONAL_MASK when register is present */
+	if (!controller->qup_v1)
+		writel_relaxed(0, controller->base + QUP_OPERATIONAL_MASK);
 	return 0;
 }
 
@@ -488,7 +491,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev;
 	void __iomem *base;
-	u32 data, max_freq, iomode;
+	u32 data = 0, max_freq, iomode;
 	int ret, irq, size;
 
 	dev = &pdev->dev;
@@ -531,15 +534,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data = readl_relaxed(base + QUP_HW_VERSION);
-
-	if (data < QUP_HW_VERSION_2_1_1) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
-		dev_err(dev, "v.%08x is not supported\n", data);
-		return -ENXIO;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
 		clk_disable_unprepare(cclk);
@@ -567,6 +561,10 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->cclk = cclk;
 	controller->irq = irq;
 
+	/* set v1 flag if device is version 1 */
+	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
+		controller->qup_v1 = 1;
+
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
@@ -604,10 +602,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
 	writel_relaxed(0, base + QUP_IO_M_MODES);
-	writel_relaxed(0, base + QUP_OPERATIONAL_MASK);
+
+	if (!controller->qup_v1)
+		writel_relaxed(0, base + QUP_OPERATIONAL_MASK);
+
 	writel_relaxed(SPI_ERROR_CLK_UNDER_RUN | SPI_ERROR_CLK_OVER_RUN,
 		       base + SPI_ERROR_FLAGS_EN);
 
+	/* if earlier version of the QUP, disable INPUT_OVERRUN */
+	if (controller->qup_v1)
+		writel_relaxed(QUP_ERROR_OUTPUT_OVER_RUN |
+			QUP_ERROR_INPUT_UNDER_RUN | QUP_ERROR_OUTPUT_UNDER_RUN,
+			base + QUP_ERROR_FLAGS_EN);
+
 	writel_relaxed(0, base + SPI_CONFIG);
 	writel_relaxed(SPI_IO_C_NO_TRI_STATE, base + SPI_IO_CONTROL);
 
@@ -729,6 +736,7 @@ static int spi_qup_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id spi_qup_dt_match[] = {
+	{ .compatible = "qcom,spi-qup-v1.1.1", },
 	{ .compatible = "qcom,spi-qup-v2.1.1", },
 	{ .compatible = "qcom,spi-qup-v2.2.1", },
 	{ }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
