From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: s3c64xx: replace clock disabling with runtime PM suspend call in remove function" to the spi tree
Date: Mon, 14 Sep 2015 19:54:34 +0100
Message-ID: <E1ZbYte-0002LK-St@finisterre>
References: <55D7614C.6040309@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D7614C.6040309-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: s3c64xx: replace clock disabling with runtime PM suspend call in remove function

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

>From 8ebe9d163e93e10458f3fd7522f29f9149e58632 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 3 Sep 2015 22:40:53 +0200
Subject: [PATCH] spi: s3c64xx: replace clock disabling with runtime PM suspend
 call in remove function

Simplify s3c64xx_spi_remove by replacing the clock disabling with calling
runtime PM suspend which does the same.
Waking up the device if it was suspended wouldn't be strictly needed
for this driver but using pm_runtime_get_sync is cleaner and makes
s3c64xx_spi_remove more consistent with the runtime PM handling in
s3c64xx_spi_setup.

pm_runtime_force_suspend does most of the work for us:
disabling the clocks, disabling runtime PM and setting it to
"suspended" state.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4e5931c..dee82e1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1225,7 +1225,7 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
@@ -1233,6 +1233,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sdd->clk);
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
