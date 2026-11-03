Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689714;
	b=tAOT8DydFB34i4SaRcUcE9pt1uEhXeDGyJJ1JqZDks9/WTKIR4RxLDdMIPIvMH/0CR5R
	 y+DaIB5XX86vs8Iwczhud137Y5AsSCsU1sCq1G37S7B50ZUnqbD8A08hYKCS4bI0+/ROv
	 NpnoVibOyG1AhO1JWnpLtLVwwmgeDJ9NldcBZWm8QOcZbcAap5wxP564wmGf72cc99gkG
	 a0f63qJV4sY8VV/Mv+icMiz0+hmIzdukhjGrtZA3EH/709eR6elG2YOvnR8IalAUaB/28
	 a8y20m6Dj2al/So7ierWaXTxNog9O3pQCOVKGxy+DrZjtZhCmUxz3CtHzy53p3AU+mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689714;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Wrl7zcHEUWl/wBFu8hjRicNPiiY2gJ6+Yx5JI+WHfRE=;
	b=cxkKEHdHWLH9v2LkR9aj6xvCXm8CtathspuY/IepXvb3zXkjaVvbKzFZHU81lDmV6fny
	 WlbLc/M+TJGHy3zvhby4YeTOJSktcMtWP3a+7mAtelj7pd4IZn0ogIox9rbkyLHYXmY3B
	 I3AMIUjvwO1WzAPl0XLv0rgRSym+GBmQ3xgkzNcppeBGWUGPNv5TcWD23qfEXaqj+rPGV
	 NHyqpnlJ+AgTBHNqz7XELN3RXIsaUK/d+35RPV+5pyDEvVZxOtgsvm2DvCzTUKvypxSnt
	 6xjXGI00oWJTgrugmd+UySRuq2txkZTQ/7ZHvgl4h+/iuX9QyAoeuqhOpk7LGv8l1GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54540606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54540606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bx79JtiOlqwdwbAA--.15710S3;
	Tue, 03 Nov 2026 15:08:29 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxRs1qiOlq6RQyAA--.24713S4;
	Tue, 03 Nov 2026 15:08:29 +0800 (CST)
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
Subject: [PATCH 6/8] spi: loongson: Move private definitions into the core driver
Date: Tue,  3 Nov 2026 15:08:18 +0800
Message-ID: <17c0bde3ddc14f6f34eea98558f535d772e79623.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxRs1qiOlq6RQyAA--.24713S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DbgAAsI
X-Coremail-Antispam: 1Uk129KBj9fXoWfArWxXr4kGF1fKrWkAFW5Arc_yoW8KFyDGo
	WxXa4kXr48uw18WFyjqr1rtr47X3W5ur4qyrn3Ca4kJ3yYyFyDJry3Xw47uF18Z3W3JFW3
	ZFyfKFW8Kr4IgFWDl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

The Loongson SPI register definitions and the private controller
structure are only used by the core driver.  Move them from the shared
header into spi-loongson-core.c and rename the structure to
loongson_spi_priv to make it clear that it is driver-private data.

The shared header now only contains the exported init function and the
PM ops declaration, which reduces the surface exposed to the PCI and
platform glue drivers.

While at it, update the copyright years and add MODULE_AUTHOR() entries
to the PCI and platform drivers.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 252 +++++++++++++++++++-------------
 drivers/spi/spi-loongson-pci.c  |  19 +--
 drivers/spi/spi-loongson-plat.c |  11 +-
 drivers/spi/spi-loongson.h      |  53 +------
 4 files changed, 173 insertions(+), 162 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 91d7acbe4302..082248f29ae7 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -1,21 +1,71 @@
 // SPDX-License-Identifier: GPL-2.0+
-// Loongson SPI Support
-// Copyright (C) 2023 Loongson Technology Corporation Limited
+//
+// Loongson SPI Controller driver
+//
+// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
 #include "spi-loongson.h"
 
