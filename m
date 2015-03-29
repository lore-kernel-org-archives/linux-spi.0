From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH/RFC 6/6] spi: bcm2835: set gpio-cs to high state prior to any
Date: Sun, 29 Mar 2015 16:03:28 +0200
Message-ID: <DA037FBB-56A7-4379-88F0-650367BBB822@martin.sperl.org>
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

 device initialization

The situation has been observed that on the RPI after a reboot the
GPIOs used for chip-selects are set to low when pinctl finishes setting
up the direction of the pins.

This can negatively impact the spi-bus and inhibit propper device
detection.

This (incomplete) code pulls the CS high to avoid the situation in the
common case of "normal" CS-priority - it still needs a revisit to get
the reverse polarity cases right as well.

A variation of this probably should get moved into spi_register_master
to fix this for other spi-controller as well.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---
 drivers/spi/spi-bcm2835.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Applies against spi - topic/bcm2835.

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 1d731b8..b6825a4 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -349,6 +349,26 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	return -EINVAL;
 }
 
+static void bcm2835_spi_initialsetup_gpio(struct spi_master *master)
+{
+	int i;
+	bool level;
+
+	if (!master->cs_gpios)
+		return;
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		if (gpio_is_valid(master->cs_gpios[i])) {
+			/* actually we need to figure out the
+			 * configured CSPOL of that device here,
+			 * not sure how to do that...
+			 */
+			level = true;
+			gpio_set_value(master->cs_gpios[i], level);
+		}
+	}
+}
+
 static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -414,6 +434,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
+	/* set GPIO-CS to disabled */
+	bcm2835_spi_initialsetup_gpio(master);
+
 	return 0;
 
 out_clk_disable:
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
