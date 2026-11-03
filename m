Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689726;
	b=kCDBLvfG18TrG683wSvSU2ZiaDsT8mSr2dz9B5YYkBxf9BS/Wwdtxd6MHNlxT3J0Irqg
	 saeM9yA0bT5SQHM/LGe+QNvr44s4PdKdRc1vEHV3nlbcQDqqAdlQ9pTEWlt8ivIHvuip9
	 7+Q3ngqQLopkKnpMz+WcaNvecMTGrmaEDz+bN8/qyYSJc9pSR8vJPH3bJ2TqzpJkaazh+
	 mi78wwyH6yYCxkUDT6pa0G+iYr2Q3j2Mhy9vM3BQNu1CmgIs9lnbSTphfc6iIOJ3cTXtg
	 1Hr/TCZ9ZWmg8n2w1EwkqzBatlMJNk4qColN8hrJ9rpgKz4Q5vqmdTlEYVY+SDr9D/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689726;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=aPDawzzUJ3BMu2Y0nfrQKxuDR6FzacUrMvCo2u/+SFU=;
	b=ml1tmWAQSp3hhTGBNrbx+Pc0wLjWySM7517LuFVqyD+G41YXDzfZKD5sUMZm7sKmoNHO
	 txgPOIQNyxQGxxLphvC8xA8tP68B1xcFvYK1Ueuks+jTCgsVLmokIc8eorwSle1dCqrrq
	 M4Dol6ep3br7disRfgrgcHiOalOHcKEhOLE9l3L2mc6zTESlRP5eJG2lzwuy6LJ12Pjbt
	 /myHrcX1VRWgVfr9jipbDBIebPWdLsrirR0cmzo5HPowcWhgxpm5JwhTUmYqXqkQxVRrI
	 mAaN1CAP1GtY5zW7U6kubeCcT+YEwM91YQvtrkruWzmaHK3PgPErU/ToRsyCdklyv7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0B606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E0B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxKvB6iOlqz9wbAA--.14830S3;
	Tue, 03 Nov 2026 15:08:42 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxtMx5iOlq7BQyAA--.11183S2;
	Tue, 03 Nov 2026 15:08:42 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-spi@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 8/8] spi: loongson: Add interrupt support for SPI controller
Date: Tue,  3 Nov 2026 15:08:35 +0800
Message-ID: <7258e7e16b8a563e60b7129946c292f70aeee1d5.1793689461.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793689461.git.zhoubinbin@loongson.cn>
References: <cover.1793689461.git.zhoubinbin@loongson.cn>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMx5iOlq7BQyAA--.11183S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGrpQPoEmAAAst
X-Coremail-Antispam: 1Uk129KBj93XoW3KFWrAryftrykGrWUCrWDJrc_yoWkXw15pF
	W5Zay5Kr4SyF4F9rn8KrWDGF1Yy34fGasrGa9rtw42grnFvw15XFy5KFyfAFWrAFWDXFW3
	uFWkCF48Ca1DZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsdb1UUUUU

The Loongson SPI controller can generate an interrupt on byte
completion.  Add an interrupt-driven transfer path and use it when an
IRQ is available, while keeping the existing polling path as a fallback.

The PCI and platform glue drivers now pass the IRQ number to
loongson_spi_init_controller().  If no IRQ is available, the driver
keeps using polling and emits an informational message.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 169 ++++++++++++++++++++++++++++++--
 drivers/spi/spi-loongson-pci.c  |   8 +-
 drivers/spi/spi-loongson-plat.c |   8 +-
 drivers/spi/spi-loongson.h      |   2 +-
 4 files changed, 175 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 5ad781471cef..2e56b3399657 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -2,6 +2,13 @@
 //
 // Loongson SPI Controller driver
 //
+// - Host-only controller with up to 4 chip selects.
+// - Double-buffered Tx/Rx FIFO, 8-bit wide.
+// - Supports booting the SoC from SPI flash.
+// - Both a polling mode and a per-byte interrupt mode are supported;
+//   the driver automatically falls back to polling if no IRQ is
+//   available.
+//
 // Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
 #include <linux/bitfield.h>
@@ -10,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -66,12 +74,20 @@
 
 #define LOONGSON_SPI_NUM_CS		4
 
+/* Maximum bytes per individual spi_transfer (further reduced for slow links) */
+#define LOONGSON_SPI_MAX_XFER_SIZE	(64 * 1024)
+
 struct loongson_spi_priv {
 	struct spi_controller	*controller;
 	struct regmap		*regmap;
 	unsigned int		hz;
 	unsigned int		mode;
 	u64			clk_rate;
+	bool			use_irq;
+	const unsigned char	*tx_ptr;
+	unsigned char		*rx_ptr;
+	unsigned int		count;
+	unsigned int		total;
 };
 
 static const struct {
@@ -252,9 +268,119 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 	return ret;
 }
 
