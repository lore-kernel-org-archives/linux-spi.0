From: Dries Van Puymbroeck <dries.van.puymbroeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Add SPI mux core and GPIO-based mux driver
Date: Tue, 26 Mar 2013 22:14:20 +0100
Message-ID: <1364332460-4808-1-git-send-email-Dries.VanPuymbroeck@barco.com>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, dries.vanpuymbroeck-s4ckItp294LQT0dZR+AlfA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1361973519-30633-1-git-send-email-peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch contains the core functionality for a multiplexer on an
SPI bus. This can be useful if a board requires more SPI devices,
and thus more chip selects, than the SPI controller on the processor
has available.

The mux device is added in the device tree as a child node of the
SPI master. Then, devices can be added as children of the mux node.
The mux will appear as if it was a SPI master device, and child
nodes will appear as chip selects on the mux bus. A bindings file is
provided for the device tree bindings.

This patch also includes a driver for a GPIO-based multiplexer, which
makes use of the core code. A bindings file for the GPIO
implementation is also provided for the device tree bindings.

Signed-off-by: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
Change log:

Changes w.r.t. V1:
 - Split the core mux functionality and the specific mux code. Core
   functionality now is in spi-mux.c, while the actual mux we use is
   in spi-barco-orka-mux-gpio.c. Using the latter as an example,
   other users should be able to add different mux implementations,
   reusing the parts in the core. spi-mux.h is also provided to be
   in include/linux/spi/

 - Changed the compatible string of the specific mux implementation
   to "barco,orka-spi-mux-gpio"

 - Changed device tree property "mux-gpios" to "gpios"

 - Changed the spi_mux_transfer_one_message and spi_mux_complete_cb
   functions according to feedback from Grant Likely: removed the
   wait queue, and call the spi_finalize_current_message call
   directly from the spi_mux_complete_cb. This removes xfer_complete
   and xfer_complete_wq, and moves child_mesg_complete
   child_mesg_context and child_mesg_dev into spi_mux_priv.

 - Renamed some structs and functions to be more in line with the
   naming in the code for I2C muxes.

 - Joined the spi_mux_gpio_probe_dt function with the
   spi_mux_gpio_probe function (and renamed to spi_add_mux)

 - Removed the values array per chip select in the specific mux code.
   The reg property is now directly used as chip select and bit mask
   for the gpio mux. (This also removes a bug where the values array
   was incorrectly allocated for sparse CS's

 - Removed of_match_ptr since driver is DT only.

Not changed w.r.t. V1:
 - spi-max-frequency is still a required DT property, even for the
   gpio mux, though it does not mean anything there. However, the
   check for this mandatory property is done by the spi core, before
   the probe function of the mux is called. This means that the mux
   code cannot get the property from its child devices before the
   check is done (and right now the core aborts the initialization if
   spi-max-frequency is not set). The only solution I see is to loosen
   the check in spi core, or requiring that muxes have this property
   too, even if it does not have meaning. If anyone has some ideas
   about this, I would appreciate them!


 .../bindings/spi/barco-orka-spi-mux-gpio.txt       |   35 ++++
 Documentation/devicetree/bindings/spi/spi-mux.txt  |  106 ++++++++++
 drivers/spi/Kconfig                                |   25 +++
 drivers/spi/Makefile                               |    4 +
 drivers/spi/spi-barco-orka-mux-gpio.c              |  142 +++++++++++++
 drivers/spi/spi-mux.c                              |  219 ++++++++++++++++++++
 include/linux/spi/spi-mux.h                        |   58 ++++++
 7 files changed, 589 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/barco-orka-spi-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.txt
 create mode 100644 drivers/spi/spi-barco-orka-mux-gpio.c
 create mode 100644 drivers/spi/spi-mux.c
 create mode 100644 include/linux/spi/spi-mux.h

diff --git a/Documentation/devicetree/bindings/spi/barco-orka-spi-mux-gpio.txt b/Documentation/devicetree/bindings/spi/barco-orka-spi-mux-gpio.txt
new file mode 100644
index 0000000..4604374
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/barco-orka-spi-mux-gpio.txt
@@ -0,0 +1,35 @@
+GPIO-based SPI Chip Select Mux for Barco Orka board
+
+This binding describes a SPI bus multiplexer that uses GPIOs to route the SPI
+chip select signals.
+
+      MOSI /--------------------------------+--------+--------+--------\
+      MISO |/------------------------------+|-------+|-------+|-------\|
+       SCL ||/----------------------------+||------+||------+||------\||
+           |||                            |||      |||      |||      |||
+    +------------+                        |||      |||      |||      |||
+    | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
+    |      |||   |                      | dev |  | dev |  | dev |  | dev |
+    |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
+    |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
+    |   +------+ |       +--++--+\\\-------/   CS-1 |        |        |
+    |            |          ||   \\\----------------/   CS-2 |        |
+    |   +------+ |          ||    \\-------------------------/   CS-3 |
+    |   | GPIO +-|----------/|     \----------------------------------/
+    |   |      +-|-----------/
+    |   +------+ |
+    +------------+
+
+Required properties:
+* Standard SPI mux properties. See spi-mux.txt in this directory.
+- compatible: "barco,orka-spi-mux-gpio"
+- gpios: list of gpios used to control the muxer
+
+Whenever an access is made to a child device, the value set in the revelant
+node's reg property is interpreted as a bitmask defining the state of the gpio
+pins, with the least significant bit defining the state of first gpio, the next
+bit the state of the second gpio and so forth. The node's reg property is also
+used by the core SPI code as the (virtual) chip select in this case.
+
+Example: see spi-mux.txt in this directory, which uses an example with this
+specific SPI mux.
diff --git a/Documentation/devicetree/bindings/spi/spi-mux.txt b/Documentation/devicetree/bindings/spi/spi-mux.txt
new file mode 100644
index 0000000..efe1ebe
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux.txt
@@ -0,0 +1,106 @@
+Common SPI multiplexer properties.
+
+This binding describes a SPI bus multiplexer to route the SPI chip select
+signals. This can be used when you need more devices than the SPI controller
+has chip selects available. An example setup is shown in ASCII art; the actual
+setting of the multiplexer to a channel needs to be done by a specific SPI mux
+driver. See barco-orka-spi-mux-gpio.txt for a concrete example.
+
+      MOSI /--------------------------------+--------+--------+--------\
+      MISO |/------------------------------+|-------+|-------+|-------\|
+       SCL ||/----------------------------+||------+||------+||------\||
+           |||                            |||      |||      |||      |||
+    +------------+                        |||      |||      |||      |||
+    | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
+    |      |||   |                      | dev |  | dev |  | dev |  | dev |
+    |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
+    |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
+    |   +------+ |       +--+---+\\\-------/   CS-1 |        |        |
+    |            |          |    \\\----------------/   CS-2 |        |
+    |   +------+ |          |     \\-------------------------/   CS-3 |
+    |   | ?    +-|----------/      \----------------------------------/
+    |   +------+ |
+    +------------+
+
+Required properties:
+- #address-cells: <1> (as for any SPI master device)
+- #size-cells: <0> (as for any SPI master device)
+- reg: chip select of the mux on the parent SPI master
+- spi-max-frequency: the maximum frequency allowed for any devices on this mux
+* SPI child nodes, as if the mux is a real spi master
+
+Optional properties:
+- Other properties specific to the multiplexer/switch hardware.
+
+A new SPI bus will be created. Then for each child node, a SPI device is
+created, with a virtual chip select on this bus according to the reg property.
+
+The property spi-max-frequency is conceptually not needed, as each child node
+holds the maximum frequency specific to that device. However, the SPI core code
+wants every device in the tree to specify a maximum frequency. So because the
+mux is a device to a parent SPI master, you need to set a maximum frequency.
+It's best to set this high, as the driver will take the minimum of this value
+and the child's maximum frequency value when doing a transfer to that child
+device.
+
+Example:
+	/*
+	 * An SPI mux on chip select 1 of the spi1 peripheral controller of an
+	 * am33xx soc. Chip select 0 is taken by another device, and the mux is
+	 * on chip select 1. Behind the mux are 4 devices which are defined as
+	 * if the spi-mux is a master. The specific mux implementation used is
+	 * barco,orka-spi-mux-gpio
+	 */
+
+	spi1 {
+		compatible = "ti,omap4-mcspi";
+		status = "enabled";
+
+		spi-flash@0 {
+			compatible = "m25p40";
+			reg = <0>;
+			spi-max-frequency = <10000000>;
+		};
+
+		spi-mux {
+			compatible = "barco,orka-spi-mux-gpio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <1>;
+			spi-max-frequency = <100000000>;
+
+			gpios = <&gpio2 30 0 &gpio2 31 0>;
+
+			spi-flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "sst,sst25vf016b";
+				spi-max-frequency = <40000000>;
+				reg = <0>;
+			};
+
+			spi-device@1 {
+				compatible = "spidev";
+				reg = <1>;
+				spi-max-frequency = <10000000>;
+			};
+
+			spi-flash@2 {
+				compatible = "winbond,w25q32";
+				reg = <2>;
+				spi-max-frequency = <20000000>;
+			};
+
+			mc13892@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,mc13892";
+				spi-max-frequency = <6000000>;
+				reg = <3>;
+
+				/* more settings... */
+			}
+
+		};
+	};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f80eee7..0b6aa58 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -481,6 +481,31 @@ config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && HAVE_CLK
 
