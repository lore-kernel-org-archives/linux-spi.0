From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-adi-v3: convert to use common clk framework
Date: Sat, 5 Apr 2014 11:29:09 +0800
Message-ID: <1396668549-20052-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>,
	Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use common clk api to get spi clock.

Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/mach-bf609/clock.c |    7 +++++++
 drivers/spi/spi-adi-v3.c         |   13 +++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
index 13644ed..2bd82b1 100644
--- a/arch/blackfin/mach-bf609/clock.c
+++ b/arch/blackfin/mach-bf609/clock.c
@@ -381,6 +381,12 @@ static struct clk ethclk = {
 	.ops	    = &dummy_clk_ops,
 };
 
+static struct clk spiclk = {
+	.name       = "spi",
+	.parent     = &sclk1,
+	.ops        = &dummy_clk_ops,
+};
+
 static struct clk_lookup bf609_clks[] = {
 	CLK(sys_clkin, NULL, "SYS_CLKIN"),
 	CLK(pll_clk, NULL, "PLLCLK"),
@@ -393,6 +399,7 @@ static struct clk_lookup bf609_clks[] = {
 	CLK(dclk, NULL, "DCLK"),
 	CLK(oclk, NULL, "OCLK"),
 	CLK(ethclk, NULL, "stmmaceth"),
+	CLK(spiclk, NULL, "spi"),
 };
 
 int __init clk_init(void)
diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
index 0c2914c..dcb2287 100644
--- a/drivers/spi/spi-adi-v3.c
+++ b/drivers/spi/spi-adi-v3.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -800,7 +801,7 @@ static int adi_spi_probe(struct platform_device *pdev)
 	struct adi_spi_master *drv_data;
 	struct resource *mem, *res;
 	unsigned int tx_dma, rx_dma;
-	unsigned long sclk;
+	struct clk *sclk;
 	int ret;
 
 	if (!info) {
@@ -808,10 +809,10 @@ static int adi_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	sclk = get_sclk1();
-	if (!sclk) {
-		dev_err(dev, "can not get sclk1\n");
-		return -ENXIO;
+	sclk = devm_clk_get(dev, "spi");
+	if (IS_ERR(sclk)) {
+		dev_err(dev, "can not get spi clock\n");
+		return PTR_ERR(sclk);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -852,7 +853,7 @@ static int adi_spi_probe(struct platform_device *pdev)
 	drv_data->tx_dma = tx_dma;
 	drv_data->rx_dma = rx_dma;
 	drv_data->pin_req = info->pin_req;
-	drv_data->sclk = sclk;
+	drv_data->sclk = clk_get_rate(sclk);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drv_data->regs = devm_ioremap_resource(dev, mem);
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
