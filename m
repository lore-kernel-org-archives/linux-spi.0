From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] spi-gpio: SPI_MASTER_NO_RX bit tested twice, missing SPI_MASTER_NO_TX?
Date: Sat, 02 Oct 2010 14:03:32 +0200
Message-ID: <4CA71F94.8050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The SPI_MASTER_NO_TX bit (can't do buffer write) wasn't tested.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/spi/spi_gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Is this what was intended?

diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index e24a634..63e51b0 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -350,7 +350,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->bitbang.master = spi_master_get(master);
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
 
-	if ((master_flags & (SPI_MASTER_NO_RX | SPI_MASTER_NO_RX)) == 0) {
+	if ((master_flags & (SPI_MASTER_NO_TX | SPI_MASTER_NO_RX)) == 0) {
 		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
 		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