+/* SPI controller register offsets */
+#define LOONGSON_SPI_SPCR_REG		0x00
+#define LOONGSON_SPI_SPSR_REG		0x01
+#define LOONGSON_SPI_FIFO_REG		0x02
+#define LOONGSON_SPI_SPER_REG		0x03
+#define LOONGSON_SPI_PARA_REG		0x04
+#define LOONGSON_SPI_SFCS_REG		0x05
+#define LOONGSON_SPI_TIMI_REG		0x06
+
+/* SPCR bits */
+#define LOONGSON_SPI_SPCR_SPR		GENMASK(1, 0)
+#define LOONGSON_SPI_SPCR_CPHA		BIT(2)
+#define LOONGSON_SPI_SPCR_CPOL		BIT(3)
+#define LOONGSON_SPI_SPCR_SPE		BIT(6)
+#define LOONGSON_SPI_SPCR_SPIE		BIT(7)
+
+/* SPSR bits */
+#define LOONGSON_SPI_SPSR_RFEMPTY	BIT(0)
+#define LOONGSON_SPI_SPSR_RFFULL	BIT(1)
+#define LOONGSON_SPI_SPSR_WFEMPTY	BIT(2)
+#define LOONGSON_SPI_SPSR_WFFULL	BIT(3)
+#define LOONGSON_SPI_SPSR_WCOL		BIT(6)
+#define LOONGSON_SPI_SPSR_SPIF		BIT(7)
+
+/* SPER bits */
+#define LOONGSON_SPI_SPER_SPRE		GENMASK(1, 0)
+
+/* SFC_PARAM bits */
+#define LOONGSON_SPI_PARA_MEM_EN	BIT(0)
+
+#define LOONGSON_SPI_DIV_MIN		2
+#define LOONGSON_SPI_DIV_MAX		4096
+
+struct loongson_spi_suspend_store {
+	unsigned char		spcr;
+	unsigned char		sper;
+	unsigned char		spsr;
+	unsigned char		para;
+	unsigned char		sfcs;
+	unsigned char		timi;
+};
+
+struct loongson_spi_priv {
+	struct spi_controller	*controller;
+	void __iomem		*base;
+	unsigned int		hz;
+	unsigned int		mode;
+	u64			clk_rate;
+	struct loongson_spi_suspend_store lss;
+};
+
 static const struct {
 	unsigned int	div;
 	unsigned char	spr;
@@ -35,38 +85,38 @@ static const struct {
 	{4096, 3, 2 },
 };
 
-static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
+static inline void loongson_spi_write_reg(struct loongson_spi_priv *priv, unsigned char reg,
 					  unsigned char data)
 {
-	writeb(data, spi->base + reg);
+	writeb(data, priv->base + reg);
 }
 
-static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
+static inline char loongson_spi_read_reg(struct loongson_spi_priv *priv, unsigned char reg)
 {
-	return readb(spi->base + reg);
+	return readb(priv->base + reg);
 }
 
 static void loongson_spi_set_cs(struct spi_device *spi, bool en)
 {
-	int cs;
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	unsigned char mask = (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
-	unsigned char val = en ? mask :  (BIT(0) << spi_get_chipselect(spi, 0));
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	unsigned char val = en ? mask : (BIT(0) << spi_get_chipselect(spi, 0));
+	int cs;
 
-	cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG) & ~mask;
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);
+	cs = loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG) & ~mask;
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, val | cs);
 }
 
-static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
+static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsigned int hz)
 {
 	unsigned long div;
 	unsigned char val;
 	unsigned int i;
 
-	if (!hz || !loongson_spi->clk_rate)
+	if (!hz || !priv->clk_rate)
 		return -EINVAL;
 
-	div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
+	div = DIV_ROUND_UP_ULL(priv->clk_rate, hz);
 	if (div < LOONGSON_SPI_DIV_MIN)
 		div = LOONGSON_SPI_DIV_MIN;
 
@@ -78,106 +128,106 @@ static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int
 	if (i == ARRAY_SIZE(loongson_spi_div_table))
 		return -EINVAL;
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
+	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG,
 			       val | loongson_spi_div_table[i].spr);
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
+	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG,
 			       val | loongson_spi_div_table[i].spre);
 
