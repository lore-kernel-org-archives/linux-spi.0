From: Stefan Roese <sr@denx.de>
Subject: [PATCH 6/9 v3] staging: spi: mt7621: Use recommended comment style
Date: Fri,  1 Feb 2019 11:17:12 +0100
Message-ID: <20190201101715.3760-6-sr@denx.de>
References: <20190201101715.3760-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, Mark Brown <broonie@kernel.org>,
 John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>
To: linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201101715.3760-1-sr@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

This patch changes some comments to use the recommended multi-line
comment style.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: NeilBrown <neil@brown.name>
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v3:
- New patch, changes spilt into separate patches

 drivers/staging/mt7621-spi/spi-mt7621.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index e548f816ea9e..00cff75ee7ac 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -123,10 +123,10 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 	if (spi->mode & SPI_LSB_FIRST)
 		reg |= MT7621_LSB_FIRST;
 
-	/* This SPI controller seems to be tested on SPI flash only
-	 * and some bits are swizzled under other SPI modes probably
-	 * due to incorrect wiring inside the silicon. Only mode 0
-	 * works correctly.
+	/*
+	 * This SPI controller seems to be tested on SPI flash only and some
+	 * bits are swizzled under other SPI modes probably due to incorrect
+	 * wiring inside the silicon. Only mode 0 works correctly.
 	 */
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
 
@@ -155,9 +155,10 @@ static inline int mt7621_spi_wait_till_ready(struct mt7621_spi *rs)
 static void mt7621_spi_read_half_duplex(struct mt7621_spi *rs,
 					int rx_len, u8 *buf)
 {
-	/* Combine with any pending write, and perform one or
-	 * more half-duplex transactions reading 'len' bytes.
-	 * Data to be written is already in MT7621_SPI_DATA*
+	/*
+	 * Combine with any pending write, and perform one or more half-duplex
+	 * transactions reading 'len' bytes. Data to be written is already in
+	 * MT7621_SPI_DATA.
 	 */
 	int tx_len = rs->pending_write;
 
-- 
2.20.1
