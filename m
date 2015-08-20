From: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: bcm53xx: Adjust devm usage
Date: Thu, 20 Aug 2015 23:28:38 +0530
Message-ID: <20150820175838.GA4895@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove use of spi_unregister_master in remove function as
devm_spi_register_master in probe function automatically
handles it. To be compatible with the change, use direct
return instead of goto and remove unnedded label out.

Also, remove bcm53xxspi_bcma_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bcm53xx.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index 1520554..cc3f938 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -247,28 +247,19 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 	if (err) {
 		spi_master_put(master);
 		bcma_set_drvdata(core, NULL);
-		goto out;
+		return err;
 	}
 
 	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only */
 	spi_new_device(master, &bcm53xx_info);
 
-out:
-	return err;
-}
-
-static void bcm53xxspi_bcma_remove(struct bcma_device *core)
-{
-	struct bcm53xxspi *b53spi = bcma_get_drvdata(core);
-
-	spi_unregister_master(b53spi->master);
+	return 0;
 }
 
 static struct bcma_driver bcm53xxspi_bcma_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= bcm53xxspi_bcma_tbl,
 	.probe		= bcm53xxspi_bcma_probe,
-	.remove		= bcm53xxspi_bcma_remove,
 };
 
 /**************************************************
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
