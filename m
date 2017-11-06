From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 2/3] spi: imx: Don't require platform data chipselect array
Date: Mon,  6 Nov 2017 11:46:17 -0800
Message-ID: <20171106194618.9421-3-tpiepho@impinj.com>
References: <20171106194618.9421-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106194618.9421-1-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If the array is not present, assume all chip selects are native.  This
is the standard behavior for SPI masters configured via the device
tree and the behavior of this driver as well when it is configured via
device tree.

This reduces platform data vs DT differences and allows most of the
platform data based boards to remove their chip select arrays.

CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ad54f8258513..5caa6c9524fa 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1526,13 +1526,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	/* Get number of chip selects, either platform data or OF */
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
-		master->cs_gpios = devm_kzalloc(&master->dev,
-			sizeof(int) * master->num_chipselect, GFP_KERNEL);
-		if (!master->cs_gpios)
-			return -ENOMEM;
-
-		for (i = 0; i < master->num_chipselect; i++)
-			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+		if (mxc_platform_info->chipselect) {
+			master->cs_gpios = devm_kzalloc(&master->dev,
+				sizeof(int) * master->num_chipselect, GFP_KERNEL);
+			if (!master->cs_gpios)
+				return -ENOMEM;
+
+			for (i = 0; i < master->num_chipselect; i++)
+				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+		}
 	} else {
 		u32 num_cs;
 
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
