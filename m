From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH spi 4/7] spi-s3c64xx: remove duplicate check on resource
Date: Tue, 21 Oct 2014 15:35:47 +0530
Message-ID: <1413885950-24208-4-git-send-email-varkab@cdac.in>
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
 drivers/spi/spi-s3c64xx.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4188b2f..5a0ce49 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1176,12 +1176,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem_res == NULL) {
-		dev_err(&pdev->dev, "Unable to get SPI MEM resource\n");
-		return -ENXIO;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
@@ -1250,6 +1244,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sdd->regs)) {
 		ret = PTR_ERR(sdd->regs);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
