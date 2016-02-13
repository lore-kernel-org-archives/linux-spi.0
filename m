From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: bcm2835: Remove unnecessary workaround to call
 gpio_set_value
Date: Sun, 14 Feb 2016 00:19:07 +0800
Message-ID: <1455380347.25581.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This should be fixed by commit 4c02cba18cc9
("pinctrl: bcm2835: Fix initial value for direction_output")

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cf04960..f35cc10 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -727,11 +727,6 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 			spi->chip_select, spi->cs_gpio, err);
 		return err;
 	}
-	/* the implementation of pinctrl-bcm2835 currently does not
-	 * set the GPIO value when using gpio_direction_output
-	 * so we are setting it here explicitly
-	 */
-	gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 
 	return 0;
 }
-- 
2.1.4



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
