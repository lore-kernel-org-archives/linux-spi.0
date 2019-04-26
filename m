From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH] spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select
Date: Fri, 26 Apr 2019 13:30:07 +0300
Message-ID: <20190426103007.29612-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When GPIO chip-select is used nothing prevents any available SPI
controllers to work with both CS-high and traditional CS-low modes.
In fact the SPI bus core code already does it, so we don't need to
introduce any modification there. But spi_setup() still fails to
switch the interface settings if CS-high flag is set for the case
of GPIO-driven slave chip-select when the SPI controller doesn't
support the hardwired CS-inversion. Lets fix it by clearing the
SPI_CS_HIGH flag out from bad_bits (unsupported by controller) when
client chip is selected by GPIO.

This feature is useful for slave devices, which in accordance with
communication protocol can work with both active-high and active-low
chip-selects. I am aware of one such device. It is MMC-SPI interface,
when at init sequence the driver needs to perform a read operation with
low and high chip-select sequentially (requirement of 74 clock cycles
with both chipselect, see the mmc_spi driver for details).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..49808892ef35 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2943,6 +2943,11 @@ int spi_setup(struct spi_device *spi)
 	 * so it is ignored here.
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	/* nothing prevents from working with active-high CS in case if it
+	 * is driven by GPIO.
+	 */
+	if (gpio_is_valid(spi->cs_gpio))
+		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
-- 
2.21.0
