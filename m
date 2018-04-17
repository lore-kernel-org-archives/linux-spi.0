From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 6/8] spi: spi-s3c64xx: Fix indentation in the register
 offset definitions
Date: Tue, 17 Apr 2018 16:29:52 +0200
Message-ID: <20180417142954.5507-6-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143049epcas2p1a9244272897740ac03d7a21d5dfb5d14@epcas2p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, kgene@kernel.org, andi@etezian.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
To: broonie@kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180417142954.5507-1-s.nawrocki@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Change indentation so register address offset and register bit definitions
are aligned to same column.

Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b9b406138675..db33bc9b4147 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -28,15 +28,15 @@
 
 #define S3C64XX_SPI_CH_CFG		0x00
 #define S3C64XX_SPI_CLK_CFG		0x04
-#define S3C64XX_SPI_MODE_CFG	0x08
-#define S3C64XX_SPI_SLAVE_SEL	0x0C
+#define S3C64XX_SPI_MODE_CFG		0x08
+#define S3C64XX_SPI_SLAVE_SEL		0x0C
 #define S3C64XX_SPI_INT_EN		0x10
 #define S3C64XX_SPI_STATUS		0x14
 #define S3C64XX_SPI_TX_DATA		0x18
 #define S3C64XX_SPI_RX_DATA		0x1C
-#define S3C64XX_SPI_PACKET_CNT	0x20
-#define S3C64XX_SPI_PENDING_CLR	0x24
-#define S3C64XX_SPI_SWAP_CFG	0x28
+#define S3C64XX_SPI_PACKET_CNT		0x20
+#define S3C64XX_SPI_PENDING_CLR		0x24
+#define S3C64XX_SPI_SWAP_CFG		0x28
 #define S3C64XX_SPI_FB_CLK		0x2C
 
 #define S3C64XX_SPI_CH_HS_EN		(1<<6)	/* High Speed Enable */
@@ -77,9 +77,9 @@
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
 
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
-#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR	(1<<4)
+#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
-#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR	(1<<2)
+#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		(1<<2)
 #define S3C64XX_SPI_ST_RX_FIFORDY		(1<<1)
 #define S3C64XX_SPI_ST_TX_FIFORDY		(1<<0)
 
@@ -100,7 +100,7 @@
 #define S3C64XX_SPI_SWAP_TX_BIT			(1<<1)
 #define S3C64XX_SPI_SWAP_TX_EN			(1<<0)
 
-#define S3C64XX_SPI_FBCLK_MSK		(3<<0)
+#define S3C64XX_SPI_FBCLK_MSK			(3<<0)
 
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
-- 
2.14.2
