From: Rajeshwari S Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Fri, 18 Oct 2013 11:02:36 +0530
Message-ID: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
Cc: linux-spi@vger.kernel.org, sjg@chromium.org,
	alim.akhtar@samsung.com, dianders@google.com, t.figa@samsung.com,
	broonie@linaro.org, broonie@kernel.org
To: linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch enables word transfer for s3c64xx spi driver.
User can set bits_per_word to 32 or 16 or 8, before calling
spi_setup, which would enable the corresponding transfer mode.

Change-Id: Ib04f9851a3ea891d2bfa527f2100acd314fe1c98
Signed-off-by: Rajeshwari S Shinde <rajeshwari.s@samsung.com>
---
Changes in V2
        - Reduced the call for s3c64xx_spi_config.
Changes in V3:
	- Corrected the coding style nits.
Chnages in V4:
	- Add switch case to support both 16 and 32 bit transfer.
	- Corrected checkpatch error.
 drivers/spi/spi-s3c64xx.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 512b889..1620b74 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -491,6 +491,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
+	u32 swapcfg = 0;
 
 	modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
 	modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
@@ -498,6 +499,22 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	chcfg = readl(regs + S3C64XX_SPI_CH_CFG);
 	chcfg &= ~S3C64XX_SPI_CH_TXCH_ON;
 
+	switch (sdd->cur_bpw) {
+	case 32:
+		swapcfg = S3C64XX_SPI_SWAP_TX_HALF_WORD |
+			S3C64XX_SPI_SWAP_RX_HALF_WORD;
+	case 16:
+		swapcfg |= S3C64XX_SPI_SWAP_TX_EN |
+			S3C64XX_SPI_SWAP_RX_EN |
+			S3C64XX_SPI_SWAP_RX_BYTE |
+			S3C64XX_SPI_SWAP_TX_BYTE;
+		writel(swapcfg, regs + S3C64XX_SPI_SWAP_CFG);
+		break;
+	default:
+		writel(0, regs + S3C64XX_SPI_SWAP_CFG);
+		break;
+	}
+
 	if (dma_mode) {
 		chcfg &= ~S3C64XX_SPI_CH_RXCH_ON;
 	} else {
@@ -905,13 +922,12 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
 		bpw = xfer->bits_per_word;
 		speed = xfer->speed_hz ? : spi->max_speed_hz;
 
-		if (xfer->len % (bpw / 8)) {
-			dev_err(&spi->dev,
-				"Xfer length(%u) not a multiple of word size(%u)\n",
-				xfer->len, bpw / 8);
-			status = -EIO;
-			goto out;
-		}
+		/*
+		 * Enable byte transfer if transfer length not a multiple of
+		 * word size
+		 */
+		if (xfer->len % (bpw / 8))
+			bpw = 8;
 
 		if (bpw != sdd->cur_bpw || speed != sdd->cur_speed) {
 			sdd->cur_bpw = bpw;
-- 
1.7.12.4
