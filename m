From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Fix failure path leak on GPIO request error" to the spi tree
Date: Tue, 31 Oct 2017 11:22:09 +0000
Message-ID: <E1e9UcT-0002yg-Rr@debutante>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Fix failure path leak on GPIO request error

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 974488e4ce1ed0b39f2c711c13f523c5912128a1 Mon Sep 17 00:00:00 2001
From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Date: Thu, 26 Oct 2017 18:08:39 -0700
Subject: [PATCH] spi: imx: Fix failure path leak on GPIO request error

If the code that requests any chip select GPIOs fails, the cleanup of
spi_bitbang_start() by calling spi_bitbang_stop() is not done.

Fix this by moving spi_bitbang_start() to after the code that requets
GPIOs.  The GPIOs are dev managed and don't need explicit cleanup.
Since spi_bitbang_start() is now the last operation, it doesn't need
to be cleaned up in the failure path.

CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fe35aaea323b..5ddd32ba2521 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1613,11 +1613,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
 
 	if (!spi_imx->slave_mode) {
 		if (!master->cs_gpios) {
@@ -1641,6 +1636,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = spi_bitbang_start(&spi_imx->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_clk_put;
+	}
+
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
-- 
2.15.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
