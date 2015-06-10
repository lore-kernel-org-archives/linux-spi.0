From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1] spi: davinci: change the lower limit of pre-scale divider to 1
Date: Wed, 10 Jun 2015 03:23:42 -0400
Message-ID: <1433921022-13151-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI hardware spec for Keystone specify a lower value of 0 for pre-scale
divider which determine what max value of spi clock (spi-max-frequency)
the device can support. This translates to a clock divider of 2. So fix
the lower limit value used for the boundary check in
davinci_spi_get_prescale() function to 1 so that a maximum of spi device
clock rate / 2 is possible to be set for spi-max-frequency.

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 - Re-send with updates to commit log and PATCH prefix
 - Applies to v4.1
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 5e99106..987afeb 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -265,7 +265,7 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 
 	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
 
-	if (ret < 3 || ret > 256)
+	if (ret < 1 || ret > 256)
 		return -EINVAL;
 
 	return ret - 1;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
