From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: coldfire-qspi: Enable clock before calling
 spi_master_resume
Date: Wed, 26 Feb 2014 09:47:55 +0800
Message-ID: <1393379275.7490.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This ensures clock has been enabled before calling spi_master_resume().
while at it, also add checking return value of spi_master_suspend and
spi_master_resume because they may fail.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index c29bbb0..62daf87 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -467,8 +467,11 @@ static int mcfqspi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	int ret;
 
-	spi_master_suspend(master);
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
 
 	clk_disable(mcfqspi->clk);
 
@@ -480,11 +483,9 @@ static int mcfqspi_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 
-	spi_master_resume(master);
-
 	clk_enable(mcfqspi->clk);
 
-	return 0;
+	return spi_master_resume(master);
 }
 #endif
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
