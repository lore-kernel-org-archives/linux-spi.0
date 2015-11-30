From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/2] spi: Mark instantiated device nodes with OF_POPULATE
Date: Mon, 30 Nov 2015 15:28:07 +0100
Message-ID: <1448893687-9159-3-git-send-email-geert+renesas@glider.be>
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

Mark (and unmark) device nodes with the POPULATE flag as appropriate.
This is required to avoid multi probing when enabling and populating SPI
buses in DT overlays.

Based on commit 4f001fd30145a6a8 ("i2c: Mark instantiated device nodes
with OF_POPULATE").

Suggested-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index afaa9427a383506a..31449c554ea9585e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -614,8 +614,12 @@ EXPORT_SYMBOL_GPL(spi_new_device);
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
 
@@ -1562,6 +1566,8 @@ static void of_register_spi_devices(struct spi_master *master)
 		return;
 
 	for_each_available_child_of_node(master->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
 		spi = of_register_spi_device(master, nc);
 		if (IS_ERR(spi))
 			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
@@ -2660,6 +2666,11 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		if (master == NULL)
 			return NOTIFY_OK;	/* not for us */
 
+		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
+			put_device(&master->dev);
+			return NOTIFY_OK;
+		}
+
 		spi = of_register_spi_device(master, rd->dn);
 		put_device(&master->dev);
 
@@ -2671,6 +2682,10 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
