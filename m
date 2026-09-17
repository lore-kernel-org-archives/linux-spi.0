Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208095908BB;
	Thu, 17 Sep 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655386; cv=none; b=Gu3EKxENVe6XY3CewXHOGBrQx7EC8q3uOUXW3u17yWaUrPvLNgptEAXM+D0m0flhIZzyOrhYOxtm0uVcQkA84UHc7DCzWvYPtIhm1w25VZyptx46Q9dr0JL+flK24uouFSwyQaTYJEqtJRIaWyNwJ2YlvKyD80KcBdq77r8616Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655386; c=relaxed/simple;
	bh=KKDAvbfL56T3jQjXZJbwXq5l2QQmq9JoHaT5QJmHfWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvDydhkYEVlxAqBZhKcn0tDiy/2mrrOC6E/lD05GNR92qRY+M6WOJehNOpzKLKHaIz7iKF8TqYYNHsg9UtXV0umAAmSHsTEB6Jet7YHQWVttXpViSnFg9UBnOCr3v848nOxTHVSh1Hba8zWhjw6AOKaNfhXWUCEyyIjf63Katm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-05 (Coremail) with SMTP id zQCowABHtD5A+atqNnqCCA--.4692S4;
	Thu, 17 Sep 2026 22:29:26 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 17 Sep 2026 22:29:20 +0800
Subject: [PATCH 2/4] spi: sg2044-nor: Honor SPI clock limits
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fix-sg204xspi-v1-2-5c95dac429a8@iscas.ac.cn>
References: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
In-Reply-To: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowABHtD5A+atqNnqCCA--.4692S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1fCryrGrWDXryDZr4UCFg_yoW5GFy5pa
	17u3W5tr4rKFsrGr4fJw13X3yay34S9a4jk347K348AFs8uw1UAFW8JFy3XFW3JFyayFyv
	vF4xZr15CrsFq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBgkNDGqr888NVAAAsq

The fixed divider ignores device and operation clock limits. Calculate
the divider before each transfer so SCK does not exceed either limit.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/spi/spi-sg2044-nor.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index ff026ca0f76635fee959d7502f457d43dbec0706..f2a1074f68477cc6611fae09c5db7aaa405edf39 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -385,6 +385,29 @@ static ssize_t sg2044_spifmc_trans_reg(struct sg2044_spifmc *spifmc,
 	return 0;
 }
 
+static int sg2044_spifmc_set_speed(struct sg2044_spifmc *spifmc,
+				   unsigned int speed_hz)
+{
+	unsigned long rate = clk_get_rate(spifmc->clk);
+	u64 div;
+	u32 reg;
+
+	if (!rate || !speed_hz)
+		return -EINVAL;
+
+	/* SCK = HCLK / (2 * (SckDiv + 1)); round down the resulting SCK. */
+	div = DIV_ROUND_UP_ULL(rate, 2ULL * speed_hz);
+	if (div > SPIFMC_CTRL_SCK_DIV_MASK + 1)
+		return -EINVAL;
+
+	reg = readl(spifmc->io_base + SPIFMC_CTRL);
+	reg &= ~SPIFMC_CTRL_SCK_DIV_MASK;
+	reg |= div - 1;
+	writel(reg, spifmc->io_base + SPIFMC_CTRL);
+
+	return 0;
+}
+
 static int sg2044_spifmc_exec_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
@@ -395,11 +418,18 @@ static int sg2044_spifmc_exec_op(struct spi_mem *mem,
 
 	mutex_lock(&spifmc->lock);
 
+	ret = sg2044_spifmc_set_speed(spifmc, op->max_freq ?
+				    min(op->max_freq, mem->spi->max_speed_hz) :
+				    mem->spi->max_speed_hz);
+	if (ret)
+		goto out_unlock;
+
 	if (op->addr.nbytes == 0)
 		ret = sg2044_spifmc_trans_reg(spifmc, op);
 	else
 		ret = sg2044_spifmc_trans(spifmc, op);
 
+out_unlock:
 	mutex_unlock(&spifmc->lock);
 
 	return ret;
@@ -409,6 +439,10 @@ static const struct spi_controller_mem_ops sg2044_spifmc_mem_ops = {
 	.exec_op = sg2044_spifmc_exec_op,
 };
 
+static const struct spi_controller_mem_caps sg2044_spifmc_mem_caps = {
+	.per_op_freq = true,
+};
+
 static void sg2044_spifmc_init(struct sg2044_spifmc *spifmc)
 {
 	u32 tran_csr;
@@ -459,6 +493,7 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->auto_runtime_pm = false;
 	ctrl->mem_ops = &sg2044_spifmc_mem_ops;
+	ctrl->mem_caps = &sg2044_spifmc_mem_caps;
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
 
 	ret = devm_mutex_init(dev, &spifmc->lock);

-- 
2.47.3