-	loongson_spi->hz = hz;
+	priv->hz = hz;
 
 	return 0;
 }
 
-static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
+static void loongson_spi_set_mode(struct loongson_spi_priv *priv,
 				  struct spi_device *spi)
 {
 	unsigned char val;
 
-	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
+	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
 	val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
+
 	if (spi->mode & SPI_CPOL)
 		val |= LOONGSON_SPI_SPCR_CPOL;
+
 	if (spi->mode & SPI_CPHA)
 		val |= LOONGSON_SPI_SPCR_CPHA;
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
-	loongson_spi->mode = spi->mode;
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
+	priv->mode = spi->mode;
 }
 
-static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
-				struct spi_device *spi, struct spi_transfer *t)
+static int loongson_spi_update_state(struct loongson_spi_priv *priv, struct spi_device *spi,
+				     struct spi_transfer *t)
 {
 	int ret;
 
-	if (t && loongson_spi->hz != t->speed_hz) {
-		ret = loongson_spi_set_clk(loongson_spi, t->speed_hz);
+	if (t && priv->hz != t->speed_hz) {
+		ret = loongson_spi_set_clk(priv, t->speed_hz);
 		if (ret)
 			return ret;
 	}
 
-	if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
-		loongson_spi_set_mode(loongson_spi, spi);
+	if ((spi->mode ^ priv->mode) & SPI_MODE_X_MASK)
+		loongson_spi_set_mode(priv, spi);
 
 	return 0;
 }
 
 static int loongson_spi_setup(struct spi_device *spi)
 {
-	struct loongson_spi *loongson_spi;
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 
-	loongson_spi = spi_controller_get_devdata(spi->controller);
 	if (spi->bits_per_word % 8)
 		return -EINVAL;
 
 	if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
 		return -EINVAL;
 
-	loongson_spi->hz = 0;
+	priv->hz = 0;
 	loongson_spi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	return 0;
 }
 
 static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
-					u8 **rx_buf, unsigned int num)
+					u8 **rx_buf)
 {
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	unsigned char status;
 	int ret;
 
 	if (tx_buf && *tx_buf)
-		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
+		loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
 	else
-		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
+		loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, 0);
 
-	ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
+	ret = readb_poll_timeout(priv->base + LOONGSON_SPI_SPSR_REG,
 				 status,
 				 !(status & LOONGSON_SPI_SPSR_RFEMPTY),
 				 1, USEC_PER_MSEC);
 
 	if (rx_buf && *rx_buf)
-		*(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+		*(*rx_buf)++ = loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
 	else
-		loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+		loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
 
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
@@ -185,25 +235,25 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 	return ret;
 }
 
-static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
+static int loongson_spi_prepare_message(struct spi_controller *host, struct spi_message *m)
 {
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
 	unsigned char para;
 
-	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
+	para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
 			       para & ~LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
 
-static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
+static int loongson_spi_transfer_one(struct spi_controller *host, struct spi_device *spi,
 				     struct spi_transfer *xfer)
 {
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	int ret;
 
-	ret = loongson_spi_update_state(loongson_spi, spi, xfer);
+	ret = loongson_spi_update_state(priv, spi, xfer);
 	if (ret)
 		return ret;
 
@@ -213,33 +263,33 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
 	return 0;
 }
 
-static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
+static int loongson_spi_unprepare_message(struct spi_controller *host, struct spi_message *m)
 {
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctrl);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
 	unsigned char para;
 
 	/* Restore the hardware SPI Flash read path */
-	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
+	para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
 			       para | LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
 
-static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
+static void loongson_spi_reginit(struct loongson_spi_priv *priv)
 {
 	unsigned char val;
 
-	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
+	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
 	val &= ~LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
 
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
 			       (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL));
 
-	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
+	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
 	val |= LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
 }
 
 static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
