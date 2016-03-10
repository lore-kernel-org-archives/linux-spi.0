From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 1/2] spi/spi-xilinx:  Add clock support
Date: Thu, 10 Mar 2016 17:41:04 +0530
Message-ID: <1457611865-40120-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add basic clock support. The clocks are requested at probe
and released at remove.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v3 changes:
Do not fail probe if no clock is given
Add a clk name
Fix some space errors

 drivers/spi/spi-xilinx.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..426ce12 100644
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
+	struct clk *clk;
 
 	int		irq;
 
@@ -428,6 +430,22 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
+	xspi->clk = devm_clk_get(&pdev->dev, "spi_fclk");
+	if (IS_ERR(xspi->clk)) {
+		if (PTR_ERR(xspi->clk) == -ENOENT) {
+			xspi->clk = NULL;
+		} else {
+			ret = PTR_ERR(xspi->clk);
+			goto put_master;
+		}
+	}
+
+	ret = clk_prepare_enable(xspi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		goto put_master;
+	}
+
 	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
@@ -485,6 +503,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 put_master:
 	spi_master_put(master);
+	clk_disable_unprepare(xspi->clk);
 
 	return ret;
 }
@@ -503,6 +522,7 @@ static int xilinx_spi_remove(struct platform_device *pdev)
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
 	spi_master_put(xspi->bitbang.master);
+	clk_disable_unprepare(xspi->clk);
 
 	return 0;
 }
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
