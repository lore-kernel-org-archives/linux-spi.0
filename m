From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] spi: davinci: use spi->cs_gpio directly
Date: Fri, 16 Oct 2015 16:22:07 +0100
Message-ID: <1445008927-23264-1-git-send-email-luisbg@osg.samsung.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	geert@linux-m68k.org, Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use spi->cs_gpio directly to remove the following build warning:
drivers/spi/spi-davinci.c:219:6: warning: 'gpio' may be used uninitialized in this function

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---

Hi,

The warning and suggestion can be seen here:
https://lkml.org/lkml/2015/10/15/909

Thanks,
Luis

 drivers/spi/spi-davinci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index a85d863..7d3af3e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -215,18 +215,10 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	struct davinci_spi_config *spicfg = spi->controller_data;
 	u8 chip_sel = spi->chip_select;
 	u16 spidat1 = CS_DEFAULT;
-	bool gpio_chipsel = false;
-	int gpio;
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
 
-	if (spi->cs_gpio >= 0) {
-		/* SPI core parse and update master->cs_gpio */
-		gpio_chipsel = true;
-		gpio = spi->cs_gpio;
-	}
-
 	/* program delay transfers if tx_delay is non zero */
 	if (spicfg->wdelay)
 		spidat1 |= SPIDAT1_WDEL;
@@ -235,11 +227,12 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
 	 */
-	if (gpio_chipsel) {
+	if (spi->cs_gpio >= 0) {
 		if (value == BITBANG_CS_ACTIVE)
-			gpio_set_value(gpio, spi->mode & SPI_CS_HIGH);
+			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
 		else
-			gpio_set_value(gpio, !(spi->mode & SPI_CS_HIGH));
+			gpio_set_value(spi->cs_gpio,
+				!(spi->mode & SPI_CS_HIGH));
 	} else {
 		if (value == BITBANG_CS_ACTIVE) {
 			spidat1 |= SPIDAT1_CSHOLD_MASK;
-- 
2.5.1
