From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: ath79: Remove now useless code" to the spi tree
Date: Thu, 17 Jan 2019 12:40:14 +0000 (GMT)
Message-ID: <20190117124014.55E0D1126FE2@debutante.sirena.org.uk>
References: <20190116185549.23295-4-albeu@free.fr>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Alban Bedel <albeu@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-4-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: ath79: Remove now useless code

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From f1b2c1c84f7f04d91749e1550f24510c6b6eac73 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:47 +0100
Subject: [PATCH] spi: ath79: Remove now useless code

The custom setup/cleanup routines included in the ath79 driver only
take care of setting the initial CS state. However that is already
handled by the bitbang code, so this code can be removed.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
