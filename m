From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] of: spi: Export single device registration method and accessors (v2)
Date: Wed, 29 Oct 2014 10:40:37 +0200
Message-ID: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-ke
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dynamically inserting spi device nodes requires the use of a single
device registration method. Rework and export it.

Methods to lookup a device/master using a device node are added
as well, of_find_spi_master_by_node() & of_find_spi_device_by_node().

Changes since v1:
* Brown paper bug with parameter on of_register_spi_device().

Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi.c | 255 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 157 insertions(+), 98 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ebcb33d..4778366 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,6 +1220,122 @@ err_init_queue:
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OF)
+
+static struct spi_device *
+of_register_spi_device(struct spi_master *master, struct device_node *nc)
+{
+	struct spi_device *spi;
+	int rc;
+	u32 value;
+
+	/* Alloc an spi_device */
+	spi = spi_alloc_device(master);
+	if (!spi) {
+		dev_err(&master->dev, "spi_device alloc error for %s\n",
+			nc->full_name);
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	/* Select device driver */
+	rc = of_modalias_node(nc, spi->modalias,
+				sizeof(spi->modalias));
+	if (rc < 0) {
+		dev_err(&master->dev, "cannot find modalias for %s\n",
+			nc->full_name);
+		goto err_out;
+	}
+
+	/* Device address */
+	rc = of_property_read_u32(nc, "reg", &value);
+	if (rc) {
+		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
+			nc->full_name, rc);
+		goto err_out;
+	}
+	spi->chip_select = value;
+
+	/* Mode (clock phase/polarity/etc.) */
+	if (of_find_property(nc, "spi-cpha", NULL))
+		spi->mode |= SPI_CPHA;
+	if (of_find_property(nc, "spi-cpol", NULL))
+		spi->mode |= SPI_CPOL;
+	if (of_find_property(nc, "spi-cs-high", NULL))
+		spi->mode |= SPI_CS_HIGH;
+	if (of_find_property(nc, "spi-3wire", NULL))
+		spi->mode |= SPI_3WIRE;
+	if (of_find_property(nc, "spi-lsb-first", NULL))
+		spi->mode |= SPI_LSB_FIRST;
+
+	/* Device DUAL/QUAD mode */
+	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
+		switch (value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_TX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_TX_QUAD;
+			break;
+		default:
+			dev_warn(&master->dev,
+				"spi-tx-bus-width %d not supported\n",
+				value);
+			break;
+		}
+	}
+
+	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
+		switch (value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_RX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_RX_QUAD;
+			break;
+		default:
+			dev_warn(&master->dev,
+				"spi-rx-bus-width %d not supported\n",
+				value);
+			break;
+		}
+	}
+
+	/* Device speed */
+	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
+	if (rc) {
+		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
+			nc->full_name, rc);
+		goto err_out;
+	}
+	spi->max_speed_hz = value;
+
+	/* IRQ */
+	spi->irq = irq_of_parse_and_map(nc, 0);
+
+	/* Store a pointer to the node in the device structure */
+	of_node_get(nc);
+	spi->dev.of_node = nc;
+
+	/* Register the new device */
+	request_module("%s%s", SPI_MODULE_PREFIX, spi->modalias);
+	rc = spi_add_device(spi);
+	if (rc) {
+		dev_err(&master->dev, "spi_device register error %s\n",
+			nc->full_name);
+		goto err_out;
+	}
+
+	return spi;
+
+err_out:
+	spi_dev_put(spi);
+	return ERR_PTR(rc);
+}
+
 /**
  * of_register_spi_devices() - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
@@ -1229,120 +1345,63 @@ err_init_queue:
  */
 static void of_register_spi_devices(struct spi_master *master)
 {
-	struct spi_device *spi;
 	struct device_node *nc;
-	int rc;
-	u32 value;
+	struct spi_device *spi;
 
 	if (!master->dev.of_node)
 		return;
 
 	for_each_available_child_of_node(master->dev.of_node, nc) {
-		/* Alloc an spi_device */
-		spi = spi_alloc_device(master);
-		if (!spi) {
-			dev_err(&master->dev, "spi_device alloc error for %s\n",
+		spi = of_register_spi_device(master, nc);
+		if (IS_ERR(spi))
+			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
 				nc->full_name);
-			spi_dev_put(spi);
-			continue;
-		}
+	}
+}
 
