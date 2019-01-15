From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] spi: sprd: Fix the error data length in SPI read-only mode
Date: Tue, 15 Jan 2019 21:46:50 +0800
Message-ID: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

In SPI read-only mode, we will always return the writing length,
which is always the power of "bits_per_word", but the length unit
using by users is byte.

Thus this patch fixes the returning length by getting from
read_bufs() function to get the correct length.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24e..fa324ce 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -380,7 +380,7 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 {
 	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u32 trans_len = ss->trans_len, len;
-	int ret, write_size = 0;
+	int ret, write_size = 0, read_size = 0;
 
 	while (trans_len) {
 		len = trans_len > SPRD_SPI_FIFO_SIZE ? SPRD_SPI_FIFO_SIZE :
@@ -416,13 +416,15 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 			goto complete;
 
 		if (ss->trans_mode & SPRD_SPI_RX_MODE)
-			ss->read_bufs(ss, len);
+			read_size += ss->read_bufs(ss, len);
 
 		trans_len -= len;
 	}
 
-	ret = write_size;
-
+	if (ss->trans_mode & SPRD_SPI_TX_MODE)
+		ret = write_size;
+	else
+		ret = read_size;
 complete:
 	sprd_spi_enter_idle(ss);
 
-- 
1.7.9.5
