From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 4/5] spi: imx: remove unnecessary check in spi_imx_can_dma
Date: Tue, 17 Jul 2018 15:43:10 +0200
Message-ID: <20180717134311.26780-5-maxime.chevallier@bootlin.com>
References: <20180717134311.26780-1-maxime.chevallier@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717134311.26780-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi_imx_can_dma function computes the watermark level so that
the transfer will fit in exactly N bursts (without a remainder).

The smallest watermark level possible being one FIFO entry per burst, we
can't never have a case where the transfer size isn't divsiible by 1.

Remove the extra check for the wml being different than 0.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3ae706dac660..ef6d3648396a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -229,9 +229,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 			break;
 	}
 
-	if (i == 0)
-		return false;
-
 	spi_imx->wml = i;
 	spi_imx->dynamic_burst = 0;
 
-- 
2.11.0
