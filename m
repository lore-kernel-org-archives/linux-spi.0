From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 2/2] spi_txx9: Fix bit rate calculation
Date: Thu,  3 Sep 2009 22:59:01 +0900
Message-ID: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	david-b@pacbell.net
To: linux-mips@linux-mips.org
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

TXx9 SPI bit rate is calculated by:
        fBR = (spi-baseclk) / (n + 1)
Fix calculation of min_speed_hz, max_speed_hz and n.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/spi/spi_txx9.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi_txx9.c b/drivers/spi/spi_txx9.c
index 96057de..19f7562 100644
--- a/drivers/spi/spi_txx9.c
+++ b/drivers/spi/spi_txx9.c
@@ -29,6 +29,8 @@
 
 
 #define SPI_FIFO_SIZE 4
+#define SPI_MAX_DIVIDER 0xff	/* Max. value for SPCR1.SER */
+#define SPI_MIN_DIVIDER 1	/* Min. value for SPCR1.SER */
 
 #define TXx9_SPMCR		0x00
 #define TXx9_SPCR0		0x04
@@ -193,11 +195,8 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 
 		if (prev_speed_hz != speed_hz
 				|| prev_bits_per_word != bits_per_word) {
-			u32 n = (c->baseclk + speed_hz - 1) / speed_hz;
-			if (n < 1)
-				n = 1;
-			else if (n > 0xff)
-				n = 0xff;
+			int n = DIV_ROUND_UP(c->baseclk, speed_hz) - 1;
+			n = clamp(n, SPI_MIN_DIVIDER, SPI_MAX_DIVIDER);
 			/* enter config mode */
 			txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR,
 					TXx9_SPMCR);
@@ -370,8 +369,8 @@ static int __init txx9spi_probe(struct platform_device *dev)
 		goto exit;
 	}
 	c->baseclk = clk_get_rate(c->clk);
-	c->min_speed_hz = (c->baseclk + 0xff - 1) / 0xff;
-	c->max_speed_hz = c->baseclk;
+	c->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
+	c->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
1.5.6.5
