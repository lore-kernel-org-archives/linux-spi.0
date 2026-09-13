Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0237E5EE
	for <linux-spi@vger.kernel.org>; Sun, 13 Sep 2026 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789274278; cv=none; b=YJXTBdH/wWAGb3kf0+gjfPXyFjnVsr7a4/gDB7w7MRJ+bN4wd5WQQrkT4cw4hYoG23g5VvlnyAeWgR1uqRLtzAaeTGOsD2UQ7ps83LGEube6dAw6Z0pPdk/1cvHn8mVrrcAbHLCQHCVin18KXP0UooTJ+vkIW8UDwylFwvYu0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789274278; c=relaxed/simple;
	bh=Xz/ibY5B5LyN8zXyjHI/EwOCnuVm4JHM63CDa26nL5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I09moUPSa/Z0nSEgcC3j2t7DWG2psvYqQdQJZ/TEr1SF1+hUPyuLaLaY9HrYB1sZHfc8LTaWYH7/ay+vEuPJQSOgCatSXHvtNXMVu7IVev+iX0EP9gQasdaDZDbnDmDuDsRwkGs5tvHJ8oDkQEbqj85VcH9Q+P1JI64mJnZ1NNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGMnJnbo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGMnJnbo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93a1118fbb8so54127085a.2
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2026 21:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789274276; x=1789879076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4iuYCB32yS1Z/2slBks3HKiKreEZHdfSx0e1Pi4YNY=;
        b=JGMnJnboG/IUfBy58J83E3B5SqUAOH1O60u/C60ICoW1UcgoIYyk0k9VOPyJdzEegc
         DNITjiEN+S2NoUjhicNNJqAea0QKBIct9NCgIkAwS3ZwJbnh4jtjzm7x2KhGagUiAYed
         vJKTC4XQQEyoeOiyig1ApLtoAcklt9yuKSCSmFNEY1Rz2qagbN6Twh8Ur/WQYDCA0Gzn
         j8rldr6MhMRhk1IF9e/FlfcH9Y7usrVeXuMVwxQni79mSC0SwEDZuf58p3fYrzXEmwjs
         3dvcg9S2NinJFEtUXW/M/jYt6N4ZfOupTBVH+wRDovONzKVBaxoygzYRJxTPg+yUG4Rz
         MI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789274276; x=1789879076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4iuYCB32yS1Z/2slBks3HKiKreEZHdfSx0e1Pi4YNY=;
        b=fvc9tVGnVzRAze4IeVNTQXp77mSR72QqaDVWuoAEGz+PpkVfQKegXswiN35Ld9wngl
         J9dkw8/QlwmJA4hg5x9yzPM5uiKXLzt/nUxWM8MC1nrCLNgflu6Y2ybCEHFR/3cfiTs4
         gZR7WhqGstvBdZKogRn+oHvM/yQ2sy/4VfpBCJkUykTtqkdG3sLIByHUHvsdyWySykWY
         5tiT9GSKKtH+liw+5m4HSyfTnUl3+DR3T/nmX7fyW2livuXgnRl8XfYy9DtkbpuUAnRe
         6V2NgUK6uVPzb95BhkgfS+Vb5IH10utYR1l08zvOP7xkVFaDWAmq7vB24fqoMdi5P+sj
         F8Rg==
X-Forwarded-Encrypted: i=1; AKwUvBzBP4AW/ElbxnM4kFwM/Y6/nfbOSQr7PC9jqZ+TIhVX6179x4swqbfyxPtunZpiMDG71CfqHtjZUzw=@vger.kernel.org
X-Gm-Message-State: AFuF++kIjqMZM6+EQ04+rJglhHlQriy44eluUl4ksfKoXGpdalDDaLgw
	tpgeDV5pvrQgwBlRxBsvH7YBqpZZtPgEhNxIe7q8s//ot2iJtmE2yGM=
X-Gm-Gg: AYBFou0jUDP3RIl/2U+Nd56rIO9ZNNzlJTNngSOiClyutJgvaubnJak1DOSPv/+4cCH
	MvCZUq+2XyEkriR6HSFYa8F9sx/MkNnep8PAuofZnL9RExXC/8PgTNr0UzS8XM5H3G/UiWAJYqc
	HvOPOeVY99rg+MBOAKRJsUPFXl+swTK6QUWLCyWXpudhZW5DGppY++mrVJphMmOaaPt8D7UdlVW
	94ZSxExGYM/38YxA2UUHdBZhQr4z9aFncNLMa+hjIv0H+MxAQlirD3lGHekEI4gyFBmxzaNIfAF
	yr0SSPzitjb0000RY+Kyue7n4xzqa1xQo61mbLSMI6kqkbQzTGTupIwn3PEpWlFJzJS8gOKPz1+
	gE86J5WPYhBjfZFCNiUdsBlF95ZsXD5Eob/5AThXwwE9S7vh6UHPyvUFdw4g9CPMUBLtXQ/u9sS
	mQyMmCW0hIvVDe4Nqy5nqx7HMpxoOqIkIvTJaubhLmgjBXwfb1ThZJ3wnMjqc991QMhbhPb/WiM
	UIOHAd+reOX04ifMldN9hy3a/758FGTwWbbpPBXDTdMbRjuRTKZT5x70LV3ux14uxlmMxtxu0+G
	QrVttRgi5xlwRL0V/wYMdoumNEvIAoE74g==
X-Received: by 2002:a05:620a:2846:b0:937:19d3:3fda with SMTP id af79cd13be357-939ea229f08mr1629502085a.28.1789274275943;
        Sat, 12 Sep 2026 21:37:55 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fc4a9455sm442083385a.31.2026.09.12.21.37.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:37:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>
