From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 035/109] spi: pic32: Use proper enum in dmaengine_prep_slave_rg
Date: Sat,  9 Nov 2019 21:44:27 -0500
Message-ID: <20191110024541.31567-35-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <natechancellor@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        clang-built-linux@googlegroups.com
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8cfde7847d5ed0bb77bace41519572963e43cd17 ]

Clang warns when one enumerated type is converted implicitly to another:

drivers/spi/spi-pic32.c:323:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_FROM_DEVICE,
                                          ^~~~~~~~~~~~~~~
drivers/spi/spi-pic32.c:333:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_TO_DEVICE,
                                          ^~~~~~~~~~~~~
2 warnings generated.

Use the proper enums from dma_transfer_direction (DMA_FROM_DEVICE =
DMA_DEV_TO_MEM = 2, DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1) to satify Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/159
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pic32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f8a45af1fa9f2..288002f6c613e 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -320,7 +320,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					  xfer->rx_sg.sgl,
 					  xfer->rx_sg.nents,
-					  DMA_FROM_DEVICE,
+					  DMA_DEV_TO_MEM,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
 		ret = -EINVAL;
@@ -330,7 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
 					  xfer->tx_sg.sgl,
 					  xfer->tx_sg.nents,
-					  DMA_TO_DEVICE,
+					  DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
 		ret = -EINVAL;
-- 
2.20.1
