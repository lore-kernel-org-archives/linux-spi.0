From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v6 2/2] spi-atmel: support inter-word delay
Date: Wed, 30 Jan 2019 09:40:05 +0100
Message-ID: <20190130084005.18649-3-jonas@norrbonn.se>
References: <20190130084005.18649-1-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130084005.18649-1-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..4954f0ab1606 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 *
-	 * DLYBCT would add delays between words, slowing down transfers.
-	 * It could potentially be useful to cope with DMA bottlenecks, but
-	 * in those cases it's probably best to just use a lower bitrate.
 	 */
 	csr |= SPI_BF(DLYBS, 0);
-	csr |= SPI_BF(DLYBCT, 0);
+
+	/* DLYBCT adds delays between words.  This is useful for slow devices
+	 * that need a bit of time to setup the next transfer.
+	 */
+	csr |= SPI_BF(DLYBCT,
+			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.19.1
