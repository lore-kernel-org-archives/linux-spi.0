From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: ath79: simplify iomem resource mapping
Date: Sun, 27 Sep 2015 18:47:35 +0200
Message-ID: <56081DA7.4040305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify the code by switching from devm_ioremap to devm_ioremap_resource.
Checking the result of platform_get_resource is not needed as
devm_ioremap_resource checks the provided resource argument for NULL.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-ath79.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index bf1f9b3..6165bf2 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -240,14 +240,9 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENOENT;
-		goto err_put_master;
-	}
-
-	sp->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!sp->base) {
-		ret = -ENXIO;
+	sp->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(sp->base)) {
+		ret = PTR_ERR(sp->base);
 		goto err_put_master;
 	}
 
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
