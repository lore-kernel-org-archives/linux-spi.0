From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: setting up cs_gpio levels prior to registering spi devices
Date: Mon,  6 Apr 2015 17:16:32 +0000
Message-ID: <1428340592-3196-3-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

With multiple SPI devices on the same bus and using cs_gpio there
is the problem that the default GPIO levels are not necessarily
correct, which can result in multiple devices (of the same type)
getting configured because the corresponding CS is low on initial
setup.

This patch sets up the "correct" default levels for each chip select
line prior to registering any of the devices.

It implements the polarity configurations set in DT (spi-cs-pol)
as well as "mode & SPI_CS_POL" provided in board_info.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

Tested with the following setup:
* native CS:
  * mcp2515
  * mmc_spi (patched to make it work on the RPI)
* gpio-CS:
  * mcp2515
  * enc28j60
* gpio-CS with "spi-cs-pol" set in DT:
  * fb_st7735r

Note: I can not test the board-info code due to lack of a corrsponding setup.

There is also a acpi function implemented, but it contains no code as of now.
The question here is if there is a need for something like this with ACPI.

We could also extend this to set up the GPIO as output regardless of any
configuration in the gpio section in the device-tree.

This would allow us to reduce the amount of redundant configuration inside
the DT that has to be kept in sync (gpio and spi sections).

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 04e9d92..807890a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1483,6 +1483,70 @@ static int of_spi_register_master(struct spi_master *master)
 }
 #endif

+static void boardinfo_spi_setup_gpiopins(struct spi_master *master)
+{
+	struct boardinfo *bi;
+	struct spi_board_info *sbi;
+
+	mutex_lock(&board_lock);
+	list_for_each_entry(bi, &board_list, list) {
+		sbi = &bi->board_info;
+		if ((master->bus_num == sbi->bus_num) &&
+		    (sbi->chip_select < master->num_chipselect) &&
+		    gpio_is_valid(master->cs_gpios[sbi->chip_select]) &&
+		    (sbi->mode & SPI_CS_HIGH))
+			gpio_set_value(master->cs_gpios[sbi->chip_select], 0);
+	}
+	mutex_unlock(&board_lock);
+}
+
+#if defined(CONFIG_OF)
+static void of_spi_setup_gpiopins(struct spi_master *master)
+{
+	struct device_node *nc;
+	u32 value;
+	int rc;
+
+	for_each_available_child_of_node(master->dev.of_node, nc) {
+		rc = of_property_read_u32(nc, "reg", &value);
+		if ((!rc) &&
+		    (value < master->num_chipselect) &&
+		    gpio_is_valid(master->cs_gpios[value]) &&
+		    of_find_property(nc, "spi-cs-high", NULL))
+			gpio_set_value(master->cs_gpios[value], 0);
+	}
+}
+#else
+static void of_spi_setup_gpiopins(struct spi_master *master) { }
+#endif
+
+static void acpi_spi_setup_gpiopins(struct spi_master *master)
+{
+	/* probably not needed, as there seems to be no cs_gpio
+	 * information in the ACPI structures but left for completeness
+	 * to get extended if needed
+	 */
+}
+
+static void spi_setup_gpiopins(struct spi_master *master)
+{
+	int i;
+
+	if (!master->cs_gpios)
+		return;
+
+	/* set up default level high for all configured cs_gpios */
+	for (i = 0; i < master->num_chipselect; i++) {
+		if (gpio_is_valid(master->cs_gpios[i]))
+			gpio_set_value(master->cs_gpios[i], 1);
+	}
+
+	/* handle reverse polarity cases for all possible config types */
+	boardinfo_spi_setup_gpiopins(master);
+	of_spi_setup_gpiopins(master);
+	acpi_spi_setup_gpiopins(master);
+}
+
 /**
  * spi_register_master - register SPI master controller
  * @master: initialized master, originally from spi_alloc_master()
@@ -1536,6 +1600,9 @@ int spi_register_master(struct spi_master *master)
 		dynamic = 1;
 	}

+	/* setting up gpio-cs with the correct levels */
+	spi_setup_gpiopins(master);
+
 	INIT_LIST_HEAD(&master->queue);
 	spin_lock_init(&master->queue_lock);
 	spin_lock_init(&master->bus_lock_spinlock);
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
