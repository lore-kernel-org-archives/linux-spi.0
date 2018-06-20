From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 07/12] spi: spi-fsl-dspi: Fix MCR register handling
Date: Wed, 20 Jun 2018 09:34:37 +0200
Message-ID: <20180620073442.20913-8-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The MCR register is not changed, so initialize it in dspi_init().

The exception is the CLR_TXF and CLR_RXF bits, which should be written to
before each transfer to make sure we start with empty FIFOs.  With MCR
register now configured as volatile, the regmap_update_bits will do a real
read-modify-write cycle.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5c5905b6509f..d83d3496d538 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -120,7 +120,6 @@
 #define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
 
 struct chip_data {
-	u32 mcr_val;
 	u32 ctar_val;
 	u16 void_write_data;
 };
@@ -644,10 +643,9 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		else
 			dspi->bytes_per_word = 2;
 
-		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_update_bits(dspi->regmap, SPI_MCR,
-				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
+				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
@@ -725,9 +723,6 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
-	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
-
 	chip->void_write_data = 0;
 
 	clkrate = clk_get_rate(dspi->clk);
@@ -883,6 +878,7 @@ static const struct regmap_config dspi_regmap_config = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
+	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 }
 
-- 
2.17.1
