From: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Subject: [PATCH] spi: rb4xx: Fix set_cs logic.
Date: Mon, 20 Apr 2015 15:53:25 +0200
Message-ID: <1429538005-1985-1-git-send-email-bert@biot.com>
Cc: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As it turns out, the set_cs() enable parameter refers to the logic level
on the CS pin, not the state of chip selection.

This broke functionality of the LEDs behind the CPLD, or at least delayed
the commands until another one came in to toggle CS.

Signed-off-by: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
---
 drivers/spi/spi-rb4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 9b449d4..50f49f3 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -90,7 +90,7 @@ static void rb4xx_set_cs(struct spi_device *spi, bool enable)
 	 * since it's all on the same hardware register. However the
 	 * CPLD needs CS deselected after every command.
 	 */
-	if (!enable)
+	if (enable)
 		rb4xx_write(rbspi, AR71XX_SPI_REG_IOC,
 			    AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
