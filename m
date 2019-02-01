From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/2 v2] staging: spi: mt7621: Minor code cleanup
Date: Fri,  1 Feb 2019 09:57:12 +0100
Message-ID: <20190201085712.32380-2-sr@denx.de>
References: <20190201085712.32380-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, Mark Brown <broonie@kernel.org>,
 John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>
To: linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201085712.32380-1-sr@denx.de>
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

This patch cleans up some minor issues with this driver:
- Remove unnecessary header includes
- Sort header alphabetically
- Use correct comment style
- Add return code check on device_reset()
- Remove SPI_BPW_MASK definition (already available in
  include/linux/spi/spi.h)
- Use macros instead of hardcoded values for SPI_MASTER register access
  as suggested by Neil Brown (in mt7621_spi_reset and mt7621_spi_prepare)

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: NeilBrown <neil@brown.name>
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v2:
- Changes are done to the driver in staging before moving it out of
  staging into drivers/spi
- Remove SPI_BPW_MASK macro
- Use macros instead of hardcoded values for SPI_MASTER bits
- Remove code cleanup comment from TODO file

 drivers/staging/mt7621-spi/TODO         |  1 -
 drivers/staging/mt7621-spi/spi-mt7621.c | 65 ++++++++++++++-----------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/mt7621-spi/TODO b/drivers/staging/mt7621-spi/TODO
index fdbc5002c32a..126cc80c7c68 100644
--- a/drivers/staging/mt7621-spi/TODO
+++ b/drivers/staging/mt7621-spi/TODO
@@ -1,5 +1,4 @@
 
-- general code review and clean up
 - ensure device-tree requirements are documented
 
 Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index c2f6f9ce52a2..167d0f09823b 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -11,28 +11,21 @@
  *   Copyright (C) 2007-2008 Marvell Ltd.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/swab.h>
 
-#include <ralink_regs.h>
+#define DRIVER_NAME		"spi-mt7621"
 
-#define SPI_BPW_MASK(bits) BIT((bits) - 1)
-
-#define DRIVER_NAME			"spi-mt7621"
 /* in usec */
-#define RALINK_SPI_WAIT_MAX_LOOP	2000
+#define RALINK_SPI_WAIT_MAX_LOOP 2000
 
 /* SPISTAT register bit field */
-#define SPISTAT_BUSY			BIT(0)
+#define SPISTAT_BUSY		BIT(0)
 
 #define MT7621_SPI_TRANS	0x00
 #define SPITRANS_BUSY		BIT(16)
@@ -43,17 +36,21 @@
 #define SPI_CTL_TX_RX_CNT_MASK	0xff
 #define SPI_CTL_START		BIT(8)
 
-#define MT7621_SPI_POLAR	0x38
 #define MT7621_SPI_MASTER	0x28
+#define MASTER_MORE_BUFMODE	BIT(2)
+#define MASTER_FULL_DUPLEX	BIT(10)
+#define MASTER_RS_CLK_SEL	GENMASK(27, 16)
+#define MASTER_RS_CLK_SEL_SHIFT	16
+#define MASTER_RS_SLAVE_SEL	GENMASK(31, 29)
+
 #define MT7621_SPI_MOREBUF	0x2c
+#define MT7621_SPI_POLAR	0x38
 #define MT7621_SPI_SPACE	0x3c
 
 #define MT7621_CPHA		BIT(5)
 #define MT7621_CPOL		BIT(4)
 #define MT7621_LSB_FIRST	BIT(3)
 
-struct mt7621_spi;
-
 struct mt7621_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
@@ -84,9 +81,13 @@ static void mt7621_spi_reset(struct mt7621_spi *rs)
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
@@ -122,18 +123,18 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 		rate = 2;
 
 	reg = mt7621_spi_read(rs, MT7621_SPI_MASTER);
-	reg &= ~(0xfff << 16);
-	reg |= (rate - 2) << 16;
+	reg &= ~MASTER_RS_CLK_SEL;
+	reg |= (rate - 2) << MASTER_RS_CLK_SEL_SHIFT;
 	rs->speed = speed;
 
 	reg &= ~MT7621_LSB_FIRST;
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
 
@@ -162,9 +163,10 @@ static inline int mt7621_spi_wait_till_ready(struct mt7621_spi *rs)
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
 
@@ -194,6 +196,7 @@ static void mt7621_spi_read_half_duplex(struct mt7621_spi *rs,
 			*buf++ = val & 0xff;
 			val >>= 8;
 		}
+
 		rx_len -= i;
 	}
 }
@@ -287,6 +290,7 @@ static int mt7621_spi_transfer_one_message(struct spi_master *master,
 	mt7621_spi_flush(rs);
 
 	mt7621_spi_set_cs(spi, 0);
+
 msg_done:
 	m->status = status;
 	spi_finalize_current_message(master);
@@ -327,6 +331,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	int status = 0;
 	struct clk *clk;
 	struct mt7621_spi_ops *ops;
+	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
@@ -374,7 +379,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "SPI reset failed!\n");
+		return ret;
+	}
 
 	mt7621_spi_reset(rs);
 
-- 
2.20.1
