From: Thomas Behan <thomas.behan@gmail.com>
Subject: [PATCH 2/4] spi: omap-100k: Fixed spacing on -= operators
Date: Wed, 27 Nov 2013 23:27:22 -0500
Message-ID: <1385612844-22482-3-git-send-email-thomas.behan@gmail.com>
References: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Cc: broonie@linaro.org, linux-kernel@vger.kernel.org,
	Thomas Behan <thomas.behan@gmail.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch.pl generated 3 errors from "x-=" statements which should have read
"x -= x" to comply with the style guide. These errors have been fixed.

Signed-off-by: Thomas Behan <thomas.behan@gmail.com>
---
 drivers/spi/spi-omap-100k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index bdf6696..5db8d2a 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -221,7 +221,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=1;
+			c -= 1;
 			if (xfer->tx_buf != NULL)
 				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
@@ -234,7 +234,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=2;
+			c -= 2;
 			if (xfer->tx_buf != NULL)
 				spi100k_write_data(spi->master,word_len, *tx++);
 			if (xfer->rx_buf != NULL)
@@ -247,7 +247,7 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=4;
+			c -= 4;
 			if (xfer->tx_buf != NULL)
 				spi100k_write_data(spi->master,word_len, *tx);
 			if (xfer->rx_buf != NULL)
-- 
1.8.1.2
