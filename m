Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548575;
	b=tp5SAxfx0vAaeYjTOEmJ+gJT/n4Y6CXkXTyw95o0r3hUj0sXzwQdTu+bSvgv6yKjL61K
	 9fd9CGzihM4mVeB++ZaETqm/tmyJEaXliQlwPIrb+s8IYxJCMvsqeifoAPAq7YaIjxyL6
	 6zqoCWb2cqED+0zBbqrnbRTGBp4Vb7NJCg0nHnqhCkkq7RhbVKxx8ORVH/q9T2VebyTiF
	 eecR/ZDH4rXtStz9jAJB3GjZuTZYBGf1jdFANlRgHdWNVcExTJ65P1Bg8Qm6uN2TRuWEV
	 UnTdmg3ZSib8w74PzIAl45/XmxQPPT5J51ebFFhcdanG1fcgwoZdvi1NXXp2UnFUCZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548575;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=DI5lAMrM8ZzmPsfhcdMIe+PmVJtGJxhaWnY6ux5XMcQ=;
	b=pwpF8cSiwyh0BhnFZYv7Wvk1Tc7sRuSlUZaERO1gsPjV5FEsuzXj9c3rd6k6EQq1fB/y
	 yyepB/S05nOjivkzPaEfYEDSLNLFKMhaCwyi/oqn3aIjRU34bO80nixZQvswzbdg8Sr60
	 OMyZC0iX8Hitf793O5if3dNOb12mfpxqcY3ne0HW2DJ+weQ8X35wpTqLnu36Oa3u+cBRd
	 BWJSW8a8FKnNn5RJILQJLezzrv8o7JA2aZgEEP+cN0Yp/3kWpcmkU4qE+Q5q9XBD9OpKC
	 AXgbWHf5o2skrU/4aZcsr/r1bmz7bOUQ4L7uDf27GlAZ28VTtNVYHFaNAdY6TyGr6eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFE606A31C
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BDFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8BxW_Bco_Zq1h4fAA--.24126S3;
	Fri, 13 Nov 2026 13:42:52 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxFs1ao_ZqMSg0AA--.48458S3;
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
Subject: [PATCH v2 5/7] spi: loongson: Fix clock divider calculation with explicit table
Date: Fri, 13 Nov 2026 13:42:41 +0800
Message-ID: <4afb0ffe94edcd2bb970c3d462809d34d3738a97.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs1ao_ZqMSg0AA--.48458S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGr2b-sDTAAAsF
X-Coremail-Antispam: 1Uk129KBj93XoW3GF48WF4xtF18CryfZFWUtrc_yoWxWr1fpF
	Wayw1Ygr4ftF48ArnxJrZ8GF1YyryfX3ZrGa9Fvw48KF9xXw4UXa45GF1fCFW3AF95XF13
	ZFZ5ur4kGFs5CabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

loongson_spi_set_clk() previously converted the requested divider into
SPCR.SPR/SPER.SPRE using rdiv[] and fls(div - 1). The rdiv[] mapping did
not match the actual divider encoding, so the programmed divider was
usually one step larger than requested, and the maximum divider could
index past the end of rdiv[].

For example:

- Requested divider 2: fls(2 - 1) = 1, rdiv[1] = 1, which encodes
  divider 4, so the output clock is half the requested rate.
- Requested divider 4: fls(4 - 1) = 2, rdiv[2] = 4, which encodes
  divider 8, again halving the output clock.
- Requested divider 8: fls(8 - 1) = 3, rdiv[3] = 2, which encodes
  divider 16.
- Requested divider 4096: div is clamped to 4096, fls(4095) = 12, and
  rdiv[12] is out of bounds because rdiv[] only has 12 entries.

Replace this with loongson_spi_div_table[], which explicitly maps each
supported divider from 2 to 4096 to its SPR/SPRE encoding, and select
the first entry whose divider is greater than or equal to the requested
value. This ensures the actual SPI clock does not exceed the requested
rate. Also make loongson_spi_set_clk() return an error and propagate it
to the caller, and validate hz and clk_rate before touching the hardware.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 68 ++++++++++++++++++++++++++-------
 drivers/spi/spi-loongson.h      | 20 ++++++++++
 2 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 19e73a64e14a..5991ce7b5603 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -16,6 +16,21 @@
 
 #include "spi-loongson.h"
 
