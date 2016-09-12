From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 6/7] spi: slave: Add SPI slave handler reporting uptime at previous message
Date: Mon, 12 Sep 2016 22:50:45 +0200
Message-ID: <1473713446-30366-7-git-send-email-geert+renesas@glider.be>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add an example SPI slave handler responding with the uptime at the time
of reception of the last SPI message.

This can be used by an external microcontroller as a dead man's switch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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
 drivers/spi/Kconfig          |   6 +++
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-slave-time.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/spi/spi-slave-time.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fa13a3663de5bde0..515bddee4018c246 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -749,6 +749,12 @@ config SPI_SLAVE
 
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
index 96e5c0d6e5bc6151..ba4a7e79fe113d3e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
+obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-slave-time.c b/drivers/spi/spi-slave-time.c
new file mode 100644
index 0000000000000000..69e970ecb579adc7
--- /dev/null
+++ b/drivers/spi/spi-slave-time.c
@@ -0,0 +1,126 @@
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
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("SPI slave reporting uptime at previous SPI message");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
