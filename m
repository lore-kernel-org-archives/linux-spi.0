From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 4/6] spi: ath79: Remove now useless code
Date: Wed, 16 Jan 2019 19:55:47 +0100
Message-ID: <20190116185549.23295-4-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The custom setup/cleanup routines included in the ath79 driver only
take care of setting the initial CS state. However that is already
handled by the bitbang code, so this code can be removed.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 43 ++---------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 09c4fb7fcf7a..847f354ebef1 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -109,44 +109,6 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
 }
 
-static int ath79_spi_setup_cs(struct spi_device *spi)
-{
-	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-
-	if (!spi->cs_gpiod) {
-		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
-
-		if (spi->mode & SPI_CS_HIGH)
-			sp->ioc_base &= ~cs_bit;
-		else
-			sp->ioc_base |= cs_bit;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
-
-	return 0;
-}
-
-static int ath79_spi_setup(struct spi_device *spi)
-{
-	int status = 0;
-
-	if (!spi->controller_state) {
-		status = ath79_spi_setup_cs(spi);
-		if (status)
-			return status;
-	}
-
-	status = spi_bitbang_setup(spi);
-
-	return status;
-}
-
-static void ath79_spi_cleanup(struct spi_device *spi)
-{
-	spi_bitbang_cleanup(spi);
-}
-
 static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 			       u32 word, u8 bits, unsigned flags)
 {
@@ -199,8 +161,8 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = ath79_spi_setup;
-	master->cleanup = ath79_spi_cleanup;
+	master->setup = spi_bitbang_setup;
+	master->cleanup = spi_bitbang_cleanup;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
@@ -209,7 +171,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
-	sp->bitbang.setup_transfer = spi_bitbang_setup_transfer;
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.19.1
