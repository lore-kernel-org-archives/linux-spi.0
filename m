From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 3/3] spi: sun6i: Use the driver data to get the buffer size
Date: Wed, 19 Oct 2016 23:02:34 +0900
Message-ID: <20161019140234.13518-4-woogyom.kim@gmail.com>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milo Kim <woogyom.kim@gmail.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019140234.13518-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The argument can be removed because the driver private data has it.

Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/spi/spi-sun6i.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 91235b2..c638f5d 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -105,8 +105,9 @@ static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
+static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi)
 {
+	int len = sspi->fifo_depth;
 	u32 reg, cnt;
 	u8 byte;
 
@@ -125,8 +126,9 @@ static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
 	}
 }
 
-static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
+static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 {
+	int len = sspi->fifo_depth;
 	u8 byte;
 
 	if (len > sspi->len)
@@ -270,7 +272,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
+	sun6i_spi_fill_fifo(sspi);
 
 	/* Enable the interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
@@ -293,7 +295,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
+	sun6i_spi_drain_fifo(sspi);
 
 out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
-- 
2.9.3
