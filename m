Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548576;
	b=yWeqxSCfy/8Kqf+7C0MTxNUTI16qf6nngg7TdTEIMtX7yepE/Iz5uKbGYkeqZSaifE8c
	 yckWky42qwhm3t3g6/2pKnkNXmyWVrHlRKIgdUqpB7fqVcHYRyZQN/sVTrHKg837gaNAV
	 Q6DHTMrUSWc8qH51F0nTTR8XoZ8FTJ4gu6ZFZfXpmcC7wQG8fz4CtGT0i0HAFXzMoLGJ8
	 VhHX76Y0AUdw6ggkKaaTrp/Xq11U4hzLqlVV049HTOhXBNa9XkksFHoDWjs10Uodawmwg
	 qMKuH4QZiF+jEBpKwdjpgXXpob6mzbEZaCppv+hYgsmdj7FpBz+YZKy0FzZAl/HIxgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548576;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Y2c4gWC7HilQCJ9Zmz99cY/PoxHeM2QFnZyYqSm31ZY=;
	b=gzd5LuKJNtMpRHVO68uZcTxa0siV+BTPhL+WC/QDFoLV1gDsnxIgRd27NU43zoWPbcbG
	 kfNA8gNijktWSKikeNIn199NxheUsLm5MELEpUkQkdQAtr6uudr/2WBDHv+vYHySJTivr
	 IEOD+BMkuobO5pHOYqg46UaxubKKQx+S4iEPW4JNS1fgYJUFJR73mS7l7CQEYPaS6WxZy
	 Ed/SZvvjahUTjeJPwApYky+G6nQB8alS3r/YA522tQhqxc8ZNH+ENi1QaxD81X+sC5vqQ
	 p6/6FMLNPpQL1c3/BlDY+hPAiv/qAL08lRXKbZmWyMjyEoz9WD5cx+lDW+OTd/qFutQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6F606A32A
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC6F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxdvBeo_Zq4R4fAA--.23783S3;
	Fri, 13 Nov 2026 13:42:54 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxFs1ao_ZqMSg0AA--.48458S5;
	Fri, 13 Nov 2026 13:42:53 +0800 (CST)
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
Subject: [PATCH v2 7/7] spi: loongson: Add interrupt mode support
Date: Fri, 13 Nov 2026 13:42:43 +0800
Message-ID: <09d0183cecce30fde0165af5fe3d4b3a362cfc1e.1794538736.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794538736.git.zhoubinbin@loongson.cn>
References: <cover.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs1ao_ZqMSg0AA--.48458S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGr2b-sDTwAAsG
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZFW8GrykWF1DJr48KF1rAFc_yoW8XFy8Wo
	WxZ3Z3Z3y8ur1xWFyjqr1Fqr47X3W5ur4qyrsay3WkJw4YvryDJry5Xr47uF18u3W3JFy7
	AFyfGFW8GF4IgrWDl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0HUDJUUUUU==

Add an interrupt-driven transfer path alongside polling. The IRQ
handler drains the RX FIFO, refills TX up to icnt+1 bytes and
finalizes the transfer when complete; if no IRQ is available the
driver falls back to polling.

Because a tail shorter than the interrupt period does not raise SPIF,
the period is chosen to divide the transfer length, so the last batch
always completes. Messages are also split into bounded chunks to keep
each transfer within the SPI core timeout, given the low per-byte
throughput of this controller.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 241 ++++++++++++++++++++++++++++++--
 drivers/spi/spi-loongson-pci.c  |  28 ++--
 drivers/spi/spi-loongson-plat.c |  17 ++-
 drivers/spi/spi-loongson.h      |  23 ++-
 4 files changed, 285 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 74f47150cc6b..8d9f85d58dba 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -1,5 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Loongson SPI Support
+//
+// - Host-only controller with up to 4 chip selects.
+// - Tx/Rx FIFO with 4-bit wide entries;
+//   (1 on Loongson-2K0300, 4 on Loongson-2K3000).
+// - Supports booting the SoC from SPI flash.
+// - Both a polling mode and an interrupt mode are supported; in
+//   interrupt mode the number of bytes per interrupt is chosen from
+//   the FIFO depth (one byte per IRQ on a single-entry FIFO, up to
+//   4 bytes per IRQ on an 4-entry FIFO). The driver automatically
+//   falls back to polling if no IRQ is available.
+//
 // Copyright (C) 2023 Loongson Technology Corporation Limited
 
 #include <linux/bitfield.h>
@@ -201,9 +212,178 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 	return ret;
 }
 
