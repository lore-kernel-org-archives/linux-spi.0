Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689712;
	b=IMcfDMkNTooIoq+TT06kD9AVhsxwQa3b4j8WFQK9dnf6HPfxh2yT08EMu9dlrGtblS5n
	 LpNFoCgrpq4Z6FkJH1SJjZVAwjpoxTy8hma1P3gwh6BsOfBiF4YyXY6yAWxTVWOsEeRue
	 1E6ErCOOM9D69qkECoFbaBGjdu5smJGfmyeERjgrGIPVIc6fY0GT8bR4HUtEJtKunlXb2
	 k3kfE08MxsDx45GCKnf/1SklVp/C53eGhfLTRCUEnzIXPmL904PH5fSwDPNoPFH4/GasZ
	 wUNDPw382/VXoBiQeqcbM1a22RjbXpTCh6PoFrC6OsA183l3XbauNy3o2cJcLB2s6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689712;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=e4/g9dGUOwLh6zPWqMi828nPInSYzn82l/bll3Edy1M=;
	b=MN96S+oqTJ2NTYccgXU19BhetfCjTYUgeqPTIlkyFS8p5Cjuf7S73IL2loEKKyQr1klJ
	 teJDIPfbhx/kPgzxPIwDRbyeYtz3eAT/k0Fc083nDrb0P0eFthr3cYvKRNDgzrmPMMAJq
	 DtVgAOfKwF0eic10pSjPj/+QlV7mNsPWJcretI4rNOedaALtQ1OD3fgVdFJK8XTLYgbLw
	 eUzic5tAW6NTag3y8FlIq64Zyq+ttBGdjNubUgggJmbmYFhPMr35ZN+aLw263DqKYgEk3
	 dWCGFogflUn3O7WtYjSk3azxrEO6bgB/qdunaCioNR1DNIJtoFYJiXbafG5AyKp0Kmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02626606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02626606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxntJuiOlqxtwbAA--.15025S3;
	Tue, 03 Nov 2026 15:08:30 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxRs1qiOlq6RQyAA--.24713S5;
	Tue, 03 Nov 2026 15:08:30 +0800 (CST)
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
Subject: [PATCH 7/8] spi: loongson: Convert to regmap API
Date: Tue,  3 Nov 2026 15:08:19 +0800
Message-ID: <4710989d3f46c1bc919ef6b3955605c538f9b7a3.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxRs1qiOlq6RQyAA--.24713S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DbwAAsJ
X-Coremail-Antispam: 1Uk129KBj9fXoWfGrW3XF47Gr4kCryUWrW3Arc_yoW8JryDCo
	WxXas7Xr48u3W8GFyUtw1rtrW7Xw1UursFvr9ak34kJ3sIya4UJry3Zw42kF1rW3W3tFWf
	uFZ3tF4rGan7tFWDl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0y89JUUUUU==

Replace the open-coded readb()/writeb() operations with regmap-mmio.
The driver contains numerous read-modify-write sequences, for example
when updating the clock divider, the mode bits, or enabling/disabling
the controller.  These are now expressed with regmap_update_bits(),
which simplifies the code and reduces boilerplate.

Use a flat register cache with the status and FIFO registers marked
volatile.  Suspend/resume then uses regcache_cache_only(),
regcache_mark_dirty(), and regcache_sync() instead of manually saving
and restoring individual registers.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 177 +++++++++++++++++---------------
 1 file changed, 93 insertions(+), 84 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 082248f29ae7..5ad781471cef 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -4,13 +4,15 @@
 //
 // Copyright (C) 2023-2026 Loongson Technology Corporation Limited
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
 #include "spi-loongson.h"
@@ -45,25 +47,31 @@
 /* SFC_PARAM bits */
 #define LOONGSON_SPI_PARA_MEM_EN	BIT(0)
 
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
+/* Hardware limits and divider masks */
 #define LOONGSON_SPI_DIV_MIN		2
 #define LOONGSON_SPI_DIV_MAX		4096
 
