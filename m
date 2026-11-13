Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548565;
	b=o1bKdB/HwyslaPYLLoK4hx/xEJpXhP5RmfIgG14TUCVcPKXJm3yIozAoADJ4apxpRz5f
	 d/7QSSRno6J2D/BGyswHQwzhyv1XRnMdB4oWLuklFgtiT3sBLg1wPOUsyeAf2KWfHZuk6
	 NEQeqAz7CuFFry6h5qPxcXTSZds1cilMFUVLankfUEmWx8jhXw4oyUe2uYZPO7pQZJZVo
	 tjfuLCpaIM7oWq1zBzGsKaLAQSrrBKrwA7nZUWtRARluLfo/BkB/c5hCj8iWQNtV2jI/U
	 39yVn0EjaxAtoS5GbqQoikKh9izOsxU4aZeRemhlR5ZfIc1EHgcoFRphNVswWf/w7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548565;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=9zxhqSsvgl/GG7DU1E6ACm/ZsZqP0LWN4MY7MFbxvX0=;
	b=BJbQT/jBBrPdIktErzM/MGiHrhxejPktn4984z/h5FI/zY8k+3OTIbwoekJTrBxXeB6s
	 3EnlsxKG7yHUOqiPlND5h3acKsBFCUIN+vMi6KbYguWI10aCOV7mmEaSXHnE/iswczYaD
	 eX9z9VTMBfkDUxWO5PegRAcff1i8pF+enxzfpWj6qZ5mlK5obwPZr3Jah+bunfL0UkjjR
	 cTOF/2dIzjA3OTnxeZTPYUGsuX853YxIjn0fd05nESpW/ZnX0UdIoz4qDJfkVMrw9Pc9l
	 ZNB8Tw2biOKzK0w4HYQidDAjWwbmUFZd3GQBk/x2oUfjssnRH2c4KAvgTyiyci52Vbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1313606A332
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1313606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Ax29FNo_ZqyR4fAA--.24819S3;
	Fri, 13 Nov 2026 13:42:37 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAx3c5Ho_ZqLSg0AA--.40410S5;
	Fri, 13 Nov 2026 13:42:36 +0800 (CST)
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
Subject: [PATCH v2 3/7] spi: loongson: Make suspend/resume registers PM-specific
Date: Fri, 13 Nov 2026 13:42:24 +0800
Message-ID: <e7dca057d9de63ddfa243fd9e3fb41738d1688d5.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c5Ho_ZqLSg0AA--.40410S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGr2f-4BugAAsn
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr45Zr45XF47AFWrWF1fZrc_yoWfXrWrpF
	1ayw45Wr4ftr4rArn8JrZ8WF1YyryfGwnrJa9Fvw40gr9xZw1UXa45WFn5Gr4ayFyUZFy3
	ZFZ5urWkGFn5CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=

The driver reuses spcr/sper/spsr/para for runtime setup, polling and PM
state. set_clk() overwrites spcr/sper during normal operation, which can
corrupt the saved state before suspend.

Move these caches into a dedicated struct loongson_spi_suspend_store
(lss) used only by the PM callbacks, and switch other code to local
variables.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 80 ++++++++++++++++++---------------
 drivers/spi/spi-loongson.h      | 14 +++---
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index bd4289022519..452c2c35564d 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -40,22 +40,23 @@ static void loongson_spi_set_cs(struct spi_device *spi, bool en)
 
 static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
 {
-	unsigned char val;
-	unsigned int div, div_tmp;
 	static const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
+	unsigned char val, spr, spre;
+	unsigned int div, div_tmp;
 
 	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
 	div_tmp = rdiv[fls(div - 1)];
-	loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
-	loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
+
+	spr = (div_tmp & GENMASK(1, 0)) >> 0;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val |
-			       loongson_spi->spcr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val | spr);
+
+	spre = (div_tmp & GENMASK(3, 2)) >> 2;
 	val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
 	val &= ~GENMASK(1, 0);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val |
