From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH 4/6] spi: bcm2835: warn about native-chip-selects being used
Date: Sun, 29 Mar 2015 16:03:26 +0200
Message-ID: <0330B85B-A297-482B-80A9-E01F236D33D2@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Applies against spi - topic/bcm2835

Could get replaced by something similar to this.
	if (!gpio_is_valid(spi->gpio_cs)) {
		if (spi->chip_select == 0) {
			spi->gpio_cs = 8;
			gpio_set_output(spi->gpio_cs);
		}
		if (spi->chip_select == 1) {
			spi->gpio_cs = 7;
			gpio_set_output(spi->gpio_cs);
		}
	}
But I do not know what is the correct call to use.

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index adf157b..601fc5e 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -82,6 +82,7 @@ struct bcm2835_spi {
 	u8 *rx_buf;
 	int tx_len;
 	int rx_len;
+	bool native_cs_use_warning_done;
 };
 
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
@@ -287,6 +288,9 @@ static void bcm2835_spi_set_cs(struct spi_device *spi, bool gpio_level)
 
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
+	struct spi_master *master = spi->master;
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+
 	/*
 	 * sanity checking the native-chipselects
 	 */
@@ -294,6 +298,14 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		return 0;
 	if (gpio_is_valid(spi->cs_gpio))
 		return 0;
+	/* we are in the native chipselect case now,
+	 * so warn about the fact that some things may not work as well
+	 */
+	if (!bs->native_cs_use_warning_done) {
+		dev_warn(&spi->dev,
+			 "setup: native chipselect is used - some driver functions/optimizations are not applied\n");
+		bs->native_cs_use_warning_done = 1;
+	}
 	if (spi->chip_select < 3)
 		return 0;
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
