From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: use spi->cs_gpio directly" to the spi tree
Date: Fri, 16 Oct 2015 19:11:08 +0100
Message-ID: <E1Zn9TA-0003Di-CI@debutante>
References: <1445008927-23264-1-git-send-email-luisbg@osg.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445008927-23264-1-git-send-email-luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: use spi->cs_gpio directly

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8cae0424787ba02987a6f3a6117f31f6a77260dc Mon Sep 17 00:00:00 2001
From: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Fri, 16 Oct 2015 16:22:07 +0100
Subject: [PATCH] spi: davinci: use spi->cs_gpio directly

Use spi->cs_gpio directly to remove the following build warning:
drivers/spi/spi-davinci.c:219:6: warning: 'gpio' may be used uninitialized in this function

Signed-off-by: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Suggested-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 3cf9faa6cc3f..8e2ddd1147aa 100644
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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
