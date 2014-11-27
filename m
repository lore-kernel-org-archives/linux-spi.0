From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] spi: cadence: Init HW after reading devicetree attributes
Date: Thu, 27 Nov 2014 16:12:17 +0100
Message-ID: <1417101138-2619-1-git-send-email-lars@metafoo.de>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Paul Cercueil <paul.cercueil-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Paul Cercueil <paul.cercueil-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

This will make it possible to use the settings specified in the devicetree
to configure the hardware.

Signed-off-by: Paul Cercueil <paul.cercueil-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 7b811e3..2404937 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -516,6 +516,17 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
+	if (ret < 0)
+		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
+	else
+		master->num_chipselect = num_cs;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
+				   &xspi->is_decoded_cs);
+	if (ret < 0)
+		xspi->is_decoded_cs = 0;
+
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
@@ -534,19 +545,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto remove_master;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
-
-	if (ret < 0)
-		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
-	else
-		master->num_chipselect = num_cs;
-
-	ret = of_property_read_u32(pdev->dev.of_node, "is-decoded-cs",
-				   &xspi->is_decoded_cs);
-
-	if (ret < 0)
-		xspi->is_decoded_cs = 0;
-
 	master->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
 	master->prepare_message = cdns_prepare_message;
 	master->transfer_one = cdns_transfer_one;
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
