From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH] spi: sprd: Fix the incorrect SPI register
Date: Wed,  4 Dec 2019 15:13:59 +0800
Message-ID: <b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        huanpeng.xin@unisoc.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Huanpeng Xin <huanpeng.xin@unisoc.com>

The original code used an incorrect SPI register to initialize the SPI
controller in sprd_spi_init_hw(), thus fix it.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Huanpeng Xin <huanpeng.xin@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/spi/spi-sprd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 2ee1feb..6678f1c 100644
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
1.7.9.5
