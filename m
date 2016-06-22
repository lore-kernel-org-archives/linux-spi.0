From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/6] spi: core: Add support for registering SPI slave controllers
Date: Wed, 22 Jun 2016 15:42:05 +0200
Message-ID: <1466602929-4191-3-git-send-email-geert+renesas@glider.be>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for registering SPI slave controllers using the existing SPI
master framework:
  - SPI slave controllers must set the SPI_MASTER_IS_SLAVE flag in
    spi_master.flags,
  - The "cs-gpios" property is ignored,
  - The bus is described in DT as having a single slave node, "reg" and
    "spi-max-frequency" properties are ignored.

>From the point of view of an SPI slave protocol handler, an SPI slave
controller looks exactly like an ordinary SPI master controller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should we rename spi_master to spi_controller?
---
 drivers/spi/Kconfig     | 14 +++++++++++++-
 drivers/spi/Makefile    |  2 ++
 drivers/spi/spi.c       | 39 ++++++++++++++++++++++++---------------
 include/linux/spi/spi.h |  5 +++--
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b931ec8d90b610f..00e990d91a715c0e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -736,6 +736,18 @@ config SPI_TLE62X0
 
 endif # SPI_MASTER
 
-# (slave support would go here)
+#
+# SLAVE side ... listening to other SPI masters
+#
+
+config SPI_SLAVE
+	bool "SPI slave protocol handlers"
+	help
+	  If your system has a slave-capable SPI controller, you can enable
+	  slave protocol handlers.
+
+if SPI_SLAVE
+
+endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3c74d003535bb9fb..71d02939080fb747 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -97,3 +97,5 @@ obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
+
+# SPI slave protocol handlers
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45951f4c5e1..6ea32255d6d9e780 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1462,6 +1462,7 @@ err_init_queue:
 static struct spi_device *
 of_register_spi_device(struct spi_master *master, struct device_node *nc)
 {
+	bool slave = master->flags & SPI_MASTER_IS_SLAVE;
 	struct spi_device *spi;
 	int rc;
 	u32 value;
@@ -1485,13 +1486,16 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	}
 
 	/* Device address */
-	rc = of_property_read_u32(nc, "reg", &value);
-	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
-			nc->full_name, rc);
-		goto err_out;
+	if (!slave) {
+		rc = of_property_read_u32(nc, "reg", &value);
+		if (rc) {
+			dev_err(&master->dev,
+				"%s has no valid 'reg' property (%d)\n",
+				nc->full_name, rc);
+			goto err_out;
+		}
+		spi->chip_select = value;
 	}
-	spi->chip_select = value;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_find_property(nc, "spi-cpha", NULL))
@@ -1543,13 +1547,16 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	}
 
 	/* Device speed */
-	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
-	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
-			nc->full_name, rc);
-		goto err_out;
+	if (!slave) {
+		rc = of_property_read_u32(nc, "spi-max-frequency", &value);
+		if (rc) {
+			dev_err(&master->dev,
+				"%s has no valid 'spi-max-frequency' property (%d)\n",
+				nc->full_name, rc);
+			goto err_out;
+		}
+		spi->max_speed_hz = value;
 	}
-	spi->max_speed_hz = value;
 
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
@@ -1779,7 +1786,7 @@ static int of_spi_register_master(struct spi_master *master)
 	int nb, i, *cs;
 	struct device_node *np = master->dev.of_node;
 
-	if (!np)
+	if (!np || master->flags & SPI_MASTER_IS_SLAVE)
 		return 0;
 
 	nb = of_gpio_named_count(np, "cs-gpios");
@@ -1885,8 +1892,10 @@ int spi_register_master(struct spi_master *master)
 	status = device_add(&master->dev);
 	if (status < 0)
 		goto done;
-	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
-			dynamic ? " (dynamic)" : "");
+	dev_dbg(dev, "registered %s %s%s\n",
+			master->flags & SPI_MASTER_IS_SLAVE ? "slave"
+							    : "master",
+			dev_name(&master->dev), dynamic ? " (dynamic)" : "");
 
 	/* If we're using a queued driver, start the queue */
 	if (master->transfer)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1f03483f61e5714b..0fbebaa7d93990a4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -28,8 +28,8 @@ struct spi_transfer;
 struct spi_flash_read_message;
 
 /*
- * INTERFACES between SPI master-side drivers and SPI infrastructure.
- * (There's no SPI slave support for Linux yet...)
+ * INTERFACES between SPI master-side drivers and SPI slave protocol handers,
+ * and SPI infrastructure.
  */
 extern struct bus_type spi_bus_type;
 
@@ -439,6 +439,7 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_MASTER_IS_SLAVE     BIT(5)		/* SPI slave controller */
 
 	/*
 	 * on some hardware transfer size may be constrained
-- 
1.9.1
