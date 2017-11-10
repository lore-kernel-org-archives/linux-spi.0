From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: GPIO based chip selects should not be required" to the spi tree
Date: Fri, 10 Nov 2017 21:30:13 +0000
Message-ID: <E1eDGsP-0004jA-7N@debutante>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: GPIO based chip selects should not be required

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 881a0b993e9f065cbb3673c94c395fa1de24bdcc Mon Sep 17 00:00:00 2001
From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Date: Tue, 31 Oct 2017 12:49:04 -0700
Subject: [PATCH] spi: imx: GPIO based chip selects should not be required

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5ddd32ba2521..70dcc8ee1f6b 100644
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
@@ -1614,13 +1621,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 
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
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
