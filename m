From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/2] spi-atmel: support inter-word delay
Date: Fri, 25 Jan 2019 12:44:29 +0100
Message-ID: <20190125114429.20066-3-jonas@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125114429.20066-1-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
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
index 74fddcd3282b..88ff3fef56e9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1209,13 +1209,14 @@ static int atmel_spi_setup(struct spi_device *spi)
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
+		clamp_t(u8, (as->spi_clk/1000000*spi->word_delay)>>5, 1, 255));
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1