-struct loongson_spi_suspend_store {
-	unsigned char		spcr;
-	unsigned char		sper;
-	unsigned char		spsr;
-	unsigned char		para;
-	unsigned char		sfcs;
-	unsigned char		timi;
-};
+#define LOONGSON_SPI_NUM_CS		4
 
 struct loongson_spi_priv {
 	struct spi_controller	*controller;
-	void __iomem		*base;
+	struct regmap		*regmap;
 	unsigned int		hz;
 	unsigned int		mode;
 	u64			clk_rate;
-	struct loongson_spi_suspend_store lss;
 };
 
 static const struct {
@@ -85,32 +93,41 @@ static const struct {
 	{4096, 3, 2 },
 };
 
-static inline void loongson_spi_write_reg(struct loongson_spi_priv *priv, unsigned char reg,
-					  unsigned char data)
+static bool loongson_spi_volatile_reg(struct device *dev, unsigned int reg)
 {
-	writeb(data, priv->base + reg);
+	switch (reg) {
+	case LOONGSON_SPI_SPSR_REG:
+	case LOONGSON_SPI_FIFO_REG:
+		return true;
+	default:
+		return false;
+	}
 }
 
-static inline char loongson_spi_read_reg(struct loongson_spi_priv *priv, unsigned char reg)
-{
-	return readb(priv->base + reg);
-}
+static const struct regmap_config loongson_spi_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.reg_stride	= 1,
+	.max_register	= LOONGSON_SPI_TIMI_REG,
+	.cache_type	= REGCACHE_FLAT_S,
+	.volatile_reg	= loongson_spi_volatile_reg,
+};
 
 static void loongson_spi_set_cs(struct spi_device *spi, bool en)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
-	unsigned char mask = (BIT(4) | BIT(0)) << spi_get_chipselect(spi, 0);
-	unsigned char val = en ? mask : (BIT(0) << spi_get_chipselect(spi, 0));
-	int cs;
+	unsigned int cs = spi_get_chipselect(spi, 0);
+	unsigned char mask, val;
 
-	cs = loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG) & ~mask;
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, val | cs);
+	mask = LOONGSON_SPI_SFCS_SW_EN(cs) | LOONGSON_SPI_SFCS_OUT(cs);
+	val = LOONGSON_SPI_SFCS_SW_EN(cs) | field_prep(LOONGSON_SPI_SFCS_OUT(cs), en);
+
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SFCS_REG, mask, val);
 }
 
 static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsigned int hz)
 {
 	unsigned long div;
-	unsigned char val;
 	unsigned int i;
 
 	if (!hz || !priv->clk_rate)
@@ -128,15 +145,13 @@ static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsigned int hz)
 	if (i == ARRAY_SIZE(loongson_spi_div_table))
 		return -EINVAL;
 
-	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
-	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG,
-			       val | loongson_spi_div_table[i].spr);
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+			   LOONGSON_SPI_SPCR_SPR,
+			   loongson_spi_div_table[i].spr);
 
-	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
-	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG,
-			       val | loongson_spi_div_table[i].spre);
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPER_REG,
+			   LOONGSON_SPI_SPER_SPRE,
+			   loongson_spi_div_table[i].spre);
 
 	priv->hz = hz;
 
@@ -146,10 +161,7 @@ static int loongson_spi_set_clk(struct loongson_spi_priv *priv, unsigned int hz)
 static void loongson_spi_set_mode(struct loongson_spi_priv *priv,
 				  struct spi_device *spi)
 {
-	unsigned char val;
-
-	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
-	val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
+	unsigned char val = 0;
 
 	if (spi->mode & SPI_CPOL)
 		val |= LOONGSON_SPI_SPCR_CPOL;
@@ -157,7 +169,9 @@ static void loongson_spi_set_mode(struct loongson_spi_priv *priv,
 	if (spi->mode & SPI_CPHA)
 		val |= LOONGSON_SPI_SPCR_CPHA;
 
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+			   LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA, val);
+
 	priv->mode = spi->mode;
 }
 
@@ -182,10 +196,10 @@ static int loongson_spi_setup(struct spi_device *spi)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 
-	if (spi->bits_per_word % 8)
+	if (spi->bits_per_word % BITS_PER_BYTE)
 		return -EINVAL;
 
-	if (spi_get_chipselect(spi, 0) >= spi->controller->num_chipselect)
+	if (spi_get_chipselect(spi, 0) >= LOONGSON_SPI_NUM_CS)
 		return -EINVAL;
 
 	priv->hz = 0;
@@ -198,23 +212,26 @@ static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_bu
 					u8 **rx_buf)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
-	unsigned char status;
+	unsigned int val = 0;
+	unsigned int status;
 	int ret;
 
 	if (tx_buf && *tx_buf)
-		loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
-	else
-		loongson_spi_write_reg(priv, LOONGSON_SPI_FIFO_REG, 0);
+		val = *((*tx_buf)++);
 
-	ret = readb_poll_timeout(priv->base + LOONGSON_SPI_SPSR_REG,
-				 status,
-				 !(status & LOONGSON_SPI_SPSR_RFEMPTY),
-				 1, USEC_PER_MSEC);
+	regmap_write(priv->regmap, LOONGSON_SPI_FIFO_REG, val);
 
