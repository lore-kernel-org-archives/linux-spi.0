From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH spi 5/7] spi-omap2-mcspi: remove duplicate check on resource
Date: Tue, 21 Oct 2014 15:35:48 +0530
Message-ID: <1413885950-24208-5-git-send-email-varkab@cdac.in>
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
 drivers/spi/spi-omap2-mcspi.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 893c3d7..305c649 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1213,8 +1213,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	regs_offset = pdata->regs_offset;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		status = -ENODEV;
+	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(mcspi->base)) {
+		status = PTR_ERR(mcspi->base);
 		goto free_master;
 	}
 
@@ -1222,12 +1223,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	r->end += regs_offset;
 	mcspi->phys = r->start;
 
-	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(mcspi->base)) {
-		status = PTR_ERR(mcspi->base);
-		goto free_master;
-	}
-
 	mcspi->dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&mcspi->ctx.cs);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
