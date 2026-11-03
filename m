Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689710;
	b=1sKMYx2vYEPzZSQbm5h567mv6spO3YtRlOnVvwWHHFvTE7OKI/JbHyim2SFF1uvPrf/m
	 +mPF5FxssMbN4IWGDO00PcQE3RCu0oRqShX6tucGQffbSHFMiRZ+/zLsCcErB60jMSlP9
	 +I/qubRTmVtNu69qc9gL0WlQxFcdXK27L13nAyF7OvEb3RWDb0XXphiI2zI7sZ7F6wbi5
	 ox3V6Y9NMr3HiFGkpsnmxVN286ZFOd6EB2QLkGCoDk4ZZkoU8y1zRExZCA7IkbE/PuTbL
	 6rVstttcYRhD8zTNLfWyg/G4mUIxg9fzwz/xW/bCzx5krkC9o3GPN9Cak6EZtF0AJhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689710;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=uEBYLLthGFpGnCbGDHUtH8idskzdse8n5cw8b5clfso=;
	b=o+CcDU35CM4k5axKfcg7B+v4T8xUCmTDE/xUm5mBEG/FrencTBjt0QpQ57mFwTcOLvcI
	 vIjPde0UMFu0ZMzjVtt2LP3Q+2KDl5aCzPSoRSsZ5GUhX8eKUXEyEtQ14GvaznIgEdjmW
	 0lA05Ulc+fMtQgQNVU/xtFWlJBbDq93y5FSYgAm+7QozYb6tVT+18Kf0C7dPBlZCmzLh0
	 7WXBrXvk1IH2I7W8CfaFq7xd0nzLgzSZ2a9j1i8zsGv4vyJjRcuXDwc8pigIIVdF9wVoF
	 tr/3b+ZgbVc5lHEhGUBabS18Lmn1ThvTPud2E+QF1Tknt9e+tuUA/RKsylIa83hg+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C30606A32E
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C30606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxdvBsiOlqvNwbAA--.14772S3;
	Tue, 03 Nov 2026 15:08:28 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxRs1qiOlq6RQyAA--.24713S3;
	Tue, 03 Nov 2026 15:08:28 +0800 (CST)
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
Subject: [PATCH 5/8] spi: loongson: Support ACPI clock-frequency and add error handling
Date: Tue,  3 Nov 2026 15:08:17 +0800
Message-ID: <221190e4b561b9ea7aaf7eea98f22e943f4fa121.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxRs1qiOlq6RQyAA--.24713S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGrpQPoEkwAAsm
X-Coremail-Antispam: 1Uk129KBj93XoW7Ary7KFyrXw1xuw4fKFyUurX_yoW5Jry8pF
	4rZa13Kr4UJrs7CrnxJ3ykGF1Yvas3JanrGa97tw18WrnxJw1jqFy3KFy5AF43AFyxXF4U
	Zry0gFW8CF4DuFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU

On platforms using ACPI (e.g., certain Loongson-2K3000 boards), the clock
framework might not be available, or clk_get_rate() may return 0. This
causes the driver to calculate an incorrect clock divider.

Introduce a helper function loongson_spi_get_clk_rate() to resolve the
input clock rate. It first attempts to read the rate via the clk framework.
If that fails or returns 0, it falls back to reading the standard
"clock-frequency" device property (which covers ACPI and DT).

Additionally, add proper error checking to ensure the driver fails to
probe gracefully if neither method provides a valid clock rate.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index 083157786790..91d7acbe4302 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -242,11 +242,32 @@ static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
 	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
 }
 
+static int loongson_spi_get_clk_rate(struct device *dev, u64 *clk_rate)
+{
+	unsigned long rate;
+	struct clk *clk;
+	u32 freq;
+
+	clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rate = clk_get_rate(clk);
+	if (!rate && !device_property_read_u32(dev, "clock-frequency", &freq))
+		rate = freq;
+
+	if (!rate)
+		return -EINVAL;
+
+	*clk_rate = rate;
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
@@ -265,11 +286,10 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 	spi->base = regs;
 	spi->controller = controller;
 
-	clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");
+	ret = loongson_spi_get_clk_rate(dev, &spi->clk_rate);
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to get clock rate");
 
-	spi->clk_rate = clk_get_rate(clk);
 	loongson_spi_reginit(spi);
 
 	spi->mode = 0;
-- 
2.52.0

