From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/4] spi: mips-lantiq: Use devm_spi_register_master()
Date: Wed, 04 Dec 2013 14:11:56 +0900
Message-ID: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Thomas Langer' <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	'John Crispin' <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_spi_register_master() to make cleanup paths simpler,
and remove unnecessary remove().

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-falcon.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index c7a74f0..dd5bd46 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -433,21 +433,12 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret)
 		spi_master_put(master);
 	return ret;
 }
 
-static int falcon_sflash_remove(struct platform_device *pdev)
-{
-	struct falcon_sflash *priv = platform_get_drvdata(pdev);
-
-	spi_unregister_master(priv->master);
-
-	return 0;
-}
-
 static const struct of_device_id falcon_sflash_match[] = {
 	{ .compatible = "lantiq,sflash-falcon" },
 	{},
@@ -456,7 +447,6 @@ MODULE_DEVICE_TABLE(of, falcon_sflash_match);
 
 static struct platform_driver falcon_sflash_driver = {
 	.probe	= falcon_sflash_probe,
-	.remove	= falcon_sflash_remove,
 	.driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
