From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/4] spi: imx: GPIO based chip selects should not be required
Date: Tue, 31 Oct 2017 12:49:04 -0700
Message-ID: <20171031194907.29108-2-tpiepho@impinj.com>
References: <20171031194907.29108-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171031194907.29108-1-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver will fail to load if no gpio chip selects are specified,
this patch changes this so that it no longer fails.

It's possible to use all native chip selects, in which case there is
no reason to have a gpio chip select array.  This is what happens if
the *optional* device tree property "cs-gpios" is omitted.

The spi core already checks for the absence of gpio chip selects in
the master and assigns any slaves the gpio_cs value of -ENOENT.

Also have the driver respect the standard SPI device tree property "num-cs"
to allow setting the number of chip selects without using cs-gpios.

CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fe35aaea323b..76bf0e4fc2c7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1523,6 +1523,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data = devtype_data;
 
+	/* Get number of chip selects, either platform data or OF */
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
 		master->cs_gpios = devm_kzalloc(&master->dev,
@@ -1532,7 +1533,13 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 		for (i = 0; i < master->num_chipselect; i++)
 			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
- 	}
+	} else {
+		u32 num_cs;
+
+		if (!of_property_read_u32(np, "num-cs", &num_cs))
+			master->num_chipselect = num_cs;
+		/* If not preset, default value of 1 is used */
+	}
 
 	spi_imx->bitbang.chipselect = spi_imx_chipselect;
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
@@ -1619,13 +1626,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	if (!spi_imx->slave_mode) {
-		if (!master->cs_gpios) {
-			dev_err(&pdev->dev, "No CS GPIOs available\n");
-			ret = -EINVAL;
-			goto out_clk_put;
-		}
-
+	/* Request GPIO CS lines, if any */
+	if (!spi_imx->slave_mode && master->cs_gpios) {
 		for (i = 0; i < master->num_chipselect; i++) {
 			if (!gpio_is_valid(master->cs_gpios[i]))
 				continue;
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