+static const struct loongson_spi_div_table div_table[] = {
+	{   2, 0, 0 },
+	{   4, 1, 0 },
+	{   8, 0, 1 },
+	{  16, 2, 0 },
+	{  32, 3, 0 },
+	{  64, 1, 1 },
+	{ 128, 2, 1 },
+	{ 256, 3, 1 },
+	{ 512, 0, 2 },
+	{1024, 1, 2 },
+	{2048, 2, 2 },
+	{4096, 3, 2 },
+};
+
 static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
 					  unsigned char data)
 {
@@ -38,26 +53,40 @@ static void loongson_spi_set_cs(struct spi_device *spi, bool en)
 	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, val | cs);
 }
 
-static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
+static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
 {
-	static const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
-	unsigned char val, spr, spre;
-	unsigned int div, div_tmp;
+	unsigned long div;
+	unsigned char val;
+	unsigned int i;
+
+	if (!hz || !loongson_spi->clk_rate)
+		return -EINVAL;
+
+	div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
+	if (div < LOONGSON_SPI_DIV_MIN)
+		div = LOONGSON_SPI_DIV_MIN;
 
-	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
-	div_tmp = rdiv[fls(div - 1)];
+	for (i = 0; i < ARRAY_SIZE(div_table); i++) {
+		if (div_table[i].div >= div)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(div_table))
+		return -EINVAL;
 
-	spr = (div_tmp & GENMASK(1, 0)) >> 0;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val | spr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
+			       val | div_table[i].spr);
 
-	spre = (div_tmp & GENMASK(3, 2)) >> 2;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val | spre);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
+			       val | div_table[i].spre);
 
 	loongson_spi->hz = hz;
+
+	return 0;
 }
 
 static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
@@ -79,8 +108,13 @@ static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
 static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
 				struct spi_device *spi, struct spi_transfer *t)
 {
-	if (t && loongson_spi->hz != t->speed_hz)
-		loongson_spi_set_clk(loongson_spi, t->speed_hz);
+	int ret;
+
+	if (t && loongson_spi->hz != t->speed_hz) {
+		ret = loongson_spi_set_clk(loongson_spi, t->speed_hz);
+		if (ret)
+			return ret;
+	}
 
 	if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
 		loongson_spi_set_mode(loongson_spi, spi);
@@ -162,8 +196,12 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
 				     struct spi_transfer *xfer)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	int ret;
+
+	ret = loongson_spi_update_state(loongson_spi, spi, xfer);
+	if (ret)
+		return ret;
 
-	loongson_spi_update_state(loongson_spi, spi, xfer);
 	if (xfer->len)
 		return loongson_spi_write_read(spi, xfer);
 
@@ -253,6 +291,10 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	if (ret)
 		return ret;
 
+	/* Expose controller capabilities to the SPI core */
+	controller->max_speed_hz = spi->clk_rate / LOONGSON_SPI_DIV_MIN;
+	controller->min_speed_hz = DIV_ROUND_UP_ULL(spi->clk_rate, LOONGSON_SPI_DIV_MAX);
+
 	loongson_spi_reginit(spi);
 
 	spi->mode = 0;
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index 6b52e23cc62b..983a39c9b0ae 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -26,9 +26,29 @@
 #define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
 #define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
 
+/* Hardware limits and divider masks */
+#define LOONGSON_SPI_DIV_MIN		2
+#define LOONGSON_SPI_DIV_MAX		4096
+
 struct device;
 struct spi_controller;
 
+/**
+ * struct loongson_spi_div_table - SPI clock divider encoding
+ * @div:  resulting clock divider (SPI input clock / SPI output clock)
+ * @spr:  value for the SPCR.SPR field
+ * @spre: value for the SPER.SPRE field
+ *
+ * One entry per supported divider from 2 to 4096. The (spr, spre) pair
+ * is programmed into the controller to produce @div; entries are sorted
+ * by @div so the first entry >= the requested divider can be selected.
+ */
+struct loongson_spi_div_table {
+	unsigned int	div;
+	unsigned char	spr;
+	unsigned char	spre;
+};
+
 struct loongson_spi_suspend_store {
 	unsigned char		spcr;
 	unsigned char		sper;
-- 
2.52.0

