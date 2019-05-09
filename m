From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] spi: bcm2835: only split transfers that exceed DLEN if DMA available
Date: Thu,  9 May 2019 16:39:59 +0200
Message-ID: <20190509144000.681-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There is no use for this when performing non DMA operations. So we
bypass the split.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/spi/spi-bcm2835.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 37893313e595..649fd6caed35 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -861,15 +861,17 @@ static int bcm2835_spi_prepare_message(struct spi_master *master,
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 	int ret;
 
-	/*
-	 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by the SPI HW
-	 * due to DLEN. Split up transfers (32-bit FIFO aligned) if the limit is
-	 * exceeded.
-	 */
-	ret = spi_split_transfers_maxsize(master, msg, 65532,
-					  GFP_KERNEL | GFP_DMA);
-	if (ret)
-		return ret;
+	if (master->can_dma) {
+		/*
+		 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
+		 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
+		 * aligned) if the limit is exceeded.
+		 */
+		ret = spi_split_transfers_maxsize(master, msg, 65532,
+						  GFP_KERNEL | GFP_DMA);
+		if (ret)
+			return ret;
+	}
 
 	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
 
-- 
2.21.0