-			       loongson_spi->sper);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, val | spre);
+
 	loongson_spi->hz = hz;
 }
 
@@ -106,8 +107,9 @@ static int loongson_spi_setup(struct spi_device *spi)
 static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
 					u8 **rx_buf, unsigned int num)
 {
-	int ret;
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	unsigned char status;
+	int ret;
 
 	if (tx_buf && *tx_buf)
 		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
@@ -115,8 +117,8 @@ static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_bu
 		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
 
 	ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
-				 loongson_spi->spsr, (loongson_spi->spsr &
-				 LOONGSON_SPI_SPSR_RFEMPTY) != LOONGSON_SPI_SPSR_RFEMPTY,
+				 status,
+				 !(status & LOONGSON_SPI_SPSR_RFEMPTY),
 				 1, USEC_PER_MSEC);
 
 	if (rx_buf && *rx_buf)
@@ -147,10 +149,11 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
 static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
+	unsigned char para;
 
-	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para &
-			       ~LOONGSON_SPI_PARA_MEM_EN);
+	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
+			       para & ~LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
@@ -170,8 +173,12 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
 static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
 {
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctrl);
+	unsigned char para;
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
+	/* Restore the hardware SPI Flash read path */
+	para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
+			       para | LOONGSON_SPI_PARA_MEM_EN);
 
 	return 0;
 }
@@ -230,38 +237,37 @@ EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
 
 static int loongson_spi_suspend(struct device *dev)
 {
-	struct loongson_spi *loongson_spi;
-	struct spi_controller *controller;
-
-	controller = dev_get_drvdata(dev);
-	spi_controller_suspend(controller);
+	struct spi_controller *controller = dev_get_drvdata(dev);
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	int ret;
 
-	loongson_spi = spi_controller_get_devdata(controller);
+	ret = spi_controller_suspend(controller);
+	if (ret)
+		return ret;
 
-	loongson_spi->spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
-	loongson_spi->sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
-	loongson_spi->spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
-	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
-	loongson_spi->sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
-	loongson_spi->timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
+	loongson_spi->lss.spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
+	loongson_spi->lss.sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
+	loongson_spi->lss.spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+	loongson_spi->lss.para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
+	loongson_spi->lss.sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
+	loongson_spi->lss.timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
 
 	return 0;
 }
 
 static int loongson_spi_resume(struct device *dev)
 {
-	struct loongson_spi *loongson_spi;
-	struct spi_controller *controller;
+	struct spi_controller *controller = dev_get_drvdata(dev);
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
 
-	controller = dev_get_drvdata(dev);
-	loongson_spi = spi_controller_get_devdata(controller);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->lss.spcr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->lss.sper);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->lss.para);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loongson_spi->lss.sfcs);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loongson_spi->lss.timi);
 
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->spcr);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->sper);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loongson_spi->spsr);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loongson_spi->sfcs);
-	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loongson_spi->timi);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
+			       LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL);
 
 	spi_controller_resume(controller);
 
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index 35f95b161842..27b3e8accfcd 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -29,19 +29,23 @@
 struct device;
 struct spi_controller;
 
-struct loongson_spi {
-	struct	spi_controller	*controller;
-	void __iomem		*base;
-	int			cs_active;
-	unsigned int		hz;
+struct loongson_spi_suspend_store {
 	unsigned char		spcr;
 	unsigned char		sper;
 	unsigned char		spsr;
 	unsigned char		para;
 	unsigned char		sfcs;
 	unsigned char		timi;
+};
+
+struct loongson_spi {
+	struct spi_controller	*controller;
+	void __iomem		*base;
+	int			cs_active;
+	unsigned int		hz;
 	unsigned int		mode;
 	u64			clk_rate;
+	struct loongson_spi_suspend_store lss;
 };
 
 int loongson_spi_init_controller(struct device *dev, void __iomem *reg);
-- 
2.52.0

