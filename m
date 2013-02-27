From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Wed, 27 Feb 2013 14:58:39 +0100
Message-ID: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

This patch contains a driver for a gpio controlled multiplexer on an
SPI bus. This can be useful if a board requires more SPI devices,
and thus more chip selects, than the SPI controller on the processor
has available.

The mux device is added in the device tree as a child node of the
SPI master. Then, devices can be added as children of the mux node.
The mux will appear as if it was a SPI master device, and child
nodes will appear as chip selects on the mux bus. A bindings file is
provided for the device tree bindings.

Since at least some SPI master drivers queue messages from the
attached devices, the mux can only send 1 message at a time from its
own queue to the master, because otherwise there would not be a
guarantee that the mux settings will be correct when the real master
does the transfer.

Signed-off-by: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-mux-gpio.txt       |  113 +++++++
 drivers/spi/Kconfig                                |    9 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-mux-gpio.c                         |  319 ++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
 create mode 100644 drivers/spi/spi-mux-gpio.c

diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
new file mode 100644
index 0000000..534a667
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
@@ -0,0 +1,113 @@
+GPIO-based SPI Chip Select Mux
+
+This binding describes a SPI bus multiplexer that uses GPIOs to route
+the SPI chip select signals. This can be used when you need more
+devices than the SPI controller has chip selects available.
+
+      MOSI /---------------------------+--------+--------+--------\
+      MISO |/-------------------------+|-------+|-------+|-------\|
+       SCL ||/-----------------------+||------+||------+||------\||
+           |||                       |||      |||      |||      |||
+    +------------+                   |||      |||      |||      |||
+    | SoC  |||   |                 +-+++-+  +-+++-+  +-+++-+  +-+++-+
+    |      |||   |                 | dev |  | dev |  | dev |  | dev |
+    |   +--+++-+ |  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
+    |   | SPI  +-|--| Mux  |\\   CS-0 |        |        |        |
+    |   +------+ |  +--++--+\\\-------/   CS-1 |        |        |
+    |            |     ||   \\\----------------/   CS-2 |        |
+    |   +------+ |     ||    \\-------------------------/   CS-3 |
+    |   | GPIO |-|-----/|     \----------------------------------/
+    |   |      |-|------/
+    |   +------+ |
+    +------------+
+
+Required properties:
+- compatible: "spi-mux-gpio"
+- #address-cells: <1> (as for any SPI master device)
+- #size-cells: <0> (as for any SPI master device)
+- reg: chip select of the mux on the parent SPI master
+- spi-max-frequency: the maximum frequency allowed for any devices on
+  this mux
+- mux-gpios: list of gpios used to control the muxer
+* SPI child nodes, as if the mux is a real spi master
+
+A new SPI bus will be created. Then for each child node, a SPI device
+is created, with a virtual chip select on this bus according to the
+reg property.
+
+Whenever an access is made to a child device, the value set in the
+revelant node's reg property is interpreted as a bitmask defining the
+state of the mux-gpios gpio pins, with the least significant bit
+defining the state of first gpio, the next bit the state of the second
+gpio and so forth.
+
+The property spi-max-frequency is conceptually not needed, as each
+child node holds the maximum frequency specific to that
+device. However, the SPI core code wants every device in the tree to
+specify a maximum frequency. So because the mux is a device to a
+parent SPI master, you need to set a maximum frequency.  It's best to
+set this high, as the driver will take the minimum of this value and
+the child's maximum frequency value when doing a transfer to that
+child device.
+
+Example:
+	/*
+	 * An SPI mux on chip select 1 of the spi1 peripheral controller of an
+
+	 * am33xx soc. Chip select 0 is taken by another device, and the mux is
+	 * on chip select 1. Behind the mux are 4 devices which are defined as
+	 * if the spi-mux is a master.
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
+			compatible = "spi-mux-gpio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <1>;
+			spi-max-frequency = <100000000>;
+
+			mux-gpios = <&gpio2 30 0 &gpio2 31 0>;
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
index f80eee7..df0390d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -481,6 +481,15 @@ config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
 	depends on SPI_DESIGNWARE && HAVE_CLK
 
+config SPI_MUX_GPIO
+	tristate "GPIO-based SPI multiplexer support"
+	depends on GENERIC_GPIO
+	help
+	  This adds support for a GPIO based multiplexer on one or more of the
+	  SPI busses. The mux will be accessible as an extra master bus, the
+	  devices behind the mux will appear to be chip selects on this master
+	  bus.
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e53c309..732670a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
+obj-$(CONFIG_SPI_MUX_GPIO)		+= spi-mux-gpio.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
diff --git a/drivers/spi/spi-mux-gpio.c b/drivers/spi/spi-mux-gpio.c
new file mode 100644
index 0000000..983565b
--- /dev/null
+++ b/drivers/spi/spi-mux-gpio.c
@@ -0,0 +1,319 @@
+/*
+ * SPI multiplexer using GPIO API
+ *
+ * Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation;
+ * version 2.1 of the License (not later!)
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not,  see <http://www.gnu.org/licenses>
+ *
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
+#include <linux/wait.h>
+#include <linux/spi/spi.h>
+
+/*
+ * This driver supports a MUX on an SPI bus. This can be useful when you need
+ * more chip selects than the hardware peripherals support, or than are
+ * available in a particular board setup.
+ *
+ * This particular implementation also assumes the MUX can set up 2^n channels,
+ * where n is the number of GPIO's connected to set the MUX.
+ *
+ * The driver will create an additional master bus. Devices added under the mux
+ * will be handled as 'chip selects' on the mux bus.
+ */
+
+/**
+ * struct spi_mux_gpio - the basic spi_mux_gpio structure
+ * @spi_device:		pointer to the device struct attached to the parent
+ *			spi master
+ * @gpios:		Array of GPIO numbers used to control MUX
+ * @n_gpios:		Number of GPIOs used to control MUX
+ * @values:		Array of bitmasks of GPIO settings (low/high) for each
+ *			position
+ * @current_cs:		The current chip select set in the mux
+ * @xfer_complete_wq:	A wait queue to wait for the parent spi master to
+ *			finish one message so this driver knows when it is safe
+ *			to switch the mux
+ * @xfer_complete:	The wait condition for the wait queue
+ */
+struct spi_mux_gpio {
+	struct spi_device	*spi;
+	unsigned int		*gpios;
+	int			n_gpios;
+	unsigned int		*values;
+	int			current_cs;
+	wait_queue_head_t	xfer_complete_wq;
+	bool			xfer_complete;
+};
+
+static int spi_mux_gpio_select(struct spi_device *spi)
+{
+	struct spi_mux_gpio *mux = spi_master_get_devdata(spi->master);
+	int i;
+
+	for (i = 0; i < mux->n_gpios; i++) {
+		gpio_set_value(mux->gpios[i],
+			       mux->values[spi->chip_select] & (1 << i));
+	}
+
+	return 0;
+}
+
+/* should not get called when our master is doing a transfer */
+static int spi_mux_gpio_setup_mux(struct spi_device *spi)
+{
+	struct spi_mux_gpio *mux = spi_master_get_devdata(spi->master);
+	int ret = 0;
+
+	if (mux->current_cs != spi->chip_select) {
+		dev_dbg(&mux->spi->dev,
+			"setting up the mux for cs %d\n",
+			spi->chip_select);
+
+		/* copy the child device's settings except for the cs */
+		if (spi->max_speed_hz < mux->spi->max_speed_hz)
+			mux->spi->max_speed_hz = spi->max_speed_hz;
+		mux->spi->mode = spi->mode;
+		mux->spi->bits_per_word = spi->bits_per_word;
+
+		ret = spi_mux_gpio_select(spi);
+		if (ret)
+			return ret;
+
+		mux->current_cs = spi->chip_select;
+	}
+
+	return ret;
+}
+
+static int spi_mux_gpio_setup(struct spi_device *spi)
+{
+	struct spi_mux_gpio *mux = spi_master_get_devdata(spi->master);
+
+	/*
+	 * can be called multiple times, won't do a valid setup now but we will
+	 * change the settings when we do a transfer (necessary because we
+	 * can't predict from which device it will be anyway)
+	 */
+	return spi_setup(mux->spi);
+}
+
+static void spi_mux_gpio_complete_cb(void *context)
+{
+	struct spi_mux_gpio *mux = (struct spi_mux_gpio *)context;
+
+	/* allow transfer function to continue */
+	mux->xfer_complete = true;
+	wake_up_interruptible(&mux->xfer_complete_wq);
+}
+
+static int spi_mux_gpio_transfer_one_message(struct spi_master *master,
+						struct spi_message *m)
+{
+	struct spi_mux_gpio *mux = spi_master_get_devdata(master);
+	struct spi_device *spi = m->spi;
+
+	void (*child_mesg_complete)(void *context);
+	void *child_mesg_context;
+	struct spi_device *child_mesg_dev;
+
+	int ret = 0;
+
+	ret = spi_mux_gpio_setup_mux(spi);
+	if (ret)
+		return ret;
+
+	/*
+	 * Replace the complete callback, context and spi_device with our own
+	 * pointers. Save originals
+	 */
+	child_mesg_complete = m->complete;
+	child_mesg_context = m->context;
+	child_mesg_dev = m->spi;
+
+	m->complete = spi_mux_gpio_complete_cb;
+	m->context = mux;
+	m->spi = mux->spi;
+
+	/* do the transfer + wait until it is done */
+	mux->xfer_complete = false;
+	spi_async(mux->spi, m);
+
+	ret = wait_event_interruptible(mux->xfer_complete_wq,
+				       mux->xfer_complete);
+
+	/*
+	 * restore callback, context, spi_device and do finalize, even if
+	 * ret != 0. In that case, m->actual_length will hold the bytes
+	 * actually transferred.
+	 */
+	m->complete = child_mesg_complete;
+	m->context = child_mesg_context;
+	m->spi = child_mesg_dev;
+	spi_finalize_current_message(master);
+
+	return ret;
+}
+
+static int spi_mux_gpio_probe_dt(struct spi_mux_gpio *mux)
+{
+	struct device_node *np = mux->spi->dev.of_node;
+	struct device_node *child;
+
+	int n_values, i;
+
+	if (!np)
+		return -ENODEV;
+
+	n_values = of_get_child_count(np);
+
+	mux->values = devm_kzalloc(&mux->spi->dev,
+			      sizeof(*mux->values) * n_values,
+			      GFP_KERNEL);
+	if (!mux->values) {
+		dev_err(&mux->spi->dev, "Cannot allocate values array");
+		return -ENOMEM;
+	}
+
+	i = 0;
+	for_each_child_of_node(np, child) {
+		of_property_read_u32(child, "reg", mux->values + i);
+		i++;
+	}
+
+	mux->n_gpios = of_gpio_named_count(np, "mux-gpios");
+	if (mux->n_gpios < 0) {
+		dev_err(&mux->spi->dev,
+			"Missing mux-gpios property in the DT.\n");
+		return -EINVAL;
+	}
+
+	mux->gpios = devm_kzalloc(&mux->spi->dev,
+			     sizeof(*mux->gpios) * mux->n_gpios,
+			     GFP_KERNEL);
+	if (!mux->gpios) {
+		dev_err(&mux->spi->dev, "Cannot allocate gpios array");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < mux->n_gpios; i++)
+		mux->gpios[i] = of_get_named_gpio(np, "mux-gpios", i);
+
+	/*
+	 * when we register our mux as an spi master, it will parse the
+	 * the children of this node and add them as devices.
+	 * So we don't need to parse the child nodes here.
+	 */
+
+	return 0;
+}
+
+static int spi_mux_gpio_probe(struct spi_device *spi)
+{
+	struct spi_master *master;
+	struct spi_mux_gpio *mux;
+	int ret = 0, i;
+	unsigned int initial_state;
+
+	master = spi_alloc_master(&spi->dev, sizeof(*mux));
+	if (master == NULL) {
+		dev_dbg(&spi->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&spi->dev, master);
+	mux = spi_master_get_devdata(master);
+	mux->spi = spi;
+
+	ret = spi_mux_gpio_probe_dt(mux);
+	if (ret < 0)
+		goto err_probe_dt;
+
+	initial_state = mux->values[0];
+	mux->current_cs = 0;
+
+	for (i = 0; i < mux->n_gpios; i++) {
+		devm_gpio_request(&spi->dev, mux->gpios[i], "spi-mux-gpio");
+		gpio_direction_output(mux->gpios[i], initial_state & (1 << i));
+	}
+
+	mux->xfer_complete = true;
+	init_waitqueue_head(&mux->xfer_complete_wq);
+
+	/* supported modes are the same as our parent's */
+	master->mode_bits = mux->spi->master->mode_bits;
+
+	master->setup = spi_mux_gpio_setup;
+	master->transfer_one_message = spi_mux_gpio_transfer_one_message;
+
+	/* the mux can have 2 ^ <nr_gpio_used_for_muxing> chip selects */
+	master->num_chipselect = 1 << mux->n_gpios;
+	master->dev.of_node = spi->dev.of_node;
+
+	/* register master -> this also adds the devices behind the mux */
+	ret = spi_register_master(master);
+	if (ret < 0)
+		goto err_register_master;
+
+	return ret;
+
+err_register_master:
+err_probe_dt:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int spi_mux_gpio_remove(struct spi_device *spi)
+{
+	struct spi_master *master = spi_get_drvdata(spi);
+
+	spi_unregister_master(master);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static const struct of_device_id spi_mux_gpio_of_match[] = {
+	{ .compatible = "spi-mux-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spi_mux_gpio_of_match);
+
+static struct spi_driver spi_mux_gpio_driver = {
+	.probe	= spi_mux_gpio_probe,
+	.remove	= spi_mux_gpio_remove,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "spi-mux-gpio",
+		.of_match_table = of_match_ptr(spi_mux_gpio_of_match),
+	},
+};
+
+module_spi_driver(spi_mux_gpio_driver);
+
+MODULE_DESCRIPTION("GPIO-based SPI multiplexer driver");
+MODULE_AUTHOR("Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:spi-mux-gpio");
-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
