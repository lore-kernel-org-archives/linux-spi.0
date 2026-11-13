Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548576;
	b=HqzvhrkB0JWFNmxB2/vptRl5i/B/mJzpAM0h+jTqIk/8pSmdwPwa+TxHkiDEuiI/Qjt2
	 Z9Tr9K0ZnNE/DsgZyxqupSU4zZ2iGb2FcDyXHbodn6yU5m23fAEVbOsa3wBooOgxyYz7O
	 cwqB6cYOh/Al59B5yNaRTQMj1LNnHxkPAuy6uAFOzoyUjFrmUql5TE3zEdI+hhxh12ps2
	 LPJ06/NcZ/FkCA/7rgLp9zuzjfx+4alorEUM2YxJIL09QepL5ckNdt4REvyNqV3/YbXYg
	 UT4RGd6a9fjy5L9bOZ1sH4pYev2DoykCF9bySzb87cU/JgVQrJxnfogTseQ0KVHFniw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548576;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=wuYOfInLZ36YS6poBKtPGGI0DNCRM/M6DV39HZ3Oo7E=;
	b=pHbdMJUPPFwnlaUfahpVx8a7kdCHqcLdiNbR1Wf6Nre0AiownrdB59lhNwd6037BBpjg
	 a2IltDWTqN6OF7NMPFbc1gSmzA/Jo6Tj2K3lnkkZeqywLUQJurOx3Q6B1v3CK+n3eGiQF
	 i3XrIMYYZBjTihDgdshwZJ4ey4b6K6qZOBMJufoptDnNDGRkibpd6AYmNy8wEk1xRT8q0
	 AcgQO0ZK/iIAjfeskQvo5cIdx6ZI0FpZ5MtEPEY4ay4boX1KARxj+QO4tmcBuZSCTDB97
	 I7ohlQ0ETnGLwnoQexIUSBD1yOlzkVi4Gb76b8uu9uaSI3pqta5Y0eH0DECfQ4vi3LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196E606A330
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4196E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxXdJdo_Zq2x4fAA--.24438S3;
	Fri, 13 Nov 2026 13:42:53 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxFs1ao_ZqMSg0AA--.48458S4;
	Fri, 13 Nov 2026 13:42:52 +0800 (CST)
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
Subject: [PATCH v2 6/7] spi: loongson: Use bitfield helpers for register access
Date: Fri, 13 Nov 2026 13:42:42 +0800
Message-ID: <204c9f81fa9af279974a8a8ca5293c263faa45cd.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs1ao_ZqMSg0AA--.48458S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGr2b-sDTgAAsH
X-Coremail-Antispam: 1Uk129KBj9fXoWfGw13GFyrtFW5tFWUWFWUWrX_yoW8Jw1fJo
	W7Xas7Xw48u3W8C3Wjqr1FqrW7X345ur4qyrn3Aa4kJ3yayFyDJr9xZrW7uF48W3W3tFW3
	AFyfKF48Kan2gF4Dl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsdb1UUUUU

Replace open-coded read/modify/write sequences with
loongson_spi_set_bits()/clear_bits()/update_bits(), define register
bits via GENMASK/BIT, and use FIELD_PREP where the mask is a
compile-time constant.

No functional change intended.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 136 ++++++++++++++++++--------------
 drivers/spi/spi-loongson.h      |  67 +++++++++++-----
 2 files changed, 122 insertions(+), 81 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 5991ce7b5603..74f47150cc6b 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -2,6 +2,8 @@
 // Loongson SPI Support
 // Copyright (C) 2023 Loongson Technology Corporation Limited
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -31,32 +33,54 @@ static const struct loongson_spi_div_table div_table[] = {
 	{4096, 3, 2 },
 };
 
-static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
-					  unsigned char data)
+static void loongson_spi_write_reg(struct loongson_spi *spi, unsigned int reg,
+				   unsigned char data)
 {
 	writeb(data, spi->base + reg);
 }
 
-static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
+static unsigned char loongson_spi_read_reg(struct loongson_spi *spi, unsigned int reg)
 {
 	return readb(spi->base + reg);
 }
 
