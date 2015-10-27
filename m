From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: dw: replace magic constant by DW_SPI_DR
Date: Tue, 27 Oct 2015 17:48:16 +0200
Message-ID: <1445960896-118379-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The offset 0x60 is the offset of the data register defined as DW_SPI_DR in the
header file. Use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index cc2e980..882cd66 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -483,7 +483,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
 	dws->dma_inited = 0;
-	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
+	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dws->name, master);
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
