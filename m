From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] spi: img-spfi: Increase DMA burst size
Date: Tue, 16 Dec 2014 13:05:46 -0800
Message-ID: <1418763946-22260-3-git-send-email-abrestic@chromium.org>
References: <1418763946-22260-1-git-send-email-abrestic@chromium.org>
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418763946-22260-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A 1-byte burst size is rather inefficient and has been shown to cause
TX issues during testing.  Increase the DMA burst size to 4-bytes for
both RX and TX DMA when using the 8-bit FIFO.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 2b29df0..29b97f8 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -336,7 +336,7 @@ static int img_spfi_start_dma(struct spi_master *master,
 		} else {
 			rxconf.src_addr = spfi->phys + SPFI_RX_8BIT_VALID_DATA;
 			rxconf.src_addr_width = 1;
-			rxconf.src_maxburst = 1;
+			rxconf.src_maxburst = 4;
 		}
 		dmaengine_slave_config(spfi->rx_ch, &rxconf);
 
@@ -360,7 +360,7 @@ static int img_spfi_start_dma(struct spi_master *master,
 		} else {
 			txconf.dst_addr = spfi->phys + SPFI_TX_8BIT_VALID_DATA;
 			txconf.dst_addr_width = 1;
-			txconf.dst_maxburst = 1;
+			txconf.dst_maxburst = 4;
 		}
 		dmaengine_slave_config(spfi->tx_ch, &txconf);
 
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
