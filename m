From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 07/10] spi: dw: eliminate unused threshold variables
Date: Wed, 14 Oct 2015 23:12:22 +0300
Message-ID: <1444853545-59868-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The tx_threshold and rx_threshold variables are not used anywhere. Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 5dae557..a2ee776 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -36,8 +36,6 @@ struct chip_data {
 
 	u8 poll_mode;		/* 1 means use poll mode */
 
-	u32 rx_threshold;
-	u32 tx_threshold;
 	u8 enable_dma;
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
@@ -425,9 +423,6 @@ static int dw_spi_setup(struct spi_device *spi)
 
 		chip->poll_mode = chip_info->poll_mode;
 		chip->type = chip_info->type;
-
-		chip->rx_threshold = 0;
-		chip->tx_threshold = 0;
 	}
 
 	chip->tmode = 0; /* Tx & Rx */
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
