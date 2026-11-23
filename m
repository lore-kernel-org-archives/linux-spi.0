Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427114;
	b=CYvG8OrIzmMf/9gkAUzH+czSz9fNvcm2fpo0TPMMk/QOsZjtLwmLefAKfDmiZaG6Y+WR
	 JfFO7JI+JykkJbVCGKWm44FmosnWTVHG0BG3MwN8fJs75eXjS5QTs1G57MkIwhu+tFVA+
	 vonbW9v26j5HzK+24IAqxgBL+gcvsy9ktg3PlX4dNMxA5IaGPS8va78Fz/VaNuThiRndR
	 K9AOjPqgdlRr43p4sQO+V3piSSiRiZnti2NQGSBIPuCqFuzGUBW1QR6d915e5g06goTlH
	 1ySHqweeZamQCw9XrhlVbEanID46ziyPAGYCvLVZogXaMJC5BCXMw/4QBebTHRK54IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427114;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=pRtao/INl6Dn3tEV5HFIkLipCrRQutnWmgmemfyP5VI=;
	b=FZCOBRU0s007Ju0ON1dGsBbnV8+qoSizY6BzTns3o15tUGH20yCFCyNpgVp3OOXWK7gh
	 dH8EHM5J/WMtQknC5BAHKEVVng7cc84YMJt0XaBFhihVAfV9aH0ZPHKiPsJUdeavpEoDz
	 rLSD6Si1+p3teCxAJ3m0SbWrDlTMqJY41o3t9h12moJucJF0pAjozB4OD0I71vu4vXuuz
	 mPQr8NL5Ko37FJ8Z6aFxIN5wz+YhQfWkUsJ9NAUer09/boTyj8fK/eZqUQ8TX468sXZ49
	 Kz36fibHsXWLmRstD5p90rr90YhIJOkdMR3nZ3iqmZZOAfx40uTxh+XUi0jWr/GrKzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B1606A682;
	Mon, 23 Nov 2026 09:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4B1606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8CxfdAoCwRr6DAiAA--.4146S3;
	Mon, 23 Nov 2026 17:45:12 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJDxTs8jCwRrW9o2AA--.44054S5;
	Mon, 23 Nov 2026 17:45:11 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bingxiong Li <libingxiong@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 3/5] spi: loongson-io: Add SPI-IO interrupt-driven driver
Date: Mon, 23 Nov 2026 17:44:48 +0800
Message-ID: <010b8f2cd618854142124c6418f4e9ccb80fb852.1795425389.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795425389.git.zhoubinbin@loongson.cn>
References: <cover.1795425389.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxTs8jCwRrW9o2AA--.44054S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGsDnvwK9wAAs-
X-Coremail-Antispam: 1Uk129KBj9fXoWfWryxur1DZF1kGr1rXw13trc_yoW5XrWUKo
	WxWFy5Xr48uw18Ca4Utr4rtr47XF95ur4UAws3CrykJ3yjyFyDJry7uw17ur1rJ3WavFW3
	Za93KFWxGFs7tr1kl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
	kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8uRRtUUUUU==

Add a platform driver for the Loongson-2K0300 SPI-IO controller.

On the Loongson-2K0300, SPI2 and SPI3 reside in the chip IO address
space and only support IO-space access.

Support 8-bit/16-bit/32-bit words, SPI modes 0-3, LSB-first,
programmable clocking and hardware chip select.

Transfer handling is interrupt-driven in small FIFO batches of
up to four bytes. On EOT IRQ the driver drains RX data and issues
the next batch until the transfer completes. This keeps each
interrupt short and works without requiring DMA providers to be
available at probe time.

Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                   |   1 +
 drivers/spi/Kconfig           |  16 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-loongson-io.c | 737 ++++++++++++++++++++++++++++++++++
 4 files changed, 755 insertions(+)
 create mode 100644 drivers/spi/spi-loongson-io.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ce1b9e514e08..70789ce6e507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15742,6 +15742,7 @@ L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
 F:	drivers/spi/spi-loongson-core.c
+F:	drivers/spi/spi-loongson-io.c
 F:	drivers/spi/spi-loongson-pci.c
 F:	drivers/spi/spi-loongson-plat.c
 F:	drivers/spi/spi-loongson.h
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a7b343d124a9..5551b883ce1e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -635,6 +635,22 @@ config SPI_LOONGSON_CORE
 	tristate
 	depends on LOONGARCH || COMPILE_TEST
 
