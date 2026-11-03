Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689694;
	b=E09f+P8wFXx2HcPs/Oci21xZ2XvWID8TVyKF9aU1JuH0CZiCU/GaazatlEa/c6GtsTYH
	 5dY3W+D3G0yBBweUdVMnFf8RCahr3MmcZng9fXfSCkQmfpzpLk3kW+RxZ36i5U2HNdPOa
	 DFGUJ3xajltD+eHzm1E6LdrYz06wdeOitVv25UbacBs+TyD+JPsVopVKE8ojvbIhGWC2g
	 hm3y92wRKpxzh4EQfw0YLRwzgmVO+d1Ceo6VcF143Jc3dHM9iNrLTm2Dak5t9y1wHhyCo
	 M5NwQvaDgG1t0d0dhJQ+RiKwyguwCje+uWOdTfX9NrG3eJZD+/kAKqFvOO5reoob9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689694;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=IOP38ng0OrUw8jCeyA/WwEceZHaeBLeVkfJ4GjCKTqU=;
	b=WHR3MKB7qgKib8lsA3yhMshGMs1+S7Gwary84enV9oK0cK1mJ6m0V0bEOltlQ++pJ0Ku
	 nF0EL/KRJQkMv80LXtcORoXR7hwyBHtGaP1GxJYY2fzdMAodNJeh6PDf2bDm5hYWvF1QF
	 6G2Qo6tJS3YxSaTwqy6F8isfkSGvaymzxX94W8SoMdWpo0PPlcvMvaMs40liJv4/SkIZ9
	 oxVd2SPIu/Eei2gtkk6e3SZ+c33pITEQ41TVjXfWccOg6vPjK6BCQaJoW435Qupw0aKjg
	 +KuH09D7Vr4oY4dmT4pzqq1iISPzSW6lFzTfct+n9uo3VGF8V2A28gk+V7KOXM06RLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B2606A32C
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785B2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bxn9FbiOlqp9wbAA--.14478S3;
	Tue, 03 Nov 2026 15:08:11 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxtMxXiOlq4BQyAA--.11182S5;
	Tue, 03 Nov 2026 15:08:10 +0800 (CST)
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
Subject: [PATCH 3/8] spi: loongson: Make suspend/resume registers PM-specific
Date: Tue,  3 Nov 2026 15:07:50 +0800
Message-ID: <ba943ed040b1c6a04a88612c1a62c04fefe876ba.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJCxtMxXiOlq4BQyAA--.11182S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DaQAAsP
X-Coremail-Antispam: 1Uk129KBj93XoWxtrW7tr4UKw43ury3GF45urX_yoWfAFW5pF
	1ayw45Wr4ftr4rArn8JrZ8WF1YyryfGwnrJa92vw4jgr9xZw1UX345WFn5Gr4ayFyUZF13
	ZFWrurWkGFn5CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Currently, the driver reuses fields like spcr, sper, spsr, and para
within struct loongson_spi for multiple purposes (runtime setup,
polling, and PM state). This state overloading makes the code fragile.
For example, set_clk() modifies spcr/sper during normal operations,
which can corrupt the saved state right before a suspend.

To fix this, move these register caches into a dedicated struct
loongson_spi_suspend_store (lss) so they are exclusively used by the
PM callbacks. Other functions (set_clk, write_read_8bit, message
handling) are updated to use local variables instead of mutating the
global PM state.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 80 ++++++++++++++++++---------------
 drivers/spi/spi-loongson.h      | 14 +++---
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index deda754e214d..9f3acf583984 100644
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
 
@@ -107,8 +108,9 @@ static int loongson_spi_setup(struct spi_device *spi)
 static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
 					u8 **rx_buf, unsigned int num)
 {
-	int ret;
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(spi->controller);
+	unsigned char status;
+	int ret;
 
 	if (tx_buf && *tx_buf)
 		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
@@ -116,8 +118,8 @@ static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_bu
 		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
 
 	ret = readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
-				 loongson_spi->spsr, (loongson_spi->spsr &
-				 LOONGSON_SPI_SPSR_RFEMPTY) != LOONGSON_SPI_SPSR_RFEMPTY,
+				 status,
+				 !(status & LOONGSON_SPI_SPSR_RFEMPTY),
 				 1, USEC_PER_MSEC);
 
 	if (rx_buf && *rx_buf)
@@ -148,10 +150,11 @@ static int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *
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
@@ -171,8 +174,12 @@ static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_dev
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
@@ -231,38 +238,37 @@ EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
 
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
index 35f95b161842..b2e73fa12420 100644
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
+	struct	spi_controller	*controller;
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

