From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Set max_speed_hz of spi_device default to
 max_speed_hz of controller
Date: Mon, 10 Feb 2014 00:08:05 +0800
Message-ID: <1391962085.10294.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In __spi_validate(), xfer->speed_hz is set to be spi->max_speed_hz if it is not
set for this transfer. However, if spi->max_speed_hz is also not set,
xfer->speed_hz is 0. Some drivers (e.g. au1550, tegra114, tegra20-sflash,
tegra20-slink, etc.) then use below code to avoid setting xfer->speed_hz to 0.

        /* Set speed to the spi max fequency if spi device has not set */
        spi->max_speed_hz = spi->max_speed_hz ? : tspi->spi_max_frequency;

Let's handle it in spi core.
If spi->max_speed_hz is not set, make it default to spi->master->max_speed_hz.
So In __spi_validate() if both xfer->speed_hz and spi->max_speed_hz are not set,
xfer->speed_hz will be set to spi->master->max_speed_hz.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d51f2a3..1c9ddf1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1787,6 +1787,9 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = spi->master->max_speed_hz;
+
 	if (spi->master->setup)
 		status = spi->master->setup(spi);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
