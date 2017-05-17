From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v4 5/6] spi: slave: Add SPI slave handler reporting uptime at previous message
Date: Wed, 17 May 2017 14:47:51 +0200
Message-ID: <1495025272-23930-6-git-send-email-geert+renesas@glider.be>
References: <1495025272-23930-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495025272-23930-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add an example SPI slave handler responding with the uptime at the time
of reception of the last SPI message.

This can be used by an external microcontroller as a dead man's switch.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v4:
  - No changes,

v3:
  - Add #include <linux/sched/clock.h>,

v2:
  - Resolve semantic differences in patch description, file header, and
    module description,
  - Use spi_async() instead of spi_read(),
  - Submit the next transfer from the previous transfer's completion
    callback, removing the need for a thread,
  - Let .remove() call spi_slave_abort() to cancel the current ongoing
    transfer, and wait for the completion to terminate,
  - Remove FIXME about hanging kthread_stop().
---
 drivers/spi/Kconfig          |   6 ++
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-slave-time.c | 127 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/spi/spi-slave-time.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f21499b1f71ab7c3..9972ee2a8454a2fc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -797,6 +797,12 @@ config SPI_SLAVE
 
 if SPI_SLAVE
 
+config SPI_SLAVE_TIME
+	tristate "SPI slave handler reporting boot up time"
+	help
+	  SPI slave handler responding with the time of reception of the last
+	  SPI message.
+
 endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e50852c6fcb87d8b..fb078693dbe40da4 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
+obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-slave-time.c b/drivers/spi/spi-slave-time.c
new file mode 100644
index 0000000000000000..c2940f3f18ecd22e
--- /dev/null
+++ b/drivers/spi/spi-slave-time.c
@@ -0,0 +1,127 @@
+/*
+ * SPI slave handler reporting uptime at reception of previous SPI message
+ *
+ * This SPI slave handler sends the time of reception of the last SPI message
+ * as two 32-bit unsigned integers in binary format and in network byte order,
+ * representing the number of seconds and fractional seconds (in microseconds)
+ * since boot up.
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/sched/clock.h>
+#include <linux/spi/spi.h>
+
+
+struct spi_slave_time_priv {
+	struct spi_device *spi;
+	struct completion finished;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	__be32 buf[2];
+};
+
+static int spi_slave_time_submit(struct spi_slave_time_priv *priv);
+
+static void spi_slave_time_complete(void *arg)
+{
+	struct spi_slave_time_priv *priv = arg;
+	int ret;
+
+	ret = priv->msg.status;
+	if (ret)
+		goto terminate;
+
+	ret = spi_slave_time_submit(priv);
+	if (ret)
+		goto terminate;
+
+	return;
+
+terminate:
+	pr_info("%s: Terminating\n", __func__);
+	complete(&priv->finished);
+}
+
+static int spi_slave_time_submit(struct spi_slave_time_priv *priv)
+{
+	u32 rem_ns;
+	int ret;
+	u64 ts;
+
+	ts = local_clock();
+	rem_ns = do_div(ts, 1000000000) / 1000;
+
+	priv->buf[0] = cpu_to_be32(ts);
+	priv->buf[1] = cpu_to_be32(rem_ns);
+
+	spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
+
+	priv->msg.complete = spi_slave_time_complete;
+	priv->msg.context = priv;
+
+	ret = spi_async(priv->spi, &priv->msg);
+	if (ret)
+		pr_err("%s: spi_async() failed %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int spi_slave_time_probe(struct spi_device *spi)
+{
+	struct spi_slave_time_priv *priv;
+	int ret;
+
+	/*
+	 * bits_per_word cannot be configured in platform data
+	 */
+	spi->bits_per_word = 8;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+	init_completion(&priv->finished);
+	priv->xfer.tx_buf = priv->buf;
+	priv->xfer.len = sizeof(priv->buf);
+
+	ret = spi_slave_time_submit(priv);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, priv);
+	return 0;
+}
+
+static int spi_slave_time_remove(struct spi_device *spi)
+{
+	struct spi_slave_time_priv *priv = spi_get_drvdata(spi);
+
+	spi_slave_abort(spi);
+	wait_for_completion(&priv->finished);
+	return 0;
+}
+
+static struct spi_driver spi_slave_time_driver = {
+	.driver = {
+		.name	= "spi-slave-time",
+	},
+	.probe		= spi_slave_time_probe,
+	.remove		= spi_slave_time_remove,
+};
+module_spi_driver(spi_slave_time_driver);
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>");
+MODULE_DESCRIPTION("SPI slave reporting uptime at previous SPI message");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
