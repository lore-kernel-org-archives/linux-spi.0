From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] spi: Uninline spi_unregister_device()
Date: Mon, 30 Nov 2015 15:28:06 +0100
Message-ID: <1448893687-9159-2-git-send-email-geert+renesas@glider.be>
References: <1448893687-9159-1-git-send-email-geert+renesas@glider.be>
Cc: Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448893687-9159-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Uninline spi_unregister_device() in preparation of adding more code to
it. Add kerneldoc documentation while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c       | 14 ++++++++++++++
 include/linux/spi/spi.h |  7 +------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cebb08e4f6077e5b..afaa9427a383506a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -605,6 +605,20 @@ struct spi_device *spi_new_device(struct spi_master *master,
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
index cce80e6dc7d11596..075bede6652104fa 100644
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
