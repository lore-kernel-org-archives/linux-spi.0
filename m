From: Stefan Roese <sr@denx.de>
Subject: [PATCH 8/9 v3] staging: spi: mt7621: Use macros instead of hardcoded
 values
Date: Fri,  1 Feb 2019 11:17:14 +0100
Message-ID: <20190201101715.3760-8-sr@denx.de>
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

This patch uses macros instead of hardcoded values for the SPI_MASTER
register access in mt7621_spi_reset() and mt7621_spi_prepare().

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

 drivers/staging/mt7621-spi/spi-mt7621.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index 89586a895320..d6385220b796 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -37,6 +37,12 @@
 #define SPI_CTL_START		BIT(8)
 
 #define MT7621_SPI_MASTER	0x28
+#define MASTER_MORE_BUFMODE	BIT(2)
+#define MASTER_FULL_DUPLEX	BIT(10)
+#define MASTER_RS_CLK_SEL	GENMASK(27, 16)
+#define MASTER_RS_CLK_SEL_SHIFT	16
+#define MASTER_RS_SLAVE_SEL	GENMASK(31, 29)
+
 #define MT7621_SPI_MOREBUF	0x2c
 #define MT7621_SPI_POLAR	0x38
 #define MT7621_SPI_SPACE	0x3c
@@ -77,9 +83,13 @@ static void mt7621_spi_reset(struct mt7621_spi *rs)
 {
 	u32 master = mt7621_spi_read(rs, MT7621_SPI_MASTER);
 
-	master |= 7 << 29;
-	master |= 1 << 2;
-	master &= ~(1 << 10);
+	/*
+	 * Select SPI device 7, enable "more buffer mode" and disable
+	 * full-duplex (only half-duplex really works on this chip
+	 * reliably)
+	 */
+	master |= MASTER_RS_SLAVE_SEL | MASTER_MORE_BUFMODE;
+	master &= ~MASTER_FULL_DUPLEX;
 
 	mt7621_spi_write(rs, MT7621_SPI_MASTER, master);
 	rs->pending_write = 0;
@@ -115,8 +125,8 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 		rate = 2;
 
 	reg = mt7621_spi_read(rs, MT7621_SPI_MASTER);
-	reg &= ~(0xfff << 16);
-	reg |= (rate - 2) << 16;
+	reg &= ~MASTER_RS_CLK_SEL;
+	reg |= (rate - 2) << MASTER_RS_CLK_SEL_SHIFT;
 	rs->speed = speed;
 
 	reg &= ~MT7621_LSB_FIRST;
-- 
2.20.1