@@ -265,74 +315,73 @@ static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
 
 int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 {
-	struct spi_controller *controller;
-	struct loongson_spi *spi;
+	struct loongson_spi_priv *priv;
+	struct spi_controller *host;
 	int ret;
 
-	controller = devm_spi_alloc_host(dev, sizeof(struct loongson_spi));
-	if (controller == NULL)
+	host = devm_spi_alloc_host(dev, sizeof(*priv));
+	if (!host)
 		return -ENOMEM;
 
-	controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH;
-	controller->setup = loongson_spi_setup;
-	controller->prepare_message = loongson_spi_prepare_message;
-	controller->transfer_one = loongson_spi_transfer_one;
-	controller->unprepare_message = loongson_spi_unprepare_message;
-	controller->set_cs = loongson_spi_set_cs;
-	controller->num_chipselect = 4;
-	dev_set_drvdata(dev, controller);
+	host->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH;
+	host->setup = loongson_spi_setup;
+	host->prepare_message = loongson_spi_prepare_message;
+	host->transfer_one = loongson_spi_transfer_one;
+	host->unprepare_message = loongson_spi_unprepare_message;
+	host->set_cs = loongson_spi_set_cs;
+	host->num_chipselect = 4;
+	dev_set_drvdata(dev, host);
 
-	spi = spi_controller_get_devdata(controller);
-	spi->base = regs;
-	spi->controller = controller;
+	priv = spi_controller_get_devdata(host);
+	priv->base = regs;
+	priv->controller = host;
 
-	ret = loongson_spi_get_clk_rate(dev, &spi->clk_rate);
+	ret = loongson_spi_get_clk_rate(dev, &priv->clk_rate);
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to get clock rate");
 
-	loongson_spi_reginit(spi);
-
-	spi->mode = 0;
+	loongson_spi_reginit(priv);
+	priv->mode = 0;
 
-	return devm_spi_register_controller(dev, controller);
+	return devm_spi_register_controller(dev, host);
 }
 EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
 
 static int loongson_spi_suspend(struct device *dev)
 {
-	struct spi_controller *controller = dev_get_drvdata(dev);
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_controller_suspend(controller);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
-	loongson_spi->lss.spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
-	loongson_spi->lss.sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
-	loongson_spi->lss.spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
-	loongson_spi->lss.para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi->lss.sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
-	loongson_spi->lss.timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
+	priv->lss.spcr = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
+	priv->lss.sper = loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
+	priv->lss.spsr = loongson_spi_read_reg(priv, LOONGSON_SPI_SPSR_REG);
+	priv->lss.para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
+	priv->lss.sfcs = loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG);
+	priv->lss.timi = loongson_spi_read_reg(priv, LOONGSON_SPI_TIMI_REG);
 
 	return 0;
 }
 
 static int loongson_spi_resume(struct device *dev)
 {
-	struct spi_controller *controller = dev_get_drvdata(dev);
-	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->lss.spcr);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->lss.sper);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->lss.para);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loongson_spi->lss.sfcs);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loongson_spi->lss.timi);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, priv->lss.spcr);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG, priv->lss.sper);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG, priv->lss.para);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, priv->lss.sfcs);
+	loongson_spi_write_reg(priv, LOONGSON_SPI_TIMI_REG, priv->lss.timi);
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
+	loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
 			       LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
 
-	spi_controller_resume(controller);
+	spi_controller_resume(host);
 
 	return 0;
 }
@@ -342,4 +391,5 @@ DEFINE_SIMPLE_DEV_PM_OPS(loongson_spi_dev_pm_ops, loongson_spi_suspend, loongson
 EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");
 
 MODULE_DESCRIPTION("Loongson SPI core driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index ccc26efd88fe..ad90be956e1e 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -1,31 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0+
+//
 // PCI interface driver for Loongson SPI Support
-// Copyright (C) 2023 Loongson Technology Corporation Limited
+//
+// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
 #include <linux/pci.h>
 
 #include "spi-loongson.h"
 
-static int loongson_spi_pci_register(struct pci_dev *pdev,
-			const struct pci_device_id *ent)
+static int loongson_spi_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	int ret;
-	void __iomem *reg_base;
 	struct device *dev = &pdev->dev;
-	int pci_bar = 0;
+	void __iomem *reg_base;
+	int pci_bar = 0, ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "cannot enable pci device\n");
+		return dev_err_probe(dev, ret, "cannot enable pci device");
 
 	reg_base = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
 	ret = PTR_ERR_OR_ZERO(reg_base);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request and remap memory\n");
+		return dev_err_probe(dev, ret, "failed to request and remap memory");
 
 	ret = loongson_spi_init_controller(dev, reg_base);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize controller\n");
+		return dev_err_probe(dev, ret, "failed to initialize controller");
 
 	return 0;
 }