+static void loongson_spi_set_bits(struct loongson_spi *spi, unsigned int reg,
+				  unsigned char bits)
+{
+	writeb(readb(spi->base + reg) | bits, spi->base + reg);
+}
+
+static void loongson_spi_clear_bits(struct loongson_spi *spi, unsigned int reg,
+				    unsigned char bits)
+{
+	writeb(readb(spi->base + reg) & ~bits, spi->base + reg);
+}
+
+static void loongson_spi_update_bits(struct loongson_spi *spi, unsigned int reg,
+				     unsigned char mask, unsigned char val)
+{
+	unsigned char tmp = readb(spi->base + reg);
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+	writeb(tmp, spi->base + reg);
+}
+
 static void loongson_spi_set_cs(struct spi_device *spi, bool en)
 {
-	int cs;
-	unsigned char mask = (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
-	unsigned char val = en ? mask :  (BIT(0) << spi_get_chipselect(spi, 0));
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	unsigned int cs = spi_get_chipselect(spi, 0);
+	unsigned char mask, val;
+
+	mask = LOONGSON_SPI_SFCS_SW_EN(cs) | LOONGSON_SPI_SFCS_OUT(cs);
+	val = LOONGSON_SPI_SFCS_SW_EN(cs) | field_prep(LOONGSON_SPI_SFCS_OUT(cs), en);
 
-	cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG) & ~mask;
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);
+	loongson_spi_update_bits(loongson_spi, LOONGSON_SPI_SFCS_REG, mask, val);
 }
 
 static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
 {
 	unsigned long div;
-	unsigned char val;
 	unsigned int i;
 
 	if (!hz || !loongson_spi->clk_rate)
@@ -74,15 +98,11 @@ static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int
 	if (i == ARRAY_SIZE(div_table))
 		return -EINVAL;
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
-	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
-			       val | div_table[i].spr);
+	loongson_spi_update_bits(loongson_spi, LOONGSON_SPI_SPCR_REG,
+				 LOONGSON_SPI_SPCR_SPR, div_table[i].spr);
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
-	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
-			       val | div_table[i].spre);
+	loongson_spi_update_bits(loongson_spi, LOONGSON_SPI_SPER_REG,
+				 LOONGSON_SPI_SPER_SPRE, div_table[i].spre);
 
 	loongson_spi->hz = hz;
 
@@ -92,21 +112,23 @@ static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int
 static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
 				  struct spi_device *spi)
 {
-	unsigned char val;
+	unsigned char val = 0;
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
-	val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
 	if (spi->mode & SPI_CPOL)
 		val |= LOONGSON_SPI_SPCR_CPOL;
+
 	if (spi->mode & SPI_CPHA)
 		val |= LOONGSON_SPI_SPCR_CPHA;
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
+	loongson_spi_update_bits(loongson_spi, LOONGSON_SPI_SPCR_REG,
+				 LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA,
+				 val);
+
 	loongson_spi->mode = spi->mode;
 }
 
 static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
-				struct spi_device *spi, struct spi_transfer *t)
+				     struct spi_device *spi, struct spi_transfer *t)
 {
 	int ret;
 
@@ -124,13 +146,12 @@ static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
 
 static int loongson_spi_setup(struct spi_device *spi)
 {
-	struct loongson_spi *loongson_spi;
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
 
-	loongson_spi = spi_controller_get_devdata(spi->controller);
-	if (spi->bits_per_word % 8)
+	if (spi->bits_per_word % BITS_PER_BYTE)
 		return -EINVAL;
 
-	if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
+	if (spi_get_chipselect(spi, 0) >= LOONGSON_SPI_NUM_CS)
 		return -EINVAL;
 
 	loongson_spi->hz = 0;
@@ -138,41 +159,41 @@ static int loongson_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
-					u8 **rx_buf, unsigned int num)
+static int loongson_spi_write_read_8bit(struct spi_device *spi,
+					const u8 **tx_buf, u8 **rx_buf)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
-	unsigned char status;
+	unsigned char status, val = 0;
 	int ret;
 
 	if (tx_buf && *tx_buf)
-		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
-	else
-		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
+		val = *((*tx_buf)++);
+
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, val);
 
 	ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
-				 status,
-				 !(status & LOONGSON_SPI_SPSR_RFEMPTY),
+				 status, !(status & LOONGSON_SPI_SPSR_RFEMPTY),
 				 1, USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
 
 	if (rx_buf && *rx_buf)
-		*(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
-	else
-		loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+		*(*rx_buf)++ = val;
 
 	return ret;
 }
 
 static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	int ret;
-	unsigned int count;
+	unsigned int count = xfer->len;
 	const u8 *tx = xfer->tx_buf;
 	u8 *rx = xfer->rx_buf;
+	int ret;
 
-	count = xfer->len;
 	do {
-		ret = loongson_spi_write_read_8bit(spi, &tx, &rx, count);
+		ret = loongson_spi_write_read_8bit(spi, &tx, &rx);
 		if (ret)
 			break;
 	} while (--count);
@@ -183,11 +204,9 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
-	unsigned char para;
 
-	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
-			       para & ~LOONGSON_SPI_PARA_MEM_EN);
+	loongson_spi_clear_bits(loongson_spi,
+				LOONGSON_SPI_PARA_REG, LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
@@ -211,30 +230,27 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
 static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctrl);
-	unsigned char para;
 
 	/* Restore the hardware SPI Flash read path */
-	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
-			       para | LOONGSON_SPI_PARA_MEM_EN);
+	loongson_spi_set_bits(loongson_spi,
+			      LOONGSON_SPI_PARA_REG, LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
 
 static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
 {
-	unsigned char val;
-
-	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
-	val &= ~LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+	/* Disable SPI */
+	loongson_spi_clear_bits(loongson_spi_dev,
+				LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE);
 
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
-			       (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL));
+	/* Clear status flags (write 1 to clear) */
+	loongson_spi_write_reg(loongson_spi_dev,
+			       LOONGSON_SPI_SPSR_REG, LOONGSON_SPI_SPSR_EVENTS);
 
-	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
-	val |= LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+	/* Enable SPI */
+	loongson_spi_set_bits(loongson_spi_dev,
+			      LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE);
 }
 
 static int loongson_spi_get_clk_rate(struct device *dev)
