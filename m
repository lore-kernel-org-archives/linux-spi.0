From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 8/8] spi: nsp-qspi: Add Broadcom NSP, NS2, Cygnus SoC support
Date: Fri, 29 Jul 2016 18:13:13 -0400
Message-ID: <1469830393-13295-9-git-send-email-kdasu.kdev@gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469830393-13295-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This spi driver uses the common spi-bcm-qspi driver
and implements NS*, Cysgnus  SoC specific intrrupt handlers.
The common driver now calls the SoC handlers when present.
Adding support for both muxed l1 and unmuxed interrupt sources.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Makefile       |   2 +-
 drivers/spi/spi-bcm-qspi.c |  89 ++++++++++++++++++++++++-
 drivers/spi/spi-bcm-qspi.h |  33 +++++++++-
 drivers/spi/spi-nsp-qspi.c | 158 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-nsp-qspi.c

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3e753db..5e46538 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_SPI_BCM2835AUX)		+= spi-bcm2835aux.o
 obj-$(CONFIG_SPI_BCM53XX)		+= spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
-obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-brcmstb-qspi.o spi-bcm-qspi.o
+obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-nsp-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
 obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0c1a617..45b2636 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -184,9 +184,15 @@ enum base_type {
 	BASEMAX,
 };
 
+enum irq_source {
+	SINGLE_L2,
+	MUXED_L1,
+};
+
 struct bcm_qspi_irq {
 	const char *irq_name;
 	const irq_handler_t irq_handler;
+	int irq_source;
 	u32 mask;
 };
 