+config SPI_LOONGSON_IO
+	tristate "Loongson SPI-IO Controller Driver"
+	depends on LOONGARCH || COMPILE_TEST
+	depends on OF
+	help
+	  This enables support for the Loongson SPI-IO controller, which is
+	  a separate SPI IP block found on Loongson-2K0300 SPI2/SPI3.
+
+	  It is a generic SPI master for externally connected SPI
+	  peripherals. It does not provide memory-mapped SPI flash
+	  access (no spi-mem support). Transfers can be interrupt-driven
+	  or DMA-driven, with runtime-selectable 8/16/32-bit frame widths
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-loongson-io.
+
 config SPI_LOONGSON_PCI
 	tristate "Loongson SPI Controller PCI Driver Support"
 	select SPI_LOONGSON_CORE
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index b6ab37271555..3af58eaa391a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SPI_KSPI2)			+= spi-kspi2.o
 obj-$(CONFIG_SPI_LJCA)			+= spi-ljca.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_LOONGSON_CORE)		+= spi-loongson-core.o
+obj-$(CONFIG_SPI_LOONGSON_IO)		+= spi-loongson-io.o
 obj-$(CONFIG_SPI_LOONGSON_PCI)		+= spi-loongson-pci.o
 obj-$(CONFIG_SPI_LOONGSON_PLATFORM)	+= spi-loongson-plat.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
