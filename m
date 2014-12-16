From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] spi: img-spfi: Enable controller before starting TX DMA
Date: Tue, 16 Dec 2014 13:05:44 -0800
Message-ID: <1418763946-22260-1-git-send-email-abrestic@chromium.org>
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It is recommended that the SPFI controller be enabled (i.e. setting
SPFI_EN in SPFI_CONTROL) before TX DMA begins.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 43781c9..e7e79e6 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -390,14 +390,14 @@ static int img_spfi_start_dma(struct spi_master *master,
 		dma_async_issue_pending(spfi->rx_ch);
 	}
 
+	spfi_start(spfi);
+
 	if (xfer->tx_buf) {
 		spfi->tx_dma_busy = true;
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(spfi->tx_ch);
 	}
 
-	spfi_start(spfi);
-
 	return 1;
 
 stop_dma:
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