+/*
+ * SPIF fires every (icnt + 1) bytes, and a tail shorter than that
+ * does not raise SPIF, which stalls the transfer. Pick the largest
+ * (icnt + 1) that divides len, falling back to 1 byte per interrupt.
+ */
+static unsigned int loongson_spi_calc_icnt(struct loongson_spi *loongson_spi,
+					   unsigned int len)
+{
+	unsigned int icnt_max;
+
+	icnt_max = min_t(unsigned int,
+			 FIELD_MAX(LOONGSON_SPI_SPER_ICNT),
+			 loongson_spi->fifo_depth - 1);
+
+	for (unsigned int icnt = icnt_max; icnt > 0; icnt--)
+		if (!(len % (icnt + 1)))
+			return icnt;
+	return 0;
+}
+
+static irqreturn_t loongson_spi_irq(int irq, void *dev_id)
+{
+	struct loongson_spi *loongson_spi = dev_id;
+	struct spi_controller *ctrl = loongson_spi->controller;
+	unsigned char status, data, limit;
+	bool done = false;
+
+	scoped_guard(spinlock_irqsave, &loongson_spi->lock) {
+		if (!loongson_spi->total)
+			return IRQ_HANDLED;
+
+		status = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+
+		if (!(status & LOONGSON_SPI_SPSR_EVENTS))
+			return IRQ_NONE;
+
+		if (status & LOONGSON_SPI_SPSR_WCOL)
+			loongson_spi_write_reg(loongson_spi,
+					       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_WCOL);
+
+		if (!(status & LOONGSON_SPI_SPSR_SPIF))
+			return IRQ_HANDLED;
+
+		loongson_spi_write_reg(loongson_spi,
+				       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_SPIF);
+
+		/* Drain the RX FIFO */
+		while (loongson_spi->count < loongson_spi->total) {
+			status = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+			if (status & LOONGSON_SPI_SPSR_RFEMPTY)
+				break;
+
+			data = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+			if (loongson_spi->rx_ptr)
+				loongson_spi->rx_ptr[loongson_spi->count] = (u8)data;
+
+			loongson_spi->count++;
+		}
+
+		/*
+		 * Refill the TX FIFO only until in-flight bytes reach icnt + 1,
+		 * so the next batch still forms a full interrupt period.
+		 */
+		limit = loongson_spi->icnt + 1;
+		while (loongson_spi->sent < loongson_spi->total &&
+		       (loongson_spi->sent - loongson_spi->count) < limit) {
+			status = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+			if (status & LOONGSON_SPI_SPSR_WFFULL)
+				break;
+
+			data = loongson_spi->tx_ptr ?
+			       loongson_spi->tx_ptr[loongson_spi->sent] : 0;
+
+			loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, data);
+			loongson_spi->sent++;
+		}
+
+		if (loongson_spi->count >= loongson_spi->total) {
+			loongson_spi_clear_bits(loongson_spi,
+						LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPIE);
+			done = true;
+		}
+	}
+
+	if (done)
+		spi_finalize_current_transfer(ctrl);
+
+	return IRQ_HANDLED;
+}
+
+static int loongson_spi_transfer_one_irq(struct spi_controller *host, struct spi_device *spi,
+					 struct spi_transfer *xfer)
+{
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(host);
+	unsigned int prefill, n = 0;
+
+	guard(spinlock_irqsave)(&loongson_spi->lock);
+
+	loongson_spi->tx_ptr = xfer->tx_buf;
+	loongson_spi->rx_ptr = xfer->rx_buf;
+	loongson_spi->total = xfer->len;
+	loongson_spi->count = 0;
+	loongson_spi->sent = 0;
+
+	/* Calculate and configure icnt */
+	loongson_spi->icnt = loongson_spi_calc_icnt(loongson_spi, xfer->len);
+	loongson_spi_update_bits(loongson_spi, LOONGSON_SPI_SPER_REG,
+				 LOONGSON_SPI_SPER_ICNT,
+				 FIELD_PREP(LOONGSON_SPI_SPER_ICNT, loongson_spi->icnt));
+
+	/* Clear any stale status */
+	loongson_spi_write_reg(loongson_spi,
+			       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_EVENTS);
+
+	/* Prefill at most icnt + 1 bytes */
+	prefill = min_t(unsigned int, xfer->len, loongson_spi->icnt + 1);
+	for (unsigned int i = 0; i < prefill; i++) {
+		unsigned int data = 0, status;
+
+		status = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+		if (status & LOONGSON_SPI_SPSR_WFFULL)
+			break;
+
+		if (loongson_spi->tx_ptr)
+			data = loongson_spi->tx_ptr[i];
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, data);
+
+		n++;
+	}
+	loongson_spi->sent = n;
+
+	/* Enable the byte-completion interrupt */
+	loongson_spi_set_bits(loongson_spi,
+			      LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPIE);
+
+	return 1;
+}
+
+static void loongson_spi_handle_err(struct spi_controller *host, struct spi_message *msg)
+{
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(host);
+
+	/*
+	 * The SPI core has given up on this message (e.g. timeout) and
+	 * handed the buffers back to the caller. Stop the byte
+	 * interrupt, clear pending status, and mark the transfer dead so
+	 * that a late IRQ cannot write into the now-invalid buffers.
+	 */
+	loongson_spi_clear_bits(loongson_spi,
+				LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPIE);
+
+	loongson_spi_write_reg(loongson_spi,
+			       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_EVENTS);
+
+	scoped_guard(spinlock_irqsave, &loongson_spi->lock) {
+		loongson_spi->tx_ptr = NULL;
+		loongson_spi->rx_ptr = NULL;
+		loongson_spi->total = 0;
+		loongson_spi->count = 0;
+		loongson_spi->sent = 0;
+		loongson_spi->icnt = 0;
+	}
+}
+
 static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = spi_split_transfers_maxsize(ctlr, m, LOONGSON_SPI_MAX_XFER_SIZE);
