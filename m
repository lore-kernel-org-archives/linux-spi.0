From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO level
Date: Thu, 30 Jun 2011 08:38:56 -0400
Message-ID: <1309437536-9315-2-git-send-email-padma.v@samsung.com>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
Content-Transfer-Encoding: 7BIT
To: kgene.kim@samsung.com, jassisinghbrar@gmail.com,
	sbkim73@samsung.com, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	linux-arm
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fixed the bug in transmission status check for 64 bytes FIFO
level.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/spi/spi_s3c64xx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index 795828b..8945e20 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -116,9 +116,7 @@
 					(((i)->fifo_lvl_mask + 1))) \
 					? 1 : 0)
 
-#define S3C64XX_SPI_ST_TX_DONE(v, i) ((((v) >> (i)->rx_lvl_offset) & \
-					(((i)->fifo_lvl_mask + 1) << 1)) \
-					? 1 : 0)
+#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)
 #define TX_FIFO_LVL(v, i) (((v) >> 6) & (i)->fifo_lvl_mask)
 #define RX_FIFO_LVL(v, i) (((v) >> (i)->rx_lvl_offset) & (i)->fifo_lvl_mask)
 
-- 
1.7.0.4
