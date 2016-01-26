From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Print actual DMA/PIO transfer mode in debug messages
Date: Tue, 26 Jan 2016 15:33:21 +0200
Message-ID: <1453815201-3178-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Transfer debug messages don't actually show is the transfer really using
DMA. Driver may fall back to PIO in case transfer size is not within the
certain limits or fails to map DMA buffers but debug messages don't reveal
that.

Move these debug messages further in pump_transfers() where the actual
transfer mode is known and use drv_data->dma_mapped flag instead of
chip->enable_dma for printing the mode.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ab9914ad8365..227e8bad19e6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1001,19 +1001,6 @@ static void pump_transfers(unsigned long data)
 					     "pump_transfers: DMA burst size reduced to match bits_per_word\n");
 	}
 
-	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
-	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
-	if (!pxa25x_ssp_comp(drv_data))
-		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz
-				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
-			chip->enable_dma ? "DMA" : "PIO");
-	else
-		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz / 2
-				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
-			chip->enable_dma ? "DMA" : "PIO");
-
 	message->state = RUNNING_STATE;
 
 	drv_data->dma_mapped = 0;
@@ -1040,6 +1027,19 @@ static void pump_transfers(unsigned long data)
 		write_SSSR_CS(drv_data, drv_data->clear_sr);
 	}
 
+	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
+	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
+	if (!pxa25x_ssp_comp(drv_data))
+		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz
+				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
+			drv_data->dma_mapped ? "DMA" : "PIO");
+	else
+		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz / 2
+				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+			drv_data->dma_mapped ? "DMA" : "PIO");
+
 	if (is_lpss_ssp(drv_data)) {
 		if ((pxa2xx_spi_read(drv_data, SSIRF) & 0xff)
 		    != chip->lpss_rx_threshold)
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