Cc: Li Youhong <liyouhong@kylinos.cn>,
	linux-spi@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] spi: amlogic-spisg: Balance runtime PM and clock cleanup
Date: Sun, 13 Sep 2026 00:37:45 -0400
Message-ID: <20260913043745.35022-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core and pclk clocks are acquired with devm_clk_get_enabled(), but
pclk is immediately disabled and core is also disabled by runtime PM and
teardown. The managed cleanup can disable them again. Meanwhile, probe
unwind and active removal disable pclk instead of the enabled child sclk,
leaving the divider's own clock references unbalanced.

Keep managed clock handles but explicitly manage the core and sclk enable
references. Let the clock framework account for pclk through its sclk
child, and unwind core if divider setup or sclk enable fails.

After clock setup, check pm_runtime_set_active() and hold a no-resume
reference before enabling runtime PM. Balance that reference on probe
failure, disable runtime PM during teardown and free the IRQ before the
explicit clock shutdown. On removal, only disable clocks that runtime
suspend has not already disabled.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Based on SPI for-next at 98100d83adc8e17606605d131e685b1fbedfe092,
which includes Li Youhong's clock-enable error handling patch:
https://lore.kernel.org/r/20260831094553.2247003-1-dayou5941@163.com/

 drivers/spi/spi-amlogic-spisg.c | 55 +++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 1b00f34..33c5cbf 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -165,6 +165,7 @@ struct spisg_device {
 	struct clk			*sclk;
 	struct clk_div_table		*tbl;
 	struct completion		completion;
+	int				irq;
 	const struct aml_spisg_data	*data;
 	u32				status;
 	u32				speed_hz;
@@ -692,13 +693,13 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 	char name[32];
 	int ret, i;
 
-	spisg->core = devm_clk_get_enabled(dev, "core");
+	spisg->core = devm_clk_get(dev, "core");
 	if (IS_ERR(spisg->core)) {
 		dev_err(dev, "core clock request failed\n");
 		return PTR_ERR(spisg->core);
 	}
 
-	spisg->pclk = devm_clk_get_enabled(dev, "pclk");
+	spisg->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(spisg->pclk)) {
 		dev_err(dev, "pclk clock request failed\n");
 		return PTR_ERR(spisg->pclk);
@@ -706,8 +707,6 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 
 	clk_set_min_rate(spisg->pclk, SPISG_PCLK_RATE_MIN);
 
-	clk_disable_unprepare(spisg->pclk);
-
 	tbl = devm_kcalloc(dev, (DIV_NUM + 1), sizeof(*tbl), GFP_KERNEL);
 	if (!tbl)
 		return -ENOMEM;
@@ -728,6 +727,10 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 	div->width = CLK_DIV_WIDTH;
 	div->table = tbl;
 
+	ret = clk_prepare_enable(spisg->core);
+	if (ret)
+		return ret;
+
 	/* Register value should not be outside of the table */
 	regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
 			   FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN - 1));
@@ -745,20 +748,25 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 	ret = devm_clk_hw_register(dev, &div->hw);
 	if (ret) {
 		dev_err(dev, "clock registration failed\n");
-		return ret;
+		goto out_core;
 	}
 
 	spisg->sclk = devm_clk_hw_get_clk(dev, &div->hw, NULL);
 	if (IS_ERR(spisg->sclk)) {
 		dev_err(dev, "get clock failed\n");
-		return PTR_ERR(spisg->sclk);
+		ret = PTR_ERR(spisg->sclk);
+		goto out_core;
 	}
 
 	ret = clk_prepare_enable(spisg->sclk);
 	if (ret)
-		return ret;
+		goto out_core;
 
 	return 0;
+
+out_core:
+	clk_disable_unprepare(spisg->core);
+	return ret;
 }
 
 static int aml_spisg_probe(struct platform_device *pdev)
@@ -802,6 +810,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	spisg->irq = irq;
 
 	ret = device_reset_optional(dev);
 	if (ret)
@@ -832,9 +841,13 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	/* default pending */
 	spisg->cfg_start = FIELD_PREP(CFG_PEND, 1);
 
-	pm_runtime_set_active(&spisg->pdev->dev);
-	pm_runtime_enable(&spisg->pdev->dev);
-	pm_runtime_resume_and_get(&spisg->pdev->dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto out_clk;
+
+	/* Clock initialization has already powered up the controller. */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
 
 	ctlr->num_chipselect = 4;
 	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST |
@@ -856,22 +869,26 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request failed\n");
-		goto out_clk;
+		goto out_pm;
 	}
 
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi controller registration failed\n");
-		goto out_clk;
+		devm_free_irq(dev, irq, spisg);
+		goto out_pm;
 	}
 
 	pm_runtime_put(&spisg->pdev->dev);
 
 	return 0;
+out_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 out_clk:
-	if (spisg->core)
-		clk_disable_unprepare(spisg->core);
-	clk_disable_unprepare(spisg->pclk);
+	clk_disable_unprepare(spisg->sclk);
+	clk_disable_unprepare(spisg->core);
+	pm_runtime_set_suspended(dev);
 
 	return ret;
 }
@@ -882,11 +899,15 @@ static void aml_spisg_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(spisg->controller);
 
-	if (!pm_runtime_suspended(&pdev->dev)) {
+	pm_runtime_disable(&pdev->dev);
+	devm_free_irq(&pdev->dev, spisg->irq, spisg);
+
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
 		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
+		clk_disable_unprepare(spisg->sclk);
 		clk_disable_unprepare(spisg->core);
-		clk_disable_unprepare(spisg->pclk);
 	}
+	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static int spisg_suspend_runtime(struct device *dev)
