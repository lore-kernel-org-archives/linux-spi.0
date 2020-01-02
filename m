From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/6] spi: rspi: Remove set_config_register() macro
Date: Thu,  2 Jan 2020 14:38:20 +0100
Message-ID: <20200102133822.29346-5-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The set_config_register() macro is used in a single place.
Make the code easier to read by just removing it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e54a25f848ea38c7..9eabef3d6cc478ff 100644
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
2.17.1
