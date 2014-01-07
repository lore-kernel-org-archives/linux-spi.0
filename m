From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: ti-qspi: Fix getting correct address for qspi
Date: Tue, 07 Jan 2014 16:25:50 +0800
Message-ID: <1389083150.24471.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

platform_get_drvdata() returns the address of qspi rather than master.
Also drop unneeded spi_unregister_master() call in ti_qspi_remove() because
we use devm_spi_register_master() in probe.

Fixes: f17414c4fcf1 (spi/qspi: set correct platform drvdata in ti_qspi_probe())
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 9190e03..4b413e9 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -563,13 +563,9 @@ free_master:
 
 static int ti_qspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master;
-	struct ti_qspi *qspi;
+	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int ret;
 
-	master = platform_get_drvdata(pdev);
-	qspi = spi_master_get_devdata(master);
-
 	ret = pm_runtime_get_sync(qspi->dev);
 	if (ret < 0) {
 		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
@@ -581,8 +577,6 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put(qspi->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	spi_unregister_master(master);
-
 	return 0;
 }
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
