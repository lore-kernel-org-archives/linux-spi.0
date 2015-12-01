From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Mark instantiated device nodes with OF_POPULATE" to the spi tree
Date: Tue, 01 Dec 2015 23:00:29 +0000
Message-ID: <E1a3tuP-00085K-3W@debutante>
References: <1448893687-9159-3-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448893687-9159-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Mark instantiated device nodes with OF_POPULATE

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

>From bd6c1644a2f6f46cdf89388e81168a70711fce3a Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Mon, 30 Nov 2015 15:28:07 +0100
Subject: [PATCH] spi: Mark instantiated device nodes with OF_POPULATE

Mark (and unmark) device nodes with the POPULATE flag as appropriate.
This is required to avoid multi probing when enabling and populating SPI
buses in DT overlays.

Based on commit 4f001fd30145a6a8 ("i2c: Mark instantiated device nodes
with OF_POPULATE").

Suggested-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f135cc9a70e..c7486a373af1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -613,8 +613,12 @@ EXPORT_SYMBOL_GPL(spi_new_device);
  */
 void spi_unregister_device(struct spi_device *spi)
 {
-	if (spi)
-		device_unregister(&spi->dev);
+	if (!spi)
+		return;
+
+	if (spi->dev.of_node)
+		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
+	device_unregister(&spi->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_device);
 
@@ -1561,6 +1565,8 @@ static void of_register_spi_devices(struct spi_master *master)
 		return;
 
 	for_each_available_child_of_node(master->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
 		spi = of_register_spi_device(master, nc);
 		if (IS_ERR(spi))
 			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
@@ -2645,6 +2651,11 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		if (master == NULL)
 			return NOTIFY_OK;	/* not for us */
 
+		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
+			put_device(&master->dev);
+			return NOTIFY_OK;
+		}
+
 		spi = of_register_spi_device(master, rd->dn);
 		put_device(&master->dev);
 
@@ -2656,6 +2667,10 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		break;
 
 	case OF_RECONFIG_CHANGE_REMOVE:
+		/* already depopulated? */
+		if (!of_node_check_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
 		/* find our device by node */
 		spi = of_find_spi_device_by_node(rd->dn);
 		if (spi == NULL)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