+static irqreturn_t loongson_spi_irq(int irq, void *dev_id)
+{
+	struct loongson_spi_priv *priv = dev_id;
+	unsigned int status, data = 0;
+	int ret;
+
+	ret = regmap_read(priv->regmap, LOONGSON_SPI_SPSR_REG, &status);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(status & (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL)))
+		return IRQ_NONE;
+
+	/* Clear WCOL if it happens to be set */
+	if (status & LOONGSON_SPI_SPSR_WCOL)
+		regmap_write(priv->regmap, LOONGSON_SPI_SPSR_REG,
+			     LOONGSON_SPI_SPSR_WCOL);
+
+	if (!(status & LOONGSON_SPI_SPSR_SPIF))
+		return IRQ_HANDLED;
+
+	/* Clear the SPIF flag (write 1 to clear) */
+	regmap_write(priv->regmap, LOONGSON_SPI_SPSR_REG,
+		     LOONGSON_SPI_SPSR_SPIF);
+
+	/* Read out the byte that was clocked in */
+	regmap_read(priv->regmap, LOONGSON_SPI_FIFO_REG, &data);
+	if (priv->rx_ptr)
+		priv->rx_ptr[priv->count] = (u8)data;
+
+	priv->count++;
+
+	if (priv->count >= priv->total) {
+		/* Transfer complete: disable the byte interrupt and finalize */
+		regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+				   LOONGSON_SPI_SPCR_SPIE, 0);
+		spi_finalize_current_transfer(priv->controller);
+		return IRQ_HANDLED;
+	}
+
+	/* Kick off the next byte */
+	if (priv->tx_ptr)
+		data = priv->tx_ptr[priv->count];
+	else
+		data = 0;
+
+	regmap_write(priv->regmap, LOONGSON_SPI_FIFO_REG, data);
+
+	return IRQ_HANDLED;
+}
+
+static int loongson_spi_transfer_one_irq(struct spi_controller *host,
+					 struct spi_device *spi,
+					 struct spi_transfer *xfer)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
+	unsigned int data = 0;
+
+	priv->tx_ptr = xfer->tx_buf;
+	priv->rx_ptr = xfer->rx_buf;
+	priv->count = 0;
+	priv->total = xfer->len;
+
+	/* Clear any stale status before enabling the interrupt */
+	regmap_write(priv->regmap, LOONGSON_SPI_SPSR_REG,
+		     LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
+
+	/* Enable the byte-completion interrupt */
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+			   LOONGSON_SPI_SPCR_SPIE, LOONGSON_SPI_SPCR_SPIE);
+
+	/* Send the first byte to start the transfer */
+	if (priv->tx_ptr)
+		data = priv->tx_ptr[0];
+	regmap_write(priv->regmap, LOONGSON_SPI_FIFO_REG, data);
+
+	/*
+	 * Return 1 so the SPI core knows the transfer will be
+	 * finalized asynchronously from the IRQ handler.
+	 */
+	return 1;
+}
+
+/*
+ * Hardware limit on a single spi_transfer. Called by the SPI core via
+ * spi_max_transfer_size() to determine the effective upper bound.
+ */
+static size_t loongson_spi_max_transfer_size(struct spi_device *spi)
+{
+	return LOONGSON_SPI_MAX_XFER_SIZE;
+}
+
 static int loongson_spi_prepare_message(struct spi_controller *host, struct spi_message *m)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
+	size_t hw_max = spi_max_transfer_size(m->spi);
+	unsigned int speed_hz;
+	size_t maxsize;
+	int ret;
+
+	/*
+	 * Split large transfers so that each individual spi_transfer
+	 * completes well within the SPI core's completion timeout.
+	 * We allow roughly one second of data per chunk, capped by
+	 * the controller's hardware maximum transfer size.
+	 */
+	speed_hz = m->spi->max_speed_hz ? m->spi->max_speed_hz : host->max_speed_hz;
+	maxsize = min_t(size_t, hw_max, (size_t)speed_hz / 8);
+	maxsize = max_t(size_t, maxsize, 64);
+
+	ret = spi_split_transfers_maxsize(host, m, maxsize);
+	if (ret)
+		return ret;
 
 	regmap_update_bits(priv->regmap, LOONGSON_SPI_PARA_REG, LOONGSON_SPI_PARA_MEM_EN, 0);
 