diff --git a/drivers/spi/spi-loongson-io.c b/drivers/spi/spi-loongson-io.c
new file mode 100644
index 000000000000..e273c9f4a943
--- /dev/null
+++ b/drivers/spi/spi-loongson-io.c
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Platform driver for Loongson-2K0300 SPI IO Support
+//
+// Copyright (C) 2017-2026 Loongson Technology Corporation Limited
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+
+/* Loongson SPI-IO Controller registers */
+#define LOONGSON_SPI_IO_CR1_REG			0x00
+#define LOONGSON_SPI_IO_CR2_REG			0x04
+#define LOONGSON_SPI_IO_CR3_REG			0x08
+#define LOONGSON_SPI_IO_CR4_REG			0x0c
+#define LOONGSON_SPI_IO_IER_REG			0x10
+#define LOONGSON_SPI_IO_SR1_REG			0x14
+#define LOONGSON_SPI_IO_SR2_REG			0x18
+#define LOONGSON_SPI_IO_CFG1_REG		0x20
+#define LOONGSON_SPI_IO_CFG2_REG		0x24
+#define LOONGSON_SPI_IO_CFG3_REG		0x28
+#define LOONGSON_SPI_IO_CRC1_REG		0x30
+#define LOONGSON_SPI_IO_CRC2_REG		0x34
+#define LOONGSON_SPI_IO_DR_REG			0x40
+
+/* Bitfields of LOONGSON_SPI_IO_CR1_REG */
+#define LOONGSON_SPI_IO_CR1_SPE			BIT(0)
+#define LOONGSON_SPI_IO_CR1_CSTART		BIT(1)
+#define LOONGSON_SPI_IO_CR1_AUTOSUS		BIT(2)
+#define LOONGSON_SPI_IO_CR1_SSREV		BIT(8)
+
+#define LOONGSON_SPI_IO_CR1_START_MASK		(LOONGSON_SPI_IO_CR1_CSTART | \
+						 LOONGSON_SPI_IO_CR1_AUTOSUS)
+
+/* Bitfields of LOONGSON_SPI_IO_CR2_REG */
+#define LOONGSON_SPI_IO_CR2_RXFTHLV		GENMASK(1, 0)
+#define LOONGSON_SPI_IO_CR2_TXFTHLV		GENMASK(9, 8)
+
+/* Bitfields of LOONGSON_SPI_IO_CR3_REG */
+#define LOONGSON_SPI_IO_CR3_TSIZE		GENMASK(15, 0)
+
+/* Bitfields of LOONGSON_SPI_IO_CR4_REG */
+#define LOONGSON_SPI_IO_CR4_CTSIZE		GENMASK(15, 0)
+
+/* Bitfields of LOONGSON_SPI_IO_IER_REG */
+#define LOONGSON_SPI_IO_IER_RXAIE		BIT(0)
+#define LOONGSON_SPI_IO_IER_TXAIE		BIT(1)
+#define LOONGSON_SPI_IO_IER_DXAIE		BIT(2)
+#define LOONGSON_SPI_IO_IER_RXEIE		BIT(4)
+#define LOONGSON_SPI_IO_IER_TXEIE		BIT(5)
+#define LOONGSON_SPI_IO_IER_SUSPIE		BIT(7)
+#define LOONGSON_SPI_IO_IER_OVRIE		BIT(8)
+#define LOONGSON_SPI_IO_IER_UDRIE		BIT(9)
+#define LOONGSON_SPI_IO_IER_CRCEIE		BIT(10)
+#define LOONGSON_SPI_IO_IER_MODFIE		BIT(11)
+#define LOONGSON_SPI_IO_IER_EOTIE		BIT(15)
+
+/* Bitfields of LOONGSON_SPI_IO_SR1_REG */
+#define LOONGSON_SPI_IO_SR1_RXA			BIT(0)
+#define LOONGSON_SPI_IO_SR1_TXA			BIT(1)
+#define LOONGSON_SPI_IO_SR1_DXA			BIT(2)
+#define LOONGSON_SPI_IO_SR1_RXE			BIT(4)
+#define LOONGSON_SPI_IO_SR1_TXE			BIT(5)
+#define LOONGSON_SPI_IO_SR1_SUSP		BIT(7)
+#define LOONGSON_SPI_IO_SR1_OVR			BIT(8)
+#define LOONGSON_SPI_IO_SR1_UDR			BIT(9)
+#define LOONGSON_SPI_IO_SR1_CRCE		BIT(10)
+#define LOONGSON_SPI_IO_SR1_MODF		BIT(11)
+#define LOONGSON_SPI_IO_SR1_EOT			BIT(15)
+
+#define LOONGSON_SPI_IO_SR1_ERR_MASK		(LOONGSON_SPI_IO_SR1_OVR | \
+						 LOONGSON_SPI_IO_SR1_UDR | \
+						 LOONGSON_SPI_IO_SR1_MODF | \
+						 LOONGSON_SPI_IO_SR1_CRCE)
+
+/* Bitfields of LOONGSON_SPI_IO_SR2_REG */
+#define LOONGSON_SPI_IO_SR2_RXFLV		GENMASK(2, 0)
+#define LOONGSON_SPI_IO_SR2_TXFLV		GENMASK(10, 8)
+
+/* Bitfields of LOONGSON_SPI_IO_CFG1_REG */
+#define LOONGSON_SPI_IO_CFG1_CPOL		BIT(0)
+#define LOONGSON_SPI_IO_CFG1_CPHA		BIT(1)
+#define LOONGSON_SPI_IO_CFG1_LSBFRST		BIT(7)
+#define LOONGSON_SPI_IO_CFG1_DSIZE		GENMASK(12, 8)
+
+/* Bitfields of LOONGSON_SPI_IO_CFG2_REG */
+#define LOONGSON_SPI_IO_CFG2_BRDEC		GENMASK(7, 2)
+#define LOONGSON_SPI_IO_CFG2_BRINT		GENMASK(15, 8)
+
+#define LOONGSON_SPI_IO_CFG2_MIN_BRINT		2
+#define LOONGSON_SPI_IO_CFG2_MAX_BRINT		FIELD_MAX(LOONGSON_SPI_IO_CFG2_BRINT)
+
+/* Bitfields of LOONGSON_SPI_IO_CFG3_REG */
+#define LOONGSON_SPI_IO_CFG3_MSTR		BIT(0)
+#define LOONGSON_SPI_IO_CFG3_DIOSWP		BIT(1)
+#define LOONGSON_SPI_IO_CFG3_DIE		BIT(2)
+#define LOONGSON_SPI_IO_CFG3_DOE		BIT(3)
+#define LOONGSON_SPI_IO_CFG3_SSMODE		GENMASK(9, 8)
+
+/* Bitfields of LOONGSON_SPI_IO_CRC1_REG */
+#define LOONGSON_SPI_IO_CRC1_CRCEN		BIT(0)
+#define LOONGSON_SPI_IO_CRC1_CRCPOLY		GENMASK(31, 1)
+
+/* Bitfields of LOONGSON_SPI_IO_CRC2_REG */
+#define LOONGSON_SPI_IO_CRC2_RCRCINI		BIT(0)
+#define LOONGSON_SPI_IO_CRC2_TCRCINI		BIT(1)
+#define LOONGSON_SPI_IO_CRC2_CRCSIZE		GENMASK(12, 8)
+
+/**
+ * enum xfer_mode - Loongson SPI transfer mode
+ * @XFER_IDLE: no transfer is in progress
+ * @XFER_INTERRUPT: interrupt-driven batch transfer
+ */
+enum xfer_mode {
+	XFER_IDLE,
+	XFER_INTERRUPT,
+};
+
+/**
+ * struct loongson_spi_priv - private data for the Loongson SPI controller
+ * @controller: SPI controller instance
+ * @dev: device backing the controller
+ * @base: MMIO base address of the SPI controller
+ * @hz: current SPI bus clock in Hz
+ * @clk_rate: parent clock rate in Hz
+ * @mode: current SPI mode bits
+ * @bits_per_word: current word size in bits
+ * @frame_bytes: bytes occupied by one frame in the FIFO and transfer buffers
+ * @irq: interrupt number
+ * @tx_buf: current transmit buffer for interrupt mode
+ * @rx_buf: current receive buffer for interrupt mode
+ * @remaining: bytes left in the current interrupt transfer
+ * @xfer_ret: result of the current transfer
+ * @batch_size: number of bytes in the current interrupt batch
+ * @xfer_completion: completion signaled when the current transfer finishes
+ * @xfer_mode: current transfer mode
+ */
+struct loongson_spi_priv {
+	struct spi_controller   *controller;
+	struct device		*dev;
+	void __iomem		*base;
+	u32                     hz;
+	u64                     clk_rate;
+	u8                      mode;
+	u8			bits_per_word;
+	u8			frame_bytes;
+
+	int			irq;
+	const u8		*tx_buf;
+	u8			*rx_buf;
+	u32			remaining;
+	int			xfer_ret;
+	u32			batch_size;
+	struct completion	xfer_completion;
+	enum xfer_mode		xfer_mode;
+};
+
+static void loongson_spi_writel(struct loongson_spi_priv *priv, u32 reg, u32 data)
+{
+	writel(data, priv->base + reg);
+}
+
+static u32 loongson_spi_readl(struct loongson_spi_priv *priv, u32 reg)
+{
+	return readl(priv->base + reg);
+}
+
+static void loongson_spi_update_bits(struct loongson_spi_priv *priv, u32 reg,
+				     u32 mask, u32 val)
+{
+	u32 tmp = readl(priv->base + reg);
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+	writel(tmp, priv->base + reg);
+}
+
+/**
+ * loongson_spi_io_read_dr() - Read one complete frame from the RX FIFO
+ * @priv: controller private data
+ *
+ * The APB read width follows the 1, 2 or 4 byte FIFO storage width selected
+ * by DSIZE. The unused high bits are zero and the low byte is stored first.
+ *
+ * Return: one frame in a little-endian container.
+ */
+static u32 loongson_spi_io_read_dr(struct loongson_spi_priv *priv)
+{
+	void __iomem *dr = priv->base + LOONGSON_SPI_IO_DR_REG;
+
+	if (priv->frame_bytes == 1)
+		return readb(dr);
+	if (priv->frame_bytes == 2)
+		return readw(dr);
+
+	return readl(dr);
+}
+
+/**
+ * loongson_spi_io_write_dr() - Write one complete frame to the TX FIFO
+ * @priv: controller private data
+ * @data: frame in a little-endian container
+ *
+ * Select the APB write strobes for a 1, 2 or 4 byte FIFO access according to
+ * the storage width selected by DSIZE.
+ */
+static void loongson_spi_io_write_dr(struct loongson_spi_priv *priv, u32 data)
+{
+	void __iomem *dr = priv->base + LOONGSON_SPI_IO_DR_REG;
+
+	if (priv->frame_bytes == 1)
+		writeb(data, dr);
+	else if (priv->frame_bytes == 2)
+		writew(data, dr);
+	else
+		writel(data, dr);
+}
+
+/**
+ * loongson_spi_io_cfg_write() - Write a configuration register
+ * @priv: controller private data
+ * @reg: configuration register offset
+ * @val: value to write
+ *
+ * CFG1/CFG2/CFG3 and CRCx writes are rejected while CR1.SPE is set.
+ * Temporarily disable the peripheral and restore CR1 around the write.
+ * The caller must ensure that no transfer is active.
+ */
+static void loongson_spi_io_cfg_write(struct loongson_spi_priv *priv, u32 reg, u32 val)
+{
+	u32 cr1 = loongson_spi_readl(priv, LOONGSON_SPI_IO_CR1_REG);
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_CR1_REG,
+			    cr1 & ~LOONGSON_SPI_IO_CR1_SPE);
+	loongson_spi_writel(priv, reg, val);
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_CR1_REG, cr1);
+}
+
+/**
+ * loongson_spi_io_timeout() - Calculate a transfer completion timeout
+ * @priv: controller private data
+ * @xfer: SPI transfer being timed
+ *
+ * Use twice the calculated wire time, with a minimum timeout of one second.
+ *
+ * Return: timeout in jiffies.
+ */
+static unsigned long loongson_spi_io_timeout(struct loongson_spi_priv *priv,
+					     struct spi_transfer *xfer)
+{
+	u64 frames = xfer->len / priv->frame_bytes;
+	u64 nsec = frames * priv->bits_per_word * NSEC_PER_SEC;
+	u32 rate = priv->hz ? priv->hz : 1000;
+	u64 msec = DIV_ROUND_UP_ULL(nsec, (u64)rate * NSEC_PER_MSEC);
+
+	return msecs_to_jiffies(max_t(u64, msec * 2, 1000));
+}
+
+static void loongson_spi_io_set_thresh(struct loongson_spi_priv *priv)
+{
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR2_REG,
+				 LOONGSON_SPI_IO_CR2_RXFTHLV |
+				 LOONGSON_SPI_IO_CR2_TXFTHLV, 0);
+}
+
+/**
+ * loongson_spi_io_set_cs() - Set the hardware chip-select output
+ * @spi: SPI target device
+ * @high: true to assert chip select
+ *
+ * The SSREV bit controls the hardware chip-select assertion state.
+ */
+static void loongson_spi_io_set_cs(struct spi_device *spi, bool high)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
+	u32 val = high ? LOONGSON_SPI_IO_CR1_SSREV : 0;
+
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_SSREV, val);
+}
+
+/**
+ * loongson_spi_io_set_clk() - Program the SPI bus clock divider
+ * @priv: controller private data
+ * @hz: requested SPI bus clock in Hz
+ */
+static void loongson_spi_io_set_clk(struct loongson_spi_priv *priv, unsigned int hz)
+{
+	u32 val;
+
+	val = clamp_val(DIV_ROUND_UP_ULL(priv->clk_rate, hz),
+			LOONGSON_SPI_IO_CFG2_MIN_BRINT, LOONGSON_SPI_IO_CFG2_MAX_BRINT);
+
+	loongson_spi_io_cfg_write(priv, LOONGSON_SPI_IO_CFG2_REG,
+				  FIELD_PREP(LOONGSON_SPI_IO_CFG2_BRINT, val));
+
+	priv->hz = hz;
+}
+
+/**
+ * loongson_spi_io_set_mode() - Apply SPI mode bits and word size
+ * @priv: controller private data
+ * @mode: SPI mode bits from the target device
+ * @bits_per_word: word size in bits
+ *
+ * Configure CPOL, CPHA and LSB_FIRST. DSIZE is programmed as the word size
+ * minus one; pin direction and SPI_3WIRE are handled separately per transfer.
+ */
+static void loongson_spi_io_set_mode(struct loongson_spi_priv *priv, u32 mode,
+				     u8 bits_per_word)
+{
+	u32 val = 0;
+
+	if (mode & SPI_CPOL)
+		val |= LOONGSON_SPI_IO_CFG1_CPOL;
+
+	if (mode & SPI_CPHA)
+		val |= LOONGSON_SPI_IO_CFG1_CPHA;
+
+	if (mode & SPI_LSB_FIRST)
+		val |= LOONGSON_SPI_IO_CFG1_LSBFRST;
+
+	val |= FIELD_PREP(LOONGSON_SPI_IO_CFG1_DSIZE, bits_per_word - 1);
+	loongson_spi_io_cfg_write(priv, LOONGSON_SPI_IO_CFG1_REG, val);
+
+	priv->mode = mode;
+	priv->bits_per_word = bits_per_word;
+
+	if (bits_per_word <= 8)
+		priv->frame_bytes = 1;
+	else if (bits_per_word <= 16)
+		priv->frame_bytes = 2;
+	else
+		priv->frame_bytes = 4;
+}
+
+/**
+ * loongson_spi_io_set_pin_mode() - Select MISO/MOSI directions for a transfer
+ * @spi: SPI target device
+ * @xfer: SPI transfer being prepared
+ *
+ * Normal mode supports full-duplex and TX-only/RX-only simplex transfers.
+ * In SPI_3WIRE mode, TX drives MOSI while RX switches MOSI to an input.
+ * Buffers supplied by SPI core for dummy TX/RX do not select a real direction.
+ *
+ * Return: 0 on success, or %-EINVAL if a 3-wire transfer requests both
+ * directions in the same transfer.
+ */
+static int loongson_spi_io_set_pin_mode(struct spi_device *spi,
+					struct spi_transfer *xfer)
+{
+	struct spi_controller *ctrl = spi->controller;
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	bool tx = xfer->tx_buf && xfer->tx_buf != ctrl->dummy_tx;
+	bool rx = xfer->rx_buf && xfer->rx_buf != ctrl->dummy_rx;
+	u32 val = LOONGSON_SPI_IO_CFG3_MSTR;
+
+	if (spi->mode & SPI_3WIRE) {
+		if (tx && rx) {
+			dev_err(&spi->dev, "3-wire mode is half-duplex only");
+			return -EINVAL;
+		}
+
+		if (rx)
+			val |= LOONGSON_SPI_IO_CFG3_DIOSWP |
+			       LOONGSON_SPI_IO_CFG3_DIE;
+		else
+			val |= LOONGSON_SPI_IO_CFG3_DOE;
+	} else {
+		/* No buffer in either direction defaults to full-duplex. */
+		if (tx || !rx)
+			val |= LOONGSON_SPI_IO_CFG3_DOE;
+		if (rx || !tx)
+			val |= LOONGSON_SPI_IO_CFG3_DIE;
+	}
+
+	if (loongson_spi_readl(priv, LOONGSON_SPI_IO_CFG3_REG) != val)
+		loongson_spi_io_cfg_write(priv, LOONGSON_SPI_IO_CFG3_REG, val);
+
+	return 0;
+}
+
+/**
+ * loongson_spi_io_update_state() - Apply per-transfer clock and device mode
+ * @spi: SPI target device
+ * @t: SPI transfer, or NULL when only the device mode needs updating
+ */
+static void loongson_spi_io_update_state(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
+	u8 bits_per_word = spi->bits_per_word;
+
+	if (t && t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+
+	if (t && priv->hz != t->speed_hz)
+		loongson_spi_io_set_clk(priv, t->speed_hz);
+
+	if (((spi->mode ^ priv->mode) & (SPI_MODE_X_MASK | SPI_LSB_FIRST | SPI_3WIRE)) ||
+	    priv->bits_per_word != bits_per_word)
+		loongson_spi_io_set_mode(priv, spi->mode, bits_per_word);
+}
+
+/**
+ * loongson_spi_io_setup() - Validate an SPI target chip select
+ * @spi: SPI target device being configured
+ *
+ * Return: 0 if the chip select is supported, otherwise %-EINVAL.
+ */
+static int loongson_spi_io_setup(struct spi_device *spi)
+{
+	if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * loongson_spi_io_start_batch() - Start one interrupt-driven FIFO batch
+ * @priv: controller private data
+ *
+ * Preload up to four FIFO bytes using whole frames, with zero-filled frames
+ * when no TX buffer is present. TSIZE counts frames rather than bytes.
+ *
+ * Return: number of bytes in the started batch, or 0 if no data remains.
+ */
+static int loongson_spi_io_start_batch(struct loongson_spi_priv *priv)
+{
+	u32 batch_size, frames;
+	u32 tx_data;
+
+	if (priv->remaining == 0)
+		return 0;
+
+	batch_size = min_t(u32, priv->remaining, 4);
+	frames = batch_size / priv->frame_bytes;
+	priv->batch_size = batch_size;
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_CR3_REG, frames - 1);
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_CR4_REG, 0);
+
+	for (unsigned int i = 0; i < batch_size; i += priv->frame_bytes) {
+		tx_data = 0;
+		if (priv->tx_buf) {
+			memcpy(&tx_data, priv->tx_buf, priv->frame_bytes);
+			priv->tx_buf += priv->frame_bytes;
+		}
+		loongson_spi_io_write_dr(priv, tx_data);
+	}
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG, LOONGSON_SPI_IO_SR1_EOT);
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_START_MASK,
+				 LOONGSON_SPI_IO_CR1_START_MASK);
+
+	return batch_size;
+}
+
+/**
+ * loongson_spi_io_irq_handler() - Handle SPI error and end-of-transfer IRQs
+ * @irq: interrupt number
+ * @dev_id: controller private data
+ *
+ * In interrupt mode, consume the current RX batch and start the next one.
+ * Controller errors disable further interrupts and complete the wait with an
+ * error status.
+ *
+ * Return: %IRQ_HANDLED for a recognized error or EOT, otherwise %IRQ_NONE.
+ */
+static irqreturn_t loongson_spi_io_irq_handler(int irq, void *dev_id)
+{
+	struct loongson_spi_priv *priv = dev_id;
+	u32 rx_data;
+	u32 sr1;
+
+	sr1 = loongson_spi_readl(priv, LOONGSON_SPI_IO_SR1_REG);
+
+	if (sr1 & LOONGSON_SPI_IO_SR1_ERR_MASK) {
+		dev_err(&priv->controller->dev, "SPI error: SR1=0x%x", sr1);
+		loongson_spi_writel(priv, LOONGSON_SPI_IO_IER_REG, 0);
+		priv->xfer_ret = -EIO;
+		complete(&priv->xfer_completion);
+		return IRQ_HANDLED;
+	}
+
+	if (!(sr1 & LOONGSON_SPI_IO_SR1_EOT))
+		return IRQ_NONE;
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG, LOONGSON_SPI_IO_SR1_EOT);
+
+	switch (priv->xfer_mode) {
+	case XFER_INTERRUPT:
+		for (unsigned int i = 0; i < priv->batch_size;
+		     i += priv->frame_bytes) {
+			rx_data = loongson_spi_io_read_dr(priv);
+			if (priv->rx_buf) {
+				memcpy(priv->rx_buf, &rx_data, priv->frame_bytes);
+				priv->rx_buf += priv->frame_bytes;
+			}
+		}
+		priv->remaining -= priv->batch_size;
+
+		if (priv->remaining == 0) {
+			loongson_spi_update_bits(priv, LOONGSON_SPI_IO_IER_REG,
+						 LOONGSON_SPI_IO_IER_EOTIE, 0);
+			loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+						 LOONGSON_SPI_IO_CR1_CSTART, 0);
+			priv->xfer_ret = 0;
+			complete(&priv->xfer_completion);
+		} else {
+			loongson_spi_io_start_batch(priv);
+		}
+		break;
+	case XFER_IDLE:
+	default:
+		dev_warn(&priv->controller->dev, "EOT with no active transfer");
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * loongson_spi_io_transfer_one() - Execute one SPI transfer
+ * @ctrl: SPI controller
+ * @spi: SPI target device
+ * @xfer: transfer to execute
+ *
+ * Apply clock, mode and pin-direction state before running interrupt-driven
+ * FIFO batches.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int loongson_spi_io_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
+					struct spi_transfer *xfer)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
+	int ret;
+
+	loongson_spi_io_update_state(spi, xfer);
+
+	if (xfer->len == 0)
+		return 0;
+
+	if (xfer->len % priv->frame_bytes) {
+		dev_err(&spi->dev, "length %u is not aligned to %u-byte frames",
+			xfer->len, priv->frame_bytes);
+		return -EINVAL;
+	}
+
+	ret = loongson_spi_io_set_pin_mode(spi, xfer);
+	if (ret)
+		return ret;
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG,
+			    LOONGSON_SPI_IO_SR1_EOT | LOONGSON_SPI_IO_SR1_ERR_MASK);
+
+	loongson_spi_io_set_thresh(priv);
+
+	priv->tx_buf = xfer->tx_buf;
+	priv->rx_buf = xfer->rx_buf;
+	priv->remaining = xfer->len;
+	priv->xfer_ret = 0;
+
+	reinit_completion(&priv->xfer_completion);
+	priv->xfer_mode = XFER_INTERRUPT;
+
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_AUTOSUS,
+				 LOONGSON_SPI_IO_CR1_AUTOSUS);
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_IER_REG,
+				 LOONGSON_SPI_IO_IER_EOTIE,
+				 LOONGSON_SPI_IO_IER_EOTIE);
+
+	loongson_spi_io_start_batch(priv);
+
+	ret = wait_for_completion_timeout(&priv->xfer_completion,
+					  loongson_spi_io_timeout(priv, xfer));
+	priv->xfer_mode = XFER_IDLE;
+
+	if (ret == 0) {
+		loongson_spi_writel(priv, LOONGSON_SPI_IO_IER_REG, 0);
+		dev_err(&spi->dev, "Interrupt transfer timeout");
+		return -ETIMEDOUT;
+	}
+
+	return priv->xfer_ret;
+}
+
+/**
+ * loongson_spi_io_reginit() - Restore the basic controller configuration
+ * @priv: controller private data
+ *
+ * Select master full-duplex pin directions and enable the SPI peripheral.
+ */
+static void loongson_spi_io_reginit(struct loongson_spi_priv *priv)
+{
+	u32 cr1;
+
+	/* CFG3 is only writable while SPE is clear; cfg_write() handles that. */
+	loongson_spi_io_cfg_write(priv, LOONGSON_SPI_IO_CFG3_REG,
+				  LOONGSON_SPI_IO_CFG3_MSTR |
+				  LOONGSON_SPI_IO_CFG3_DIE |
+				  LOONGSON_SPI_IO_CFG3_DOE);
+
+	cr1 = loongson_spi_readl(priv, LOONGSON_SPI_IO_CR1_REG);
+	cr1 &= ~LOONGSON_SPI_IO_CR1_START_MASK;
+	cr1 |= LOONGSON_SPI_IO_CR1_SPE;
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_CR1_REG, cr1);
+}
+
+/**
+ * loongson_spi_io_handle_err() - Quiesce hardware after a failed message
+ * @ctrl: SPI controller
+ * @msg: failed SPI message
+ *
+ * Stop the engine, discard stale RX FIFO data, clear status and software
+ * transfer state, then restore the basic configuration.
+ */
+static void loongson_spi_io_handle_err(struct spi_controller *ctrl,
+				       struct spi_message *msg)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(ctrl);
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_IER_REG, 0);
+	synchronize_irq(priv->irq);
+
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_START_MASK, 0);
+
+	loongson_spi_io_set_thresh(priv);
+
+	while (FIELD_GET(LOONGSON_SPI_IO_SR2_RXFLV,
+			 loongson_spi_readl(priv, LOONGSON_SPI_IO_SR2_REG)))
+		loongson_spi_io_read_dr(priv);
+
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG,
+			    LOONGSON_SPI_IO_SR1_EOT | LOONGSON_SPI_IO_SR1_ERR_MASK);
+
+	priv->tx_buf = NULL;
+	priv->rx_buf = NULL;
+	priv->remaining = 0;
+	priv->batch_size = 0;
+	priv->xfer_ret = 0;
+	priv->xfer_mode = XFER_IDLE;
+	reinit_completion(&priv->xfer_completion);
+
+	loongson_spi_io_reginit(priv);
+}
+
+static int loongson_spi_io_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct loongson_spi_priv *priv;
+	struct spi_controller *host;
+	struct clk *clk;
+	int ret;
+
+	host = devm_spi_alloc_host(dev, sizeof(*priv));
+	if (!host)
+		return -ENOMEM;
+
+	host->mode_bits = SPI_MODE_X_MASK | SPI_LSB_FIRST | SPI_3WIRE;
+	host->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
+	host->setup = loongson_spi_io_setup;
+	host->transfer_one = loongson_spi_io_transfer_one;
+	host->set_cs = loongson_spi_io_set_cs;
+	host->handle_err = loongson_spi_io_handle_err;
+	host->num_chipselect = 1;
+	dev_set_drvdata(dev, host);
+
+	priv = spi_controller_get_devdata(host);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->controller = host;
+	priv->dev = dev;
+	priv->xfer_mode = XFER_IDLE;
+	priv->batch_size = 0;
+
+	init_completion(&priv->xfer_completion);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock");
+	priv->clk_rate = clk_get_rate(clk);
+	if (!priv->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "clock rate is zero");
+
+	/* the divider is >= 2, and BRINT is 8 bits wide. */
+	host->max_speed_hz = (u32)min_t(u64, div_u64(priv->clk_rate, 2), U32_MAX);
+	host->min_speed_hz = (u32)min_t(u64, DIV_ROUND_UP_ULL(priv->clk_rate, 255),
+					U32_MAX);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "no IRQ resource");
+
+	ret = devm_request_irq(dev, priv->irq, loongson_spi_io_irq_handler,
+			       IRQF_SHARED, dev_name(dev), priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request IRQ");
+
+	loongson_spi_io_reginit(priv);
+	loongson_spi_writel(priv, LOONGSON_SPI_IO_IER_REG, 0);
+
+	return devm_spi_register_controller(dev, host);
+}
+
+static const struct of_device_id loongson_spi_io_id_table[] = {
+	{ .compatible = "loongson,ls2k0300-spi-io" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, loongson_spi_io_id_table);
+
+static struct platform_driver loongson_spi_io_plat_driver = {
+	.probe = loongson_spi_io_probe,
+	.driver	= {
+		.name	= "loongson-spi-io",
+		.of_match_table = loongson_spi_io_id_table,
+	},
+};
+module_platform_driver(loongson_spi_io_plat_driver);
+
+MODULE_DESCRIPTION("Loongson spi io controller driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.52.0

