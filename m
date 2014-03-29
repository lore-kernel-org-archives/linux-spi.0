From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: bitbang: Make spi_bitbang_stop() return void
Date: Sat, 29 Mar 2014 08:02:13 +0800
Message-ID: <1396051333.18624.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_bitbang_stop() never fails, so make it return void.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bitbang.c       | 4 +---
 drivers/spi/spi-gpio.c          | 5 ++---
 drivers/spi/spi-omap-uwire.c    | 5 ++---
 include/linux/spi/spi_bitbang.h | 2 +-
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 3bfdb85..dc7d2c2 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -466,11 +466,9 @@ EXPORT_SYMBOL_GPL(spi_bitbang_start);
 /**
  * spi_bitbang_stop - stops the task providing spi communication
  */
-int spi_bitbang_stop(struct spi_bitbang *bitbang)
+void spi_bitbang_stop(struct spi_bitbang *bitbang)
 {
 	spi_unregister_master(bitbang->master);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_stop);
 
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 406bbd7..0982307 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -502,13 +502,12 @@ static int spi_gpio_remove(struct platform_device *pdev)
 {
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
-	int				status;
 
 	spi_gpio = platform_get_drvdata(pdev);
 	pdata = dev_get_platdata(&pdev->dev);
 
 	/* stop() unregisters child devices too */
-	status = spi_bitbang_stop(&spi_gpio->bitbang);
+	spi_bitbang_stop(&spi_gpio->bitbang);
 
 	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
 		gpio_free(SPI_MISO_GPIO);
@@ -517,7 +516,7 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	gpio_free(SPI_SCK_GPIO);
 	spi_master_put(spi_gpio->bitbang.master);
 
-	return status;
+	return 0;
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 31ce92f..be2a2e1 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -516,14 +516,13 @@ static int uwire_probe(struct platform_device *pdev)
 static int uwire_remove(struct platform_device *pdev)
 {
 	struct uwire_spi	*uwire = platform_get_drvdata(pdev);
-	int			status;
 
 	// FIXME remove all child devices, somewhere ...
 
-	status = spi_bitbang_stop(&uwire->bitbang);
+	spi_bitbang_stop(&uwire->bitbang);
 	uwire_off(uwire);
 	iounmap(uwire_base);
-	return status;
+	return 0;
 }
 
 /* work with hotplug and coldplug */
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index daebaba..85578d4 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -42,6 +42,6 @@ extern int spi_bitbang_setup_transfer(struct spi_device *spi,
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);
-extern int spi_bitbang_stop(struct spi_bitbang *spi);
+extern void spi_bitbang_stop(struct spi_bitbang *spi);
 
 #endif	/* __SPI_BITBANG_H */
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
