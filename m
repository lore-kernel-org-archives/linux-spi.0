From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] spi: s3c64xx: fix runtime PM handling
Date: Tue, 18 Aug 2015 23:06:09 +0200
Message-ID: <55D39E41.8010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch fixes / extends the runtime PM handling.
- Currently the driver instructs the SPI core to use auto-suspend
  but doesn't configure it. Add the necessary calls and let it
  autosuspend after probe.
- In case the driver registration fails runtime PM needs to be
  properly disabled.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c4d3b06..15a6de1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -32,6 +32,7 @@
 #define MAX_SPI_PORTS		6
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
+#define AUTOSUSPEND_TIMEOUT     2000
 
 /* Registers and bit-fields */
 
@@ -1180,13 +1181,15 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
+	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	ret = devm_spi_register_master(dev, master);
 	if (ret != 0) {
 		dev_err(dev, "cannot register SPI master: %d\n", ret);
-		goto err3;
+		goto err4;
 	}
 
 	dev_dbg(dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
@@ -1195,8 +1198,14 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_autosuspend(dev);
+
 	return 0;
 
+err4:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 err3:
 	clk_disable_unprepare(sdd->src_clk);
 err2:
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
