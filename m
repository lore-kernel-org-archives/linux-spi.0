From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v3] spi: Add Lattice ECP3 FPGA configuration via SPI
Date: Wed, 28 Nov 2012 06:57:44 +0100
Message-ID: <1354082264-28426-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch adds support for bitstream configuration (programming /
loading) of the Lattice ECP3 FPGA's via the SPI bus.

Here an example on my custom MPC5200 based board:

$ echo 1 > /sys/class/firmware/spi0.0/loading
$ cat fpga_a4m2k.bit > /sys/class/firmware/spi0.0/data
$ echo 0 > /sys/class/firmware/spi0.0/loading

leads to these messages:

lattice-ecp3 spi0.0: FPGA Lattice ECP3-35 detected
lattice-ecp3 spi0.0: Configuring the FPGA...
lattice-ecp3 spi0.0: FPGA succesfully configured!

Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
v3:
- Removed unnecessary goto (return instead)
- Added waiting for completion in remove

v2:
- Moved from drivers/firmware to drivers/spi as suggested by
  Ming Lei
- Removed pseudo device
- Removed static buffer pointer usage

 drivers/spi/Kconfig                   |  11 ++
 drivers/spi/Makefile                  |   1 +
 drivers/spi/spi-lattice-ecp3-config.c | 233 ++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/spi/spi-lattice-ecp3-config.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1acae35..e7b108773 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -461,6 +461,17 @@ config SPI_DW_MMIO
 #
 comment "SPI Protocol Masters"
 
+config SPI_LATTICE_ECP3_CONFIG
+	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
+	depends on SYSFS
+	select FW_LOADER
+	default	n
+	help
+	  This option enables support for bitstream configuration (programming
+	  or loading) of the Lattice ECP3 FPGA family via SPI.
+
+	  If unsure, say N.
+
 config SPI_SPIDEV
 	tristate "User mode SPI device driver support"
 	depends on EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c48df47..9a532c0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
