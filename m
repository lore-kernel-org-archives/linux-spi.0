From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dspi: clear SPI_SR before enable interrupt" to the spi tree
Date: Sat, 29 Oct 2016 12:51:42 -0600
Message-ID: <E1c0YjG-0000KD-Cx@finisterre>
References: <1476698554-12150-1-git-send-email-yao.yuan@freescale.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        yao.yuan-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476698554-12150-1-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dspi: clear SPI_SR before enable interrupt

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

>From 5ee67b587a2b0092bdea3123349c8c3c43e8e46e Mon Sep 17 00:00:00 2001
From: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Date: Mon, 17 Oct 2016 18:02:34 +0800
Subject: [PATCH] spi: dspi: clear SPI_SR before enable interrupt

Once dspi is used in uboot, the SPI_SR have been set by some value.
At this time, if kernel enable the interrupt before clear the
status flag, that will trigger the wrong interrupt.

Signed-off-by: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 35c0dd945668..a67b0ff6a362 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -70,6 +70,7 @@
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
+#define SPI_SR_CLEAR		0xdaad0000
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
@@ -646,6 +647,11 @@ static const struct regmap_config dspi_regmap_config = {
 	.max_register = 0x88,
 };
 
+static void dspi_init(struct fsl_dspi *dspi)
+{
+	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -709,6 +715,7 @@ static int dspi_probe(struct platform_device *pdev)
 		return PTR_ERR(dspi->regmap);
 	}
 
+	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
 		dev_err(&pdev->dev, "can't get platform irq\n");
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
