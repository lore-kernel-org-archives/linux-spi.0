From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi/spi-xilinx:  Add clock support
Date: Tue, 8 Mar 2016 14:12:08 +0530
Message-ID: <1457426528-15247-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add basic clock support. The clocks are requested at probe
and released at remove.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-xilinx.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..7e12338 100644
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
 
@@ -428,6 +430,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		goto put_master;
 	}
 
+	xspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xspi->clk)) {
+		dev_err(&pdev->dev, "input clock not found.\n");
+		return PTR_ERR(xspi->clk);
+	}
+	ret = clk_prepare_enable(xspi->clk);
+	if (ret)
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+
 	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
 	master->dev.of_node = pdev->dev.of_node;
@@ -485,6 +496,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 put_master:
 	spi_master_put(master);
+	clk_disable_unprepare(xspi->clk);
 
 	return ret;
 }
@@ -503,6 +515,7 @@ static int xilinx_spi_remove(struct platform_device *pdev)
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
