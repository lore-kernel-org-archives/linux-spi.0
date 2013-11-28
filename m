From: Thomas Behan <thomas.behan@gmail.com>
Subject: [PATCH 3/4] spi: omap-100k: Fixed spacing on commas
Date: Wed, 27 Nov 2013 23:27:23 -0500
Message-ID: <1385612844-22482-4-git-send-email-thomas.behan@gmail.com>
References: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Cc: broonie@linaro.org, linux-kernel@vger.kernel.org,
	Thomas Behan <thomas.behan@gmail.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385612844-22482-1-git-send-email-thomas.behan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch.pl generated 5 errors due to missing spaces after commas. These
errors have been fixed.

Signed-off-by: Thomas Behan <thomas.behan@gmail.com>
---
 drivers/spi/spi-omap-100k.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 5db8d2a..fcd783c 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -155,7 +155,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 
 static int spi100k_read_data(struct spi_master *master, int len)
 {
-	int dataH,dataL;
+	int dataH, dataL;
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
 
 	/* Always do at least 16 bits */
@@ -236,9 +236,9 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		do {
 			c -= 2;
 			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master,word_len, *tx++);
+				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
-				*rx++ = spi100k_read_data(spi->master,word_len);
+				*rx++ = spi100k_read_data(spi->master, word_len);
 		} while (c);
 	} else if (word_len <= 32) {
 		u32             *rx;
@@ -249,9 +249,9 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		do {
 			c -= 4;
 			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master,word_len, *tx);
+				spi100k_write_data(spi->master, word_len, *tx);
 			if (xfer->rx_buf != NULL)
-				*rx = spi100k_read_data(spi->master,word_len);
+				*rx = spi100k_read_data(spi->master, word_len);
 		} while (c);
 	}
 	return count - c;
-- 
1.8.1.2
