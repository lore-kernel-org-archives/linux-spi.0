From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH spi 6/7] spi-mxs: remove duplicate check on resource
Date: Tue, 21 Oct 2014 15:35:49 +0530
Message-ID: <1413885950-24208-6-git-send-email-varkab@cdac.in>
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
 drivers/spi/spi-mxs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 22a0af0..778cb98 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -536,15 +536,15 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	const int clk_freq_default = 160000000;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq_err = platform_get_irq(pdev, 0);
-	irq_dma = platform_get_irq(pdev, 1);
-	if (!iores || irq_err < 0 || irq_dma < 0)
-		return -EINVAL;
-
 	base = devm_ioremap_resource(&pdev->dev, iores);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	irq_err = platform_get_irq(pdev, 0);
+	irq_dma = platform_get_irq(pdev, 1);
+	if (irq_err < 0 || irq_dma < 0)
+		return -EINVAL;
+
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
 		return PTR_ERR(pinctrl);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
