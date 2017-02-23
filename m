From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 5/6] spi: davinci: do not use DMA for vmalloc'ed buffers
Date: Thu, 23 Feb 2017 19:02:00 +0100
Message-ID: <1487872921-26628-6-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Using vmalloc'ed buffers will fail since daVinci has
VIVT cache and only the kernel lowmem virtual address
is invalidated/flushed when performing DMA.
The virtual address returned from vmalloc() is not
invalidated/flushed and may contain stale data when
returning from spi_sync().
Fixes errors when running UBIFS over SPI NOR.
Revert this when all upper layer users of vmalloc'ed
buffers sent to SPI handles cache flushing/invalidating.

Signed-off-by: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 75c658e..f37bbdd 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -482,7 +482,9 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 
 	if (spicfg)
 		can_dma = (spicfg->io_type == SPI_IO_TYPE_DMA) &&
-			(xfer->len >= DMA_MIN_BYTES);
+			(xfer->len >= DMA_MIN_BYTES) &&
+			!is_vmalloc_addr(xfer->rx_buf) &&
+			!is_vmalloc_addr(xfer->tx_buf);
 
 	return can_dma;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
