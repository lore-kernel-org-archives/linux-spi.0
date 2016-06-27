From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v2 2/3] spi: of: allow instantiating slaves without a driver
Date: Mon, 27 Jun 2016 21:02:31 +0200
Message-ID: <a85f91bf364bd6e1681f5973ac92c2bb7f9a8999.1467053363.git.hramrach@gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467053363.git.hramrach@gmail.com>
In-Reply-To: <cover.1467053363.git.hramrach@gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI slave devices are not created when looking up driver for the slave
fails. Create a device anyway so it can be manually bound to a driver.

This allows manually binding a driver to slave devices for which the
driver specified by compatible is not available of for which no driver
is specified at all. Drivers like spidev or m25p80 that require no
configuratiom can be bound to such node.

Since this allows slave DT nodes without specifying a slave driver make
speed also optional. It makes no sense to specify speed when the device
is not specified. The value is only advisory anyway and the slave
driver can try to set arbitrary transfer speed.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0239b45..9b3b512 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1477,9 +1477,8 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	rc = of_modalias_node(nc, spi->modalias,
 				sizeof(spi->modalias));
 	if (rc < 0) {
-		dev_err(&master->dev, "cannot find modalias for %s\n",
+		dev_warn(&master->dev, "cannot find modalias for %s\n",
 			nc->full_name);
-		goto err_out;
 	}
 
 	/* Device address */
@@ -1543,11 +1542,11 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	/* Device speed */
 	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
+		dev_warn(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
 			nc->full_name, rc);
-		goto err_out;
+	} else {
+		spi->max_speed_hz = value;
 	}
-	spi->max_speed_hz = value;
 
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
-- 
2.8.1
