From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: slave: Add SPI slave handler controlling system state" to the spi tree
Date: Fri, 26 May 2017 13:12:42 +0100
Message-ID: <E1dEE6k-0001Nd-0c@debutante>
References: <1495458705-11692-7-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495458705-11692-7-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: slave: Add SPI slave handler controlling system state

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ce70e06c093a9609377e93ee20e7c528e156af14 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Mon, 22 May 2017 15:11:45 +0200
Subject: [PATCH] spi: slave: Add SPI slave handler controlling system state

Add an example SPI slave handler to allow remote control of system
reboot, power off, halt, and suspend.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig                    |   6 ++
 drivers/spi/Makefile                   |   1 +
 drivers/spi/spi-slave-system-control.c | 154 +++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/spi/spi-slave-system-control.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ade542c5bfd8..e6d9e329a380 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -802,6 +802,12 @@ config SPI_SLAVE_TIME
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
index fb078693dbe4..1d7923e8c63b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
+obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
new file mode 100644
index 000000000000..c0257e937995
--- /dev/null
+++ b/drivers/spi/spi-slave-system-control.c
@@ -0,0 +1,154 @@
+/*
+ * SPI slave handler controlling system state
+ *
+ * This SPI slave handler allows remote control of system reboot, power off,
+ * halt, and suspend.
+ *
+ * Copyright (C) 2016-2017 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Usage (assuming /dev/spidev2.0 corresponds to the SPI master on the remote
+ * system):
+ *
+ *   # reboot='\x7c\x50'
+ *   # poweroff='\x71\x3f'
+ *   # halt='\x38\x76'
+ *   # suspend='\x1b\x1b'
+ *   # spidev_test -D /dev/spidev2.0 -p $suspend # or $reboot, $poweroff, $halt
+ */
+
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+#include <linux/spi/spi.h>
+
+/*
+ * The numbers are chosen to display something human-readable on two 7-segment
+ * displays connected to two 74HC595 shift registers
+ */
+#define CMD_REBOOT	0x7c50	/* rb */
+#define CMD_POWEROFF	0x713f	/* OF */
+#define CMD_HALT	0x3876	/* HL */
+#define CMD_SUSPEND	0x1b1b	/* ZZ */
+
+struct spi_slave_system_control_priv {
+	struct spi_device *spi;
+	struct completion finished;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	__be16 cmd;
+};
+
+static
+int spi_slave_system_control_submit(struct spi_slave_system_control_priv *priv);
+
+static void spi_slave_system_control_complete(void *arg)
+{
+	struct spi_slave_system_control_priv *priv = arg;
+	u16 cmd;
+	int ret;
+
+	if (priv->msg.status)
+		goto terminate;
+
+	cmd = be16_to_cpu(priv->cmd);
+	switch (cmd) {
+	case CMD_REBOOT:
+		dev_info(&priv->spi->dev, "Rebooting system...\n");
+		kernel_restart(NULL);
+
+	case CMD_POWEROFF:
+		dev_info(&priv->spi->dev, "Powering off system...\n");
+		kernel_power_off();
+		break;
+
+	case CMD_HALT:
+		dev_info(&priv->spi->dev, "Halting system...\n");
+		kernel_halt();
+		break;
+
+	case CMD_SUSPEND:
+		dev_info(&priv->spi->dev, "Suspending system...\n");
+		pm_suspend(PM_SUSPEND_MEM);
+		break;
+
+	default:
+		dev_warn(&priv->spi->dev, "Unknown command 0x%x\n", cmd);
+		break;
+	}
+
+	ret = spi_slave_system_control_submit(priv);
+	if (ret)
+		goto terminate;
+
+	return;
+
+terminate:
+	dev_info(&priv->spi->dev, "Terminating\n");
+	complete(&priv->finished);
+}
+
+static
+int spi_slave_system_control_submit(struct spi_slave_system_control_priv *priv)
+{
+	int ret;
+
+	spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
+
+	priv->msg.complete = spi_slave_system_control_complete;
+	priv->msg.context = priv;
+
+	ret = spi_async(priv->spi, &priv->msg);
+	if (ret)
+		dev_err(&priv->spi->dev, "spi_async() failed %d\n", ret);
+
+	return ret;
+}
+
+static int spi_slave_system_control_probe(struct spi_device *spi)
+{
+	struct spi_slave_system_control_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+	init_completion(&priv->finished);
+	priv->xfer.rx_buf = &priv->cmd;
+	priv->xfer.len = sizeof(priv->cmd);
+
+	ret = spi_slave_system_control_submit(priv);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, priv);
+	return 0;
+}
+
+static int spi_slave_system_control_remove(struct spi_device *spi)
+{
+	struct spi_slave_system_control_priv *priv = spi_get_drvdata(spi);
+
+	spi_slave_abort(spi);
+	wait_for_completion(&priv->finished);
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
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>");
+MODULE_DESCRIPTION("SPI slave handler controlling system state");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
