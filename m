From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: nuc900: Remove unused fields from struct nuc900_spi
Date: Sat, 08 Feb 2014 11:15:57 +0800
Message-ID: <1391829357.11855.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-nuc900.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index d8d55c7..675c210 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -57,11 +57,8 @@ struct nuc900_spi {
 	unsigned char		*rx;
 	struct clk		*clk;
 	struct spi_master	*master;
-	struct spi_device	*curdev;
-	struct device		*dev;
 	struct nuc900_spi_info *pdata;
 	spinlock_t		lock;
-	struct resource		*res;
 };
 
 static inline struct nuc900_spi *to_hw(struct spi_device *sdev)
@@ -337,6 +334,7 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 {
 	struct nuc900_spi *hw;
 	struct spi_master *master;
+	struct resource *res;
 	int err = 0;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct nuc900_spi));
@@ -348,7 +346,6 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 	hw = spi_master_get_devdata(master);
 	hw->master = master;
 	hw->pdata  = dev_get_platdata(&pdev->dev);
-	hw->dev = &pdev->dev;
 
 	if (hw->pdata == NULL) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
@@ -368,8 +365,8 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 	hw->bitbang.chipselect     = nuc900_spi_chipsel;
 	hw->bitbang.txrx_bufs      = nuc900_spi_txrx;
 
-	hw->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hw->regs = devm_ioremap_resource(&pdev->dev, hw->res);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hw->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(hw->regs)) {
 		err = PTR_ERR(hw->regs);
 		goto err_pdata;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
