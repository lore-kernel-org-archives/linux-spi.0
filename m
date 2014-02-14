From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] spi: coldfire-qspi: Fix getting correct address for
 *mcfqspi
Date: Fri, 14 Feb 2014 09:53:00 +0800
Message-ID: <1392342780.22981.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

dev_get_drvdata() returns the address of master rather than mcfqspi.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 0ab2c55..8e4f1c9c 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -508,7 +508,8 @@ static int mcfqspi_resume(struct device *dev)
 #ifdef CONFIG_PM_RUNTIME
 static int mcfqspi_runtime_suspend(struct device *dev)
 {
-	struct mcfqspi *mcfqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 
 	clk_disable(mcfqspi->clk);
 
@@ -517,7 +518,8 @@ static int mcfqspi_runtime_suspend(struct device *dev)
 
 static int mcfqspi_runtime_resume(struct device *dev)
 {
-	struct mcfqspi *mcfqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 
 	clk_enable(mcfqspi->clk);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
