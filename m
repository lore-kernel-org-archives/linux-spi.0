From: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: octeon: Split driver into Octeon specific and common parts
Date: Mon, 25 Jul 2016 19:49:56 +0200
Message-ID: <20160725174956.6746-1-jglauber@cavium.com>
References: <20160724205416.GA6345@sirena.org.uk>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>,
	Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160724205416.GA6345-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Separate driver probing from SPI transfer functions.

Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Makefile                       |   1 +
 drivers/spi/spi-cavium-octeon.c            | 102 ++++++++++++++++++++++++
 drivers/spi/{spi-octeon.c => spi-cavium.c} | 122 +----------------------------
 drivers/spi/spi-cavium.h                   |  31 ++++++++
 4 files changed, 136 insertions(+), 120 deletions(-)
 create mode 100644 drivers/spi/spi-cavium-octeon.c
 rename drivers/spi/{spi-octeon.c => spi-cavium.c} (54%)

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3c74d00..185367e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
+spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
 obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
new file mode 100644
index 0000000..97310c1
--- /dev/null
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -0,0 +1,102 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "spi-cavium.h"
+
+static int octeon_spi_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem;
+	void __iomem *reg_base;
+	struct spi_master *master;
+	struct octeon_spi *p;
+	int err = -ENOENT;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct octeon_spi));
+	if (!master)
+		return -ENOMEM;
+	p = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, master);
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(reg_base)) {
+		err = PTR_ERR(reg_base);
+		goto fail;
+	}
+
+	p->register_base = reg_base;
+	p->sys_freq = octeon_get_io_clock_rate();
+
+	p->regs.config = 0;
+	p->regs.status = 0x08;
+	p->regs.tx = 0x10;
+	p->regs.data = 0x80;
+
+	master->num_chipselect = 4;
+	master->mode_bits = SPI_CPHA |
+			    SPI_CPOL |
+			    SPI_CS_HIGH |
+			    SPI_LSB_FIRST |
+			    SPI_3WIRE;
+
+	master->transfer_one_message = octeon_spi_transfer_one_message;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
+
+	master->dev.of_node = pdev->dev.of_node;
+	err = devm_spi_register_master(&pdev->dev, master);
+	if (err) {
+		dev_err(&pdev->dev, "register master failed: %d\n", err);
+		goto fail;
+	}
+
+	return 0;
+fail:
+	spi_master_put(master);
+	return err;
+}
+
+static int octeon_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct octeon_spi *p = spi_master_get_devdata(master);
+
+	/* Clear the CSENA* and put everything in a known state. */
+	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	return 0;
+}
+
+static const struct of_device_id octeon_spi_match[] = {
+	{ .compatible = "cavium,octeon-3010-spi", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_spi_match);
+
+static struct platform_driver octeon_spi_driver = {
+	.driver = {
+		.name		= "spi-octeon",
+		.of_match_table = octeon_spi_match,
+	},
+	.probe		= octeon_spi_probe,
+	.remove		= octeon_spi_remove,
+};
+
+module_platform_driver(octeon_spi_driver);
+
+MODULE_DESCRIPTION("Cavium, Inc. OCTEON SPI bus driver");
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-cavium.c
similarity index 54%
rename from drivers/spi/spi-octeon.c
rename to drivers/spi/spi-cavium.c
index 2180176..8857e7d 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-cavium.c
@@ -6,42 +6,11 @@
  * Copyright (C) 2011, 2012 Cavium, Inc.
  */
 
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
 #include <linux/spi/spi.h>
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/of.h>
-
-#include <asm/octeon/octeon.h>
 
 #include "spi-cavium.h"
 
-#define OCTEON_SPI_MAX_BYTES 9
-
-#define OCTEON_SPI_MAX_CLOCK_HZ 16000000
-
-struct octeon_spi_regs {
-	int config;
-	int status;
-	int tx;
-	int data;
-};
-
-struct octeon_spi {
-	void __iomem *register_base;
-	u64 last_cfg;
-	u64 cs_enax;
-	int sys_freq;
-	struct octeon_spi_regs regs;
-};
-
-#define OCTEON_SPI_CFG(x)	(x->regs.config)
-#define OCTEON_SPI_STS(x)	(x->regs.status)
-#define OCTEON_SPI_TX(x)	(x->regs.tx)
-#define OCTEON_SPI_DAT0(x)	(x->regs.data)
-
 static void octeon_spi_wait_ready(struct octeon_spi *p)
 {
 	union cvmx_mpi_sts mpi_sts;
@@ -154,8 +123,8 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	return xfer->len;
 }
 
-static int octeon_spi_transfer_one_message(struct spi_master *master,
-					   struct spi_message *msg)
+int octeon_spi_transfer_one_message(struct spi_master *master,
+				    struct spi_message *msg)
 {
 	struct octeon_spi *p = spi_master_get_devdata(master);
 	unsigned int total_len = 0;
@@ -178,90 +147,3 @@ err:
 	spi_finalize_current_message(master);
 	return status;
 }
-
-static int octeon_spi_probe(struct platform_device *pdev)
-{
-	struct resource *res_mem;
-	void __iomem *reg_base;
-	struct spi_master *master;
-	struct octeon_spi *p;
-	int err = -ENOENT;
-
-	master = spi_alloc_master(&pdev->dev, sizeof(struct octeon_spi));
-	if (!master)
-		return -ENOMEM;
-	p = spi_master_get_devdata(master);
-	platform_set_drvdata(pdev, master);
-
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
-	if (IS_ERR(reg_base)) {
-		err = PTR_ERR(reg_base);
-		goto fail;
-	}
-
-	p->register_base = reg_base;
-	p->sys_freq = octeon_get_io_clock_rate();
-
-	p->regs.config = 0;
-	p->regs.status = 0x08;
-	p->regs.tx = 0x10;
-	p->regs.data = 0x80;
-
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPHA |
-			    SPI_CPOL |
-			    SPI_CS_HIGH |
-			    SPI_LSB_FIRST |
-			    SPI_3WIRE;
-
-	master->transfer_one_message = octeon_spi_transfer_one_message;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
-
-	master->dev.of_node = pdev->dev.of_node;
-	err = devm_spi_register_master(&pdev->dev, master);
-	if (err) {
-		dev_err(&pdev->dev, "register master failed: %d\n", err);
-		goto fail;
-	}
-
-	dev_info(&pdev->dev, "OCTEON SPI bus driver\n");
-
-	return 0;
-fail:
-	spi_master_put(master);
-	return err;
-}
-
-static int octeon_spi_remove(struct platform_device *pdev)
-{
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct octeon_spi *p = spi_master_get_devdata(master);
-
-	/* Clear the CSENA* and put everything in a known state. */
-	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-
-	return 0;
-}
-
-static const struct of_device_id octeon_spi_match[] = {
-	{ .compatible = "cavium,octeon-3010-spi", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, octeon_spi_match);
-
-static struct platform_driver octeon_spi_driver = {
-	.driver = {
-		.name		= "spi-octeon",
-		.of_match_table = octeon_spi_match,
-	},
-	.probe		= octeon_spi_probe,
-	.remove		= octeon_spi_remove,
-};
-
-module_platform_driver(octeon_spi_driver);
-
-MODULE_DESCRIPTION("Cavium, Inc. OCTEON SPI bus driver");
-MODULE_AUTHOR("David Daney");
-MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-cavium.h b/drivers/spi/spi-cavium.h
index d41dba5..88c5f36 100644
--- a/drivers/spi/spi-cavium.h
+++ b/drivers/spi/spi-cavium.h
@@ -1,3 +1,32 @@
+#ifndef __SPI_CAVIUM_H
+#define __SPI_CAVIUM_H
+
+#define OCTEON_SPI_MAX_BYTES 9
+#define OCTEON_SPI_MAX_CLOCK_HZ 16000000
+
+struct octeon_spi_regs {
+	int config;
+	int status;
+	int tx;
+	int data;
+};
+
+struct octeon_spi {
+	void __iomem *register_base;
+	u64 last_cfg;
+	u64 cs_enax;
+	int sys_freq;
+	struct octeon_spi_regs regs;
+};
+
+#define OCTEON_SPI_CFG(x)	(x->regs.config)
+#define OCTEON_SPI_STS(x)	(x->regs.status)
+#define OCTEON_SPI_TX(x)	(x->regs.tx)
+#define OCTEON_SPI_DAT0(x)	(x->regs.data)
+
+int octeon_spi_transfer_one_message(struct spi_master *master,
+				    struct spi_message *msg);
+
 /* MPI register descriptions */
 
 #define CVMX_MPI_CFG (CVMX_ADD_IO_SEG(0x0001070000001000ull))
@@ -296,3 +325,5 @@ union cvmx_mpi_tx {
 	struct cvmx_mpi_tx_s cn66xx;
 	struct cvmx_mpi_tx_cn61xx cnf71xx;
 };
+
+#endif /* __SPI_CAVIUM_H */
-- 
2.9.0.rc0.21.g7777322

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
