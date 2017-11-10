From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Don't require platform data chipselect array" to the spi tree
Date: Fri, 10 Nov 2017 21:30:04 +0000
Message-ID: <E1eDGsG-0004h1-V3@debutante>
References: <20171031194907.29108-4-tpiepho@impinj.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171031194907.29108-4-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Don't require platform data chipselect array

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

>From ffd4db9e10fdb431b559af052c17015682bbe2aa Mon Sep 17 00:00:00 2001
From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Date: Tue, 31 Oct 2017 12:49:06 -0700
Subject: [PATCH] spi: imx: Don't require platform data chipselect array

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fdbbdac66839..79ddefe4180d 100644
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
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
