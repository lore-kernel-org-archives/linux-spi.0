From: Vicente Bergas <vicencb@gmail.com>
Subject: [PATCH] spi: rockchip: Revert "set min/max speed"
Date: Sun,  7 Apr 2019 02:57:59 +0200
Message-ID: <20190407005759.2425-1-vicencb@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vicente Bergas <vicencb@gmail.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This reverts
commit 420b82f84294 ("spi: rockchip: set min/max speed")
commit 74b7efa82b11 ("spi: rockchip: precompute rx sample delay")
The former breaks bursts of writes of 48 bytes or more.
Both patches touch the same part of the file and it is not trivial to
only revert the first. Reverting both just results in an easy to fix
conflict.

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
---
 drivers/spi/spi-rockchip.c | 80 ++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3912526ead66..682f3567a8c8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -97,7 +97,6 @@
 #define CR0_BHT_8BIT				0x1
 
 #define CR0_RSD_OFFSET				14
-#define CR0_RSD_MAX				0x3
 
 #define CR0_FRF_OFFSET				16
 #define CR0_FRF_SPI					0x0
@@ -119,10 +118,6 @@
 /* Bit fields in SER, 2bit */
 #define SER_MASK					0x3
 
-/* Bit fields in BAUDR */
-#define BAUDR_SCKDV_MIN				2
-#define BAUDR_SCKDV_MAX				65534
-
 /* Bit fields in SR, 5bit */
 #define SR_MASK						0x1f
 #define SR_BUSY						(1 << 0)
@@ -155,7 +150,7 @@
 #define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
-#define MAX_SCLK_OUT				50000000U
+#define MAX_SCLK_OUT		50000000
 
 /*
  * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
@@ -184,11 +179,12 @@ struct rockchip_spi {
 
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
-	/* frequency of spiclk */
-	u32 freq;
+	/* max bus freq supported */
+	u32 max_freq;
 
 	u8 n_bytes;
-	u8 rsd;
+	u32 rsd_nsecs;
+	u32 speed;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 };
@@ -198,6 +194,11 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
+static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
+{
+	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
+}
+
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -472,9 +473,10 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 	u32 cr1;
+	u32 div = 0;
 	u32 dmacr = 0;
+	int rsd = 0;
 
-	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
@@ -514,6 +516,33 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
+	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
+		rs->speed = MAX_SCLK_OUT;
+
+	/* the minimum divisor is 2 */
+	if (rs->max_freq < 2 * rs->speed) {
+		clk_set_rate(rs->spiclk, 2 * rs->speed);
+		rs->max_freq = clk_get_rate(rs->spiclk);
+	}
+
+	/* div doesn't support odd number */
+	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
+	div = (div + 1) & 0xfffe;
+
+	/* Rx sample delay is expressed in parent clock cycles (max 3) */
+	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->max_freq >> 8),
+				1000000000 >> 8);
+	if (!rsd && rs->rsd_nsecs) {
+		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
+			     rs->max_freq, rs->rsd_nsecs);
+	} else if (rsd > 3) {
+		rsd = 3;
+		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+			     rs->max_freq, rs->rsd_nsecs,
+			     rsd * 1000000000U / rs->max_freq);
+	}
+	cr0 |= rsd << CR0_RSD_OFFSET;
+
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 	writel_relaxed(cr1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
@@ -530,12 +559,9 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-	/* the hardware only supports an even clock divisor, so
-	 * round divisor = spiclk / speed up to nearest even number
-	 * so that the resulting speed is <= the requested speed
-	 */
-	writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
-			rs->regs + ROCKCHIP_SPI_BAUDR);
+	spi_set_clk(rs, div);
+
+	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
 }
 
 static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
@@ -564,6 +590,7 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
+	rs->speed = xfer->speed_hz;
 	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
 
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
@@ -652,24 +679,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 
 	rs->dev = &pdev->dev;
-	rs->freq = clk_get_rate(rs->spiclk);
+	rs->max_freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
-				  &rsd_nsecs)) {
-		/* rx sample delay is expressed in parent clock cycles (max 3) */
-		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8),
-				1000000000 >> 8);
-		if (!rsd) {
-			dev_warn(rs->dev, "%u Hz are too slow to express %u ns delay\n",
-					rs->freq, rsd_nsecs);
-		} else if (rsd > CR0_RSD_MAX) {
-			rsd = CR0_RSD_MAX;
-			dev_warn(rs->dev, "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-					rs->freq, rsd_nsecs,
-					CR0_RSD_MAX * 1000000000U / rs->freq);
-		}
-		rs->rsd = rsd;
-	}
+				  &rsd_nsecs))
+		rs->rsd_nsecs = rsd_nsecs;
 
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
@@ -687,8 +701,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
-	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
-	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->transfer_one = rockchip_spi_transfer_one;
-- 
2.21.0
