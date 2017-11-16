From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Fix failure path leak on GPIO request error correctly" to the spi tree
Date: Thu, 16 Nov 2017 19:30:19 +0000 (GMT)
Message-ID: <20171116193019.DC05544005B@finisterre.ee.mobilebroadband>
References: <20171106183823.3186-1-tpiepho@impinj.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106183823.3186-1-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Fix failure path leak on GPIO request error correctly

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

>From 8197f489f4c4398391746a377c10501076b05168 Mon Sep 17 00:00:00 2001
From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Date: Mon, 6 Nov 2017 10:38:23 -0800
Subject: [PATCH] spi: imx: Fix failure path leak on GPIO request error
 correctly

In commit 974488e4ce1e ("spi: imx: Fix failure path leak on GPIO request
error"), spi_bitbang_start() was moved later in the probe sequence.  But
this doesn't work, as spi_bitbang_start() has to be called before
requesting GPIOs because the GPIO data in the spi master is populated when
the master is registed, and that doesn't happen until spi_bitbang_start()
is called.  The default only works if one uses one CS.

So add a failure path call to spi_bitbang_stop() to fix the leak.

CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5ddd32ba2521..301cdb721bad 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1613,6 +1613,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	master->dev.of_node = pdev->dev.of_node;
+	ret = spi_bitbang_start(&spi_imx->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_clk_put;
+	}
 
 	if (!spi_imx->slave_mode) {
 		if (!master->cs_gpios) {
@@ -1631,23 +1636,19 @@ static int spi_imx_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
 					master->cs_gpios[i]);
-				goto out_clk_put;
+				goto out_spi_bitbang;
 			}
 		}
 	}
 
-	ret = spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
-
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
 	clk_disable(spi_imx->clk_per);
 	return ret;
 
+out_spi_bitbang:
+	spi_bitbang_stop(&spi_imx->bitbang);
 out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
