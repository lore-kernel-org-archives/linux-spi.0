From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: Choose correct pre-scaler limit based on SOC" to the spi tree
Date: Fri, 24 Jul 2015 18:29:20 +0100
Message-ID: <E1ZIgme-0001J7-KG@debutante>
References: <1436903127-6777-3-git-send-email-fcooper@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436903127-6777-3-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: Choose correct pre-scaler limit based on SOC

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

>From fa466c91970a0207d9384016cc7884a7f61834b6 Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Wed, 22 Jul 2015 07:32:22 -0500
Subject: [PATCH] spi: davinci: Choose correct pre-scaler limit based on SOC

Currently the pre-scaler limit is incorrect. The value differs slightly
for various devices so a single value can't be used. Using the compatible
field select the correct pre-scaler limit.

Add new compatible field value for Keystone devices to support their
unique pre-scaler limit value.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-davinci.txt        |  2 +
 drivers/spi/spi-davinci.c                          | 43 ++++++++++++++++++----
 include/linux/platform_data/spi-davinci.h          |  1 +
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 12ecfe9e3599..d1e914adcf6e 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -12,6 +12,8 @@ Required properties:
 - compatible:
 	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
 	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
+	- "ti,keystone-spi" for SPI used similar to that on Keystone2 SoC
+		family
 - reg: Offset and length of SPI controller register space
 - num-cs: Number of chip selects. This includes internal as well as
 	GPIO chip selects.
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b4605c4158f4..3cf9faa6cc3f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -139,6 +139,8 @@ struct davinci_spi {
 	u32			(*get_tx)(struct davinci_spi *);
 
 	u8			*bytes_per_word;
+
+	u8			prescaler_limit;
 };
 
 static struct davinci_spi_config davinci_spi_default_cfg;
@@ -266,7 +268,7 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 	/* Subtract 1 to match what will be programmed into SPI register. */
 	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz) - 1;
 
-	if (ret < 0 || ret > 255)
+	if (ret < dspi->prescaler_limit || ret > 255)
 		return -EINVAL;
 
 	return ret;
@@ -833,13 +835,40 @@ rx_dma_failed:
 }
 
 #if defined(CONFIG_OF)
+
+/* OF SPI data structure */
+struct davinci_spi_of_data {
+	u8	version;
+	u8	prescaler_limit;
+};
+
+static const struct davinci_spi_of_data dm6441_spi_data = {
+	.version = SPI_VERSION_1,
+	.prescaler_limit = 2,
+};
+
+static const struct davinci_spi_of_data da830_spi_data = {
+	.version = SPI_VERSION_2,
+	.prescaler_limit = 2,
+};
+
+static const struct davinci_spi_of_data keystone_spi_data = {
+	.version = SPI_VERSION_1,
+	.prescaler_limit = 0,
+};
+
 static const struct of_device_id davinci_spi_of_match[] = {
 	{
 		.compatible = "ti,dm6441-spi",
+		.data = &dm6441_spi_data,
 	},
 	{
 		.compatible = "ti,da830-spi",
-		.data = (void *)SPI_VERSION_2,
+		.data = &da830_spi_data,
+	},
+	{
+		.compatible = "ti,keystone-spi",
+		.data = &keystone_spi_data,
 	},
 	{ },
 };
@@ -858,21 +887,21 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 			struct davinci_spi *dspi)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct davinci_spi_of_data *spi_data;
 	struct davinci_spi_platform_data *pdata;
 	unsigned int num_cs, intr_line = 0;
 	const struct of_device_id *match;
 
 	pdata = &dspi->pdata;
 
-	pdata->version = SPI_VERSION_1;
 	match = of_match_device(davinci_spi_of_match, &pdev->dev);
 	if (!match)
 		return -ENODEV;
 
-	/* match data has the SPI version number for SPI_VERSION_2 */
-	if (match->data == (void *)SPI_VERSION_2)
-		pdata->version = SPI_VERSION_2;
+	spi_data = (struct davinci_spi_of_data *)match->data;
 
+	pdata->version = spi_data->version;
+	pdata->prescaler_limit = spi_data->prescaler_limit;
 	/*
 	 * default num_cs is 1 and all chipsel are internal to the chip
 	 * indicated by chip_sel being NULL or cs_gpios being NULL or
@@ -992,7 +1021,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-
+	dspi->prescaler_limit = pdata->prescaler_limit;
 	dspi->version = pdata->version;
 
 	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
diff --git a/include/linux/platform_data/spi-davinci.h b/include/linux/platform_data/spi-davinci.h
index 8dc2fa47a2aa..f4edcb03c40c 100644
--- a/include/linux/platform_data/spi-davinci.h
+++ b/include/linux/platform_data/spi-davinci.h
@@ -49,6 +49,7 @@ struct davinci_spi_platform_data {
 	u8			num_chipselect;
 	u8			intr_line;
 	u8			*chip_sel;
+	u8			prescaler_limit;
 	bool			cshold_bug;
 	enum dma_event_q	dma_event_q;
 };
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
