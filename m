From: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/pxa2xx: change default supported DMA burst size to 1
Date: Fri,  6 Jun 2014 01:45:09 +0800
Message-ID: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LKML-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

This is to fix the SPI DMA transfer failure for speed less than 1M.
If using current DMA burst size setting (16), the Rx data bytes are
invalid due to each data byte is multiplied according to the burst
size setting.

Let's said supposedly we shall receive the following 18 bytes of data:
01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18
Instead, the data bytes received consist of "16 bytes of '01' +
2 bytes of '02'" :
01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 02 02

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index f6759dc..c41ff14 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -368,7 +368,7 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 	 * otherwise we use the default. Also we use the default FIFO
 	 * thresholds for now.
 	 */
-	*burst_code = chip_info ? chip_info->dma_burst_size : 16;
+	*burst_code = chip_info ? chip_info->dma_burst_size : 1;
 	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
 		   | SSCR1_TxTresh(TX_THRESH_DFLT);
 
-- 
1.7.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
