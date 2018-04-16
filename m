From: sxauwsk <sxauwsk@163.com>
Subject: [PATCH] [PATCH v1] spi: cadence: Add usleep_range() for  cdns_spi_fill_tx_fifo()
Date: Mon, 16 Apr 2018 14:46:40 +0800
Message-ID: <1523861200-34130-1-git-send-email-sxauwsk@163.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangshikai@inno-instrument.cn, sxauwsk <sxauwsk@163.com>,
        guojian <guojian@innoinstrument.net>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In case of xspi work in busy condition, may send bytes failed.
once something wrong, spi controller did't work any more

My test found this situation appear in both of read/write process.
so when TX FIFO is full, add one byte delay before send data;

Signed-off-by: sxauwsk <sxauwsk@163.com>
Signed-off-by: guojian <guojian@innoinstrument.net>
Signed-off-by: wangshikai <wangshikai@inno-instrument.cn>
---
 drivers/spi/spi-cadence.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 66ae055..9694042 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -315,9 +315,11 @@ static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
 	       (xspi->tx_bytes > 0)) {
 
 		/* When xspi in busy condition, bytes may send failed,
-		 * caused communication failure so add one byte delay
+		 * then spi control did't work thoroughly, add one byte delay
 		 */
-		usleep_range(10, 20);
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR_OFFSET) &
+		    CDNS_SPI_IXR_TXFULL_MASK)
+			usleep_range(10, 20);
 
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-- 
1.7.9.5
