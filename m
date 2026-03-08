Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146A1F3D56
	for <linux-spi@vger.kernel.org>; Sun,  8 Mar 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772976903; cv=none; b=fE0A56C7NNs8H/A09U6N66ReZagAvipWSurEGiK16rDtNK/bI6XCV7YwUhqgTrat0bFd9AgCwSPfkCLzs65wzwmy3y1N6rdZOKa/p4YotDF9/h04YdREz/gbpUyHKWHbbu9cTgHtNNuDfRR7oew23IA9TEZ1/P8BYx+bQ5Qv88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772976903; c=relaxed/simple;
	bh=IdkYZcqSAsfDr/v01fcZng8MKVvKs612Vz+/y2dFwAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hG6+6HKxfg9Ve3aeKNNgLilCTlRXYfRBx7STFslqZRUgQpDcgNjm/tt2QfNBWSLlrxYNl9H/ohf87ZdnJtsPs35MA4Wq1WGW60kwNws/c7oup2p8cO/Rev+wjUeaIzxlSDddeJufG6pU4gvbrVOCxpSGOE9XMiXi928+VHa03QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMCjaptE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMCjaptE"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829ac4670c4so1236396b3a.0
        for <linux-spi@vger.kernel.org>; Sun, 08 Mar 2026 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772976901; x=1773581701; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JltE6+8Ow4XXeaqmNG/IJKeoUqa+n358vgCzVseFfy4=;
        b=eMCjaptEfWwLFBwnK5ob5bYSNiyCW6XIbjpLWi/Lnv80o9e+ykuZ59eg1e1MXcZEWA
         ObG31TEpjkV5vTwPeQRGXikKEqC2ZABEzvBcAsf6bz2IUJG3nyJPduvEaSn7/dSQdUfP
         6z28/OXe0v+eXORpalEnVLnesgbSvIi792Jngmya+qyktODSTzLwhxZ33OL18z6piEfb
         gFaZKYzPBnWfqN5SFnSsJiUIk5g95H0iJPA59TG6v6mpm0tv6adAYgHAh2+oDRX6Z7j4
         JUeZ8ML6UJ9Lf2Fe8/LOkhHtWjCnmIsyib8LOD2WX4qohgsxHFvkFmGRssI7XrBAzJ+y
         6eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772976901; x=1773581701;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JltE6+8Ow4XXeaqmNG/IJKeoUqa+n358vgCzVseFfy4=;
        b=YfpkwD1H/n64nNfi5Hs0/Ikw7haTP0CxdBg8OPDpYED1Tt+ZxqiSeWt93UMr3Xg5vz
         N9cDp905F3jrHUKq2brufSx+kUjVnpyF+0jB++mO5nzdMXAkqLJV/aizxSN0y0Rc6OXu
         R7U/qJ57Ym0WyH+3WIr1cSjBmVK7+Moikj0cDgDQA7dpHNVoVBZ44A/pUdB5RGBBrVB3
         XjETBjHkfSR2hC0hkzDPwO4l+mHTTEMeMYhqTDx3v9Uv1OCOfuPo/vu2bdBxxVixBn9a
         dqjxCx9t3f5bIeWZ+8WbnJk3nXuqG5Jr29D3yy/RZpIpcSuV7+yMUWDMDxIgwgl2GQuT
         TG5g==
X-Forwarded-Encrypted: i=1; AJvYcCWxGK1HmYrr8JeNyFLdTtMdAu68dmbSeJ+mBkzALQjFd9ZzexhSFNabBnUfhI+JWqz2y3bGUOEdNfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRN9kU8C+xedj9uirnkqaunGRrSTvMRiSQ2NQgzfLTklxoOPtK
	ax6Un2iPRHHpMWf8axDCruGpdQGC5x4WGanvOsF7xw5a1Bc4bQg4sp7n
X-Gm-Gg: ATEYQzyMHdLHQKdLo0GzPnob8V2zELX4YHm6i0l9zIQiX15a1dPOE1jUkUlAlT2dqgv
	jK3jlAd6HSXiOt1FhFuUSG3IP7GOSN0bM+ukeb+nJKI7tf/XybdNbWWvl3itLfgpGeZUiEMDWgp
	jb3xNumoE6PQGT6J5n+8ox4zkbcUjt248/Kj9HuIu1iMMTeZ7R1lauSXt1i1VnLj5wO82wAoYuB
	yBMXzksqo6GnBeEJlEoZYb1DnAL+/5bK9VQq8rVaKcsroECp1FEVgjkASmafyTRp4nQIbfvyLSW
	5+mXOK0+CWN09vMtiJyi+XdO5TMQWoHDyt45IO++x6rP2lvsNKXu9wXzamLthQNghlHpU5bJA0V
	mAyF3M/KPkKZqVZO20o1T+S5/fimmKRO9//WggCg+JuY8u8SbEEHQoak5nV8t3Sp+nleZM7jz6a
	LDy7XA8tWY709OEmeJo8QtnInXC+L0CZB1SzSW
X-Received: by 2002:a05:6a00:1c87:b0:824:374a:1424 with SMTP id d2e1a72fcca58-829a2f699dbmr7046957b3a.58.1772976901013;
        Sun, 08 Mar 2026 06:35:01 -0700 (PDT)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4507:7fb4:bc3a:eca9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d696bsm6895996b3a.58.2026.03.08.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 06:35:00 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 08 Mar 2026 21:34:55 +0800
Subject: [PATCH] spi: amlogic: spifc-a4: Remove redundant clock cleanup
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP56rWkC/x3MQQqAIBBA0avIrBtQC5GuEi3MZmo2JgoRSHdPW
 r7F/w0qFaEKs2pQ6JYqV+owg4J4hnQQyt4NVlunR+2xZuGIYUKDzjNvxrnAzNCDXIjl+WfL+r4
 fJLtx3FwAAAA=
X-Change-ID: 20260308-spifc-a4-1-68ffb166afff
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772976897; l=3322;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=IdkYZcqSAsfDr/v01fcZng8MKVvKs612Vz+/y2dFwAw=;
 b=ZfSJgryJPy5aIsot/eh+rHeNfAWOTkrwIbpOT+IyH6Dk59HdDBzl90AJrxWPOzvfYj5ChX+9G
 NRb8Zp5gGxUD17R8GomZSUGQhE3vo+0fTosH2TwvmNc8b76FJ2UE1KA
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver uses devm_clk_get_enabled() which enables the clock and
registers a callback to automatically disable it when the device
is unbound.

Remove the redundant aml_sfc_disable_clk() call in the error paths
and remove callback.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 46 ++++++--------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 2aef528cfc1b..d3061c870ff8 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -1084,14 +1084,6 @@ static int aml_sfc_clk_init(struct aml_sfc *sfc)
 	return clk_set_rate(sfc->core_clk, SFC_BUS_DEFAULT_CLK);
 }
 
-static int aml_sfc_disable_clk(struct aml_sfc *sfc)
-{
-	clk_disable_unprepare(sfc->core_clk);
-	clk_disable_unprepare(sfc->gate_clk);
-
-	return 0;
-}
-
 static int aml_sfc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1142,16 +1134,12 @@ static int aml_sfc_probe(struct platform_device *pdev)
 
 	/* Enable Amlogic flash controller spi mode */
 	ret = regmap_write(sfc->regmap_base, SFC_SPI_CFG, SPI_MODE_EN);
-	if (ret) {
-		dev_err(dev, "failed to enable SPI mode\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable SPI mode\n");
 
 	ret = dma_set_mask(sfc->dev, DMA_BIT_MASK(32));
-	if (ret) {
-		dev_err(sfc->dev, "failed to set dma mask\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(sfc->dev, ret, "failed to set dma mask\n");
 
 	sfc->ecc_eng.dev = &pdev->dev;
 	sfc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
@@ -1159,10 +1147,8 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	sfc->ecc_eng.priv = sfc;
 
 	ret = nand_ecc_register_on_host_hw_engine(&sfc->ecc_eng);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register Aml host ecc engine.\n");
-		goto err_out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register Aml host ecc engine.\n");
 
 	ret = of_property_read_u32(np, "amlogic,rx-adj", &val);
 	if (!ret)
@@ -1178,24 +1164,7 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	ctrl->min_speed_hz = SFC_MIN_FREQUENCY;
 	ctrl->num_chipselect = SFC_MAX_CS_NUM;
 
-	ret = devm_spi_register_controller(dev, ctrl);
-	if (ret)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	aml_sfc_disable_clk(sfc);
-
-	return ret;
-}
-
-static void aml_sfc_remove(struct platform_device *pdev)
-{
-	struct spi_controller *ctlr = platform_get_drvdata(pdev);
-	struct aml_sfc *sfc = spi_controller_get_devdata(ctlr);
-
-	aml_sfc_disable_clk(sfc);
+	return devm_spi_register_controller(dev, ctrl);
 }
 
 static const struct of_device_id aml_sfc_of_match[] = {
@@ -1213,7 +1182,6 @@ static struct platform_driver aml_sfc_driver = {
 		.of_match_table = aml_sfc_of_match,
 	},
 	.probe = aml_sfc_probe,
-	.remove = aml_sfc_remove,
 };
 module_platform_driver(aml_sfc_driver);
 

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260308-spifc-a4-1-68ffb166afff

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