+	if (ret)
+		return ret;
 
 	loongson_spi_clear_bits(loongson_spi,
 				LOONGSON_SPI_PARA_REG, LOONGSON_SPI_PARA_MEM_EN);
@@ -221,10 +401,13 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
 	if (ret)
 		return ret;
 
-	if (xfer->len)
-		return loongson_spi_write_read(spi, xfer);
+	if (!xfer->len)
+		return 0;
+
+	if (loongson_spi->use_irq)
+		return loongson_spi_transfer_one_irq(ctrl, spi, xfer);
 
-	return 0;
+	return loongson_spi_write_read(spi, xfer);
 }
 
 static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
@@ -240,15 +423,16 @@ static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct sp
 
 static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
 {
-	/* Disable SPI */
+	/* Disable SPI and its interrupt */
 	loongson_spi_clear_bits(loongson_spi_dev,
-				LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE);
+				LOONGSON_SPI_SPCR_REG,
+				LOONGSON_SPI_SPCR_SPE | LOONGSON_SPI_SPCR_SPIE);
 
 	/* Clear status flags (write 1 to clear) */
 	loongson_spi_write_reg(loongson_spi_dev,
 			       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_EVENTS);
 
-	/* Enable SPI */
+	/* Enable SPI (interrupt remains disabled until a transfer starts) */
 	loongson_spi_set_bits(loongson_spi_dev,
 			      LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE);
 }
@@ -280,7 +464,45 @@ static int loongson_spi_get_clk_rate(struct device *dev)
 	return 0;
 }
 
-int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
+static void loongson_spi_get_fifo_depth(struct device *dev)
+{
+	struct spi_controller *controller = dev_get_drvdata(dev);
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	unsigned int depth;
+
+	if (device_property_read_u32(dev, "fifo-depth", &depth)) {
+		loongson_spi->fifo_depth = 1;
+		dev_warn(dev,
+			 "fifo-depth not declared, defaulting to 1 (single-byte)");
+		return;
+	}
+
+	loongson_spi->fifo_depth = depth;
+}
+
+static void loongson_spi_irqinit(struct device *dev, int irq)
+{
+	struct spi_controller *controller = dev_get_drvdata(dev);
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	int ret;
+
+	if (irq <= 0) {
+		loongson_spi->use_irq = false;
+		return;
+	}
+
+	ret = devm_request_irq(dev, irq, loongson_spi_irq, 0, "loongson-spi", loongson_spi);
+	if (ret) {
+		loongson_spi->use_irq = false;
+		dev_warn(dev, "failed to request IRQ %d with %d, using polling", irq, ret);
+		return;
+	}
+
+	spin_lock_init(&loongson_spi->lock);
+	loongson_spi->use_irq = true;
+}
+
+int loongson_spi_init_controller(struct device *dev, void __iomem *regs, int irq)
 {
 	struct spi_controller *controller;
 	struct loongson_spi *spi;
@@ -295,6 +517,7 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	controller->prepare_message = loongson_spi_prepare_message;
 	controller->transfer_one = loongson_spi_transfer_one;
 	controller->unprepare_message = loongson_spi_unprepare_message;
+	controller->handle_err = loongson_spi_handle_err;
 	controller->set_cs = loongson_spi_set_cs;
 	controller->num_chipselect = LOONGSON_SPI_NUM_CS;
 	dev_set_drvdata(dev, controller);
@@ -312,8 +535,8 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	controller->min_speed_hz = DIV_ROUND_UP_ULL(spi->clk_rate, LOONGSON_SPI_DIV_MAX);
 
 	loongson_spi_reginit(spi);
-
-	spi->mode = 0;
+	loongson_spi_get_fifo_depth(dev);
+	loongson_spi_irqinit(dev, irq);
 
 	return devm_spi_register_controller(dev, controller);
 }
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index ccc26efd88fe..5317603dc486 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -7,25 +7,33 @@
 #include "spi-loongson.h"
 
 static int loongson_spi_pci_register(struct pci_dev *pdev,
-			const struct pci_device_id *ent)
+				     const struct pci_device_id *ent)
 {
-	int ret;
-	void __iomem *reg_base;
 	struct device *dev = &pdev->dev;
-	int pci_bar = 0;
+	void __iomem *reg_base;
+	int ret, irq = 0;
 
 	ret = pcim_enable_device(pdev);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "cannot enable pci device\n");
