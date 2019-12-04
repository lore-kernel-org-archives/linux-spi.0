From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: Fix the incorrect SPI register" to the spi tree
Date: Wed,  4 Dec 2019 12:15:40 +0000 (GMT)
Message-ID: <applied-b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
References: <b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
Cc: baolin.wang7@gmail.com, Baolin Wang <baolin.wang7@gmail.com>,
        broonie@kernel.org, huanpeng.xin@unisoc.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Huanpeng Xin <huanpeng.xin@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: Fix the incorrect SPI register

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 5e9c5236b7b86779b53b762f7e66240c3f18314b Mon Sep 17 00:00:00 2001
From: Huanpeng Xin <huanpeng.xin@unisoc.com>
Date: Wed, 4 Dec 2019 15:13:59 +0800
Subject: [PATCH] spi: sprd: Fix the incorrect SPI register

The original code used an incorrect SPI register to initialize the SPI
controller in sprd_spi_init_hw(), thus fix it.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Huanpeng Xin <huanpeng.xin@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 2ee1feb41681..6678f1cbc566 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -678,7 +678,7 @@ static int sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 	if (d->unit != SPI_DELAY_UNIT_SCK)
 		return -EINVAL;
 
-	val = readl_relaxed(ss->base + SPRD_SPI_CTL7);
+	val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
 	val &= ~(SPRD_SPI_SCK_REV | SPRD_SPI_NG_TX | SPRD_SPI_NG_RX);
 	/* Set default chip selection, clock phase and clock polarity */
 	val |= ss->hw_mode & SPI_CPHA ? SPRD_SPI_NG_RX : SPRD_SPI_NG_TX;
-- 
2.20.1
