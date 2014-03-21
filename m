From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] spi: fix spi-atmel.c printk format warnings
Date: Fri, 21 Mar 2014 08:53:41 -0700
Message-ID: <532C6085.9070203@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Morton <akpm@linux-foundation.org>
To: Mark Brown <broonie@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning by using %p extension 'ad' for dma_addr_t.

drivers/spi/spi-atmel.c:1228:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat]
drivers/spi/spi-atmel.c:1228:3: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

I thought that a patch for this was already posted but I can't find it...
Applies to mainline.

--- linux-next-20140321.orig/drivers/spi/spi-atmel.c
+++ linux-next-20140321/drivers/spi/spi-atmel.c
@@ -1226,10 +1226,10 @@ static int atmel_spi_transfer_one_messag
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		dev_dbg(&spi->dev,
-			"  xfer %p: len %u tx %p/%08x rx %p/%08x\n",
+			"  xfer %p: len %u tx %p/%pad rx %p/%pad\n",
 			xfer, xfer->len,
-			xfer->tx_buf, xfer->tx_dma,
-			xfer->rx_buf, xfer->rx_dma);
+			xfer->tx_buf, &xfer->tx_dma,
+			xfer->rx_buf, &xfer->rx_dma);
 	}
 
 msg_done:
