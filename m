From: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/3] spi: xilinx: Add QUAD support
Date: Mon, 30 May 2016 15:17:01 +0530
Message-ID: <1464601621-5157-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Naga Sureshkumar Relli" <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds QUAD mode support to axi spi controller.
updated supported mode bits to SPI_TX_QUAD and SPI_RX_QUAD.

Signed-off-by: Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
changes for v2
 - none
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d903857..4467590 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -74,6 +74,7 @@
 
 /* Number of data lines used to receive */
 #define XSPI_RX_ONE_WIRE	1
+#define XSPI_RX_FOUR_WIRE	4
 
 /**
  * struct xilinx_spi - This definition define spi driver instance
@@ -558,8 +559,10 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 			xspi->tx_fifo = xspi_fill_tx_fifo_32;
 			xspi->rx_fifo = xspi_read_rx_fifo_32;
 		}
+	} else if (xspi->rx_bus_width == XSPI_RX_FOUR_WIRE) {
+		master->mode_bits |= SPI_TX_QUAD | SPI_RX_QUAD;
 	} else {
-		dev_err(&pdev->dev, "Dual/Quad Modes are not supported\n");
+		dev_err(&pdev->dev, "Dual Mode not supported\n");
 		goto put_master;
 	}
 	xspi->cs_inactive = 0xffffffff;
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
