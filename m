From: sxauwsk <sxauwsk@163.com>
Subject: [PATCH] spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()
Date: Mon, 16 Apr 2018 20:07:31 +0800
Message-ID: <1523880451-37748-1-git-send-email-sxauwsk@163.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sxauwsk <sxauwsk@163.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In case of xspi work in busy condition, may send bytes failed then caused
communication failure. once something wrong, spi controller did't work any more.

My test found this situation appear in both of read/write operation.
so when TX FIFO is full, add one byte delay before send data.

Signed-off-by: sxauwsk <sxauwsk@163.com>
---
 drivers/spi/spi-cadence.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5c9516a..9694042 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -313,6 +313,14 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)

	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
 	       (xspi->tx_bytes > 0)) {
+
+		/* When xspi in busy condition, bytes may send failed,
+		 * then spi control did't work thoroughly, add one byte delay
+		 */
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
+		    CDNS_SPI_IXR_TXFULL_MASK)
+			usleep_range(10, 20);
+
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
 		else
--
1.7.9.5
