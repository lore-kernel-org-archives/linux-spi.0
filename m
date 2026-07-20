Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49B3D6CC7
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544054; cv=none; b=qtNidvAwUqnBGPMVZyv7FNOcBKzKQLOuYLRYU0je9F/lZ2nn3UnebXkkROVEseMAKgEM0725FVEi1hOZ7Lc4/PPkB0oWLlHXXms2jx5eKWlgPYG/h+HZuwJMNGj34oR7eVhwInWUlWMCMpMHIY/1cgv2snvs+YcUjXwv+OPk8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544054; c=relaxed/simple;
	bh=1VOB5qihoLYvUrKgDurvNJnb5E6H9r/MCX/C1s4p2D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmmArjPtjKKyTLIEzyHYqyMCKNEqx7nS780juVYDZUP2kMnaCXsQJY6fL/JEdpkYPmPSZx2o3lLxUsSkGoWer5IPWDY6NOXJqR0h6PRF0byxrFvr4xy5YCzy7GRyUbSbEIg/96csUG7UyexXOsOMWV/5MQ0yaZITadHFFkz3gTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so8463045ad.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544051; x=1785148851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cHJ+v/E14jZBDLKhft+LTxzEaKtkH3VvD3xnlIFMVc=;
        b=WtbasQf1w5aSRkpN/ns4tc6od1kWgdFm71xqqdR6NCZ/e6adgZ0fbNJL5VakH+r6Ay
         SwZGRhKRX8EG/RCahPlR8eH4AUERbjcI+4/x9HNuuynoorDNf+IJ7QuKA+ZjyV84smr8
         7yBLhyr1FzQP5YGfcmZGEB5m+fp79Ht8shyolK2jE/ZRpycBHPFpzefc0ZU6Oc/W5fZQ
         F/R2cqmm6cvQBLHe0Ok2c37cBdaIY/+AUCEp5BMXa4W5ruPVG75rSXcj0GTM+MvqXXT4
         GBE7dRyGHrViUKZp1DT9BEUbzGUYvRRZ3JrotaEzlPvGFLAJAn4GbqT0GEouoX2lDfQz
         tEVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/dQwVnL2aKmPAtX2y3R45ZENe2DmrsC4DXV7XqJsrEM/4LbAgpb6c3QLM5VSHIyddEHKJQZqefRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9N0Nf7jVYGhcxjr9HUdnPY07u0d0FMQTiETbb7Lzk61Noftx
	/i78TYFuhy0UAYeIkA5S8Tya695KFK509bKtSIiauRzsUH44FoAChII=
X-Gm-Gg: AR+sD10mmBAycrPXbCgp/9iZGDemFXn1ZVkPLjliNh8WXGK3r9fuDxHP3bZD5LIEnlj
	qqD3xvbEXfGmSVAG45YRxBrdwJw84H1YHZDRYfoV5VIPXud2umrPpwWdQsbHGTW/C+Sp0q3A5Z1
	F9zy7t05wIJ4peYSNsFHPAE8SfmVrIgYVkM/JUbLHRXMy1q2eFO7oGg6RFOpCwcCl4XXMBfzOte
	WYxJkicQrg9P/nlfmmfSmP9BfH6j7f7MF6/5z5oGfrMEuJEc+XXjHRZASy6WRyKHRFYVlcPhpeV
	qDputiyFUTGyb99z7F3VcnFuO/z8P5bqJf7krFCaPn2HLg2PXW0giDaEOTl99noh2o1DL6E8HXP
	I/C0vnEjwl6FZJyGXY41MvpWct5tYteZLcNGfvyD57CevSrbSkRo73MbcNhagv5rUL0PXAtxQ0R
	ZxjJXEzqE2DgEzG8Y1DGSp4YtbqTbk6jJ5TMzVY1z7Y4v6wiabtP4Lwmyi3kI1IkJaDU7t/RTHP
	7qN3NTi/KCe011PWA==
X-Received: by 2002:a17:902:e80a:b0:2c9:fc14:588f with SMTP id d9443c01a7336-2cf3494afc3mr150265455ad.29.1784544051064;
        Mon, 20 Jul 2026 03:40:51 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:50 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v15 7/7] spi: pxa2xx: rename local status variable to ret
