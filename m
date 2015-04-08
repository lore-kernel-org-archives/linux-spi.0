From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v2 5/5] spi: bcm-mspi: Add support to set serial baud clock rate
Date: Wed, 8 Apr 2015 11:04:35 -0700
Message-ID: <1428516275-12819-6-git-send-email-jonathar@broadcom.com>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Richardson <jonathar@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, Rafal Milecki <zajec5@gmail.com>
To: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The driver wasn't setting the SPBR (serial clock baud rate) which caused
it to run at the slowest speed possible. The driver now calculates the
SPBR based on the reference clock frequency resulting in much faster
SPI transfers.

Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/spi/spi-bcm-mspi.c |   50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/spi/spi-bcm-mspi.c b/drivers/spi/spi-bcm-mspi.c
index 32bb1f0..9320de9 100644
--- a/drivers/spi/spi-bcm-mspi.c
+++ b/drivers/spi/spi-bcm-mspi.c
@@ -18,10 +18,15 @@
 #include <linux/bcma/bcma.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
+#include <linux/clk.h>
 
 #include "spi-bcm-mspi.h"
 
 #define BCM_MSPI_MAX_SPI_BAUD   13500000	/* 216 MHz? */
+#define SPBR_MIN                8U
+#define SPBR_MAX                255U
+#define MSPI_SPCR0_LSB_OFFSET   0x200
+#define MSPI_SPCR0_LSB_SHIFT    0
 
 /* The longest observed required wait was 19 ms */
 #define BCM_MSPI_SPE_TIMEOUT_MS 80
@@ -33,7 +38,9 @@ struct bcm_mspi {
 
 	void __iomem *base;
 	struct spi_master *master;
+	struct clk *clk;
 	size_t read_offset;
+	u32    spbr;
 
 	void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 value);
 	u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
@@ -45,6 +52,15 @@ static inline unsigned int bcm_mspi_calc_timeout(size_t len)
 	return (len * 9000 / BCM_MSPI_MAX_SPI_BAUD * 110 / 100) + 1;
 }
 
+static void bcm_mspi_hw_init(struct bcm_mspi *mspi)
+{
+	/* Set SPBR (serial clock baud rate). */
+	if (mspi->spbr) {
+		mspi->mspi_write(mspi, MSPI_SPCR0_LSB_OFFSET,
+			mspi->spbr << MSPI_SPCR0_LSB_SHIFT);
+	}
+}
+
 static int bcm_mspi_wait(struct bcm_mspi *mspi, unsigned int timeout_ms)
 {
 	unsigned long deadline;
@@ -222,6 +238,7 @@ static struct bcm_mspi *bcm_mspi_init(struct device *dev)
 {
 	struct bcm_mspi *data;
 	struct spi_master *master;
+	u32 desired_rate;
 
 	master = spi_alloc_master(dev, sizeof(*data));
 	if (!master) {
@@ -236,6 +253,33 @@ static struct bcm_mspi *bcm_mspi_init(struct device *dev)
 	master->dev.of_node = dev->of_node;
 	master->transfer_one = bcm_mspi_transfer_one;
 
+	/*
+	 * Enable clock if provided. The frequency can be changed by setting
+	 * SPBR (serial clock baud rate) based on the desired 'clock-frequency'.
+	 *
+	 * Baud rate is calculated as: mspi_clk / (2 * SPBR) where SPBR is a
+	 * value between 1-255. If not set then it is left at the h/w default.
+	 */
+	data->clk = devm_clk_get(dev, "mspi_clk");
+	if (!IS_ERR(data->clk)) {
+		int ret = clk_prepare_enable(data->clk);
+
+		if (ret < 0) {
+			dev_err(dev, "failed to enable clock: %d\n", ret);
+			return 0;
+		}
+
+		/* Calculate SPBR if clock-frequency provided. */
+		if (of_property_read_u32(dev->of_node, "clock-frequency",
+			&desired_rate) >= 0) {
+			u32 spbr = clk_get_rate(data->clk) / (2 * desired_rate);
+
+			if (spbr > 0)
+				data->spbr = clamp_val(spbr, SPBR_MIN,
+					SPBR_MAX);
+		}
+	}
+
 	return data;
 }
 
@@ -287,6 +331,9 @@ static int bcm_mspi_probe(struct platform_device *pdev)
 	data->mspi_write = bcm_mspi_write;
 	platform_set_drvdata(pdev, data);
 
+	/* Initialize SPI controller. */
+	bcm_mspi_hw_init(data);
+
 	err = devm_spi_register_master(dev, data->master);
 	if (err)
 		goto out;
@@ -362,6 +409,9 @@ static int bcm_mspi_bcma_probe(struct bcma_device *core)
 
 	bcma_set_drvdata(core, data);
 
+	/* Initialize SPI controller. */
+	bcm_mspi_hw_init(data);
+
 	err = devm_spi_register_master(&core->dev, data->master);
 	if (err) {
 		spi_master_put(data->master);
-- 
1.7.9.5
