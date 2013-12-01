From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based chipselects
Date: Sun,  1 Dec 2013 11:59:16 +0400
Message-ID: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch takes the CS active level from the GPIO bindings,
so we remove the special property "spi-cs-high" for chipselects
that use GPIO.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi.c       | 28 ++++++++++++++++++----------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 98f4b77..d2ba1ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -413,8 +413,12 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
-	if (master->cs_gpios)
+	if (master->cs_gpios) {
 		spi->cs_gpio = master->cs_gpios[spi->chip_select];
+		if (!(master->cs_gpios_flags[spi->chip_select] &
+		      OF_GPIO_ACTIVE_LOW))
+			spi->mode |= SPI_CS_HIGH;
+	}
 
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
@@ -1027,10 +1031,14 @@ static void of_register_spi_devices(struct spi_master *master)
 			spi->mode |= SPI_CPHA;
 		if (of_find_property(nc, "spi-cpol", NULL))
 			spi->mode |= SPI_CPOL;
-		if (of_find_property(nc, "spi-cs-high", NULL))
-			spi->mode |= SPI_CS_HIGH;
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
+		if (of_find_property(nc, "spi-cs-high", NULL)) {
+			if (master->cs_gpios)
+				dev_notice(&master->dev,
+					"\"spi-cs-high\" property is obsolete.\n");
+			spi->mode |= SPI_CS_HIGH;
+		}
 
 		/* Device DUAL/QUAD mode */
 		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
@@ -1260,7 +1268,7 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);
 #ifdef CONFIG_OF
 static int of_spi_register_master(struct spi_master *master)
 {
-	int nb, i, *cs;
+	int nb, i;
 	struct device_node *np = master->dev.of_node;
 
 	if (!np)
@@ -1275,19 +1283,19 @@ static int of_spi_register_master(struct spi_master *master)
 	else if (nb < 0)
 		return nb;
 
-	cs = devm_kzalloc(&master->dev,
-			  sizeof(int) * master->num_chipselect,
-			  GFP_KERNEL);
-	master->cs_gpios = cs;
+	master->cs_gpios = devm_kzalloc(&master->dev, master->num_chipselect *
+		(sizeof(int) + sizeof(enum of_gpio_flags)), GFP_KERNEL);
 
 	if (!master->cs_gpios)
 		return -ENOMEM;
 
 	for (i = 0; i < master->num_chipselect; i++)
-		cs[i] = -ENOENT;
+		master->cs_gpios[i] = -ENOENT;
 
 	for (i = 0; i < nb; i++)
-		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
+		master->cs_gpios[i] =
+			of_get_named_gpio_flags(np, "cs-gpios", i,
+						&master->cs_gpios_flags[i]);
 
 	return 0;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba7..c0cade2 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -423,6 +423,8 @@ struct spi_master {
 
 	/* gpio chip select */
 	int			*cs_gpios;
+	/* GPIO flags */
+	enum of_gpio_flags	*cs_gpios_flags;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
