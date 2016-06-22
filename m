From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/6] spi: slave: Add SPI slave handler controlling system state
Date: Wed, 22 Jun 2016 15:42:08 +0200
Message-ID: <1466602929-4191-6-git-send-email-geert+renesas@glider.be>
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

Add an SPI slave handler to allow remote control of system reboot, power
off, halt, and suspend.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
FIXME kthread_stop() hangs, as spi_write() is blocked on a completion
---
 drivers/spi/Kconfig                    |   6 ++
 drivers/spi/Makefile                   |   1 +
 drivers/spi/spi-slave-system-control.c | 134 +++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/spi/spi-slave-system-control.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e9b2f48574464949..9657415125ccb631 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -754,6 +754,12 @@ config SPI_SLAVE_TIME
 	  SPI slave handler responding with the time of reception of the last
 	  SPI message.
 
+config SPI_SLAVE_SYSTEM_CONTROL
+	tristate "SPI slave handler controlling system state"
+	help
+	  SPI slave handler to allow remote control of system reboot, power
+	  off, halt, and suspend.
+
 endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index dc67b8f137e2ced0..3b0487a9da91dfa8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
+obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
new file mode 100644
index 0000000000000000..350711dec1281675
--- /dev/null
+++ b/drivers/spi/spi-slave-system-control.c
@@ -0,0 +1,134 @@
+/*
+ * SPI slave handler controlling system state
+ *
+ * This SPI slave handler allows remote control of system reboot, power off,
+ * halt, and suspend.
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/spi/spi.h>
+
+/*
+ * The numbers are chosen to display something human-readable on two 7-segment
+ * displays connected to two 74HC595 shift registers
+ */
+#define CMD_REBOOT	0x507c	/* rb */
+#define CMD_POWEROFF	0x3f71	/* OF */
+#define CMD_HALT	0x7638	/* HL */
+#define CMD_SUSPEND	0x1b1b	/* ZZ */
+
+struct spi_slave_system_control_priv {
+	struct spi_device *spi;
+	struct task_struct *thread;
+};
+
+static int spi_slave_system_control_send(struct spi_device *spi)
+{
+	__le16 cmd;
+	int error;
+
+	error = spi_read(spi, &cmd, sizeof(cmd));
+	if (error)
+		return error;
+
+	switch (le16_to_cpu(cmd)) {
+	case CMD_REBOOT:
+		pr_info("Rebooting system...\n");
+		kernel_restart(NULL);
+
+	case CMD_POWEROFF:
+		pr_info("Powering off system...\n");
+		kernel_power_off();
+		break;
+
+	case CMD_HALT:
+		pr_info("Halting system...\n");
+		kernel_halt();
+		break;
+
+	case CMD_SUSPEND:
+		pr_info("Suspending system...\n");
+		pm_suspend(PM_SUSPEND_MEM);
+		break;
+
+	default:
+		pr_warn("%s: Unknown command 0x%x\n", __func__, cmd);
+		break;
+	}
+	return 0;
+}
+
+static int spi_slave_system_control_thread(void *data)
+{
+	struct spi_slave_system_control_priv *priv = data;
+	int error;
+
+	while (!kthread_should_stop()) {
+		error = spi_slave_system_control_send(priv->spi);
+		if (error)
+			pr_err("%s: SPI transfer failed %d\n", __func__, error);
+	}
+
+	return 0;
+}
+
+static int spi_slave_system_control_probe(struct spi_device *spi)
+{
+	struct spi_slave_system_control_priv *priv;
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
+	priv->thread = kthread_run(spi_slave_system_control_thread, priv,
+				   "spi-slave-system-control/%s",
+				   dev_name(&spi->dev));
+	if (IS_ERR(priv->thread))
+		return PTR_ERR(priv->thread);
+
+	spi_set_drvdata(spi, priv);
+
+	return 0;
+}
+
+static int spi_slave_system_control_remove(struct spi_device *spi)
+{
+	struct spi_slave_system_control_priv *priv = spi_get_drvdata(spi);
+
+	/* FIXME Doesn't work, as spi_read() is blocked on a completion */
+	kthread_stop(priv->thread);
+	return 0;
+}
+
+static struct spi_driver spi_slave_system_control_driver = {
+	.driver = {
+		.name	= "spi-slave-system-control",
+	},
+	.probe		= spi_slave_system_control_probe,
+	.remove		= spi_slave_system_control_remove,
+};
+module_spi_driver(spi_slave_system_control_driver);
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("SPI slave reporting boot up time");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
