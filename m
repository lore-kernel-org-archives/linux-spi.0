From: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
Subject: [PATCH 2/4] spi: spi-ath79: Add device tree support
Date: Fri, 24 Apr 2015 16:19:22 +0200
Message-ID: <1429885164-28501-3-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alban Bedel <albeu-GANU6spQydw@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429885164-28501-1-git-send-email-albeu-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Set the OF node of the spi controller and use the generic GPIO based
chip select instead of the custom controller data. As the controller
data isn't used by any board just drop it.

Signed-off-by: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
---
 .../mips/include/asm/mach-ath79/ath79_spi_platform.h |  4 ----
 drivers/spi/spi-ath79.c                              | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
index aa2283e..aa71216 100644
--- a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
+++ b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
@@ -16,8 +16,4 @@ struct ath79_spi_platform_data {
 	unsigned	num_chipselect;
 };
 
-struct ath79_spi_controller_data {
-	unsigned	gpio;
-};
-
 #endif /* _ATH79_SPI_PLATFORM_H */
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b02eb4a..239bc31 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -79,10 +79,8 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 	}
 
 	if (spi->chip_select) {
-		struct ath79_spi_controller_data *cdata = spi->controller_data;
-
 		/* SPI is normally active-low */
-		gpio_set_value(cdata->gpio, cs_high);
+		gpio_set_value(spi->cs_gpio, cs_high);
 	} else {
 		if (cs_high)
 			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
@@ -117,11 +115,9 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 
 static int ath79_spi_setup_cs(struct spi_device *spi)
 {
-	struct ath79_spi_controller_data *cdata;
 	int status;
 
-	cdata = spi->controller_data;
-	if (spi->chip_select && !cdata)
+	if (spi->chip_select && !gpio_is_valid(spi->cs_gpio))
 		return -EINVAL;
 
 	status = 0;
@@ -134,7 +130,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 		else
 			flags |= GPIOF_INIT_HIGH;
 
-		status = gpio_request_one(cdata->gpio, flags,
+		status = gpio_request_one(spi->cs_gpio, flags,
 					  dev_name(&spi->dev));
 	}
 
@@ -144,8 +140,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 static void ath79_spi_cleanup_cs(struct spi_device *spi)
 {
 	if (spi->chip_select) {
-		struct ath79_spi_controller_data *cdata = spi->controller_data;
-		gpio_free(cdata->gpio);
+		gpio_free(spi->cs_gpio);
 	}
 }
 
@@ -217,6 +212,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	}
 
 	sp = spi_master_get_devdata(master);
+	master->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -301,12 +297,18 @@ static void ath79_spi_shutdown(struct platform_device *pdev)
 	ath79_spi_remove(pdev);
 }
 
+static const struct of_device_id ath79_spi_of_match[] = {
+	{ .compatible = "qca,ar7100-spi", },
+	{ },
+};
+
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
 	.remove		= ath79_spi_remove,
 	.shutdown	= ath79_spi_shutdown,
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = ath79_spi_of_match,
 	},
 };
 module_platform_driver(ath79_spi_driver);
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
