From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: st-ssc4: Fix misuse of
 devm_gpio_request/devm_gpio_free APIs
Date: Sun, 05 Jun 2016 18:42:27 +0800
Message-ID: <1465123347.17550.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

devm_* API is supposed to be used only in probe function call.
The resource is allocated at 'probe' and free automatically at 'remove'.
Usage of devm_* functions outside probe sometimes leads to resource leak.
Thus avoid using devm_* APIs in .setup/.cleanup callbacks.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-st-ssc4.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index d5adf9f..fb6ed8b 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -201,10 +201,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 
 static void spi_st_cleanup(struct spi_device *spi)
 {
-	int cs = spi->cs_gpio;
-
-	if (gpio_is_valid(cs))
-		devm_gpio_free(&spi->dev, cs);
+	gpio_free(spi->cs_gpio);
 }
 
 /* the spi->mode bits understood by this driver: */
@@ -227,14 +224,15 @@ static int spi_st_setup(struct spi_device *spi)
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
 
@@ -243,7 +241,8 @@ static int spi_st_setup(struct spi_device *spi)
 	if (sscbrg < 0x07 || sscbrg > BIT(16)) {
 		dev_err(&spi->dev,
 			"baudrate %d outside valid range %d\n", sscbrg, hz);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free_gpio;
 	}
 
 	spi_st->baud = spi_st_clk / (2 * sscbrg);
@@ -292,6 +291,10 @@ static int spi_st_setup(struct spi_device *spi)
 	 readl_relaxed(spi_st->base + SSC_RBUF);
 
 	 return 0;
+
+out_free_gpio:
+	gpio_free(cs);
+	return ret;
 }
 
 /* Interrupt fired when TX shift register becomes empty */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
