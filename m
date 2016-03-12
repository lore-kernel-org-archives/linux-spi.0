From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 1/2] spi/spi-xilinx:  Add clock support
Date: Sat, 12 Mar 2016 13:30:36 +0530
Message-ID: <1457769637-5627-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add basic clock support. The clocks are requested at probe
and released at remove.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v3 changes:
Do not fail probe if no clock is given
Add a clk name
Fix some space errors
v4 changes:
correct the clock name
also check for ENOENT to prevent breaking current dts

 drivers/spi/spi-xilinx.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..bd9ad61 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/xilinx_spi.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #define XILINX_SPI_MAX_CS	32
 
@@ -83,6 +84,7 @@ struct xilinx_spi {
 	struct spi_bitbang bitbang;
 	struct completion done;
 	void __iomem	*regs;	/* virt. address of the control registers */
+	struct clk *aclk;	/* AXI clock */
 
 	int		irq;
 
@@ -428,6 +430,24 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
+	xspi->aclk = devm_clk_get(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(xspi->aclk)) {
+		if (PTR_ERR(xspi->aclk) == -ENOENT) {
+			dev_err(&pdev->dev, "No clocks found for aclk\n");
+			xspi->aclk = NULL;
+		} else {
+			dev_err(&pdev->dev, "axi clock error %d\n", ret);
+			ret = PTR_ERR(xspi->aclk);
+			goto put_master;
+		}
+	}
+
+	ret = clk_prepare_enable(xspi->aclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable axi clock.\n");
+		goto put_master;
+	}
+
 	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
@@ -460,7 +480,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
 				dev_name(&pdev->dev), xspi);
 		if (ret)
-			goto put_master;
+			goto dis_master_clk;
 	}
 
 	/* SPI controller initializations */
@@ -469,7 +489,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&xspi->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_bitbang_start FAILED\n");
-		goto put_master;
+		goto dis_master_clk;
 	}
 
 	dev_info(&pdev->dev, "at 0x%08llX mapped to 0x%p, irq=%d\n",
@@ -483,9 +503,10 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	return 0;
 
+dis_master_clk:
+	clk_disable_unprepare(xspi->aclk);
 put_master:
 	spi_master_put(master);
-
 	return ret;
 }
 
@@ -503,6 +524,7 @@ static int xilinx_spi_remove(struct platform_device *pdev)
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
 	spi_master_put(xspi->bitbang.master);
+	clk_disable_unprepare(xspi->aclk);
 
 	return 0;
 }
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
