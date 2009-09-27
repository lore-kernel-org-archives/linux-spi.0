From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH] atmel_spi: fix dma addr calculation for len > BUFFER_SIZE
Date: Sun, 27 Sep 2009 15:26:27 +1000
Message-ID: <1254029187.7587.146.camel@ben-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	kernel <kernel@avr32linux.org>, dbrownell@users.sourceforge.net
To: hskinnemoen@atmel.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751972AbZI0FWR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


If len > BUFFER_LEN and !xfer->rx_buf we end up calculating the tx
buffer address as

*tx_dma = xfer->tx_dma + xfer->len - BUFFER_SIZE;

which is constant; i.e. we just send the last BUFFER_SIZE data over
again until we've reached the right number of bytes.

This patch gets around this by using the /requested/ length when
calculating addresses.

Note there's no way len != *plen when we calculate the rx buffer address
but conceptually we should be using *plen and I don't want someone to
come through later, see the calculations for rx and tx are different and
"clean up" back to what we had.

Signed-off-by: Ben Nizette <bn@niasdigital.com>

---
 drivers/spi/atmel_spi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index f5b3fdb..8ce70cb 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -189,14 +189,14 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 
 	/* use scratch buffer only when rx or tx data is unspecified */
 	if (xfer->rx_buf)
-		*rx_dma = xfer->rx_dma + xfer->len - len;
+		*rx_dma = xfer->rx_dma + xfer->len - *plen;
 	else {
 		*rx_dma = as->buffer_dma;
 		if (len > BUFFER_SIZE)
 			len = BUFFER_SIZE;
 	}
 	if (xfer->tx_buf)
-		*tx_dma = xfer->tx_dma + xfer->len - len;
+		*tx_dma = xfer->tx_dma + xfer->len - *plen;
 	else {
 		*tx_dma = as->buffer_dma;
 		if (len > BUFFER_SIZE)
-- 
1.6.0.4
