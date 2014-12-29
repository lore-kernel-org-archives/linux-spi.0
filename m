From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-imx: Do not store the irq number in the private structure
Date: Mon, 29 Dec 2014 19:38:51 -0200
Message-ID: <1419889131-15472-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The irq number is only used inside the probe function, so there is really no
need to store it in the private structure.

Use a local 'irq' variable to hold the the irq number instead.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-imx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 961b97d..6a2ff75 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -89,7 +89,6 @@ struct spi_imx_data {
 
 	struct completion xfer_done;
 	void __iomem *base;
-	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
@@ -1076,7 +1075,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs;
+	int i, ret, num_cs, irq;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -1143,16 +1142,16 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	spi_imx->irq = platform_get_irq(pdev, 0);
-	if (spi_imx->irq < 0) {
-		ret = spi_imx->irq;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		goto out_master_put;
 	}
 
-	ret = devm_request_irq(&pdev->dev, spi_imx->irq, spi_imx_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, spi_imx_isr, 0,
 			       dev_name(&pdev->dev), spi_imx);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
+		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
 		goto out_master_put;
 	}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