+obj-$(CONFIG_SPI_LATTICE_ECP3_CONFIG)	+= spi-lattice-ecp3-config.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
diff --git a/drivers/spi/spi-lattice-ecp3-config.c b/drivers/spi/spi-lattice-ecp3-config.c
new file mode 100644
index 0000000..d3e107f
--- /dev/null
+++ b/drivers/spi/spi-lattice-ecp3-config.c
@@ -0,0 +1,233 @@
+/*
+ * Copyright (C) 2012 Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#define DRIVER_NAME	"lattice-ecp3"
+#define DRIVER_VER	"1.0"
+#define FIRMWARE_NAME	"lattice-ecp3.bit"
+
+/*
+ * The JTAG ID's of the supported FPGA's. The ID is 32bit wide
+ * reversed as noted in the manual.
+ */
+#define ID_ECP3_17	0xc2088080
+#define ID_ECP3_35	0xc2048080
+
+/* FPGA commands */
+#define FPGA_CMD_READ_ID	0x07	/* plus 24 bits */
+#define FPGA_CMD_READ_STATUS	0x09	/* plus 24 bits */
+#define FPGA_CMD_CLEAR		0x70
+#define FPGA_CMD_REFRESH	0x71
+#define FPGA_CMD_WRITE_EN	0x4a	/* plus 2 bits */
+#define FPGA_CMD_WRITE_DIS	0x4f	/* plus 8 bits */
+#define FPGA_CMD_WRITE_INC	0x41	/* plus 0 bits */
+
+/*
+ * The status register is 32bit revered, DONE is bit 17 from the TN1222.pdf
+ * (LatticeECP3 Slave SPI Port User's Guide)
+ */
+#define FPGA_STATUS_DONE	0x00004000
+#define FPGA_STATUS_CLEARED	0x00010000
+
+#define FPGA_CLEAR_TIMEOUT	5000	/* max. 5000ms for FPGA clear */
+#define FPGA_CLEAR_MSLEEP	10
+#define FPGA_CLEAR_LOOP_COUNT	(FPGA_CLEAR_TIMEOUT / FPGA_CLEAR_MSLEEP)
+
+struct ecp3_dev {
+	u32 jedec_id;
+	char *name;
+};
+
+static const struct ecp3_dev ecp3_dev[] = {
+	{
+		.jedec_id = ID_ECP3_17,
+		.name = "Lattice ECP3-17",
+	},
+	{
+		.jedec_id = ID_ECP3_35,
+		.name = "Lattice ECP3-35",
+	},
+};
+
+static struct completion fw_loaded;
+
+static void firmware_load(const struct firmware *fw, void *context)
+{
+	struct spi_device *spi = (struct spi_device *)context;
+	u8 *buffer;
+	int ret;
+	u8 txbuf[8];
+	u8 rxbuf[8];
+	int rx_len = 8;
+	int i;
+	u32 jedec_id;
+	u32 status;
+
+	if (fw->size == 0) {
+		dev_err(&spi->dev, "Error: Firmware size is 0!\n");
+		return;
+	}
+
+	/* Fill dummy data (24 stuffing bits for commands) */
+	txbuf[1] = 0x00;
+	txbuf[2] = 0x00;
+	txbuf[3] = 0x00;
+
+	/* Trying to speak with the FPGA via SPI... */
+	txbuf[0] = FPGA_CMD_READ_ID;
+	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	dev_dbg(&spi->dev, "FPGA JTAG ID=%08x\n", *(u32 *)&rxbuf[4]);
+	jedec_id = *(u32 *)&rxbuf[4];
+
+	for (i = 0; i < ARRAY_SIZE(ecp3_dev); i++) {
+		if (jedec_id == ecp3_dev[i].jedec_id)
+			break;
+	}
+	if (i == ARRAY_SIZE(ecp3_dev)) {
+		dev_err(&spi->dev,
+			"Error: No supported FPGA detected (JEDEC_ID=%08x)!\n",
+			jedec_id);
+		return;
+	}
+
+	dev_info(&spi->dev, "FPGA %s detected\n", ecp3_dev[i].name);
+
+	txbuf[0] = FPGA_CMD_READ_STATUS;
+	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	dev_dbg(&spi->dev, "FPGA Status=%08x\n", *(u32 *)&rxbuf[4]);
+
+	buffer = kzalloc(fw->size + 8, GFP_KERNEL);
+	if (!buffer) {
+		dev_err(&spi->dev, "Error: Can't allocate memory!\n");
+		return;
+	}
+
+	/*
+	 * Insert WRITE_INC command into stream (one SPI frame)
+	 */
+	buffer[0] = FPGA_CMD_WRITE_INC;
+	buffer[1] = 0xff;
+	buffer[2] = 0xff;
+	buffer[3] = 0xff;
+	memcpy(buffer + 4, fw->data, fw->size);
+
+	txbuf[0] = FPGA_CMD_REFRESH;
+	ret = spi_write(spi, txbuf, 4);
+
+	txbuf[0] = FPGA_CMD_WRITE_EN;
+	ret = spi_write(spi, txbuf, 4);
+
+	txbuf[0] = FPGA_CMD_CLEAR;
+	ret = spi_write(spi, txbuf, 4);
+
+	/*
+	 * Wait for FPGA memory to become cleared
+	 */
+	for (i = 0; i < FPGA_CLEAR_LOOP_COUNT; i++) {
+		txbuf[0] = FPGA_CMD_READ_STATUS;
+		ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+		status = *(u32 *)&rxbuf[4];
+		if (status == FPGA_STATUS_CLEARED)
+			break;
+
+		msleep(FPGA_CLEAR_MSLEEP);
+	}
+
+	if (i == FPGA_CLEAR_LOOP_COUNT) {
+		dev_err(&spi->dev,
+			"Error: Timeout waiting for FPGA to clear (status=%08x)!\n",
+			status);
+		kfree(buffer);
+		return;
+	}
+
+	dev_info(&spi->dev, "Configuring the FPGA...\n");
+	ret = spi_write(spi, buffer, fw->size + 8);
+
+	txbuf[0] = FPGA_CMD_WRITE_DIS;
+	ret = spi_write(spi, txbuf, 4);
+
+	txbuf[0] = FPGA_CMD_READ_STATUS;
+	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	dev_dbg(&spi->dev, "FPGA Status=%08x\n", *(u32 *)&rxbuf[4]);
+	status = *(u32 *)&rxbuf[4];
+
+	/* Check result */
+	if (status & FPGA_STATUS_DONE)
+		dev_info(&spi->dev, "FPGA succesfully configured!\n");
+	else
+		dev_info(&spi->dev, "FPGA not configured (DONE not set)\n");
+
+	/*
+	 * Don't forget to release the firmware again
+	 */
+	release_firmware(fw);
+
+	kfree(buffer);
+
+	complete(&fw_loaded);
+}
+
+static int __devinit lattice_ecp3_probe(struct spi_device *spi)
+{
+	int err;
+
+	init_completion(&fw_loaded);
+	err = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
+				      FIRMWARE_NAME, &spi->dev,
+				      GFP_KERNEL, spi, firmware_load);
+	if (err) {
+		dev_err(&spi->dev, "Firmware loading failed with %d!\n", err);
+		return err;
+	}
+
+	dev_info(&spi->dev, "FPGA bitstream configuration driver registered (ver %s)\n",
+		DRIVER_VER);
+
+	return 0;
+}
+
+static int __devexit lattice_ecp3_remove(struct spi_device *spi)
+{
+	wait_for_completion(&fw_loaded);
+
+	return 0;
+}
+
+static const struct spi_device_id lattice_ecp3_id[] __devinitdata = {
+	{ "ecp3-17", 0 },
+	{ "ecp3-35", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, lattice_ecp3_id);
+
+static struct spi_driver lattice_ecp3_driver = {
+	.driver = {
+		.name = "lattice-ecp3",
+		.owner = THIS_MODULE,
+	},
+	.probe = lattice_ecp3_probe,
+	.remove = __devexit_p(lattice_ecp3_remove),
+	.id_table = lattice_ecp3_id,
+};
+
+module_spi_driver(lattice_ecp3_driver);
+
+MODULE_AUTHOR("Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>");
+MODULE_DESCRIPTION("Lattice ECP3 FPGA configuration via SPI");
+MODULE_LICENSE("GPL");
-- 
1.8.0.1


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
INSIGHTS What's next for parallel hardware, programming and related areas?
Interviews and blogs by thought leaders keep you ahead of the curve.
http://goparallel.sourceforge.net
