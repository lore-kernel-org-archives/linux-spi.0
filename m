From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] spi: spi-ath79: fix initial GPIO CS line setup
Date: Sun,  2 Mar 2014 20:54:42 +0100
Message-ID: <1393790082-23964-1-git-send-email-juhosg@openwrt.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The 'ath79_spi_setup_cs' function initializes the chip
select line of a given SPI device in order to make sure
that the device is inactive.

If the SPI_CS_HIGH bit is set for a given device, it
means that the CS line of that device is active HIGH
so it must be set to LOW initially. In case of GPIO
CS lines, the 'ath79_spi_setup_cs' function does the
opposite of that due to the wrong GPIO flags.

Fix the code to use the correct GPIO flags.

Reported-by: Ronald Wahl <ronald.wahl-DpCwlqDxEn1BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-ath79.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 31534b5..c3b2fb9 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -132,9 +132,9 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 		flags = GPIOF_DIR_OUT;
 		if (spi->mode & SPI_CS_HIGH)
-			flags |= GPIOF_INIT_HIGH;
-		else
 			flags |= GPIOF_INIT_LOW;
+		else
+			flags |= GPIOF_INIT_HIGH;
 
 		status = gpio_request_one(cdata->gpio, flags,
 					  dev_name(&spi->dev));
-- 
1.7.10
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