-		/* Select device driver */
-		if (of_modalias_node(nc, spi->modalias,
-				     sizeof(spi->modalias)) < 0) {
-			dev_err(&master->dev, "cannot find modalias for %s\n",
-				nc->full_name);
-			spi_dev_put(spi);
-			continue;
-		}
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
 
-		/* Device address */
-		rc = of_property_read_u32(nc, "reg", &value);
-		if (rc) {
-			dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
-				nc->full_name, rc);
-			spi_dev_put(spi);
-			continue;
-		}
-		spi->chip_select = value;
-
-		/* Mode (clock phase/polarity/etc.) */
-		if (of_find_property(nc, "spi-cpha", NULL))
-			spi->mode |= SPI_CPHA;
-		if (of_find_property(nc, "spi-cpol", NULL))
-			spi->mode |= SPI_CPOL;
-		if (of_find_property(nc, "spi-cs-high", NULL))
-			spi->mode |= SPI_CS_HIGH;
-		if (of_find_property(nc, "spi-3wire", NULL))
-			spi->mode |= SPI_3WIRE;
-		if (of_find_property(nc, "spi-lsb-first", NULL))
-			spi->mode |= SPI_LSB_FIRST;
-
-		/* Device DUAL/QUAD mode */
-		if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
-			switch (value) {
-			case 1:
-				break;
-			case 2:
-				spi->mode |= SPI_TX_DUAL;
-				break;
-			case 4:
-				spi->mode |= SPI_TX_QUAD;
-				break;
-			default:
-				dev_warn(&master->dev,
-					 "spi-tx-bus-width %d not supported\n",
-					 value);
-				break;
-			}
-		}
+/* bah; the match functions differ just by const-ness */
+static int of_dev_node_match_const(struct device *dev, const void *data)
+{
+	return dev->of_node == data;
+}
 
-		if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
-			switch (value) {
-			case 1:
-				break;
-			case 2:
-				spi->mode |= SPI_RX_DUAL;
-				break;
-			case 4:
-				spi->mode |= SPI_RX_QUAD;
-				break;
-			default:
-				dev_warn(&master->dev,
-					 "spi-rx-bus-width %d not supported\n",
-					 value);
-				break;
-			}
-		}
+/* must call put_device() when done with returned spi_device device */
+struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+{
+	struct device *dev;
 
-		/* Device speed */
-		rc = of_property_read_u32(nc, "spi-max-frequency", &value);
-		if (rc) {
-			dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
-				nc->full_name, rc);
-			spi_dev_put(spi);
-			continue;
-		}
-		spi->max_speed_hz = value;
+	dev = bus_find_device(&spi_bus_type, NULL, node,
+					 of_dev_node_match);
+	if (!dev)
+		return NULL;
 
-		/* IRQ */
-		spi->irq = irq_of_parse_and_map(nc, 0);
+	return to_spi_device(dev);
+}
+EXPORT_SYMBOL(of_find_spi_device_by_node);
 
-		/* Store a pointer to the node in the device structure */
-		of_node_get(nc);
-		spi->dev.of_node = nc;
+/* forward decl */
+static struct class spi_master_class;
 
-		/* Register the new device */
-		request_module("%s%s", SPI_MODULE_PREFIX, spi->modalias);
-		rc = spi_add_device(spi);
-		if (rc) {
-			dev_err(&master->dev, "spi_device register error %s\n",
-				nc->full_name);
-			spi_dev_put(spi);
-		}
+/* the spi masters are not using spi_bus, so we find it with another way */
+struct spi_master *of_find_spi_master_by_node(struct device_node *node)
+{
+	struct device *dev;
 
-	}
+	dev = class_find_device(&spi_master_class, NULL, node,
+				of_dev_node_match_const);
+	if (!dev)
+		return NULL;
+
+	/* reference got in class_find_device */
+	return container_of(dev, struct spi_master, dev);
 }
+EXPORT_SYMBOL(of_find_spi_master_by_node);
+
 #else
 static void of_register_spi_devices(struct spi_master *master) { }
 #endif
-- 
1.7.12
