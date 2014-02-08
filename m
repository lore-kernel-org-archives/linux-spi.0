From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: octeon: Remove unused bits_per_word from struct
 octeon_spi_setup
Date: Sat, 08 Feb 2014 23:12:20 +0800
Message-ID: <1391872340.4110.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index cf88974..1bd6eca 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -36,7 +36,6 @@ struct octeon_spi_setup {
 	u32 max_speed_hz;
 	u8 chip_select;
 	u8 mode;
-	u8 bits_per_word;
 };
 
 static void octeon_spi_wait_ready(struct octeon_spi *p)
@@ -203,7 +202,6 @@ static struct octeon_spi_setup *octeon_spi_new_setup(struct spi_device *spi)
 	setup->max_speed_hz = spi->max_speed_hz;
 	setup->chip_select = spi->chip_select;
 	setup->mode = spi->mode;
-	setup->bits_per_word = spi->bits_per_word;
 	return setup;
 }
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