@@ -280,7 +296,7 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	controller->transfer_one = loongson_spi_transfer_one;
 	controller->unprepare_message = loongson_spi_unprepare_message;
 	controller->set_cs = loongson_spi_set_cs;
-	controller->num_chipselect = 4;
+	controller->num_chipselect = LOONGSON_SPI_NUM_CS;
 	dev_set_drvdata(dev, controller);
 
 	spi = spi_controller_get_devdata(controller);
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index 983a39c9b0ae..c46169e8c780 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -5,34 +5,59 @@
 #ifndef __LINUX_SPI_LOONGSON_H
 #define __LINUX_SPI_LOONGSON_H
 
-#include <linux/bits.h>
-#include <linux/pm.h>
-#include <linux/types.h>
+/* SPI controller register offsets */
+#define LOONGSON_SPI_SPCR_REG		0x00
+#define LOONGSON_SPI_SPSR_REG		0x01
+#define LOONGSON_SPI_FIFO_REG		0x02
+#define LOONGSON_SPI_SPER_REG		0x03
+#define LOONGSON_SPI_PARA_REG		0x04
+#define LOONGSON_SPI_SFCS_REG		0x05
+#define LOONGSON_SPI_TIMI_REG		0x06
 
-#define	LOONGSON_SPI_SPCR_REG	0x00
-#define	LOONGSON_SPI_SPSR_REG	0x01
-#define	LOONGSON_SPI_FIFO_REG	0x02
-#define	LOONGSON_SPI_SPER_REG	0x03
-#define	LOONGSON_SPI_PARA_REG	0x04
-#define	LOONGSON_SPI_SFCS_REG	0x05
-#define	LOONGSON_SPI_TIMI_REG	0x06
+/* SPCR bits */
+#define LOONGSON_SPI_SPCR_SPR		GENMASK(1, 0)
+#define LOONGSON_SPI_SPCR_CPHA		BIT(2)
+#define LOONGSON_SPI_SPCR_CPOL		BIT(3)
+#define LOONGSON_SPI_SPCR_SPE		BIT(6)
+#define LOONGSON_SPI_SPCR_SPIE		BIT(7)
 
-/* Bits definition for Loongson SPI register */
-#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
-#define	LOONGSON_SPI_SPCR_CPHA	BIT(2)
-#define	LOONGSON_SPI_SPCR_CPOL	BIT(3)
-#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
-#define	LOONGSON_SPI_SPSR_RFEMPTY	BIT(0)
-#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
-#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
+/* SPSR bits */
+#define LOONGSON_SPI_SPSR_RFEMPTY	BIT(0)
+#define LOONGSON_SPI_SPSR_RFFULL	BIT(1)
+#define LOONGSON_SPI_SPSR_WFEMPTY	BIT(2)
+#define LOONGSON_SPI_SPSR_WFFULL	BIT(3)
+#define LOONGSON_SPI_SPSR_WCOL		BIT(6)
+#define LOONGSON_SPI_SPSR_SPIF		BIT(7)
+
+/* SPSR event bits: transfer complete (SPIF) or write collision (WCOL) */
+#define LOONGSON_SPI_SPSR_EVENTS	(LOONGSON_SPI_SPSR_SPIF | \
+					 LOONGSON_SPI_SPSR_WCOL)
+
+/* SPER bits */
+#define LOONGSON_SPI_SPER_SPRE		GENMASK(1, 0)
+
+/* SFC_PARAM bits */
+#define LOONGSON_SPI_PARA_MEM_EN	BIT(0)
+
+/*
+ * SFC_SOFTCS layout:
+ *   bit  cs      : per-CS software-control enable
+ *   bit  cs + 4  : per-CS output level
+ *
+ * The chip select index is a runtime value, so FIELD_PREP() (which
+ * requires a compile-time constant mask) cannot be used here. These
+ * helpers keep the shift hidden behind a field-like accessor.
+ */
+#define LOONGSON_SPI_SFCS_OUT_SHIFT	4
+#define LOONGSON_SPI_SFCS_SW_EN(cs)	BIT(cs)
+#define LOONGSON_SPI_SFCS_OUT(cs)	BIT((cs) + LOONGSON_SPI_SFCS_OUT_SHIFT)
+
+#define LOONGSON_SPI_NUM_CS		4
 
 /* Hardware limits and divider masks */
 #define LOONGSON_SPI_DIV_MIN		2
 #define LOONGSON_SPI_DIV_MAX		4096
 
-struct device;
-struct spi_controller;
-
 /**
  * struct loongson_spi_div_table - SPI clock divider encoding
  * @div:  resulting clock divider (SPI input clock / SPI output clock)
-- 
2.52.0

