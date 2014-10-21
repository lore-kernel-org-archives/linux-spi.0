From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH spi 7/7] spi-ep93xx: remove duplicate check on resource
Date: Tue, 21 Oct 2014 15:35:50 +0530
Message-ID: <1413885950-24208-7-git-send-email-varkab@cdac.in>
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
 drivers/spi/spi-ep93xx.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d7bac60..9a4c435 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1077,20 +1077,14 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "unable to get iomem resource\n");
-		error = -ENODEV;
-		goto fail_put_clock;
-	}
-
-	espi->sspdr_phys = res->start + SSPDR;
-
 	espi->regs_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(espi->regs_base)) {
 		error = PTR_ERR(espi->regs_base);
 		goto fail_put_clock;
 	}
 
+	espi->sspdr_phys = res->start + SSPDR;
+
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
 				0, "ep93xx-spi", espi);
 	if (error) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
