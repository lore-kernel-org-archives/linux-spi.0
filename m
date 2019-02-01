From: Stefan Roese <sr@denx.de>
Subject: [PATCH 5/9 v3] staging: spi: mt7621: Minor cosmetic changes
Date: Fri,  1 Feb 2019 11:17:11 +0100
Message-ID: <20190201101715.3760-5-sr@denx.de>
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

Align  macro definitions and add some empty lines to make the code better
readable.

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

 drivers/staging/mt7621-spi/spi-mt7621.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index fe9c863af1cc..e548f816ea9e 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -19,12 +19,13 @@
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
-#define DRIVER_NAME			"spi-mt7621"
+#define DRIVER_NAME		"spi-mt7621"
+
 /* in usec */
-#define RALINK_SPI_WAIT_MAX_LOOP	2000
+#define RALINK_SPI_WAIT_MAX_LOOP 2000
 
 /* SPISTAT register bit field */
-#define SPISTAT_BUSY			BIT(0)
+#define SPISTAT_BUSY		BIT(0)
 
 #define MT7621_SPI_TRANS	0x00
 #define SPITRANS_BUSY		BIT(16)
@@ -186,6 +187,7 @@ static void mt7621_spi_read_half_duplex(struct mt7621_spi *rs,
 			*buf++ = val & 0xff;
 			val >>= 8;
 		}
+
 		rx_len -= i;
 	}
 }
@@ -279,6 +281,7 @@ static int mt7621_spi_transfer_one_message(struct spi_master *master,
 	mt7621_spi_flush(rs);
 
 	mt7621_spi_set_cs(spi, 0);
+
 msg_done:
 	m->status = status;
 	spi_finalize_current_message(master);
-- 
2.20.1
