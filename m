Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548574;
	b=n0iVVzWaKWceQ0+A9NmHGdW+I9BKJpc7o8yoqzpjfHjYUdJplpzenWThrPsx0LsPkFp+
	 IOMV6uQiPp2qowpgsTe09VkjNsfSFr9e4TzydiFrZrBmzAt9WBmBVbk+VHnUi0ujcz2VW
	 TOMZ6jaiDrp5lt9IzurFVyWW6rLjgQcCLmYjUiOPylthYydKtCS8dt7VPLZDnwWCkIoJG
	 gunJmKMCjwhY7M12kSVjdFnkoOaraeJWHVOBx1NwlYLZvGn5Lyr8rmZM+5uqxfE/HMSns
	 qcYaOWADC5KFWhQMEMwMQgR23VYjpAjVTF25GQSxReCvH7XFIlwrgOn6gvy1tXWqA1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548574;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=8BHc6OkNiYU068jF2edIEhuA2AYoSSoySJitM137Gho=;
	b=H8BVcjqFZqTkpHjkVHHA6GsqdjPI0C3xnCH4XMiiYd2TaLuJ02/zcKLNeHmR8gIcbbOJ
	 gxsQi1uupT98Zzfh9JjLeXCojWnN+ORxLgPd4NGDhG5f7xHeEnXIEqcZq5LLGxdQ/KHTQ
	 9TQx4cRrZH213OHfSLNZgefvVR4LvHOtJzp57JYQlYZ2MPvOj5UnIXD3UBXE1yJYpSmOn
	 MRgVIHxSBbGk63P2WEJRbGu4Qp7Qmzy/alX55SLFYNt6KbVzBpSMaGDxuxQ9+vk2hLJ6L
	 YbbgG2rQlQzzAyI8hgbvrnuryQurc58+9TNGkVNmPduRuMrsURyo2jAdd0z6x5eA8rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF2606A321
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EEF2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxD9Nbo_Zq0R4fAA--.24426S3;
	Fri, 13 Nov 2026 13:42:51 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxFs1ao_ZqMSg0AA--.48458S2;
	Fri, 13 Nov 2026 13:42:51 +0800 (CST)
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
Subject: [PATCH v2 4/7] spi: loongson: Fix clock rate retrieval on ACPI platforms
Date: Fri, 13 Nov 2026 13:42:40 +0800
Message-ID: <894bb5162717f29087c6b095bec7b3a94ac0b46e.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs1ao_ZqMSg0AA--.48458S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGr2b-sDSwAAsC
X-Coremail-Antispam: 1Uk129KBj93XoWxur15uF43uFW5Zw1kCw4xKrX_yoWrXw43pF
	WSva1Ygr13Jr4kurnxJrWkGF1Yy34fW3ZrGa92yw40k3sxXw1UXry5GFy5Ar4ayF1UZFy5
	ZrW8WF4kCF4ruFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

On ACPI platforms the clock framework may be unavailable or return 0,
leaving clk_rate zero and producing a bogus SPI divider.

Add loongson_spi_get_clk_rate(): try the clk framework first, then fall
back to the "clock-frequency" device property (supported by both ACPI
and DT). Fail probe if neither provides a valid rate. Also disable and
re-enable the clock in suspend/resume.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 43 +++++++++++++++++++++++++++++----
 drivers/spi/spi-loongson.h      |  1 +
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 452c2c35564d..19e73a64e14a 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -199,11 +199,38 @@ static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
 	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
 }
 
+static int loongson_spi_get_clk_rate(struct device *dev)
+{
+	struct spi_controller *controller = dev_get_drvdata(dev);
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	unsigned int freq, ret;
+
+	loongson_spi->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(loongson_spi->clk))
+		return dev_err_probe(dev, PTR_ERR(loongson_spi->clk),
+				     "Failed to get spi clock");
+
+	if (loongson_spi->clk) {
+		loongson_spi->clk_rate = clk_get_rate(loongson_spi->clk);
+		if (!loongson_spi->clk_rate)
+			return dev_err_probe(dev, -EINVAL, "Failed to get frequency");
+		return 0;
+	}
+
+	ret = device_property_read_u32(dev, "clock-frequency", &freq);
+	if (ret || !freq)
+		return dev_err_probe(dev, -EINVAL, "Failed to parse clock-frequency");
+
+	loongson_spi->clk_rate = freq;
+
+	return 0;
+}
+
 int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 {
 	struct spi_controller *controller;
 	struct loongson_spi *spi;
-	struct clk *clk;
+	int ret;
 
 	controller = devm_spi_alloc_host(dev, sizeof(struct loongson_spi));
 	if (controller == NULL)
@@ -222,11 +249,10 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	spi->base = regs;
 	spi->controller = controller;
 
-	clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");
+	ret = loongson_spi_get_clk_rate(dev);
+	if (ret)
+		return ret;
 
-	spi->clk_rate = clk_get_rate(clk);
 	loongson_spi_reginit(spi);
 
 	spi->mode = 0;
@@ -252,6 +278,8 @@ static int loongson_spi_suspend(struct device *dev)
 	loongson_spi->lss.sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
 	loongson_spi->lss.timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
 
+	clk_disable_unprepare(loongson_spi->clk);
+
 	return 0;
 }
 
@@ -259,6 +287,11 @@ static int loongson_spi_resume(struct device *dev)
 {
 	struct spi_controller *controller = dev_get_drvdata(dev);
 	struct loongson_spi *loongson_spi = spi_controller_get_devdata(controller);
+	int ret;
+
+	ret = clk_prepare_enable(loongson_spi->clk);
+	if (ret)
+		return ret;
 
 	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->lss.spcr);
 	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->lss.sper);
diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h
index 27b3e8accfcd..6b52e23cc62b 100644
--- a/drivers/spi/spi-loongson.h
+++ b/drivers/spi/spi-loongson.h
@@ -41,6 +41,7 @@ struct loongson_spi_suspend_store {
 struct loongson_spi {
 	struct spi_controller	*controller;
 	void __iomem		*base;
+	struct clk		*clk;
 	int			cs_active;
 	unsigned int		hz;
 	unsigned int		mode;
-- 
2.52.0

