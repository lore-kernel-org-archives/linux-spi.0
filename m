From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Fix invalid SPI use during system suspend" to the spi tree
Date: Wed,  5 Sep 2018 12:46:03 +0100 (BST)
Message-ID: <20180905114603.E093011229D0@debutante.sirena.org.uk>
References: <20180905084939.7401-4-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180905084939.7401-4-geert+renesas@glider.be>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Fix invalid SPI use during system suspend

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

>From c1ca59c22c56930b377a665fdd1b43351887830b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 5 Sep 2018 10:49:38 +0200
Subject: [PATCH] spi: rspi: Fix invalid SPI use during system suspend

If the SPI queue is running during system suspend, the system may lock
up.

Fix this by stopping/restarting the queue during system suspend/resume,
by calling spi_master_suspend()/spi_master_resume() from the PM
callbacks.  In-kernel users will receive an -ESHUTDOWN error while
system suspend/resume is in progress.

Based on a patch for sh-msiof by Gaku Inami.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-rspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 95dc4d78618d..f93a4587e3fb 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1350,12 +1350,36 @@ static const struct platform_device_id spi_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int rspi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
+
+	return spi_master_suspend(rspi->master);
+}
+
+static int rspi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
+
+	return spi_master_resume(rspi->master);
+}
+
+static SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
+#define DEV_PM_OPS	&rspi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver rspi_driver = {
 	.probe =	rspi_probe,
 	.remove =	rspi_remove,
 	.id_table =	spi_driver_ids,
 	.driver		= {
 		.name = "renesas_spi",
+		.pm = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(rspi_of_match),
 	},
 };
-- 
2.19.0.rc1
