From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Fix invalid SPI use during system suspend" to the spi tree
Date: Wed,  5 Sep 2018 12:46:12 +0100 (BST)
Message-ID: <20180905114612.5DC1711229D0@debutante.sirena.org.uk>
References: <20180905084939.7401-2-geert+renesas@glider.be>
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org
To: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180905084939.7401-2-geert+renesas@glider.be>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Fix invalid SPI use during system suspend

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

>From ffa69d6a16f686efe45269342474e421f2aa58b2 Mon Sep 17 00:00:00 2001
From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Wed, 5 Sep 2018 10:49:36 +0200
Subject: [PATCH] spi: sh-msiof: Fix invalid SPI use during system suspend

If the SPI queue is running during system suspend, the system may lock
up.

Fix this by stopping/restarting the queue during system suspend/resume
by calling spi_master_suspend()/spi_master_resume() from the PM
callbacks.  In-kernel users will receive an -ESHUTDOWN error while
system suspend/resume is in progress.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: Cleanup, reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-sh-msiof.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 539d6d1a277a..bfe4e6d4f7bf 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,12 +1426,37 @@ static const struct platform_device_id spi_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int sh_msiof_spi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_suspend(p->master);
+}
+
+static int sh_msiof_spi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_resume(p->master);
+}
+
+static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
+			 sh_msiof_spi_resume);
+#define DEV_PM_OPS	&sh_msiof_spi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
 	.remove		= sh_msiof_spi_remove,
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
+		.pm		= DEV_PM_OPS,
 		.of_match_table = of_match_ptr(sh_msiof_match),
 	},
 };
-- 
2.19.0.rc1