@@ -49,5 +49,6 @@ static struct pci_driver loongson_spi_pci_driver = {
 module_pci_driver(loongson_spi_pci_driver);
 
 MODULE_DESCRIPTION("Loongson spi pci driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
index 6f8202264341..dcfbdd50e996 100644
--- a/drivers/spi/spi-loongson-plat.c
+++ b/drivers/spi/spi-loongson-plat.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
+//
 // Platform driver for Loongson SPI Support
-// Copyright (C) 2023 Loongson Technology Corporation Limited
+//
+// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
 #include <linux/err.h>
 #include <linux/platform_device.h>
@@ -9,9 +11,9 @@
 
 static int loongson_spi_platform_probe(struct platform_device *pdev)
 {
-	int ret;
-	void __iomem *reg_base;
 	struct device *dev = &pdev->dev;
+	void __iomem *reg_base;
+	int ret;
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
@@ -19,7 +21,7 @@ static int loongson_spi_platform_probe(struct platform_device *pdev)
 
 	ret = loongson_spi_init_controller(dev, reg_base);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize controller\n");
+		return dev_err_probe(dev, ret, "failed to initialize controller");
 
 	return 0;
 }
@@ -42,5 +44,6 @@ static struct platform_driver loongson_spi_plat_driver = {
 module_platform_driver(loongson_spi_plat_driver);
 
 MODULE_DESCRIPTION("Loongson spi platform driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("SPI_LOONGSON_CORE");
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index 89efd4ce69d8..c8b722bc5fb5 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -1,56 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* Header File for Loongson SPI Driver. */
-/* Copyright (C) 2023 Loongson Technology Corporation Limited */
+//
+// Loongson SPI Support - common header
+//
+// Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
 #ifndef __LINUX_SPI_LOONGSON_H
 #define __LINUX_SPI_LOONGSON_H
 
-#include <linux/bits.h>
-#include <linux/pm.h>
-#include <linux/types.h>
-
-#define	LOONGSON_SPI_SPCR_REG	0x00
-#define	LOONGSON_SPI_SPSR_REG	0x01
-#define	LOONGSON_SPI_FIFO_REG	0x02
-#define	LOONGSON_SPI_SPER_REG	0x03
-#define	LOONGSON_SPI_PARA_REG	0x04
-#define	LOONGSON_SPI_SFCS_REG	0x05
-#define	LOONGSON_SPI_TIMI_REG	0x06
-
-/* Bits definition for Loongson SPI register */
-#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
-#define	LOONGSON_SPI_SPCR_CPHA	BIT(2)
-#define	LOONGSON_SPI_SPCR_CPOL	BIT(3)
-#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
-#define	LOONGSON_SPI_SPSR_RFEMPTY	BIT(0)
-#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
-#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
-
-#define LOONGSON_SPI_DIV_MIN		2
-#define LOONGSON_SPI_DIV_MAX		4096
-
-struct device;
-struct spi_controller;
-
-struct loongson_spi_suspend_store {
-	unsigned char		spcr;
-	unsigned char		sper;
-	unsigned char		spsr;
-	unsigned char		para;
-	unsigned char		sfcs;
-	unsigned char		timi;
-};
-
-struct loongson_spi {
-	struct	spi_controller	*controller;
-	void __iomem		*base;
-	int			cs_active;
-	unsigned int		hz;
-	unsigned int		mode;
-	u64			clk_rate;
-	struct loongson_spi_suspend_store lss;
-};
-
 int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
 extern const struct dev_pm_ops loongson_spi_dev_pm_ops;
+
 #endif /* __LINUX_SPI_LOONGSON_H */
-- 
2.52.0