@@ -207,6 +213,10 @@ struct bcm_qspi {
 	u32 base_clk;
 	u32 max_speed_hz;
 	void __iomem *base[BASEMAX];
+
+	/* Some SoCs provide custom interrupt status register(s) */
+	struct bcm_qspi_soc	*soc;
+
 	struct bcm_qspi_parms last_parms;
 	struct qspi_trans  trans_pos;
 	int state;
@@ -840,6 +850,7 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 	int ret = 0;
 	int retry = 3;
 	unsigned long timeo = msecs_to_jiffies(100);
+	struct bcm_qspi_soc *soc = qspi->soc;
 
 	if (bcm_qspi_bspi_ver_three(qspi))
 		if (msg->addr_width == BSPI_ADDRLEN_4BYTES)
@@ -883,6 +894,15 @@ retry:
 	bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
 	bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
 
+	if (qspi->soc) {
+		/*
+		 * clear soc MSPI and BSPI interrupts and enable
+		 * BSPI interrupts.
+		 */
+		soc->bcm_qspi_int_ack(soc, MSPI_BSPI_DONE);
+		soc->bcm_qspi_int_set(soc, BSPI_DONE, true);
+	}
+
 	bcm_qspi_bspi_lr_start(qspi);
 	/* Must flush previous writes before starting BSPI operation */
 	mb();
@@ -999,9 +1019,12 @@ static irqreturn_t bcm_qspi_mspi_l2_isr(int irq, void *dev_id)
 	u32 status = bcm_qspi_read(qspi, MSPI, MSPI_MSPI_STATUS);
 
 	if (status & MSPI_MSPI_STATUS_SPIF) {
+		struct bcm_qspi_soc *soc = qspi->soc;
 		/* clear interrupt */
 		status &= ~MSPI_MSPI_STATUS_SPIF;
 		bcm_qspi_write(qspi, MSPI, MSPI_MSPI_STATUS, status);
+		if (qspi->soc)
+			soc->bcm_qspi_int_ack(soc, MSPI_DONE);
 		complete(&qspi->mspi_done);
 		return IRQ_HANDLED;
 	} else {
@@ -1013,11 +1036,16 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
 {
 	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
 	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	struct bcm_qspi_soc *soc = qspi->soc;
 
 	if (qspi->bspi_enabled && qspi->bspi_rf_msg) {
 		bcm_qspi_bspi_lr_data_read(qspi);
 		if (qspi->bspi_rf_msg_len == 0) {
 			qspi->bspi_rf_msg = NULL;
+			if (qspi->soc)
+				/* disable soc BSPI interrupt */
+				soc->bcm_qspi_int_set(soc, BSPI_DONE, false);
+
 			if (qspi->bspi_rf_msg_status)
 				bcm_qspi_bspi_lr_clear(qspi);
 			else
@@ -1025,6 +1053,11 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq, void *dev_id)
 
 			complete(&qspi->bspi_done);
 		}
+
+		if (qspi->soc)
+			/* clear soc BSPI interrupt */
+			soc->bcm_qspi_int_ack(soc, BSPI_DONE);
+
 		return IRQ_HANDLED;
 	}
 
@@ -1035,14 +1068,40 @@ static irqreturn_t bcm_qspi_bspi_lr_err_l2_isr(int irq, void *dev_id)
 {
 	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
 	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	struct bcm_qspi_soc *soc = qspi->soc;
 
 	dev_dbg(&qspi->pdev->dev, "BSPI INT error status %x\n",
 		qspi_dev_id->irqp->mask);
 	qspi->bspi_rf_msg_status = -EIO;
+	if (qspi->soc)
+		/* clear soc interrupt */
+		soc->bcm_qspi_int_ack(soc, BSPI_ERR);
+
 	complete(&qspi->bspi_done);
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t bcm_qspi_l1_isr(int irq, void *dev_id)
+{
+	struct bcm_qspi_dev_id *qspi_dev_id = dev_id;
+	struct bcm_qspi *qspi = qspi_dev_id->dev;
+	struct bcm_qspi_soc *soc = qspi->soc;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (soc) {
+		u32 status = soc->bcm_qspi_get_int_status(soc);
+
+		if (status & MSPI_DONE)
+			ret = bcm_qspi_mspi_l2_isr(irq, dev_id);
+		else if (status & BSPI_DONE)
+			ret = bcm_qspi_bspi_lr_l2_isr(irq, dev_id);
+		else if (status & BSPI_ERR)
+			ret = bcm_qspi_bspi_lr_err_l2_isr(irq, dev_id);
+	}
+
+	return ret;
+}
+
 static const struct bcm_qspi_irq qspi_irq_tab[] = {
 	{
 		.irq_name = "spi_lr_fullness_reached",
@@ -1082,6 +1141,13 @@ static const struct bcm_qspi_irq qspi_irq_tab[] = {
 		.irq_handler = bcm_qspi_mspi_l2_isr,
 		.mask = INTR_MSPI_HALTED_MASK,
 	},
+	{
+		/* single muxed L1 interrupt source */
+		.irq_name = "spi_l1_intr",
+		.irq_handler = bcm_qspi_l1_isr,
+		.irq_source = MUXED_L1,
+		.mask = QSPI_INTERRUPTS_ALL,
+	},
 };
 
 static void bcm_qspi_bspi_init(struct bcm_qspi *qspi)
@@ -1231,7 +1297,17 @@ int bcm_qspi_probe(struct platform_device *pdev, struct bcm_qspi_soc *soc)
 	for (val = 0; val < num_irqs; val++) {
 		irq = -1;
 		name = qspi_irq_tab[val].irq_name;
-		irq = platform_get_irq_byname(pdev, name);
+		if (soc && qspi_irq_tab[val].irq_source == MUXED_L1) {
+			/* all mspi, bspi intrs muxed to one L1 intr */
+			irq = platform_get_irq(pdev, 0);
+			of_property_read_string(dev->of_node,
+						"interrupt-names",
+						&name);
+		}
+
+		if (qspi_irq_tab[val].irq_source == SINGLE_L2)
+			/* get the l2 interrupts */
+			irq = platform_get_irq_byname(pdev, name);
 
 		if (irq  >= 0) {
 			ret = devm_request_irq(&pdev->dev, irq,
@@ -1257,6 +1333,17 @@ int bcm_qspi_probe(struct platform_device *pdev, struct bcm_qspi_soc *soc)
 		goto err2;
 	}
 
+	/*
+	 * Some SoCs integrate spi controller (e.g., its interrupt bits)
+	 * in specific ways
+	 */
+	if (soc) {
+		qspi->soc = soc;
+		soc->bcm_qspi_int_set(soc, MSPI_DONE, true);
+	} else {
+		qspi->soc = NULL;
+	}
+
 	qspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk)) {
 		dev_warn(dev, "unable to get clock\n");
diff --git a/drivers/spi/spi-bcm-qspi.h b/drivers/spi/spi-bcm-qspi.h
index e0a354a..407059c 100644
--- a/drivers/spi/spi-bcm-qspi.h
+++ b/drivers/spi/spi-bcm-qspi.h
@@ -48,10 +48,25 @@
 	(INTR_MSPI_DONE_MASK |		       \
 	 INTR_MSPI_HALTED_MASK)
 
+#define QSPI_INTERRUPTS_ALL                    \
+	(MSPI_INTERRUPTS_ALL |		       \
+	 BSPI_LR_INTERRUPTS_ALL)
+
 struct platform_device;
 struct dev_pm_ops;
 
-struct bcm_qspi_soc;
+enum {
+	MSPI_DONE = 0x1,
+	BSPI_DONE = 0x2,
+	BSPI_ERR = 0x4,
+	MSPI_BSPI_DONE = 0x7
+};
+
+struct bcm_qspi_soc {
+	void (*bcm_qspi_int_ack)(struct bcm_qspi_soc *soc, int type);
+	void (*bcm_qspi_int_set)(struct bcm_qspi_soc *soc, int type, bool en);
+	u32 (*bcm_qspi_get_int_status)(struct bcm_qspi_soc *soc);
+};
 
 /* Read controller register*/
 static inline u32 bcm_qspi_readl(struct platform_device *pdev,
@@ -73,6 +88,22 @@ static inline void bcm_qspi_writel(struct platform_device *pdev,
 		writel_relaxed(data, addr);
 }
 
+static inline u32 get_qspi_mask(int type)
+{
+	switch (type) {
+	case MSPI_DONE:
+		return INTR_MSPI_DONE_MASK;
+	case BSPI_DONE:
+		return BSPI_LR_INTERRUPTS_ALL;
+	case MSPI_BSPI_DONE:
+		return QSPI_INTERRUPTS_ALL;
+	case BSPI_ERR:
+		return BSPI_LR_INTERRUPTS_ERROR;
+	}
+
+	return 0;
+}
+
 int bcm_qspi_probe(struct platform_device *pdev, struct bcm_qspi_soc *soc);
 int bcm_qspi_remove(struct platform_device *pdev);
 
diff --git a/drivers/spi/spi-nsp-qspi.c b/drivers/spi/spi-nsp-qspi.c
new file mode 100644
index 0000000..2a4e052
--- /dev/null
+++ b/drivers/spi/spi-nsp-qspi.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2016 Broadcom Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "spi-bcm-qspi.h"
+
+#define INTR_BASE_BIT_SHIFT			0x02
+#define INTR_COUNT				0x07
+
+struct bcm_nsp_soc {
+	struct bcm_qspi_soc soc;
+	struct platform_device *pdev;
+	void __iomem *int_reg;
+	void __iomem *int_status_reg;
+	spinlock_t soclock;
+};
+
+static u32 bcm_nsp_qspi_get_l2_int_status(struct bcm_qspi_soc *soc)
+{
+	struct bcm_nsp_soc *priv =
+			container_of(soc, struct bcm_nsp_soc, soc);
+	void __iomem *mmio = priv->int_status_reg;
+	int i;
+	u32 val = 0, sts = 0;
+
+	for (i = 0; i < INTR_COUNT; i++) {
+		if (bcm_qspi_readl(priv->pdev, mmio + (i * 4)))
+			val |= 1UL << i;
+	}
+
+	if (val & INTR_MSPI_DONE_MASK)
+		sts |= MSPI_DONE;
+
+	if (val & BSPI_LR_INTERRUPTS_ALL)
+		sts |= BSPI_DONE;
+
+	if (val & BSPI_LR_INTERRUPTS_ERROR)
+		sts |= BSPI_ERR;
+
+	return sts;
+}
+
+static void bcm_nsp_qspi_int_ack(struct bcm_qspi_soc *soc, int type)
+{
+	struct bcm_nsp_soc *priv =
+			container_of(soc, struct bcm_nsp_soc, soc);
+	void __iomem *mmio = priv->int_status_reg;
+	u32 mask = get_qspi_mask(type);
+	int i;
+
+	for (i = 0; i < INTR_COUNT; i++) {
+		if (mask & (1UL << i))
+			bcm_qspi_writel(priv->pdev, 1, mmio + (i * 4));
+	}
+}
+
+static void bcm_nsp_qspi_int_set(struct bcm_qspi_soc *soc, int type, bool en)
+{
+	struct bcm_nsp_soc *priv =
+			container_of(soc, struct bcm_nsp_soc, soc);
+	void __iomem *mmio = priv->int_reg;
+	u32 mask = get_qspi_mask(type);
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->soclock, flags);
+
+	val = bcm_qspi_readl(priv->pdev, mmio);
+
+	if (en)
+		val = val | (mask << INTR_BASE_BIT_SHIFT);
+	else
+		val = val & ~(mask << INTR_BASE_BIT_SHIFT);
+
+	bcm_qspi_writel(priv->pdev, val, mmio);
+
+	spin_unlock_irqrestore(&priv->soclock, flags);
+}
+
+static int bcm_nsp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm_nsp_soc *priv;
+	struct bcm_qspi_soc *soc;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	soc = &priv->soc;
+	priv->pdev = pdev;
+
+	spin_lock_init(&priv->soclock);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr_regs");
+	priv->int_reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->int_reg))
+		return PTR_ERR(priv->int_reg);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "intr_status_reg");
+	priv->int_status_reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->int_status_reg))
+		return PTR_ERR(priv->int_status_reg);
+
+	bcm_nsp_qspi_int_ack(soc, MSPI_BSPI_DONE);
+	bcm_nsp_qspi_int_set(soc, MSPI_BSPI_DONE, false);
+
+	soc->bcm_qspi_int_ack = bcm_nsp_qspi_int_ack;
+	soc->bcm_qspi_int_set = bcm_nsp_qspi_int_set;
+	soc->bcm_qspi_get_int_status = bcm_nsp_qspi_get_l2_int_status;
+
+	return bcm_qspi_probe(pdev, soc);
+}
+
+static int bcm_nsp_remove(struct platform_device *pdev)
+{
+	return bcm_qspi_remove(pdev);
+}
+
+static const struct of_device_id bcm_nsp_of_match[] = {
+	{ .compatible = "brcm,spi-nsp-qspi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm_nsp_of_match);
+
+static struct platform_driver bcm_nsp_driver = {
+	.probe			= bcm_nsp_probe,
+	.remove			= bcm_nsp_remove,
+	.driver = {
+		.name		= "bcm_nsp",
+		.pm		= &bcm_qspi_pm_ops,
+		.of_match_table = bcm_nsp_of_match,
+	}
+};
+module_platform_driver(bcm_nsp_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Kamal Dasu");
+MODULE_DESCRIPTION("SPI flash driver for Broadcom NSP, NS2, Cygnus SoCs");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