@@ -271,10 +397,13 @@ static int loongson_spi_transfer_one(struct spi_controller *host, struct spi_dev
 	if (ret)
 		return ret;
 
-	if (xfer->len)
-		return loongson_spi_write_read(spi, xfer);
+	if (!xfer->len)
+		return 0;
 
-	return 0;
+	if (priv->use_irq)
+		return loongson_spi_transfer_one_irq(host, spi, xfer);
+
+	return loongson_spi_write_read(spi, xfer);
 }
 
 static int loongson_spi_unprepare_message(struct spi_controller *host, struct spi_message *m)
@@ -290,14 +419,15 @@ static int loongson_spi_unprepare_message(struct spi_controller *host, struct sp
 
 static void loongson_spi_reginit(struct loongson_spi_priv *priv)
 {
-	/* Disable SPI */
-	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE, 0);
+	/* Disable SPI and its interrupt */
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+			   LOONGSON_SPI_SPCR_SPE | LOONGSON_SPI_SPCR_SPIE, 0);
 
 	/* Clear status flags (write 1 to clear) */
 	regmap_write(priv->regmap, LOONGSON_SPI_SPSR_REG,
 		     LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
 
-	/* Enable SPI */
+	/* Enable SPI (interrupt remains disabled until a transfer starts) */
 	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
 			   LOONGSON_SPI_SPCR_SPE, LOONGSON_SPI_SPCR_SPE);
 }
@@ -323,7 +453,26 @@ static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
 	return 0;
 }
 
-int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
+static void loongson_spi_irqinit(struct loongson_spi_priv *priv, struct device *dev, int irq)
+{
+	int ret;
+
+	if (irq <= 0) {
+		priv->use_irq = false;
+		return;
+	}
+
+	ret = devm_request_irq(dev, irq, loongson_spi_irq, 0, "loongson-spi", priv);
+	if (ret) {
+		priv->use_irq = false;
+		dev_warn(dev, "failed to request IRQ %d with %d, using polling", irq, ret);
+		return;
+	}
+
+	priv->use_irq = true;
+}
+
+int loongson_spi_init_controller(struct device *dev, void __iomem *regs, int irq)
 {
 	struct loongson_spi_priv *priv;
 	struct spi_controller *host;
@@ -338,6 +487,7 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	host->prepare_message = loongson_spi_prepare_message;
 	host->transfer_one = loongson_spi_transfer_one;
 	host->unprepare_message = loongson_spi_unprepare_message;
+	host->max_transfer_size = loongson_spi_max_transfer_size;
 	host->set_cs = loongson_spi_set_cs;
 	host->num_chipselect = LOONGSON_SPI_NUM_CS;
 	dev_set_drvdata(dev, host);
@@ -353,9 +503,14 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to get clock rate");
 
+	/* Expose controller capabilities to the SPI core */
+	host->max_speed_hz = priv->clk_rate / LOONGSON_SPI_DIV_MIN;
+
 	loongson_spi_reginit(priv);
 	priv->mode = 0;
 
+	loongson_spi_irqinit(priv, dev, irq);
+
 	return devm_spi_register_controller(dev, host);
 }
 EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index ad90be956e1e..582f8aa10470 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -11,8 +11,8 @@
 static int loongson_spi_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
+	int pci_bar = 0, ret, irq;
 	void __iomem *reg_base;
-	int pci_bar = 0, ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret < 0)
@@ -23,7 +23,11 @@ static int loongson_spi_pci_register(struct pci_dev *pdev, const struct pci_devi
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request and remap memory");
 
-	ret = loongson_spi_init_controller(dev, reg_base);
+	irq = pci_irq_vector(pdev, 0);
+	if (irq < 0)
+		dev_info(dev, "no IRQ available, will use PIO mode");
+
+	ret = loongson_spi_init_controller(dev, reg_base, irq);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize controller");
 
diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
index dcfbdd50e996..d4d37748c3c2 100644
--- a/drivers/spi/spi-loongson-plat.c
+++ b/drivers/spi/spi-loongson-plat.c
@@ -13,13 +13,17 @@ static int loongson_spi_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *reg_base;
-	int ret;
+	int ret, irq;
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-	ret = loongson_spi_init_controller(dev, reg_base);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		dev_info(dev, "no IRQ specified, will use PIO mode");
+
+	ret = loongson_spi_init_controller(dev, reg_base, irq);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize controller");
 
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index c8b722bc5fb5..b60619b02ec3 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -7,7 +7,7 @@
 #ifndef __LINUX_SPI_LOONGSON_H
 #define __LINUX_SPI_LOONGSON_H
 
-int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
+int loongson_spi_init_controller(struct device *dev, void __iomem *reg, int irq);
 extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
 
 #endif /* __LINUX_SPI_LOONGSON_H */
-- 
2.52.0

