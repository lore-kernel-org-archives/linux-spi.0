Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689710;
	b=T6zszLY61zwBnV90Tbx478eSS7iN8uO19k7+SippDpWyu1u7blivYhUXPx9asLm2tK9V
	 5WfN6AIHIbRpDGus+MD+OTSgTXGWBQ6zUkIPD0W1fNXvgxZsMmOmEXqDJpFO6GJQcl9Nf
	 MKsAm9zLjSzjReJ7z4CVdFYu2NY2+gBQPmn5CJ+Qemda5xcHJoJ6wb/CKDUctl6Wyih11
	 y8/bux2Gx85jqGc93xAJmrSKgdJqBOfa6/1KVWdIdxFUtbQb/qd47lScHdR91SkpolM9J
	 4/06QDeBDXewTLIJ92mT+G3hDOreMU/R5fdQacQA+CAwMakXiyEsCZPfkCCWfo2TQfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689710;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=p6/XXq/b+K0GWmpPC9nVho08AC7ArIetYLRqknyiAPw=;
	b=GwlQZp/M6mJGAoawXc/iNH75bEEfpEvV2mT6Sz3+sq5Vu94Xv6dNw8XnP3BzYv73zITb
	 fU6NLY2wn0r/ZAZPyxWHADep2+gG5K+jWPO3pn9eWExBYg2ELSS5KZzPVbCq1/QQt+BjL
	 4S3WMMiJDmUI05qHNwZqHsdKpmKpGDYfzC+9zvmSDB5/ocA25PGZy5yJeZl38+Fd7UuqO
	 R2qiCf+xVF48QNdjEt4raB7t4P6rzntgi2OaBTtZ3Yrl/RaLPdwXvwhRRDKyxg7V0uVDz
	 Bz+kBOQp1Ai5lriGu1Tp0uvwJK29iKScqot1lcT6O1I3hxZxFU+c+od2jvLZ5wRcxAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC0606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CC0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxztJriOlqt9wbAA--.14701S3;
	Tue, 03 Nov 2026 15:08:27 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxRs1qiOlq6RQyAA--.24713S2;
	Tue, 03 Nov 2026 15:08:27 +0800 (CST)
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
Subject: [PATCH 4/8] spi: loongson: Fix clock divider calculation with explicit table
Date: Tue,  3 Nov 2026 15:08:16 +0800
Message-ID: <4b36ba4220b30e5dcc1dccf4db3a49a57c65122a.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxRs1qiOlq6RQyAA--.24713S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DbQAAsL
X-Coremail-Antispam: 1Uk129KBj93XoW3GF48WF4xtF18CryfZFWUtrc_yoW7CrWxpF
	4ayw1Ygr4SqF48ArnxJrZ8GF1YyryfX3ZrGa9Fvw48KF98Xw4UXa45GF1fGr43AF95ZF17
	ZFZ5ur4kGFs5urcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

loongson_spi_set_clk() previously converted the requested divider into
SPCR.SPR/SPER.SPRE using rdiv[] and fls(div - 1).  The rdiv[] mapping did
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
value.  This ensures the actual SPI clock does not exceed the requested
rate.  Also make loongson_spi_set_clk() return an error and propagate it
to the caller, and validate hz and clk_rate before touching the hardware.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 68 ++++++++++++++++++++++++++-------
 drivers/spi/spi-loongson.h      |  3 ++
 2 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 9f3acf583984..083157786790 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -16,6 +16,25 @@
 
 #include "spi-loongson.h"
 
+static const struct {
+	unsigned int	div;
+	unsigned char	spr;
+	unsigned char	spre;
+} loongson_spi_div_table[] = {
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
@@ -38,26 +57,40 @@ static void loongson_spi_set_cs(struct spi_device *spi, bool en)
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
 
-	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
-	div_tmp = rdiv[fls(div - 1)];
+	if (!hz || !loongson_spi->clk_rate)
+		return -EINVAL;
+
+	div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
+	if (div < LOONGSON_SPI_DIV_MIN)
+		div = LOONGSON_SPI_DIV_MIN;
+
+	for (i = 0; i < ARRAY_SIZE(loongson_spi_div_table); i++) {
+		if (loongson_spi_div_table[i].div >= div)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(loongson_spi_div_table))
+		return -EINVAL;
 
-	spr = (div_tmp & GENMASK(1, 0)) >> 0;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val | spr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
+			       val | loongson_spi_div_table[i].spr);
 
-	spre = (div_tmp & GENMASK(3, 2)) >> 2;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val | spre);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
+			       val | loongson_spi_div_table[i].spre);
 
 	loongson_spi->hz = hz;
+
+	return 0;
 }
 
 static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
@@ -79,8 +112,13 @@ static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
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
@@ -163,8 +201,12 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
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
 
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index b2e73fa12420..89efd4ce69d8 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -26,6 +26,9 @@
 #define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
 #define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
 
+#define LOONGSON_SPI_DIV_MIN		2
+#define LOONGSON_SPI_DIV_MAX		4096
+
 struct device;
 struct spi_controller;
 
-- 
2.52.0

