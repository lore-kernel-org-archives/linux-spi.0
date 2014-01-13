From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi/pxa2xx: initialize DMA channels to -1 to prevent inadvertent match
Date: Mon, 13 Jan 2014 11:17:04 +0200
Message-ID: <1389604624-8412-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit cddb339badb0 (spi/pxa2xx: convert to dma_request_slave_channel_compat())
converted the driver to use ACPI provided DMA helpers but it forgot to
initialize the platform data for the channels to -1. Failing to do so will
result inadvertent match in the filter function because 0 is a valid
channel number.

Prevent this from happening by initializing both platform data channels
correctly to -1.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7765b1999537..cbc68848789d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1066,6 +1066,8 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
+	pdata->tx_chan_id = -1;
+	pdata->rx_chan_id = -1;
 
 	return pdata;
 }
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