+	/* Wait for RX FIFO not empty */
+	ret = regmap_read_poll_timeout(priv->regmap, LOONGSON_SPI_SPSR_REG,
+				       status,
+				       !(status & LOONGSON_SPI_SPSR_RFEMPTY),
+				       1, USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	regmap_read(priv->regmap, LOONGSON_SPI_FIFO_REG, &val);
 	if (rx_buf && *rx_buf)
-		*(*rx_buf)++ = loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
-	else
-		loongson_spi_read_reg(priv, LOONGSON_SPI_FIFO_REG);
+		*(*rx_buf)++ = (u8)val;
 
 	return ret;
 }
@@ -238,11 +255,8 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 static int loongson_spi_prepare_message(struct spi_controller *host, struct spi_message *m)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
-	unsigned char para;
 
-	para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
-			       para & ~LOONGSON_SPI_PARA_MEM_EN);
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_PARA_REG, LOONGSON_SPI_PARA_MEM_EN, 0);
 
 	return 0;
 }
@@ -266,30 +280,26 @@ static int loongson_spi_transfer_one(struct spi_controller *host, struct spi_dev
 static int loongson_spi_unprepare_message(struct spi_controller *host, struct spi_message *m)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
-	unsigned char para;
 
 	/* Restore the hardware SPI Flash read path */
-	para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG,
-			       para | LOONGSON_SPI_PARA_MEM_EN);
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_PARA_REG,
+			   LOONGSON_SPI_PARA_MEM_EN, LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
 
 static void loongson_spi_reginit(struct loongson_spi_priv *priv)
 {
-	unsigned char val;
+	/* Disable SPI */
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG, LOONGSON_SPI_SPCR_SPE, 0);
 
-	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
-	val &= ~LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
+	/* Clear status flags (write 1 to clear) */
+	regmap_write(priv->regmap, LOONGSON_SPI_SPSR_REG,
+		     LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
 
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
-			       (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL));
-
-	val = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
-	val |= LOONGSON_SPI_SPCR_SPE;
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, val);
+	/* Enable SPI */
+	regmap_update_bits(priv->regmap, LOONGSON_SPI_SPCR_REG,
+			   LOONGSON_SPI_SPCR_SPE, LOONGSON_SPI_SPCR_SPE);
 }
 
 static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
@@ -329,13 +339,16 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	host->transfer_one = loongson_spi_transfer_one;
 	host->unprepare_message = loongson_spi_unprepare_message;
 	host->set_cs = loongson_spi_set_cs;
-	host->num_chipselect = 4;
+	host->num_chipselect = LOONGSON_SPI_NUM_CS;
 	dev_set_drvdata(dev, host);
 
 	priv = spi_controller_get_devdata(host);
-	priv->base = regs;
 	priv->controller = host;
 
+	priv->regmap = devm_regmap_init_mmio(dev, regs, &loongson_spi_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "unable to init regmap");
+
 	ret = loongson_spi_get_clk_rate(dev, &priv->clk_rate);
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to get clock rate");
@@ -357,12 +370,8 @@ static int loongson_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	priv->lss.spcr = loongson_spi_read_reg(priv, LOONGSON_SPI_SPCR_REG);
-	priv->lss.sper = loongson_spi_read_reg(priv, LOONGSON_SPI_SPER_REG);
-	priv->lss.spsr = loongson_spi_read_reg(priv, LOONGSON_SPI_SPSR_REG);
-	priv->lss.para = loongson_spi_read_reg(priv, LOONGSON_SPI_PARA_REG);
-	priv->lss.sfcs = loongson_spi_read_reg(priv, LOONGSON_SPI_SFCS_REG);
-	priv->lss.timi = loongson_spi_read_reg(priv, LOONGSON_SPI_TIMI_REG);
+	regcache_cache_only(priv->regmap, true);
+	regcache_mark_dirty(priv->regmap);
 
 	return 0;
 }
@@ -371,15 +380,15 @@ static int loongson_spi_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(host);
+	int ret;
 
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPCR_REG, priv->lss.spcr);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPER_REG, priv->lss.sper);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_PARA_REG, priv->lss.para);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SFCS_REG, priv->lss.sfcs);
-	loongson_spi_write_reg(priv, LOONGSON_SPI_TIMI_REG, priv->lss.timi);
-
-	loongson_spi_write_reg(priv, LOONGSON_SPI_SPSR_REG,
-			       LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
+	regcache_cache_only(priv->regmap, false);
+	ret = regcache_sync(priv->regmap);
+	if (ret) {
+		regcache_cache_only(priv->regmap, true);
+		regcache_mark_dirty(priv->regmap);
+		return ret;
+	}
 
 	spi_controller_resume(host);
 
-- 
2.52.0

