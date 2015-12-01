From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Uninline spi_unregister_device()" to the spi tree
Date: Tue, 01 Dec 2015 23:00:30 +0000
Message-ID: <E1a3tuQ-000865-3D@debutante>
References: <1448893687-9159-2-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448893687-9159-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Uninline spi_unregister_device()

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

>From 3b1884c24c98dada51fc4b05735773f0078711d2 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Mon, 30 Nov 2015 15:28:06 +0100
Subject: [PATCH] spi: Uninline spi_unregister_device()

Uninline spi_unregister_device() in preparation of adding more code to
it. Add kerneldoc documentation while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 14 ++++++++++++++
 include/linux/spi/spi.h |  7 +------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..3f135cc9a70e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -604,6 +604,20 @@ struct spi_device *spi_new_device(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
+/**
+ * spi_unregister_device - unregister a single SPI device
+ * @spi: spi_device to unregister
+ *
+ * Start making the passed SPI device vanish. Normally this would be handled
+ * by spi_unregister_master().
+ */
+void spi_unregister_device(struct spi_device *spi)
+{
+	if (spi)
+		device_unregister(&spi->dev);
+}
+EXPORT_SYMBOL_GPL(spi_unregister_device);
+
 static void spi_match_master_to_boardinfo(struct spi_master *master,
 				struct spi_board_info *bi)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6dc7d1..075bede66521 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1115,12 +1115,7 @@ spi_add_device(struct spi_device *spi);
 extern struct spi_device *
 spi_new_device(struct spi_master *, struct spi_board_info *);
 
-static inline void
-spi_unregister_device(struct spi_device *spi)
-{
-	if (spi)
-		device_unregister(&spi->dev);
-}
+extern void spi_unregister_device(struct spi_device *spi);
 
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