+comment "SPI Multiplexer support"
+
+config SPI_MUX
+	tristate "SPI multiplexer support"
+	help
+	  This adds support for SPI multiplexers. The mux will be accessible as
+	  an extra master bus, the devices behind the mux will appear to be
+	  chip selects on this master bus. It is still neccessary to select one
+	  or more specific mux drivers.
+
+config SPI_BARCO_ORKA_MUX_GPIO
+	tristate "SPI mux support for the barco orka board, GPIO based"
+	depends on GENERIC_GPIO
+	depends on SPI_MUX
+	help
+	  This adds support for the SPI mux on the Orka board from Barco. The
+	  mux is a simple GPIO based multiplexer where the chip select is
+	  interpreted as a bitmask defining the state of the gpio pins, with
+	  the least significant bit defining the state of first gpio, the next
+	  bit the state of the second gpio and so forth.
+
+#
+# Add new SPI multiplexer drivers in alphabetical order above this line
+#
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e53c309..98c0572 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -8,6 +8,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
+obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
@@ -71,3 +72,6 @@ obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_TXX9)			+= spi-txx9.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
+
+#SPI mux drivers
+obj-$(CONFIG_SPI_BARCO_ORKA_MUX_GPIO)	+= spi-barco-orka-mux-gpio.o
diff --git a/drivers/spi/spi-barco-orka-mux-gpio.c b/drivers/spi/spi-barco-orka-mux-gpio.c
new file mode 100644
index 0000000..7b0fc89
--- /dev/null
+++ b/drivers/spi/spi-barco-orka-mux-gpio.c
@@ -0,0 +1,142 @@
+/*
+ * SPI multiplexer driver using GPIO API for Barco Orka board
+ *
+ * Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not,  see <http://www.gnu.org/licenses>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mux.h>
+
+/**
+ * DOC: Driver description
+ *
+ * This driver supports the mux on the Barco Orka board. The MUX can set up 2^n
+ * channels, where n is the number of GPIO's connected to set the MUX. The chip
+ * select of the child devices will be interpreted as a bitmask for the GPIO's,
+ * with the least significant bit defining the state of first gpio, the next
+ * bit the state of the second gpio and so forth.
+ */
+
+/**
+ * struct barco_orka_spi_mux_gpio - the basic barco_orka_spi_mux_gpio structure
+ * @gpios:		Array of GPIO numbers used to control MUX
+ * @n_gpios:		Number of GPIOs used to control MUX
+ */
+struct barco_orka_spi_mux_gpio {
+	unsigned int	*gpios;
+	int		n_gpios;
+};
+
+static int barco_orka_spi_mux_gpio_select(void *mux_dev, u8 chip_select)
+{
+	struct barco_orka_spi_mux_gpio *mux =
+		(struct barco_orka_spi_mux_gpio *)mux_dev;
+	int i;
+
+	for (i = 0; i < mux->n_gpios; i++) {
+		gpio_set_value(mux->gpios[i],
+			       chip_select & (1 << i));
+	}
+
+	return 0;
+}
+
+static int barco_orka_spi_mux_gpio_probe(struct spi_device *spi)
+{
+	struct barco_orka_spi_mux_gpio *mux;
+	struct device_node *np;
+	int ret = 0, i;
+	u16 num_chipselect;
+
+	mux = devm_kzalloc(&spi->dev, sizeof(*mux), GFP_KERNEL);
+	if (mux == NULL) {
+		dev_err(&spi->dev, "Failed to allocate driver struct\n");
+		return -ENOMEM;
+	}
+
+	np = spi->dev.of_node;
+	if (!np)
+		return -ENODEV;
+
+	mux->n_gpios = of_gpio_named_count(np, "gpios");
+	if (mux->n_gpios < 0) {
+		dev_err(&spi->dev, "Missing gpios property in the DT.\n");
+		return -EINVAL;
+	}
+
+	mux->gpios = devm_kzalloc(&spi->dev,
+			     sizeof(*mux->gpios) * mux->n_gpios,
+			     GFP_KERNEL);
+	if (!mux->gpios) {
+		dev_err(&spi->dev, "Cannot allocate gpios array");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < mux->n_gpios; i++)
+		mux->gpios[i] = of_get_named_gpio(np, "gpios", i);
+
+	for (i = 0; i < mux->n_gpios; i++) {
+		devm_gpio_request(&spi->dev, mux->gpios[i],
+				  "barco-orka-spi-mux-gpio");
+		gpio_direction_output(mux->gpios[i], 0);
+	}
+
+	/* the mux can have 2 ^ <nr_gpio_used_for_muxing> chip selects */
+	num_chipselect = 1 << mux->n_gpios;
+
+	ret = spi_add_mux(spi, mux, num_chipselect,
+			  barco_orka_spi_mux_gpio_select);
+	return ret;
+}
+
+static int barco_orka_spi_mux_gpio_remove(struct spi_device *spi)
+{
+	spi_del_mux(spi);
+	return 0;
+}
+
+static const struct of_device_id barco_orka_spi_mux_gpio_of_match[] = {
+	{ .compatible = "barco,orka-spi-mux-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, barco_orka_spi_mux_gpio_of_match);
+
+static struct spi_driver barco_orka_spi_mux_gpio_driver = {
+	.probe	= barco_orka_spi_mux_gpio_probe,
+	.remove	= barco_orka_spi_mux_gpio_remove,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "barco,orka-spi-mux-gpio",
+		.of_match_table = barco_orka_spi_mux_gpio_of_match,
+	},
+};
+
+module_spi_driver(barco_orka_spi_mux_gpio_driver);
+
+MODULE_DESCRIPTION("GPIO-based SPI multiplexer driver for Barco Orka");
+MODULE_AUTHOR("Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:barco,orka-spi-mux-gpio");
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
new file mode 100644
index 0000000..9cc9e94
--- /dev/null
+++ b/drivers/spi/spi-mux.c
@@ -0,0 +1,219 @@
+/*
+ * SPI multiplexer core driver
+ *
+ * Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not,  see <http://www.gnu.org/licenses>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mux.h>
+
+
+/**
+ * DOC: Driver description
+ *
+ * This driver supports a MUX on an SPI bus. This can be useful when you need
+ * more chip selects than the hardware peripherals support, or than are
+ * available in a particular board setup.
+ *
+ * The driver will create an additional master bus. Devices added under the mux
+ * will be handled as 'chip selects' on the mux bus.
+ *
+ * This is just the core mux driver, you will need an aditional mux-specific
+ * driver which needs to implement the spi_mux_select callback to set the mux.
+ */
+
+/**
+ * struct spi_mux_priv - the basic spi_mux structure
+ * @spi_device:		pointer to the device struct attached to the parent
+ *			spi master
+ * @current_cs:		The current chip select set in the mux
+ * @child_mesg_complete: The mux replaces the complete callback in the child's
+ *			message to its own callback; this field is used by the
+ *			driver to store the child's callback during a transfer
+ * @child_mesg_context: Used to store the child's context to the callback
+ * @child_mesg_dev:	Used to store the spi_device pointer to the child
+ * @spi_mux_select:	Callback to the specific mux implementation to set the
+ *			mux to a chip select
+ * @mux_dev:		Data passed to spi_mux_select callback and returned
+ *			with spi_del_mux
+ */
+struct spi_mux_priv {
+	struct spi_device	*spi;
+	u8			current_cs;
+
+	void			(*child_mesg_complete)(void *context);
+	void			*child_mesg_context;
+	struct spi_device	*child_mesg_dev;
+
+	int	(*spi_mux_select)(void *mux_dev, u8 chip_select);
+	void	*mux_dev;
+};
+
+/* should not get called when the parent master is doing a transfer */
+static int spi_mux_setup_mux(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv = spi_master_get_devdata(spi->master);
+	int ret = 0;
+
+	if (priv->current_cs != spi->chip_select) {
+		dev_dbg(&priv->spi->dev,
+			"setting up the mux for cs %d\n",
+			spi->chip_select);
+
+		/* copy the child device's settings except for the cs */
+		if (spi->max_speed_hz < priv->spi->max_speed_hz)
+			priv->spi->max_speed_hz = spi->max_speed_hz;
+		priv->spi->mode = spi->mode;
+		priv->spi->bits_per_word = spi->bits_per_word;
+
+		ret = priv->spi_mux_select(priv->mux_dev, spi->chip_select);
+		if (ret)
+			return ret;
+
+		priv->current_cs = spi->chip_select;
+	}
+
+	return ret;
+}
+
+static int spi_mux_setup(struct spi_device *spi)
+{
+	struct spi_mux_priv *priv = spi_master_get_devdata(spi->master);
+
+	/*
+	 * can be called multiple times, won't do a valid setup now but we will
+	 * change the settings when we do a transfer (necessary because we
+	 * can't predict from which device it will be anyway)
+	 */
+	return spi_setup(priv->spi);
+}
+
+static void spi_mux_complete_cb(void *context)
+{
+	struct spi_mux_priv *priv = (struct spi_mux_priv *)context;
+	struct spi_master *master = spi_get_drvdata(priv->spi);
+	struct spi_message *m = master->cur_msg;
+
+	m->complete = priv->child_mesg_complete;
+	m->context = priv->child_mesg_context;
+	m->spi = priv->child_mesg_dev;
+	spi_finalize_current_message(master);
+}
+
+static int spi_mux_transfer_one_message(struct spi_master *master,
+						struct spi_message *m)
+{
+	struct spi_mux_priv *priv = spi_master_get_devdata(master);
+	struct spi_device *spi = m->spi;
+	int ret = 0;
+
+	ret = spi_mux_setup_mux(spi);
+	if (ret)
+		return ret;
+
+	/*
+	 * Replace the complete callback, context and spi_device with our own
+	 * pointers. Save originals
+	 */
+	priv->child_mesg_complete = m->complete;
+	priv->child_mesg_context = m->context;
+	priv->child_mesg_dev = m->spi;
+
+	m->complete = spi_mux_complete_cb;
+	m->context = priv;
+	m->spi = priv->spi;
+
+	/* do the transfer */
+	ret = spi_async(priv->spi, m);
+	return ret;
+}
+
+int spi_add_mux(struct spi_device *spi, void *mux_dev, u16 num_chipselect,
+		int (*spi_mux_select)(void *mux_dev, u8 chip_select))
+{
+	struct spi_master *master;
+	struct spi_mux_priv *priv;
+	int ret = 0;
+
+	master = spi_alloc_master(&spi->dev, sizeof(*priv));
+	if (master == NULL) {
+		dev_dbg(&spi->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&spi->dev, master);
+	priv = spi_master_get_devdata(master);
+	priv->spi = spi;
+	priv->spi_mux_select = spi_mux_select;
+	priv->mux_dev = mux_dev;
+
+	priv->current_cs = 0;
+	ret = priv->spi_mux_select(priv->mux_dev, priv->current_cs);
+	if (ret)
+		goto err_mux_select;
+
+	/* supported modes are the same as our parent's */
+	master->mode_bits = spi->master->mode_bits;
+
+	master->setup = spi_mux_setup;
+	master->transfer_one_message = spi_mux_transfer_one_message;
+	master->num_chipselect = num_chipselect;
+	master->dev.of_node = spi->dev.of_node;
+
+	/*
+	 * when we register our mux as an spi master, it will parse the
+	 * the children of this node and add them as devices.
+	 * So we don't need to parse the child nodes here.
+	 */
+	ret = spi_register_master(master);
+	if (ret < 0)
+		goto err_register_master;
+
+	return ret;
+
+err_mux_select:
+err_register_master:
+	spi_master_put(master);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_add_mux);
+
+void spi_del_mux(struct spi_device *spi)
+{
+	struct spi_master *master = spi_get_drvdata(spi);
+
+	spi_unregister_master(master);
+	spi_master_put(master);
+}
+EXPORT_SYMBOL_GPL(spi_del_mux);
+
+void *spi_get_mux_dev(struct spi_device *spi)
+{
+	struct spi_master *master = spi_get_drvdata(spi);
+	struct spi_mux_priv *priv = spi_master_get_devdata(master);
+	return priv->mux_dev;
+}
+EXPORT_SYMBOL_GPL(spi_get_mux_dev);
+
+MODULE_DESCRIPTION("SPI multiplexer core functions");
+MODULE_AUTHOR("Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:spi-mux");
diff --git a/include/linux/spi/spi-mux.h b/include/linux/spi/spi-mux.h
new file mode 100644
index 0000000..726d1ef
--- /dev/null
+++ b/include/linux/spi/spi-mux.h
@@ -0,0 +1,58 @@
+/*
+ * SPI multiplexer core driver
+ *
+ * Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not,  see <http://www.gnu.org/licenses>
+ */
+
+#ifndef _LINUX_SPI_MUX_H
+#define _LINUX_SPI_MUX_H
+
+#ifdef __KERNEL__
+
+/**
+ * spi_add_mux: - create a SPI bus on a multiplexed bus segment.
+ * @spi: the SPI device struct attached to the parent SPI controller
+ * @mux_dev: pointer to the mux's implementation-dependent data
+ * @num_chipselect: maximum number of chip selects on this mux
+ * @spi_mux_select: callback function to set the mux to a specified chip select
+ *
+ * Description: adds a mux on the chip select of @spi
+ * Return: 0 if success, err otherwise
+ */
+extern int spi_add_mux(struct spi_device *spi,
+		       void *mux_dev,
+		       u16 num_chipselect,
+		       int (*spi_mux_select)(void *mux_dev, u8 chip_select));
+
+/**
+ * spi_del_mux: - delete a SPI mutliplexer previously added by spi_add_mux
+ * @spi: the SPI device struct attached to the parent SPI controller
+ *
+ * Description: deletes the mux on the chip select of @spi
+ */
+extern void spi_del_mux(struct spi_device *spi);
+
+/**
+ * spi_get_mux_dev: - get pointer to the mux's implementation-dependent data
+ * @spi: the SPI device struct attached to the parent SPI controller
+ *
+ * Return: the mux_dev pointer passed in spi_add_mux
+ */
+extern void *spi_get_mux_dev(struct spi_device *spi);
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_SPI_MUX_H */
-- 
1.7.9.5


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
