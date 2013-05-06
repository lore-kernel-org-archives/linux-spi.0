From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] spi/sirf: Let device core handle pinctrl
Date: Mon,  6 May 2013 20:31:18 +0100
Message-ID: <1367868678-12492-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device
core) we can rely on device core for handling pinctrl so remove
devm_pinctrl_get_select_default() from the driver.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/spi/spi-sirf.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f59d417..899dc3b 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -19,7 +19,6 @@
 #include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/pinctrl/consumer.h>
 
 #define DRIVER_NAME "sirfsoc_spi"
 
@@ -127,7 +126,6 @@ struct sirfsoc_spi {
 	void __iomem *base;
 	u32 ctrl_freq;  /* SPI controller clock speed */
 	struct clk *clk;
-	struct pinctrl *p;
 
 	/* rx & tx bufs from the spi_transfer */
 	const void *tx;
@@ -558,15 +556,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
-	sspi->p = pinctrl_get_select_default(&pdev->dev);
-	ret = IS_ERR(sspi->p);
-	if (ret)
-		goto free_master;
-
 	sspi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sspi->clk)) {
 		ret = -EINVAL;
-		goto free_pin;
+		goto free_master;
 	}
 	clk_prepare_enable(sspi->clk);
 	sspi->ctrl_freq = clk_get_rate(sspi->clk);
@@ -594,8 +587,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 free_clk:
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
-free_pin:
-	pinctrl_put(sspi->p);
 free_master:
 	spi_master_put(master);
 err_cs:
@@ -618,7 +609,6 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 	}
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
-	pinctrl_put(sspi->p);
 	spi_master_put(master);
 	return 0;
 }
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
