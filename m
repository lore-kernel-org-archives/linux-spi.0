From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH] spi: dw: support 4-16 bits per word
Date: Wed,  8 Aug 2018 09:14:21 +0200
Message-ID: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---
 drivers/spi/spi-dw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..2ecbb6b19cea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -307,14 +307,14 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
+	if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
+		return -EINVAL;
+	if (transfer->bits_per_word <= 8) {
 		dws->n_bytes = 1;
 		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
+	} else {
 		dws->n_bytes = 2;
 		dws->dma_width = 2;
-	} else {
-		return -EINVAL;
 	}
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
@@ -493,7 +493,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.17.1
