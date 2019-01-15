From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: Fix the error data length in SPI read-only mode" to the spi tree
Date: Tue, 15 Jan 2019 19:08:35 +0000 (GMT)
Message-ID: <20190115190835.768671127848@debutante.sirena.org.uk>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lanqing Liu <lanqing.liu@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: Fix the error data length in SPI read-only mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 63f5ffc46d4f53b309a93b83420b2e4bd0da5aba Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@spreadtrum.com>
Date: Tue, 15 Jan 2019 21:46:50 +0800
Subject: [PATCH] spi: sprd: Fix the error data length in SPI read-only mode

In SPI read-only mode, we will always return the writing length,
which is always the power of "bits_per_word", but the length unit
using by users is byte.

Thus this patch fixes the returning length by getting from
read_bufs() function to get the correct length.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24eec624..fa324ce194b2 100644
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
2.20.1
