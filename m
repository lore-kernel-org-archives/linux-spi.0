From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: Fall back to master maximum speed if no slave speed specified
Date: Fri, 21 Aug 2015 09:40:35 -0700
Message-ID: <1440175235-9677-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If a slave appears with no maximum transfer speed specified fall back to
using the maximum for the master instead.  It's questionable if we
should let slaves do this but let's be defensive.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 08861a0..67733ef 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2035,6 +2035,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (!xfer->speed_hz)
 			xfer->speed_hz = spi->max_speed_hz;
+		if (!xfer->speed_hz)
+			xfer->speed_hz = master->max_speed_hz;
 
 		if (master->max_speed_hz &&
 		    xfer->speed_hz > master->max_speed_hz)
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
