From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH v3] spi: dw: support 4-16 bits per word
Date: Tue,  4 Sep 2018 21:49:44 +0200
Message-ID: <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v3
- remove the check for valid 'bits_per_word' from dw_spi_transfer_one()
- add reviewed-by tag

Changes in v2:
- use DIV_ROUND_UP to calculate number of bytes per word instead of
  if/else range checks

 drivers/spi/spi-dw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..58a7caf31d59 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -307,15 +307,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
-		dws->n_bytes = 1;
-		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
-		dws->n_bytes = 2;
-		dws->dma_width = 2;
-	} else {
-		return -EINVAL;
-	}
+
+	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
@@ -493,7 +491,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.17.1