Date: Mon, 20 Jul 2026 18:40:29 +0800
Message-Id: <20260720104029.13740-8-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720104029.13740-1-fourdollars@debian.org>
References: <20260720104029.13740-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the return value variable name from 'status' to 'ret' in the
pxa2xx_spi_probe(), pxa2xx_spi_suspend(), pxa2xx_spi_resume(), and
pxa2xx_spi_runtime_resume() functions to conform to standard Linux kernel
coding conventions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 56e434f6e794..612361ffe6dc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1313,7 +1313,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	const struct lpss_config *config;
-	int status;
+	int ret;
 	u32 tmp;
 
 	if (platform_info->is_target)
@@ -1372,8 +1372,8 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
-		status = pxa2xx_spi_dma_setup(drv_data);
-		if (status) {
+		ret = pxa2xx_spi_dma_setup(drv_data);
+		if (ret) {
 			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
@@ -1387,16 +1387,16 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	status = pxa2xx_spi_clk_enable(drv_data);
-	if (status)
+	ret = pxa2xx_spi_clk_enable(drv_data);
+	if (ret)
 		goto out_error_dma_alloc;
 
 	drv_data->suspended = false;
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+	ret = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
 			drv_data);
-	if (status < 0) {
-		status = dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_clock_enabled;
 	}
 
@@ -1477,23 +1477,23 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
-			status = PTR_ERR(drv_data->gpiod_ready);
+			ret = PTR_ERR(drv_data->gpiod_ready);
 			goto out_error_irq_alloc;
 		}
 	}
 
 	/* Register with the SPI framework */
 	dev_set_drvdata(dev, drv_data);
-	status = spi_register_controller(controller);
-	if (status) {
-		dev_err_probe(dev, status, "problem registering SPI controller\n");
+	ret = spi_register_controller(controller);
+	if (ret) {
+		dev_err_probe(dev, ret, "problem registering SPI controller\n");
 		goto out_error_irq_alloc;
 	}
 
 	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
 		pm_runtime_get_noresume(dev);
 
-	return status;
+	return ret;
 
 out_error_irq_alloc:
 	free_irq(ssp->irq, drv_data);
@@ -1504,7 +1504,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 out_error_dma_alloc:
 	pxa2xx_spi_dma_release(drv_data);
 
-	return status;
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_probe, "SPI_PXA2xx");
 
@@ -1542,14 +1542,14 @@ static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
+	int ret;
 
-	status = pm_runtime_resume_and_get(dev);
-	if (status < 0)
-		return status;
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
 
-	status = spi_controller_suspend(drv_data->controller);
-	if (status)
+	ret = spi_controller_suspend(drv_data->controller);
+	if (ret)
 		goto out_put;
 
 	/* Disable SSP interrupt generation on hardware level while clock is active */
@@ -1582,19 +1582,19 @@ static int pxa2xx_spi_suspend(struct device *dev)
 
 out_put:
 	pm_runtime_put_noidle(dev);
-	return status;
+	return ret;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
+	int ret;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = pxa2xx_spi_clk_enable(drv_data);
-		if (status)
+		ret = pxa2xx_spi_clk_enable(drv_data);
+		if (ret)
 			goto out_put;
 	}
 
@@ -1639,8 +1639,8 @@ static int pxa2xx_spi_resume(struct device *dev)
 	drv_data->suspended = false;
 
 	/* Start the queue running */
-	status = spi_controller_resume(drv_data->controller);
-	if (status) {
+	ret = spi_controller_resume(drv_data->controller);
+	if (ret) {
 		drv_data->suspended = true;
 		synchronize_irq(ssp->irq);
 		pxa2xx_spi_clk_disable(drv_data);
@@ -1651,7 +1651,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (!pm_runtime_suspended(dev))
 		pm_runtime_put_noidle(dev);
 
-	return status;
+	return ret;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
@@ -1668,11 +1668,11 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	int status;
+	int ret;
 
-	status = pxa2xx_spi_clk_enable(drv_data);
-	if (status)
-		return status;
+	ret = pxa2xx_spi_clk_enable(drv_data);
+	if (ret)
+		return ret;
 
 	drv_data->suspended = false;
 	return 0;
-- 
2.39.5

