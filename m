From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH spi 3/7] spi-sirf: remove duplicate check on resource
Date: Tue, 21 Oct 2014 15:35:46 +0530
Message-ID: <1413885950-24208-3-git-send-email-varkab@cdac.in>
References: <1413885950-24208-1-git-send-email-varkab@cdac.in>
Cc: Varka Bhadram <varkab-If5XQcfNmg0@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413885950-24208-1-git-send-email-varkab-If5XQcfNmg0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sanity check on resource happening with devm_ioremap_resource().

Signed-off-by: Varka Bhadram <varkab-If5XQcfNmg0@public.gmane.org>
---
 drivers/spi/spi-sirf.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f59d417..ee85da2 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -502,12 +502,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "Unable to get IO resource\n");
-		ret = -ENODEV;
-		goto free_master;
-	}
 	master->num_chipselect = num_cs;
 
 	for (i = 0; i < master->num_chipselect; i++) {
@@ -534,6 +528,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		}
 	}
 
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sspi->base)) {
 		ret = PTR_ERR(sspi->base);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
