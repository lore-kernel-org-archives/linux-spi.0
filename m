From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 4/6] spi: slave: Add SPI slave handler reporting boot up time
Date: Wed, 22 Jun 2016 15:42:07 +0200
Message-ID: <1466602929-4191-5-git-send-email-geert+renesas@glider.be>
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
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add an SPI slave handler responding with the time of reception of the
last SPI message.

This can be used by an external microcontroller as a dead man's switch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
FIXME kthread_stop() hangs, as spi_write() is blocked on a completion
---
 drivers/spi/Kconfig          |   6 +++
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-slave-time.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/spi/spi-slave-time.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 00e990d91a715c0e..e9b2f48574464949 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -748,6 +748,12 @@ config SPI_SLAVE
 
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
index 71d02939080fb747..dc67b8f137e2ced0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -99,3 +99,4 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
+obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-slave-time.c b/drivers/spi/spi-slave-time.c
new file mode 100644
index 0000000000000000..3d606af318024573
--- /dev/null
+++ b/drivers/spi/spi-slave-time.c
@@ -0,0 +1,103 @@
+/*
+ * SPI slave handler reporting boot up time
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
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/spi/spi.h>
+
+
+struct spi_slave_time_priv {
+	struct spi_device *spi;
+	struct task_struct *thread;
+};
+
+static int spi_slave_time_send(struct spi_device *spi)
+{
+	__be32 msg[2];
+	u32 rem_ns;
+	u64 ts;
+
+	ts = local_clock();
+	rem_ns = do_div(ts, 1000000000) / 1000;
+
+	msg[0] = cpu_to_be32(ts);
+	msg[1] = cpu_to_be32(rem_ns);
+
+	return spi_write(spi, &msg, sizeof(msg));
+}
+
+static int spi_slave_time_thread(void *data)
+{
+	struct spi_slave_time_priv *priv = data;
+	int error;
+
+	while (!kthread_should_stop()) {
+		error = spi_slave_time_send(priv->spi);
+		if (error)
+			pr_err("%s: SPI transfer failed %d\n", __func__, error);
+	}
+
+	return 0;
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
+	priv->thread = kthread_run(spi_slave_time_thread, priv,
+				   "spi-slave-time/%s", dev_name(&spi->dev));
+	if (IS_ERR(priv->thread))
+		return PTR_ERR(priv->thread);
+
+	spi_set_drvdata(spi, priv);
+	return 0;
+}
+
+static int spi_slave_time_remove(struct spi_device *spi)
+{
+	struct spi_slave_time_priv *priv = spi_get_drvdata(spi);
+
+	/* FIXME Doesn't work, as spi_write() is blocked on a completion */
+	kthread_stop(priv->thread);
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
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("SPI slave reporting boot up time");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
