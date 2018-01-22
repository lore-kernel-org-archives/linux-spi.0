From: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] spi: add spi multiplexing functions for dt
Date: Mon, 22 Jan 2018 22:51:12 +0000
Message-ID: <1516661472-16452-2-git-send-email-ben.whitten@gmail.com>
References: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516661472-16452-1-git-send-email-ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Like I2C busses SPI devices can also sit behind multiplexers.
This patch adds is based off the I2C implementation and allows
description in the devicetree.

Signed-off-by: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig     |  10 +++
 drivers/spi/Makefile    |   3 +
 drivers/spi/spi-mux.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi-mux.h |  55 +++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/spi/spi-mux.c
 create mode 100644 include/linux/spi-mux.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2..58eba70 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -51,6 +51,16 @@ config SPI_MASTER
 
 if SPI_MASTER
 
+config SPI_MUX
+	tristate "SPI bus multiplexing support"
+	help
+	  Say Y here if you want the SPI core to support the ability to
+	  handle multiplexed SPI bus topologies, by presenting each
+	  multiplexed segment as an SPI controller.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-mux.
+
 comment "SPI Master Controller Drivers"
 
 config SPI_ALTERA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8e0cda7..ef525fe 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -109,6 +109,9 @@ obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
+# SPI muxs
+obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
+
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
new file mode 100644
index 0000000..a2008c1
--- /dev/null
+++ b/drivers/spi/spi-mux.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for an SPI multiplexer
+ *
+ * Copyright (c) 2018   Ben Whitten
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/spi-mux.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+struct spi_mux_priv {
+	struct spi_controller *controller;
+	struct spi_mux_core *muxc;
+	u32 chan_id;
+};
+
+struct spi_mux_core *spi_mux_alloc(struct spi_controller *parent,
+				   struct device *dev,
+				   int max_controllers,
+				   int sizeof_priv,
+				   int (*select)(struct spi_mux_core *, u32),
+				   int (*deselect)(struct spi_mux_core *, u32),
+				   int (*transfer_one_message)
+					(struct spi_controller *controller,
+					 struct spi_message *msg))
+{
+	struct spi_mux_core *muxc;
+
+	muxc = devm_kzalloc(dev, sizeof(*muxc)
+			    + max_controllers * sizeof(muxc->controller[0])
+			    + sizeof_priv, GFP_KERNEL);
+	if (!muxc)
+		return NULL;
+	if (sizeof_priv)
+		muxc->priv = &muxc->controller[max_controllers];
+
+	muxc->parent = parent;
+	muxc->dev = dev;
+
+	muxc->select = select;
+	muxc->deselect = deselect;
+	muxc->transfer_one_message = transfer_one_message;
+	muxc->max_controllers = max_controllers;
+
+	return muxc;
+}
+EXPORT_SYMBOL_GPL(spi_mux_alloc);
+
+u32 spi_mux_get_chan_id(struct spi_controller *controller)
+{
+	struct spi_mux_priv *priv = spi_controller_get_devdata(controller);
+
+	return priv->chan_id;
+}
+EXPORT_SYMBOL_GPL(spi_mux_get_chan_id);
+
+static int spi_mux_transfer_one_message(struct spi_controller *controller,
+					struct spi_message *msg)
+{
+	struct spi_mux_priv *priv = spi_controller_get_devdata(controller);
+	struct spi_mux_core *muxc = priv->muxc;
+	struct spi_device *spi = to_spi_device(muxc->dev);
+	int ret;
+
+	ret = muxc->select(muxc, priv->chan_id);
+	if (ret < 0)
+		return ret;
+
+	/* If we have a custom transfer, use it */
+	if (muxc->transfer_one_message)
+		ret = muxc->transfer_one_message(controller, msg);
+	else
+		ret = spi_sync(spi, msg);
+
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+
+	return ret;
+}
+
+static int spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id)
+{
+	struct spi_controller *controller;
+	struct spi_mux_priv *priv;
+	int ret;
+
+	if (muxc->num_controllers >= muxc->max_controllers) {
+		dev_err(muxc->dev, "No room for more spi-mux controllers");
+		return -EINVAL;
+	}
+
+	controller = spi_alloc_master(muxc->dev, sizeof(*priv));
+	if (!controller)
+		return -ENOMEM;
+	priv = spi_controller_get_devdata(controller);
+
+	/* Setup private controller data */
+	priv->muxc = muxc;
+	priv->controller = controller;
+	priv->chan_id = chan_id;
+
+	priv->controller->transfer_one_message = spi_mux_transfer_one_message;
+
+	/* Look for the child of this controller */
+	if (muxc->dev->of_node) {
+		struct device_node *dev_node = muxc->dev->of_node;
+		struct device_node *mux_node, *child = NULL;
+		u32 reg;
+
+		mux_node = of_get_child_by_name(dev_node, "spi-mux");
+		if (!mux_node)
+			mux_node = of_node_get(dev_node);
+
+		for_each_child_of_node(mux_node, child) {
+			ret = of_property_read_u32(child, "reg", &reg);
+			if (ret)
+				continue;
+			if (chan_id == reg)
+				break;
+		}
+
+		priv->controller->dev.of_node = child;
+		of_node_put(mux_node);
+	}
+
+	ret = devm_spi_register_controller(muxc->dev, priv->controller);
+	if (ret) {
+		spi_controller_put(priv->controller);
+		dev_err(muxc->dev, "Problem registering spi controller: %d\n",
+			ret);
+		return ret;
+	}
+
+	muxc->controller[muxc->num_controllers++] = priv->controller;
+
+	return ret;
+}
+
+static void spi_mux_del_controllers(struct spi_mux_core *muxc)
+{
+	struct spi_controller *controller =
+	    muxc->controller[--muxc->num_controllers];
+	struct device_node *np = controller->dev.of_node;
+
+	muxc->controller[muxc->num_controllers] = NULL;
+	of_node_put(np);
+}
+
+static void devm_spi_mux_del_controllers(struct device *dev, void *res)
+{
+	spi_mux_del_controllers(*(struct spi_mux_core **)res);
+}
+
+int devm_spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id)
+{
+	struct spi_mux_core **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_spi_mux_del_controllers, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = spi_mux_add_controller(muxc, chan_id);
+	if (!ret) {
+		*ptr = muxc;
+		devres_add(muxc->dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_spi_mux_add_controller);
+
+MODULE_AUTHOR("Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("SPI driver for multiplexed SPI busses");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi-mux.h b/include/linux/spi-mux.h
new file mode 100644
index 0000000..5978f86
--- /dev/null
+++ b/include/linux/spi-mux.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for an SPI multiplexer
+ *
+ * Copyright (c) 2018   Ben Whitten
+ */
+
+#ifndef _LINUX_SPI_MUX_H_
+#define _LINUX_SPI_MUX_H_
+
+#ifdef __KERNEL__
+
+struct spi_mux_core {
+	struct spi_controller *parent;
+	struct device *dev;
+
+	void *priv;
+
+	int (*select)(struct spi_mux_core *, u32 chan_id);
+	int (*deselect)(struct spi_mux_core *, u32 chan_id);
+	int (*transfer_one_message)(struct spi_controller *controller,
+				    struct spi_message *msg);
+
+	int num_controllers;
+	int max_controllers;
+	struct spi_controller *controller[0];
+};
+
+struct spi_mux_core *spi_mux_alloc(struct spi_controller *parent,
+				   struct device *dev,
+				   int max_controllers,
+				   int sizeof_priv,
+				   int (*select)(struct spi_mux_core *, u32),
+				   int (*deselect)(struct spi_mux_core *, u32),
+				   int (*transfer_one_message)
+					(struct spi_controller *controller,
+					 struct spi_message *msg));
+
+static inline void *spi_mux_priv(struct spi_mux_core *muxc)
+{
+	return muxc->priv;
+}
+
+u32 spi_mux_get_chan_id(struct spi_controller *controller);
+
+/*
+ * Called to create an spi bus on a multiplexed bus segment.
+ * The chan_id parameter is passed to the select and deselect
+ * callback functions to perform hardware-specific mux control.
+ */
+int devm_spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id);
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_SPI_MUX_H_ */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
