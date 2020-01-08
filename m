From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Remove set_config_register() macro" to the spi tree
Date: Wed, 08 Jan 2020 15:59:13 +0000
Message-ID: <applied-20200102133822.29346-5-geert+renesas@glider.be>
References: <20200102133822.29346-5-geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102133822.29346-5-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Remove set_config_register() macro

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From 8f2344fa7f54382eeaf4b65d70c74b0b44df7a6b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:20 +0100
Subject: [PATCH] spi: rspi: Remove set_config_register() macro

The set_config_register() macro is used in a single place.
Make the code easier to read by just removing it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-5-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e54a25f848ea..9eabef3d6cc4 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -426,8 +426,6 @@ static int qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 	return n;
 }
 
-#define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
-
 static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | enable, RSPI_SPCR);
@@ -940,7 +938,7 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_LOOP)
 		rspi->sppcr |= SPPCR_SPLP;
 
-	set_config_register(rspi, 8);
+	rspi->ops->set_config_register(rspi, 8);
 
 	if (msg->spi->mode &
 	    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)) {
-- 
2.20.1
