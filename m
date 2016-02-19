From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Remove unused DMA buffer mappings
Date: Fri, 19 Feb 2016 15:01:21 +0200
Message-ID: <1455886881-5790-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Only legacy PXA DMA implementation was using these rx_dma and tx_dma DMA
addresses so they are not needed after commit 6356437e65c2
("spi: spi-pxa2xx: remove legacy PXA DMA bits").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 --
 drivers/spi/spi-pxa2xx.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0eb79368eabc..2c4e8ccd573b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -995,8 +995,6 @@ static void pump_transfers(unsigned long data)
 	drv_data->tx_end = drv_data->tx + transfer->len;
 	drv_data->rx = transfer->rx_buf;
 	drv_data->rx_end = drv_data->rx + transfer->len;
-	drv_data->rx_dma = transfer->rx_dma;
-	drv_data->tx_dma = transfer->tx_dma;
 	drv_data->len = transfer->len;
 	drv_data->write = drv_data->tx ? chip->write : null_writer;
 	drv_data->read = drv_data->rx ? chip->read : null_reader;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 8e781c8b4374..a1ef88948144 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -69,8 +69,6 @@ struct driver_data {
 	void *rx;
 	void *rx_end;
 	int dma_mapped;
-	dma_addr_t rx_dma;
-	dma_addr_t tx_dma;
 	size_t rx_map_len;
 	size_t tx_map_len;
 	u8 n_bytes;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