+		return dev_err_probe(dev, ret, "cannot enable pci device");
 
-	reg_base = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
+	reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
 	ret = PTR_ERR_OR_ZERO(reg_base);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request and remap memory\n");
-
-	ret = loongson_spi_init_controller(dev, reg_base);
+		return dev_err_probe(dev, ret, "failed to request and remap memory");
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		dev_warn(dev, "no IRQ available, will use PIO mode");
+	} else {
+		irq = pci_irq_vector(pdev, 0);
+		if (irq < 0)
+			dev_warn(dev, "failed to get IRQ vector, will use PIO mode");
+	}
+
+	ret = loongson_spi_init_controller(dev, reg_base, irq);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize controller\n");
+		return dev_err_probe(dev, ret, "failed to initialize controller");
 
 	return 0;
 }
diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
index 6f8202264341..82d8505b6b66 100644
--- a/drivers/spi/spi-loongson-plat.c
+++ b/drivers/spi/spi-loongson-plat.c
@@ -9,17 +9,26 @@
 
 static int loongson_spi_platform_probe(struct platform_device *pdev)
 {
-	int ret;
-	void __iomem *reg_base;
 	struct device *dev = &pdev->dev;
+	void __iomem *reg_base;
+	int ret, irq = 0;
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-	ret = loongson_spi_init_controller(dev, reg_base);
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (ret < 0)
+		dev_warn(dev, "no IRQ specified, will use PIO mode");
+	else
+		irq = ret;
+
+	ret = loongson_spi_init_controller(dev, reg_base, irq);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize controller\n");
+		return dev_err_probe(dev, ret, "failed to initialize controller");
 
 	return 0;
 }
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index c46169e8c780..442f22ee89af 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -35,6 +35,7 @@
 
 /* SPER bits */
 #define LOONGSON_SPI_SPER_SPRE		GENMASK(1, 0)
+#define LOONGSON_SPI_SPER_ICNT		GENMASK(7, 6)
 
 /* SFC_PARAM bits */
 #define LOONGSON_SPI_PARA_MEM_EN	BIT(0)
@@ -54,6 +55,16 @@
 
 #define LOONGSON_SPI_NUM_CS		4
 
+/*
+ * This controller has no DMA and moves one byte per IRQ/polling
+ * iteration, so actual throughput is far below speed_hz while the
+ * SPI core scales its timeout from the theoretical speed_hz.
+ * Split messages into fixed-size chunks so each transfer completes
+ * well inside the core's per-transfer timeout. This is a software
+ * policy, not a hardware limit.
+ */
+#define LOONGSON_SPI_MAX_XFER_SIZE	SZ_4K
+
 /* Hardware limits and divider masks */
 #define LOONGSON_SPI_DIV_MIN		2
 #define LOONGSON_SPI_DIV_MAX		4096
@@ -92,8 +103,18 @@ struct loongson_spi {
 	unsigned int		mode;
 	u64			clk_rate;
 	struct loongson_spi_suspend_store lss;
+
+	spinlock_t		lock;	/* protects tx_ptr, rx_ptr and transfer state */
+	bool			use_irq;
+	const unsigned char	*tx_ptr;
+	unsigned char		*rx_ptr;
+	unsigned int		count;
+	unsigned int		sent;
+	unsigned int		total;
+	unsigned int		icnt;
+	unsigned int		fifo_depth;
 };
 
-int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
+int loongson_spi_init_controller(struct device *dev, void __iomem *regs, int irq);
 extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
 #endif /* __LINUX_SPI_LOONGSON_H */
-- 
2.52.0

