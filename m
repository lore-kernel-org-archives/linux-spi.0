From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/4] spi: bcm-mspi: Add support to set serial baud clock rate
Date: Thu, 2 Apr 2015 12:23:23 -0700
Message-ID: <1428002603-21892-5-git-send-email-jonathar@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428002603-21892-1-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver wasn't setting the SPBR (serial clock baud rate) which caused
it to run at the slowest speed possible. The driver now calculates the
SPBR based on the reference clock frequency resulting in much faster
SPI transfers.

Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-bcm-mspi.c |   48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/spi/spi-bcm-mspi.c b/drivers/spi/spi-bcm-mspi.c
index df27449..5617b5b 100644
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
@@ -221,6 +237,7 @@ static struct bcm_mspi *bcm_mspi_init(struct device *dev)
 {
 	struct bcm_mspi *data;
 	struct spi_master *master;
+	u32 desired_rate;
 
 	master = spi_alloc_master(dev, sizeof(*data));
 	if (!master) {
@@ -235,6 +252,31 @@ static struct bcm_mspi *bcm_mspi_init(struct device *dev)
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
+			data->spbr = clamp_val(spbr, SPBR_MIN, SPBR_MAX);
+		}
+	}
+
 	return data;
 }
 
@@ -286,6 +328,9 @@ static int bcm_mspi_probe(struct platform_device *pdev)
 	data->mspi_write = bcm_mspi_write;
 	platform_set_drvdata(pdev, data);
 
+	/* Initialize SPI controller. */
+	bcm_mspi_hw_init(data);
+
 	err = devm_spi_register_master(dev, data->master);
 	if (err)
 		goto out;
@@ -360,6 +405,9 @@ static int bcm_mspi_bcma_probe(struct bcma_device *core)
 	data->core = core;
 	bcma_set_drvdata(core, data);
 
+	/* Initialize SPI controller. */
+	bcm_mspi_hw_init(data);
+
 	err = devm_spi_register_master(&core->dev, data->master);
 	if (err) {
 		spi_master_put(data->master);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
