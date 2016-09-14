From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: st-ssc4: Fix misuse of devm_gpio_request/devm_gpio_free APIs" to the spi tree
Date: Wed, 14 Sep 2016 18:17:01 +0100
Message-ID: <E1bkDnx-00022F-8T@debutante>
References: <1465123347.17550.1.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465123347.17550.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: st-ssc4: Fix misuse of devm_gpio_request/devm_gpio_free APIs

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

>From 42531686639d6a3fe49518f2baca3f7256708242 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sun, 5 Jun 2016 18:42:27 +0800
Subject: [PATCH] spi: st-ssc4: Fix misuse of devm_gpio_request/devm_gpio_free
 APIs

devm_* API is supposed to be used only in probe function call.
The resource is allocated at 'probe' and free automatically at 'remove'.
Usage of devm_* functions outside probe sometimes leads to resource leak.
Thus avoid using devm_* APIs in .setup/.cleanup callbacks.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index a56eca0e95a6..e54b59638458 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -175,10 +175,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 
 static void spi_st_cleanup(struct spi_device *spi)
 {
-	int cs = spi->cs_gpio;
-
-	if (gpio_is_valid(cs))
-		devm_gpio_free(&spi->dev, cs);
+	gpio_free(spi->cs_gpio);
 }
 
 /* the spi->mode bits understood by this driver: */
@@ -201,14 +198,15 @@ static int spi_st_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	if (devm_gpio_request(&spi->dev, cs, dev_name(&spi->dev))) {
+	ret = gpio_request(cs, dev_name(&spi->dev));
+	if (ret) {
 		dev_err(&spi->dev, "could not request gpio:%d\n", cs);
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = gpio_direction_output(cs, spi->mode & SPI_CS_HIGH);
 	if (ret)
-		return ret;
+		goto out_free_gpio;
 
 	spi_st_clk = clk_get_rate(spi_st->clk);
 
@@ -217,7 +215,8 @@ static int spi_st_setup(struct spi_device *spi)
 	if (sscbrg < 0x07 || sscbrg > BIT(16)) {
 		dev_err(&spi->dev,
 			"baudrate %d outside valid range %d\n", sscbrg, hz);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free_gpio;
 	}
 
 	spi_st->baud = spi_st_clk / (2 * sscbrg);
@@ -266,6 +265,10 @@ static int spi_st_setup(struct spi_device *spi)
 	 readl_relaxed(spi_st->base + SSC_RBUF);
 
 	 return 0;
+
+out_free_gpio:
+	gpio_free(cs);
+	return ret;
 }
 
 /* Interrupt fired when TX shift register becomes empty */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
