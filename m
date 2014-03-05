From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH 2/2] spi: sirf: Add missing spi_master_{resume,suspend}
 calls to PM callbacks
Date: Wed, 05 Mar 2014 15:19:09 +0800
Message-ID: <1394003949.18343.4.camel@phoenix>
References: <1394003843.18343.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394003843.18343.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is required since commit 2025172e3280 "spi/bitbang: Use core message pump".
spi-bitbang now uses core message pump, so it needs to call spi_master_suspend/
spi_master_resume to stop/start the queue while suspend/resume.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a72b8f8..1a77ad5 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -748,6 +748,11 @@ static int spi_sirfsoc_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct sirfsoc_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
 
 	clk_disable(sspi->clk);
 	return 0;
@@ -764,7 +769,7 @@ static int spi_sirfsoc_resume(struct device *dev)
 	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
 	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
 
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
